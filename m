Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2717FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1ED20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1ED20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGXRHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:07:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388462AbeGXRHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:07:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E6615A2;
        Tue, 24 Jul 2018 09:00:03 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B69C3F237;
        Tue, 24 Jul 2018 08:59:59 -0700 (PDT)
Subject: Re: [PATCH 2/3] drivers/irqchip: Add Actions external interrupts
 support
To:     Parthiban Nallathambi <pn@denx.de>, tglx@linutronix.de,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
References: <20180724150219.1807724-1-pn@denx.de>
 <20180724150219.1807724-3-pn@denx.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <46c0e4e7-7599-2d3f-7188-b5624fe5c389@arm.com>
Date:   Tue, 24 Jul 2018 16:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724150219.1807724-3-pn@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 16:02, Parthiban Nallathambi wrote:
> Actions Semi Owl family SoC's S500, S700 and S900 provides support
> for 3 external interrupt controllers through SIRQ pins.
> 
> Each line can be independently configured as interrupt or wake-up source,
> and triggers either on rising, falling or both edges. Each line can also
> be masked independently.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/irq-owl-sirq.c | 275 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 276 insertions(+)
>  create mode 100644 drivers/irqchip/irq-owl-sirq.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 15f268f646bf..072c4409e7c4 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
>  obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
> +obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
>  obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
>  obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
>  obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
> diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
> new file mode 100644
> index 000000000000..8605da99d77d
> --- /dev/null
> +++ b/drivers/irqchip/irq-owl-sirq.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * Actions Semi Owl SoCs SIRQ interrupt controller driver
> + *
> + * Copyright (C) 2014 Actions Semi Inc.
> + * David Liu <liuwei@actions-semi.com>
> + *
> + * Author: Parthiban Nallathambi <pn@denx.de>
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/irqchip/chained_irq.h>
> +
> +#define OWL_MAX_NR_SIRQS	3
> +
> +/* INTC_EXTCTL register offset for S900 */
> +#define S900_INTC_EXTCTL0	0x200
> +#define S900_INTC_EXTCTL1	0x528
> +#define S900_INTC_EXTCTL2	0x52C
> +
> +/* INTC_EXTCTL register offset for S700 */
> +#define S700_INTC_EXTCTL	0x200
> +
> +#define INTC_EXTCTL_PENDING		BIT(0)
> +#define INTC_EXTCTL_CLK_SEL		BIT(4)
> +#define INTC_EXTCTL_EN			BIT(5)
> +#define	INTC_EXTCTL_TYPE_MASK		GENMASK(6, 7)
> +#define	INTC_EXTCTL_TYPE_HIGH		0
> +#define	INTC_EXTCTL_TYPE_LOW		BIT(6)
> +#define	INTC_EXTCTL_TYPE_RISING		BIT(7)
> +#define	INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
> +
> +struct owl_sirq_info {
> +	void __iomem		*base;
> +	struct irq_domain	*irq_domain;

This is completely global, right? Why do you have this in a
per-interrupt structure?

> +	unsigned long		reg;
> +	unsigned long		hwirq;
> +	unsigned int		virq;
> +	unsigned int		parent_irq;
> +	bool			share_reg;
> +	spinlock_t		lock;

This should be a raw_spinlock_t for the sake of making RT's life easier.

> +};
> +
> +/* s900 has INTC_EXTCTL individual register to handle each line */
> +static struct owl_sirq_info s900_sirq_info[OWL_MAX_NR_SIRQS] = {
> +	{ .reg = S900_INTC_EXTCTL0, .share_reg = false },
> +	{ .reg = S900_INTC_EXTCTL1, .share_reg = false },
> +	{ .reg = S900_INTC_EXTCTL2, .share_reg = false },
> +};
> +
> +/* s500 and s700 shares the 32 bit (24 usable) register for each line */
> +static struct owl_sirq_info s700_sirq_info[OWL_MAX_NR_SIRQS] = {
> +	{ .reg = S700_INTC_EXTCTL, .share_reg = true },
> +	{ .reg = S700_INTC_EXTCTL, .share_reg = true },
> +	{ .reg = S700_INTC_EXTCTL, .share_reg = true },
> +};
> +
> +static unsigned int sirq_read_extctl(struct owl_sirq_info *sirq)
> +{
> +	unsigned int val;
> +
> +	val = readl_relaxed(sirq->base + sirq->reg);
> +	if (sirq->share_reg)

Is there a system that can have both "shared" and "non-shared"
controllers? If that's not the case (which I strongly suspect), why
isn't that a global property, a static key, or even a different set of
operations altogether?

> +		val = (val >> (2 - sirq->hwirq) * 8) & 0xff;
> +
> +	return val;
> +}
> +
> +static void sirq_write_extctl(struct owl_sirq_info *sirq, unsigned int extctl)
> +{
> +	unsigned int val;
> +
> +	if (sirq->share_reg) {
> +		val = readl_relaxed(sirq->base + sirq->reg);
> +		val &= ~(0xff << (2 - sirq->hwirq) * 8);
> +		extctl &= 0xff;
> +		extctl = (extctl << (2 - sirq->hwirq) * 8) | val;
> +	}
> +
> +	writel_relaxed(extctl, sirq->base + sirq->reg);
> +}
> +
> +static void owl_sirq_ack(struct irq_data *d)
> +{
> +	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
> +	unsigned int extctl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sirq->lock, flags);
> +
> +	extctl = sirq_read_extctl(sirq);
> +	extctl |= INTC_EXTCTL_PENDING;
> +	sirq_write_extctl(sirq, extctl);
> +
> +	spin_unlock_irqrestore(&sirq->lock, flags);
> +}
> +
> +static void owl_sirq_mask(struct irq_data *d)
> +{
> +	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
> +	unsigned int extctl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sirq->lock, flags);
> +
> +	extctl = sirq_read_extctl(sirq);
> +	extctl &= ~(INTC_EXTCTL_EN);
> +	sirq_write_extctl(sirq, extctl);
> +
> +	spin_unlock_irqrestore(&sirq->lock, flags);
> +}
> +
> +static void owl_sirq_unmask(struct irq_data *d)
> +{
> +	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
> +	unsigned int extctl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sirq->lock, flags);
> +
> +	/* we don't hold the irq pending generated before irq enabled */

What do you mean here?

> +	extctl = sirq_read_extctl(sirq);
> +	extctl |= INTC_EXTCTL_EN;
> +	sirq_write_extctl(sirq, extctl);
> +
> +	spin_unlock_irqrestore(&sirq->lock, flags);
> +}
> +
> +/* PAD_PULLCTL needs to be defined in pinctrl */
> +static int owl_sirq_set_type(struct irq_data *d, unsigned int flow_type)
> +{
> +	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
> +	unsigned int extctl, type;
> +	unsigned long flags;
> +
> +	switch (flow_type) {
> +	case IRQF_TRIGGER_LOW:
> +		type = INTC_EXTCTL_TYPE_LOW;
> +		break;
> +	case IRQF_TRIGGER_HIGH:
> +		type = INTC_EXTCTL_TYPE_HIGH;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		type = INTC_EXTCTL_TYPE_FALLING;
> +		break;
> +	case IRQF_TRIGGER_RISING:
> +		type = INTC_EXTCTL_TYPE_RISING;

You advertise being able to trigger on both edges in your commit
description, but this doesn't seem to be the case here.

> +		break;
> +	default:
> +		return  -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&sirq->lock, flags);
> +
> +	extctl = sirq_read_extctl(sirq);
> +	extctl &= ~(INTC_EXTCTL_PENDING | INTC_EXTCTL_TYPE_MASK);
> +	extctl |= type;
> +	sirq_write_extctl(sirq, extctl);
> +
> +	spin_unlock_irqrestore(&sirq->lock, flags);

And what about the parent IRQ? is the signalling always level?

> +
> +	return 0;
> +}
> +
> +static void owl_sirq_handler(struct irq_desc *desc)
> +{
> +	struct owl_sirq_info *sirq = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int extctl;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	extctl = sirq_read_extctl(sirq);
> +	if (extctl & INTC_EXTCTL_PENDING)
> +		generic_handle_irq(sirq->virq);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static struct irq_chip owl_irq_chip = {
> +	.name = "owl-sirq",
> +	.irq_ack = owl_sirq_ack,
> +	.irq_mask = owl_sirq_mask,
> +	.irq_unmask = owl_sirq_unmask,
> +	.irq_set_type = owl_sirq_set_type,

Where is the wake-up handling that you advertised above?

> +};
> +
> +static int __init owl_sirq_init(struct owl_sirq_info *sirq_info, int nr_sirq,
> +				struct device_node *np)
> +{
> +	struct owl_sirq_info *sirq;
> +	void __iomem *base;
> +	struct irq_domain *irq_domain;
> +	int i, irq_base;
> +	unsigned int extctl;
> +	u8 sample_clk[OWL_MAX_NR_SIRQS];
> +
> +	base = of_iomap(np, 0);
> +	if (!base)
> +		return -ENOMEM;
> +
> +	irq_base = irq_alloc_descs(-1, 32, nr_sirq, 0);

No. Descriptors are supposed to be allocated on demand by core code, and
not by irqchip drivers.

> +	if (irq_base < 0) {
> +		pr_err("sirq: failed to allocate IRQ numbers\n");
> +		goto out_unmap;
> +	}
> +
> +	irq_domain = irq_domain_add_legacy(np, nr_sirq, irq_base, 0,
> +					&irq_domain_simple_ops, NULL);

Legacy? What legacy? A modern DT platform has no need for this, so
please stick to a linear domain (though see below).

> +	if (!irq_domain) {
> +		pr_err("sirq: irq domain init failed\n");
> +		goto out_free_desc;
> +	}
> +
> +	memset(sample_clk, 0, sizeof(sample_clk));
> +	of_property_read_u8_array(np, "sampling-rate-24m", sample_clk,
> +				nr_sirq);

I find this most bizarre. Why is the sampling rate configurable? How do
you even decide which sample rate you want? Frankly, I'd rather see
24MHz being the default (because 32KHz feels incredibly low).

> +
> +	for (i = 0; i < nr_sirq; i++) {
> +		sirq = &sirq_info[i];
> +
> +		sirq->base = base;
> +		sirq->irq_domain = irq_domain;
> +		sirq->hwirq = i;
> +		sirq->virq = irq_base + i;
> +
> +		sirq->parent_irq = irq_of_parse_and_map(np, i);
> +		irq_set_handler_data(sirq->parent_irq, sirq);
> +		irq_set_chained_handler_and_data(sirq->parent_irq,
> +						owl_sirq_handler, sirq);
> +
> +		irq_set_chip_and_handler(sirq->virq, &owl_irq_chip,
> +				handle_level_irq);
> +		irq_set_chip_data(sirq->virq, sirq);
> +
> +		if (sample_clk[i]) {
> +			extctl = sirq_read_extctl(sirq);
> +			extctl |= INTC_EXTCTL_CLK_SEL;
> +			sirq_write_extctl(sirq, extctl);
> +		}
> +		spin_lock_init(&sirq->lock);
> +	}

I have the feeling you may have the wrong end of the stick here. The way
I understand your system, you have 3 SPIs that are brought out of the
SoC, with a tiny bit of glue logic that allows the interrupt polarity to
be tweaked.

If I understood it right, then this should be represented as a
hierarchical irqchip, such as drivers/irqchip/irq-mtk-sysirq.c which
does the same thing. The whole ack/mask dance feels completely
pointless, as we already have the same controls at the GIC level.

> +
> +	return 0;
> +
> +out_free_desc:
> +	irq_free_descs(irq_base, nr_sirq);
> +out_unmap:
> +	iounmap(base);
> +
> +	return -EINVAL;
> +}
> +
> +static int __init s700_sirq_of_init(struct device_node *np,
> +					struct device_node *parent)
> +{
> +	return owl_sirq_init(s700_sirq_info, ARRAY_SIZE(s700_sirq_info), np);
> +}
> +IRQCHIP_DECLARE(s700_sirq, "actions,s700-sirq", s700_sirq_of_init);
> +
> +static int __init s900_sirq_of_init(struct device_node *np,
> +					struct device_node *parent)
> +{
> +	return owl_sirq_init(s900_sirq_info, ARRAY_SIZE(s900_sirq_info), np);
> +}
> +IRQCHIP_DECLARE(s900_sirq, "actions,s900-sirq", s900_sirq_of_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
