FROM alpine

ENV REVIEWDOG_VERSION=v0.17.4

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}
RUN wget -O - -q https://git.io/misspell | sh -s -- -b /usr/local/bin/

# add python
RUN apk add --no-cache python3 py3-pip

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt

ENTRYPOINT ["/entrypoint.sh"]