Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40308214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40308214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeHBLo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:44:56 -0400
Received: from verein.lst.de ([213.95.11.211]:38908 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeHBLo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:44:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8775468D64; Thu,  2 Aug 2018 11:59:11 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:59:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: [PATCH 5/9] RISC-V: implement low-level interrupt handling
Message-ID: <20180802095911.GA14841@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-6-hch@lst.de> <alpine.DEB.2.21.1808021147540.2037@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808021147540.2037@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:48:55AM +0200, Thomas Gleixner wrote:
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 9aaf6c986771..fa2c08e3c05e 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -168,8 +168,8 @@ ENTRY(handle_exception)
> >  
> >  	/* Handle interrupts */
> >  	move a0, sp /* pt_regs */
> > -	REG_L a1, handle_arch_irq
> > -	jr a1
> > +	move a1, s4 /* scause */
> > +	tail do_IRQ
> 
> What's the reason for doing the whole exception dance in ASM ?

I'll let Palmer defend it.  But for now I just want minimal changes
to actually get a booting system..
