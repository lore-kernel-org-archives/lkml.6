Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BDDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED5C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED5C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeIGHoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:44:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56942 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbeIGHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:44:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07716261|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CnW3XSL_1536289489;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnW3XSL_1536289489)
          by smtp.aliyun-inc.com(10.147.42.197);
          Fri, 07 Sep 2018 11:04:49 +0800
Date:   Fri, 7 Sep 2018 11:04:49 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 06/26] csky: Cache and TLB routines
Message-ID: <20180907030447.GA10434@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:31:16PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> > new file mode 100644
> > index 0000000..fcb2142
> > --- /dev/null
> > +++ b/arch/csky/include/asm/io.h
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#ifndef __ASM_CSKY_IO_H
> > +#define __ASM_CSKY_IO_H
> > +
> > +#include <abi/pgtable-bits.h>
> > +#include <linux/types.h>
> > +#include <linux/version.h>
> > +
> > +extern void __iomem *ioremap(phys_addr_t offset, size_t size);
> > +
> > +extern void iounmap(void *addr);
> > +
> > +extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
> > +               size_t size, unsigned long flags);
> > +
> > +#define ioremap_nocache(phy, sz)       ioremap(phy, sz)
> > +#define ioremap_wc ioremap_nocache
> > +#define ioremap_wt ioremap_nocache
> > +
> > +#include <asm-generic/io.h>
> 
> It is very unusual for an architecture to not need special handling in asm/io.h,
> to do the proper barriers etc.
> 
> Can you describe how C-Sky hardware implements MMIO?
Our mmio is uncachable and strong-order address, so there is no need
barriers for access these io addr.

 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache

Current ioremap_wc and ioremap_wt implementation are too simple and
we'll improve it in future.

> In particular:
> 
> - Is a read from uncached memory always serialized with DMA, and with
>   other CPUs doing MMIO access to a different address?
CPU use ld.w to get data from uncached strong order memory.
Other CPUs use the same mmio vaddr to access the uncachable strong order
memory paddr.

> - How does endianess work? Are there any buses that flip bytes around
>   when running big-endian, or do you always do that in software?
Currently we only support little-endian and soc will follow it.

 Guo Ren
