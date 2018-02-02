Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeBBVRT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:17:19 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35402 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBBVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:17:10 -0500
X-Google-Smtp-Source: AH8x224u1QAIXsprIu/IY9VDgw9MRlLMaAQfK6/jVa3nuTRgY5vwGadzUjJB7DdRtRSC04x/oRt/CA==
Date: Fri, 2 Feb 2018 16:17:08 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 7/7] Kbuild: lto: pass -m32/-m64 to to LDFINAL
In-Reply-To: <CAK8P3a3R79Hd7QWdskfRscA1UndQGPaLP3rcKdykEOqPr1ja=Q@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1802021609240.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-7-arnd@arndb.de> <nycvar.YSQ.7.76.1802021336090.1842@knanqh.ubzr> <CAK8P3a3dgFjXP3wub+J5-_67MS2Mm_twktD=cyoY2pPro+AWzQ@mail.gmail.com> <nycvar.YSQ.7.76.1802021523390.1842@knanqh.ubzr>
 <CAK8P3a3R79Hd7QWdskfRscA1UndQGPaLP3rcKdykEOqPr1ja=Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Arnd Bergmann wrote:

> On Fri, Feb 2, 2018 at 9:38 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Fri, 2 Feb 2018, Arnd Bergmann wrote:
> >
> >> Do you have a git tree with other changes for LTO on ARM? I'd
> >> like to try that as well.
> >
> > I currently have only 2 other patches.
> >
> > You need commit 75fea300d73a that just hit mainline (you may cherry-pick
> > it easily if necessary).
> 
> Ok, I apparently have that already by basing on today's linux-next.

OK. linux-next has had it for quite a while.

> > Then the following:
> >
> > ----- >8
> > Subject: [PATCH] HACK: enable LTO on ARM
> >
> > Without the ${KBUILD_VMLINUX_LIBS} move the build fails with missing
> > memcpy all over the place. Didn't figure it out yet.
> 
> Added that now as well, thanks! I'll see what comes out of it.

I forgot: you'll need to hack your toolchain a bit too.

Here's the script I created to remember about the issue:

----- >8
#!/bin/bash

# work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78353

GCC_ROOT=/opt/gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf

set -e
set -x

cd $GCC_ROOT//arm-linux-gnueabihf/bin
[ -e fat-as ] && exit 1
mv as fat-as
cat > as << EOF
#!/bin/bash
exec -a "\$0" "\$(dirname "\$0")/fat-as" -mimplicit-it=always "\$@"
EOF
chmod +x as
8< -----

> Have you tried arm64 already? I suppose I could do the same change 
> there and see what happens.

No, didn't try arm64.


Nicolas
