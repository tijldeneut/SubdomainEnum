FROM python:3-alpine

RUN apk add --update-cache \
    git wget curl nano unzip go

RUN export CGO_ENABLED=0

#RUN go get -v github.com/OWASP/Amass/v3/...
RUN go install -v github.com/owasp-amass/amass/v4/...@master

#RUN go get -u github.com/tomnomnom/assetfinder
RUN go install -v github.com/tomnomnom/assetfinder@latest

RUN cd /var/tmp/ && git clone https://github.com/fleetcaptain/Turbolist3r.git; \
    cd /var/tmp/Turbolist3r && pip install -r requirements.txt

RUN cd /var/tmp/ && git clone https://github.com/shmilylty/OneForAll.git; \
    cd /var/tmp/OneForAll && python3 -m pip install -U pip setuptools wheel && pip3 install -r requirements.txt

RUN GO111MODULE=on go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest

#RUN go get -u github.com/tomnomnom/httprobe
RUN go install -v github.com/tomnomnom/httprobe@latest

#RUN go get -u github.com/bluecanarybe/ResponseChecker
RUN go install -v github.com/bluecanarybe/ResponseChecker@latest

RUN GO111MODULE=on go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

RUN mkdir -p /root/.config/subfinder
ADD config.yaml /root/.config/subfinder/config.yaml
ADD subdomains.sh subdomains.sh
RUN chmod +x subdomains.sh

CMD echo "Please specify your target in the Docker run command"
