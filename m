Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938160AbeBUPO0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:14:26 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33423 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeBUPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:13:11 -0500
X-Google-Smtp-Source: AH8x225wLYL3oeLzBOjC9BzfqcQp8YBNZhzG/fTmHEuYcKMBVFEm9Zy+/LXKbTVwzH1TzzZ7VdsEcQ==
Date: Wed, 21 Feb 2018 10:13:08 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <CAK8P3a3S=PRwOnvtzFENMC+iTLRMiibpMmSS=GynLMSfN1OpZA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1802211004420.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-2-arnd@arndb.de> <nycvar.YSQ.7.76.1802202158020.31644@knanqh.ubzr> <CAK8P3a3S=PRwOnvtzFENMC+iTLRMiibpMmSS=GynLMSfN1OpZA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Arnd Bergmann wrote:

> On Wed, Feb 21, 2018 at 4:01 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 20 Feb 2018, Arnd Bergmann wrote:
> >
> >> This fails during deflate_xip_data.sh
> >>
> >>   /home/arnd/cross-gcc/bin/arm-linux-gnueabi-objcopy -O binary -R .comment -S  vmlinux arch/arm/boot/xipImage && /bin/bash -c '/git/arm-soc/arch/arm/boot/deflate_xip_data.sh vmlinux arch/arm/boot/xipImage || { rm -f arch/arm/boot/xipImage; false; }'
> >> make -f /git/arm-soc/scripts/Makefile.modpost
> >> + sym_val __data_loc
> >> + sed -n / __data_loc$/{s/ .*$//p;q}
> >> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> >> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> >> + local val=ac74c0f4
> >> + [ ac74c0f4 ]
> >> + echo 2893332724
> >> + __data_loc=2893332724
> >> + sym_val _edata_loc
> >> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> >> + sed -n / _edata_loc$/{s/ .*$//p;q}
> >> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> >> + local val=ac7b8744
> >> + [ ac7b8744 ]
> >> + echo 2893776708
> >> + _edata_loc=2893776708
> >> + sym_val _xiprom
> >> + sed -n / _xiprom$/{s/ .*$//p;q}
> >> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> >> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> >>
> >> Obviously we want to make the combination work, no idea why it doesn't.
> >>
> >
> > You should move this to config XIP_DEFLATED_DATA instead.
> 
> Right, makes sense. I'd still prever nm to not crash, but that would be a small
> improvement.

I'll have a look at nm.

However this feature is linked to head-inflate-data.c (your patch #5/7) 
and I have no obvious quick solution in mind for that one.


Nicolas
