Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E71E2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E71E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeIGRha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:37:30 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56463 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbeIGRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:37:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0754758|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CniazSD_1536324936;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CniazSD_1536324936)
          by smtp.aliyun-inc.com(10.147.41.121);
          Fri, 07 Sep 2018 20:55:37 +0800
Date:   Fri, 7 Sep 2018 20:55:36 +0800
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
Message-ID: <20180907125536.GA2308@guoren>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
 <20180907030447.GA10434@guoren-Inspiron-7460>
 <CAK8P3a2K_ecCQEs840hQMrjsf4H8hHxS+HtM2TtPDYpRu8-LeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2K_ecCQEs840hQMrjsf4H8hHxS+HtM2TtPDYpRu8-LeQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:14:38AM +0200, Arnd Bergmann wrote:
> On Fri, Sep 7, 2018 at 5:04 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Thu, Sep 06, 2018 at 04:31:16PM +0200, Arnd Bergmann wrote:
> > > On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > Can you describe how C-Sky hardware implements MMIO?
> > Our mmio is uncachable and strong-order address, so there is no need
> > barriers for access these io addr.
> >
> >  #define ioremap_wc ioremap_nocache
> >  #define ioremap_wt ioremap_nocache
> >
> > Current ioremap_wc and ioremap_wt implementation are too simple and
> > we'll improve it in future.
> >
> > > In particular:
> > >
> > > - Is a read from uncached memory always serialized with DMA, and with
> > >   other CPUs doing MMIO access to a different address?
> > CPU use ld.w to get data from uncached strong order memory.
> > Other CPUs use the same mmio vaddr to access the uncachable strong order
> > memory paddr.
> 
> Ok, but what about the DMA? The most common requirement for
> serialization here is with a DMA transfer, where you first write
> into a buffer in memory, then write to an MMIO register to trigger
> a DMA-load, and then the device reads the data from memory.
> Without a barrier before the MMIO, the data may still be in a
> store queue of the CPU, and the DMA gets stale data.

> 
> Similarly, an MMIO read may be used to see if a DMA has completed
> and the device register tells you that the DMA has left the device,
> but without a barrier, the CPU may have prefetched the DMA
> data while waiting for the MMIO-read to complete. The __io_ar()
> barrier() in asm-generic/io.h prevents the compiler from reordering
> the two reads, but if an weakly ordered read (in coherent DMA buffer)
> can bypass a strongly ordered read (MMIO), then it's still still
> broken.
__io_ar() barrier()? not rmb() ?! I've defined the rmb in asm/barrier, So
I got rmb() here not barrier().

Only __io_br() is barrier().

> > > - How does endianess work? Are there any buses that flip bytes around
> > >   when running big-endian, or do you always do that in software?
> > Currently we only support little-endian and soc will follow it.
> 
> Ok, that makes it easier. If you think that you won't even need big-endian
> support in the long run, you could also remove your asm/byteorder.h
> header. If you're not sure, it doesn't hurt to keep it of course.
Em... I'm not sure, so let me keep it for a while.

Best Regards
 Guo Ren
