Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeCOOaT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:30:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751980AbeCOOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:30:17 -0400
Date: Thu, 15 Mar 2018 11:30:12 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New -Werror=restrict error with incremental gcc
Message-ID: <20180315143012.GA2221@redhat.com>
References: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 14, 2018 at 02:19:41PM -0700, Laura Abbott escreveu:
> Hi,
> 
> Fedora picked up a new gcc (8.0.1-0.18.fc29) and it seems to have introduced a new error:
> 
>   gcc -Wp,-MD,/home/labbott/linux/tools/objtool/.str_error_r.o.d -Wp,-MT,/home/labbott/linux/tools/objtool/str_error_r.o -Wall -Werror -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wshadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3 -Wno-switch-default -Wno-switch-enum -Wno-packed -fomit-frame-pointer -O2 -g -I/home/labbott/linux/tools/include -I/home/labbott/linux/tools/arch/x86/include/uapi -I/home/labbott/linux/tools/objtool/arch/x86/include -I/home/labbott/linux/tools/lib -D"BUILD_STR(s)=#s" -c -o /home/labbott/linux/tools/objtool/str_error_r.o ../lib/str_error_r.c
> ../lib/str_error_r.c: In function ‘str_error_r’:
> ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
>    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
>    ^~
> 
> This looks like gcc is now warning about the aliasing from printing out buf
> while printing to the buffer. I can work around this pretty easily but I
> know people have strong opinions about gcc warnings. Any thoughts?

I couldn't reproduce it here:

[perfbuilder@b34646cdb12b perf]$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap
--enable-languages=c,c++,objc,obj-c++,fortran,ada,go,lto --prefix=/usr
--mandir=/usr/share/man --infodir=/usr/share/info
--with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared
--enable-threads=posix --enable-checking=release --enable-multilib
--with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions
--enable-gnu-unique-object --enable-linker-build-id
--with-gcc-major-version-only --with-linker-hash-style=gnu
--enable-plugin --enable-initfini-array --with-isl --enable-libmpx
--enable-offload-targets=nvptx-none --without-cuda-driver
--enable-gnu-indirect-function --with-tune=generic --with-arch_32=i686
--build=x86_64-redhat-linux
Thread model: posix
gcc version 8.0.1 20180310 (Red Hat 8.0.1-0.17) (GCC) 
[perfbuilder@b34646cdb12b perf]$ rpm -q gcc
gcc-8.0.1-0.17.fc29.x86_64
[perfbuilder@b34646cdb12b perf]$

[perfbuilder@b34646cdb12b perf]$ make O=/tmp/build/kernel/ 
make[1]: Entering directory '/tmp/build/kernel'
  CHK     include/config/kernel.release
  Using /git/perf as source for kernel
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    /git/perf/scripts/checksyscalls.sh
  DESCEND  objtool
  CC       /tmp/build/kernel/tools/objtool/str_error_r.o
  LD       /tmp/build/kernel/tools/objtool/objtool-in.o
  LINK     /tmp/build/kernel/tools/objtool/objtool
  CHK     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/asn1_compiler


:-\

But I noticed some of those warnings and started action on then for
tools/perf, things like:

"perf annotate: Use asprintf when formatting objdump command line"

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?id=f22ed8ad2ca0

- Arnaldo
