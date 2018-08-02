Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80433C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380BF214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380BF214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbeHBNh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:37:26 -0400
Received: from verein.lst.de ([213.95.11.211]:39327 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbeHBNhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:37:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 357206FD12; Thu,  2 Aug 2018 13:51:18 +0200 (CEST)
Date:   Thu, 2 Aug 2018 13:51:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
Message-ID: <20180802115118.GB21984@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-8-hch@lst.de> <alpine.DEB.2.21.1808021149470.2037@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808021149470.2037@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 12:04:04PM +0200, Thomas Gleixner wrote:
> 
> On Thu, 26 Jul 2018, Christoph Hellwig wrote:
> 
> > This patch adds a driver for the Platform Level Interrupt Controller (PLIC)
> 
> See Documentation/process/submitting-patches.rst and search for 'This patch'

Fixed.

> > +static DEFINE_SPINLOCK(plic_toggle_lock);
> 
> RAW_SPINLOCK please.

Done.

> > +static inline void plic_irq_toggle(struct irq_data *d, int enable)
> > +{
> > +	int cpu;
> > +
> > +	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
> > +	for_each_present_cpu(cpu)
> > +		plic_toggle(cpu, d->hwirq, enable);
> 
> I suggest to make that:
> 
> 	for_each_cpu(cpu, irq_data_get_affinity_mask(d))
> 		plic_toggle(cpu, d->hwirq, enable);

Done.

> That gives you immediately support for interrupt affinity. And then it's
> trivial to do the actual irq_chip::irq_set_affinity() magic as well.

I'll defer that to an incremental patch (added to my todo list).

> > +static void plic_handle_irq(struct pt_regs *regs)
> > +{
> > +	void __iomem *claim =
> > +		plic_hart_offset(smp_processor_id()) + CONTEXT_CLAIM;
> 
> Either ignore the 80 char thing or just move the assignment into the code
> section please. That line break is horrible to read.

That area has been rewritten anyway as we need a cpuid to context
lookup to cover real SOCs vs just qemu.
