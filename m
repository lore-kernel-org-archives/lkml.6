Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBUDMH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:12:07 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45400 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeBUDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:12:06 -0500
X-Google-Smtp-Source: AH8x224ss5Hfzso62WSLBiPuG/98HJEjgdVKwMpykSyu/Q2TqMeU5kzcvuf6J1kZSV3b2lvzaLHr9Q==
Date: Tue, 20 Feb 2018 22:12:04 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] ARM: LTO: avoid THUMB2_KERNEL+LTO
In-Reply-To: <20180220215954.4092811-3-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802202202220.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-3-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> Trying to build an LTO-Enabled kernel with Thumb2 instructions failed
> horribly for me, with an endless output of things like
> 
> ccVnNycO.s:2665: Error: thumb conditional instruction should be in IT block -- `bxne lr'
> ccVnNycO.s:7128: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r2,[r3]'
> ccVnNycO.s:7258: Error: thumb conditional instruction should be in IT block -- `strexeq lr,r0,[r3]'
> ccVnNycO.s:17380: Error: thumb conditional instruction should be in IT block -- `strexeq r1,r2,[r6]'
> ccVnNycO.s:19163: Error: thumb conditional instruction should be in IT block -- `strexeq r8,r6,[r3]'
> ccVnNycO.s:22722: Error: thumb conditional instruction should be in IT block -- `strexeq r7,r1,[r0]'
> ccVnNycO.s:24105: conditional infixes are deprecated in unified syntax
> ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `sbcccs r1,r1,r3'
> ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
> ccVnNycO.s:24210: conditional infixes are deprecated in unified syntax
> ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `sbcccs r2,r2,r3'
> ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
> 
> I did not investigate this too much, disabling Thumb2 support when LTO is
> set lets me build randconfig kernels.
> 
> Since ARM_SINGLE_ARMV7M is Thumb2-only, I have to disallow LTO for V7-M
> targets.

Here's the workaround I sent you on January 2rd:

----- >*
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
----- >8


Nicolas
