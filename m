Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeFAIbT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:31:19 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38955 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeFAIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:31:13 -0400
X-Google-Smtp-Source: ADUXVKL885URfWFkEg6ZQ9jMpM93h23TYWeAgBzXV9PBdXF3erlT+0mEAxWIpLsr3gIM0212KrHuWgbeLlwYeF2DcEY=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT0S-4qq1T3q25H0BGsJSUpTsgV_+TGKBiPW-MUKyqzsQ@mail.gmail.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNATmbiigNnPmfwOgMHqxyTOJ0H4ROMAfHZKqRxYN+W-=1w@mail.gmail.com> <CAK7LNAT0S-4qq1T3q25H0BGsJSUpTsgV_+TGKBiPW-MUKyqzsQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 1 Jun 2018 10:31:11 +0200
X-Google-Sender-Auth: qmPEtfpGI251vXxxrpc1Us5bdc0
Message-ID: <CAK8P3a0SSJCK36JWxMuTWX1vCF4y7Rys8QL=_nz6syPsR_+c=w@mail.gmail.com>
Subject: Re: [PATCH v5 00/31] kconfig: move compiler capability tests to Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 2:38 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-05-28 21:23 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2018-05-28 18:21 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:

>
> I pushed this series to the for-next branch.
> Unless a significant problem is reported,
> I'd like to merge this series in the upcoming MW.
> At least, I need to keep it in linux-next for a while.
>
> Your comments and tags are still appreciated.
> I will add tags (or replace patches if necessary) later,
> but I want this series tested in linux-next
> to expose to more developers' eyes.
>
> It passed my local test.  O-day bot did not report anything so far.

I found a problem when using ccache, resulting in this output while building
scripts/kconfig:

$  make V=1 O=obj-tmp/ CC="ccache gcc" defconfig
make[1]: Entering directory '/git/arm-soc'
make -C /home/arnd/arm-soc/obj-tmp KBUILD_SRC=/git/arm-soc \
-f /git/arm-soc/Makefile defconfig
make[2]: Entering directory '/git/arm-soc/obj-tmp'
make -f ../scripts/Makefile.build obj=scripts/basic
  gcc -Wp,-MD,scripts/basic/.fixdep.d -Iscripts/basic -Wall
-Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-std=gnu89  -o scripts/basic/fixdep ../scripts/basic/fixdep.c
rm -f .tmp_quiet_recordmcount
ln -fsn .. source
/bin/bash ../scripts/mkmakefile \
    .. . 4 17
make -f ../scripts/Makefile.build obj=scripts/kconfig defconfig
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Iscripts/kconfig -Wall
-Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-std=gnu89 -c -o scripts/kconfig/conf.o ../scripts/kconfig/conf.c
  bison -oscripts/kconfig/zconf.tab.c -t -l ../scripts/kconfig/zconf.y
  flex -oscripts/kconfig/zconf.lex.c -L ../scripts/kconfig/zconf.l
  gcc -Wp,-MD,scripts/kconfig/.zconf.tab.o.d -Iscripts/kconfig -Wall
-Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-std=gnu89  -I../scripts/kconfig -c -o scripts/kconfig/zconf.tab.o
scripts/kconfig/zconf.tab.c
  gcc  -o scripts/kconfig/conf scripts/kconfig/conf.o
scripts/kconfig/zconf.tab.o
scripts/kconfig/conf  --defconfig=arch/arm/configs/multi_v7_defconfig Kconfig
ccache: invalid option -- 'r'
Usage:
    ccache [options]
    ccache compiler [compiler options]
    compiler [compiler options]          (via symbolic link)

Options:
    -c, --cleanup         delete old files and recalculate size counters
                          (normally not needed as this is done automatically)
    -C, --clear           clear the cache completely (except configuration)
    -F, --max-files=N     set maximum number of files in cache to N (use 0 for
                          no limit)
    -M, --max-size=SIZE   set maximum size of cache to SIZE (use 0 for no
                          limit); available suffixes: k, M, G, T (decimal) and
                          Ki, Mi, Gi, Ti (binary); default suffix: G
    -o, --set-config=K=V  set configuration key K to value V
    -p, --print-config    print current configuration options
    -s, --show-stats      show statistics summary
    -z, --zero-stats      zero statistics counters

    -h, --help            print this help text
    -V, --version         print version and copyright information

See also <https://ccache.samba.org>.
#
# configuration written to .config
#
make[2]: Leaving directory '/git/arm-soc/obj-tmp'
make[1]: Leaving directory '/git/arm-soc'

It appears to just keep going after this output, but clearly something is wrong.
I bisected it to bde197706614 ("gcc-plugins: test plugin support in Kconfig
and clean up Makefile").

     Arnd
