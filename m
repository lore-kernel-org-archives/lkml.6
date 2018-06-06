Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0+WwH87P"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5BB0607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeFFMj7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbeFFMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:39:56 -0400
Date: Wed, 6 Jun 2018 09:39:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hank Qiu <hank.qiu@dji.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux/tools/perf cannot be compiled for Android - linux-4.15
Message-ID: <20180606123953.GB24381@kernel.org>
References: <5a9b4a082c534984b1b84fa5e0f28d6d@CWMAIL-AP-F11.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9b4a082c534984b1b84fa5e0f28d6d@CWMAIL-AP-F11.dji.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 06, 2018 at 05:39:33AM +0000, Hank Qiu escreveu:
> Hi
> I am trying to use tools/perf to tuning my Android devices.

> But I cannot build it for Android successfully following the
> instructions in tools/perf/Documentation/android.txt.
 
> I download the latest NDK, which is android-ndk-r17 and follow the
> instructions in section a to export NDK_TOOLCHAIN and NDK_SYSROOT for
> arm.

r17, ok, I'll create a new container with that one to see if there is
something new, but see below for how I test it with r15c.

> Then I compile perf for Android using the exact same command in this
> documentation, but it cannot work and throw me an error "No
> gnu/libc-version.h found, please install glibc-dev[el]".  This
> confuses me a lot, since I am using CROSS_COMPILE toolchain for
> Android, and I cannot just use apt install glibc-dev to solve this
> problem, because it will install glibc to my host rather than the
> toolchain. By the way, I already installed glibc in my host.
 
>          My code is linux-4.15 and here are the instructions I used:
>              export NDK_TOOLCHAIN=~/android-ndk-r17/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
> export NDK_SYSROOT=~/android-ndk-r17/platforms/android-24/arch-arm
> make WERROR=0 ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie -sysroot=${NDK_SYSROOT}"

> I am wondering why I cannot build it successfully for Android
> following the documentation.
 
> I have google it for a long time, but they all suggest me to use
> linux-tools-perf, which don't answer why linux/tools/perf cannot be
> used.
 
> If anyone know how to solve this issue, please help me. Looking
> forward to your reply.

I regularly test build it using a docker container, the one below, check
if there is something you're missing. To make it clear, the build
process is all in the rx_and_build.sh script, the Dockerfile is just to
setup the environment, which you already have done, so just check the
env vars and how they get used up to the point where the build takes
place in rx_and_build.sh, which is in this line:

make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/linux/tools/perf O=/tmp/build/perf

# cat ~/git/linux-perf-tools-build/android/r15c/arm/Dockerfile
# docker.io/acmel/linux-perf-tools-build-android-ndk:r15c-arm
FROM docker.io/fedora:26
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV VERSION=android-ndk-r15c
ENV NDK=/opt/${VERSION}
ENV SOURCEFILE=${VERSION}-linux-x86_64.zip
RUN dnf -y install make bison flex gcc unzip findutils tar xz && \
    dnf -y clean all && \
    mkdir -m 777 -p /tmp/build/perf /tmp/build/objtool && \
    curl -OL https://dl.google.com/android/repository/${SOURCEFILE} && \
    unzip -d /opt ${SOURCEFILE} && \
    rm -f ${SOURCEFILE} && \
    rm -rf ${NDK}/sources \
	   ${NDK}/platforms/android-[19]* \
	   ${NDK}/platforms/android-2[0-5]* \
	   ${NDK}/platforms/android-26/arch-mips* \
	   ${NDK}/platforms/android-26/arch-x86* \
	   ${NDK}/toolchains/x86* \
	   ${NDK}/toolchains/mips* \
	   ${NDK}/toolchains/llvm* \
	   ${NDK}/prebuilt/ \
	   ${NDK}/python* \
	   ${NDK}/shader-tools/ &&\
    rm -rf /usr/share/doc /usr/share/gtk-doc /usr/share/locale /usr/share/man
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r perfbuilder && \
    useradd -m -r -g perfbuilder perfbuilder && \
    chown -R perfbuilder.perfbuilder /tmp/build/ /git/
ENV ARCH=arm
ENV ARM_NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
ENV ARM_NDK_SYSROOT=${NDK}/platforms/android-26/arch-arm
ENV EXTRA_CFLAGS="-Wno-attributes -Wno-unused-function -pie --sysroot=${ARM_NDK_SYSROOT}"
ENV CROSS_COMPILE=${ARM_NDK_TOOLCHAIN}
ENV EXTRA_MAKE_ARGS=WERROR=0
USER perfbuilder
COPY rx_and_build.sh /
ENTRYPOINT ["/rx_and_build.sh"]


And then the rx_and_build.sh is:


#!/bin/sh
# Copyright (c) Red Hat Inc. 2017-
# Arnaldo Carvalho de Melo <acme@redhat.com>
# cross build Dockerfiles must have ENV lines for ARCH and CROSS_COMPILE

export PATH=$PATH:$EXTRA_PATH

if [ -z "$1" ] ; then
	export PERF_TARBALL=http://localhost/perf/perf-latest.tar.xz
else
	export PERF_TARBALL=$1
fi

cd /git
echo "Downloading $PERF_TARBALL..."
curl -OL $PERF_TARBALL || wget $PERF_TARBALL
xzcat `basename $PERF_TARBALL` | tar xf - && \
mv perf-*/ linux && \

cat /git/linux/HEAD

# print the version for dm to harvest and put in the status line
${CROSS_COMPILE}gcc -v

make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/linux/tools/perf O=/tmp/build/perf && \
rm -rf /tmp/build/perf/{.[^.]*,*} && \
make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C /git/linux/tools/perf O=/tmp/build/perf || exit 1

# Bail ou if we don't have clang, print the version for dm to harvest and put in the status line
${CROSS_COMPILE}clang -v || exit 0

rm -rf /tmp/build/perf/{.[^.]*,*} && \
make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/linux/tools/perf O=/tmp/build/perf CC=clang && \
rm -rf /tmp/build/perf/{.[^.]*,*} && \
make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang

rm -rf /tmp/build/perf/{.[^.]*,*} && \
make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBCLANGLLVM=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang

rm -rf /tmp/build/perf/{.[^.]*,*} && \
make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBCLANGLLVM=1 -C /git/linux/tools/perf O=/tmp/build/perf

# Need tp create a MANIFEST on tools/objtool and/or make sure it uses
# only stuff in tools/include/, etc.
#make -C /git/linux/tools/objtool O=/tmp/build/objtool && \
#
# We now use just a detached tarball, not the whole kernel sources
# accessed via NFS, so...
#make -C /git/linux O=/tmp/build/linux defconfig && \
#make -C /git/linux O=/tmp/build/linux headers_install && \
#make -C /git/linux O=/tmp/build/linux samples/bpf/
