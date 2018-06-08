Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kF+OC9NZGluLXgAAmS7hNA
	; Fri, 08 Jun 2018 10:26:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1CD79607A4; Fri,  8 Jun 2018 10:26:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8E1B360590;
	Fri,  8 Jun 2018 10:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E1B360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeFHK0Y convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 06:26:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38334 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeFHK0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:26:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 326A92073D; Fri,  8 Jun 2018 12:26:20 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id B6D4A20376;
        Fri,  8 Jun 2018 12:26:09 +0200 (CEST)
Date: Fri, 8 Jun 2018 12:26:09 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Haim Boot <hayim@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/16] irqchip/irq-mvebu-sei: add new driver for
 Marvell SEI
Message-ID: <20180608122609.0bb051f6@xps13>
In-Reply-To: <b11849f0-3593-51e1-8d4f-b05bfe6412a1@arm.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
        <20180522094042.24770-10-miquel.raynal@bootlin.com>
        <b11849f0-3593-51e1-8d4f-b05bfe6412a1@arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> > +static struct irq_chip mvebu_sei_ap_wired_irq_chip = {
> > +	.name			= "AP wired SEI",
> > +	.irq_mask		= mvebu_sei_mask_irq,
> > +	.irq_unmask		= mvebu_sei_unmask_irq,
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +	.irq_set_type		= irq_chip_set_type_parent,  
> 
> You seem to assume that this driver is purely dealing with edge
> interrupts. And yet you pass the request directly to the parrent. What
> does it mean? Shouldn't you at least check that this is an edge request
> and fail otherwise?

MSI are rising-edge interrupts while wired ones are level (high)
interrupts. I will correct this.


> > +		irq_chip = &mvebu_sei_ap_wired_irq_chip;
> > +		hwirq = fwspec->param[0];
> > +	} else {
> > +		irq_chip = &mvebu_sei_cp_msi_irq_chip;
> > +		spin_lock(&sei->cp_msi_lock);  
> 
> This could as well be a mutex.

Ok.

> 
> > +		hwirq = bitmap_find_free_region(sei->cp_msi_bitmap,
> > +						SEI_IRQ_COUNT, 0);  
> 
> It is a bit weird that you're allocating from a 64bit bitmap while you
> only have 43 interrupts available... At the 44th interrupt, something
> bad is going to happen.

Absolutely, to solve this issue, I just had to:

s/SEI_IRQ_COUNT/sei->cp_interrupts.number/ 

> 
> > +		spin_unlock(&sei->cp_msi_lock);
> > +		if (hwirq < 0)
> > +			return -ENOSPC;
> > +	}
> > +

[...]

> > +static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
> > +{
> > +	struct mvebu_sei *sei = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	unsigned long irqmap, irq_bit;
> > +	u32 reg_idx, virq, irqn;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	/* Read both SEI cause registers (64 bits) */
> > +	for (reg_idx = 0; reg_idx < SEI_IRQ_REG_COUNT; reg_idx++) {
> > +		irqmap = readl_relaxed(sei->base + GICP_SECR(reg_idx));
> > +
> > +		/* Call handler for each set bit */
> > +		for_each_set_bit(irq_bit, &irqmap, SEI_IRQ_COUNT_PER_REG) {
> > +			/* Cause Register gives the SEI number */
> > +			irqn = irq_bit + reg_idx * SEI_IRQ_COUNT_PER_REG;
> > +			/*
> > +			 * Finding Linux mapping (virq) needs the right domain
> > +			 * and the relative hwirq (which start at 0 in both
> > +			 * cases, while irqn is relative to all SEI interrupts).
> > +			 */  
> 
> It is a bit odd that you're virtualizing the hwirq number. The whole
> point of splitting hwirq from virq is that you don't have to do that and
> can use the the raw HW number. You're saving a tiny bit of memory in the
> irq_domain, at the expense of more complexity. I don't know if that's
> worth it...
> 
> > +			if (irqn < sei->ap_interrupts.number) {
> > +				virq = irq_find_mapping(sei->ap_domain, irqn);
> > +			} else {
> > +				irqn -= sei->ap_interrupts.number;
> > +				virq = irq_find_mapping(sei->cp_domain, irqn);
> > +			}
> > +
> > +			/* Call IRQ handler */
> > +			generic_handle_irq(virq);
> > +		}
> > +
> > +		/* Clear interrupt indication by writing 1 to it */
> > +		writel(irqmap, sei->base + GICP_SECR(reg_idx));
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}

[...]

> It feels like this patch could do with a total split:
> 
> - Introduce the wired side of the driver
> - then the MSI part
> 
> Drop the common domain callbacks, and treat the two domains separately.
> I seriously doubt there will be much of an overlap anyway.

Maybe I don't get what "saving a tiny bit of memory" really means in
this situation. What I am doing right now is duplicating hundreds of
lines and changing things like:

        sei_hwirq = mvebu_sei_domain_to_sei_irq(..., hwirq)

into

        sei_hwirq = sei->ap_interrupts.first + d->hwirq;

and 

        sei_hwirq = sei->cp_interrupts.first + d->hwirq;

because I still need to translate this hwirq number into an offset
within 64 bits. In fact, for each configuration/management operation
like clearing, checking or masking an interrupt, a bit must be twisted
within a pair of registers. This offset cannot be just the hwirq
number, it must be shifted depending on the IRQ domain/type of
interrupt.

I'm sorry but I will need more guidance on this because I don't see the
point in duplicating so much code that was factorized.

Thanks,
Miquèl
