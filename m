Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE61C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2A214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF2A214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeHBLyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:54:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36299 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeHBLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:54:40 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flASi-0003G4-Ff; Thu, 02 Aug 2018 12:04:04 +0200
Date:   Thu, 2 Aug 2018 12:04:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     palmer@sifive.com, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anup@brainfault.org,
        atish.patra@wdc.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
In-Reply-To: <20180726143723.16585-8-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1808021149470.2037@nanos.tec.linutronix.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-8-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jul 2018, Christoph Hellwig wrote:

> This patch adds a driver for the Platform Level Interrupt Controller (PLIC)

See Documentation/process/submitting-patches.rst and search for 'This patch'

> +static inline void __iomem *plic_hart_offset(int ctxid)
> +{
> +	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
> +}
> +
> +/*
> + * Protect mask operations on the registers given that we can't assume that
> + * atomic memory operations work on them.
> + */
> +static DEFINE_SPINLOCK(plic_toggle_lock);

RAW_SPINLOCK please.

> +
> +static inline void plic_toggle(int ctxid, int hwirq, int enable)
> +{
> +	u32 __iomem *reg = plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
> +	u32 hwirq_mask = 1 << (hwirq % 32);
> +
> +	spin_lock(&plic_toggle_lock);
> +	if (enable)
> +		writel(readl(reg) | hwirq_mask, reg);
> +	else
> +		writel(readl(reg) & ~hwirq_mask, reg);
> +	spin_unlock(&plic_toggle_lock);
> +}
> +
> +static inline void plic_irq_toggle(struct irq_data *d, int enable)
> +{
> +	int cpu;
> +
> +	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
> +	for_each_present_cpu(cpu)
> +		plic_toggle(cpu, d->hwirq, enable);

I suggest to make that:

	for_each_cpu(cpu, irq_data_get_affinity_mask(d))
		plic_toggle(cpu, d->hwirq, enable);
       
That gives you immediately support for interrupt affinity. And then it's
trivial to do the actual irq_chip::irq_set_affinity() magic as well.

> +/*
> + * Handling an interrupt is a two-step process: first you claim the interrupt
> + * by reading the claim register, then you complete the interrupt by writing
> + * that source ID back to the same claim register.  This automatically enables
> + * and disables the interrupt, so there's nothing else to do.
> + */
> +static void plic_handle_irq(struct pt_regs *regs)
> +{
> +	void __iomem *claim =
> +		plic_hart_offset(smp_processor_id()) + CONTEXT_CLAIM;

Either ignore the 80 char thing or just move the assignment into the code
section please. That line break is horrible to read.

> +	irq_hw_number_t hwirq;
> +

Other than that this looks halfways sane.

Thanks,

	tglx
