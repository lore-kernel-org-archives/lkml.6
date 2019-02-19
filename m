Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3829C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9626D21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfBSPkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:40:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46636 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:40:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0399FEBD;
        Tue, 19 Feb 2019 07:40:04 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DAAE3F690;
        Tue, 19 Feb 2019 07:40:02 -0800 (PST)
Date:   Tue, 19 Feb 2019 15:39:58 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Message-ID: <20190219153958.5cff032b@why.wild-wind.fr.eu.org>
In-Reply-To: <TY1PR01MB1769ECBED0DE9BCC39DF1FDCF57C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
        <20181113130910.22130-3-phil.edworthy@renesas.com>
        <TY1PR01MB1769ECBED0DE9BCC39DF1FDCF57C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 15:27:25 +0000
Phil Edworthy <phil.edworthy@renesas.com> wrote:

> Hello,
> 
> Any comments on this patch?

Err... I'm afraid it fell through the cracks. It's been three months,
and I've paged out most of last year.

Can you please resend it on top of a recent -rc, and I'll try to have a
look. No promise though.

Thanks,

	M.

> 
> Thanks
> Phil
> 
> > -----Original Message-----
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> > Sent: 13 November 2018 13:09
> > To: Marc Zyngier <marc.zyngier@arm.com>; Thomas Gleixner
> > <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>; linux-renesas-
> > soc@vger.kernel.org; linux-kernel@vger.kernel.org; Phil Edworthy
> > <phil.edworthy@renesas.com>
> > Subject: [PATCH v3 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
> > interrupt multiplexer
> > 
> > On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > configured to have 32 interrupt outputs, so we have a total of 96 GPIO
> > interrupts. All of these are passed to the GPIO IRQ Muxer, which selects
> > 8 of the GPIO interrupts to pass onto the GIC. The interrupt signals aren't
> > latched, so there is nothing to do in this driver when an interrupt is received,
> > other than tell the corresponding GPIO block.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v3:
> >  - Use 'interrupt-map' DT property to map the interrupts, this is very similar
> >    to PCIe MSI. The only difference is that we need to get hold of the interrupt
> >    specifier for the interupts coming into the irqmux.
> >  - Do not use a chained interrupt controller.
> > v2:
> >  - Use interrupt-map to allow the GPIO controller info to be specified
> >    as part of the irq.
> >  - Renamed struct and funcs from 'girq' to a more comprehenisble 'irqmux'.
> > ---
> >  drivers/irqchip/Kconfig        |   9 ++
> >  drivers/irqchip/Makefile       |   1 +
> >  drivers/irqchip/rzn1-irq-mux.c | 205
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 215 insertions(+)
> >  create mode 100644 drivers/irqchip/rzn1-irq-mux.c
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > 96451b581452..53c54bba1dd8 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -204,6 +204,15 @@ config RENESAS_IRQC
> >  	select GENERIC_IRQ_CHIP
> >  	select IRQ_DOMAIN
> > 
> > +config RENESAS_RZN1_IRQ_MUX
> > +	bool "Renesas RZ/N1 GPIO IRQ multiplexer support"
> > +	depends on ARCH_RZN1
> > +	select IRQ_DOMAIN
> > +	help
> > +	  Say yes here to add support for the GPIO IRQ multiplexer
> > embedded
> > +	  in Renesas RZ/N1 SoC devices. The GPIO IRQ Muxer selects which of
> > +	  the interrupts coming from the GPIO controllers are used.
> > +
> >  config ST_IRQCHIP
> >  	bool
> >  	select REGMAP
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> > b822199445ff..b090f84dd42e 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_SIRF_IRQ)			+= irq-
> > sirfsoc.o
> >  obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
> > +obj-$(CONFIG_RENESAS_RZN1_IRQ_MUX)	+= rzn1-irq-mux.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> >  obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
> >  obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
> > diff --git a/drivers/irqchip/rzn1-irq-mux.c b/drivers/irqchip/rzn1-irq-mux.c
> > new file mode 100644 index 000000000000..ee7810b9b3f3
> > --- /dev/null
> > +++ b/drivers/irqchip/rzn1-irq-mux.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RZ/N1 GPIO Interrupt Multiplexer
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > +configured
> > + * to have 32 interrupt outputs, so we have a total of 96 GPIO interrupts.
> > + * All of these are passed to the GPIO IRQ Muxer, which selects 8 of
> > +the GPIO
> > + * interrupts to pass onto the GIC.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +
> > +#define MAX_NR_INPUT_IRQS	96
> > +#define MAX_NR_OUTPUT_IRQS	8
> > +
> > +/*
> > + * "interrupt-map" consists of 1 interrupt cell, 0 address cells,
> > +phandle to
> > + * interrupt parent, and parent interrupt specifier (3 cells for GIC),
> > +giving
> > + * a total of 5 cells.
> > + */
> > +#define IMAP_LENGTH		5
> > +
> > +struct irqmux_priv;
> > +struct irqmux_one {
> > +	unsigned int irq;
> > +	unsigned int src_hwirq;
> > +	struct irqmux_priv *priv;
> > +};
> > +
> > +struct irqmux_priv {
> > +	struct device *dev;
> > +	struct irq_domain *irq_domain;
> > +	unsigned int nr_irqs;
> > +	struct irqmux_one mux[MAX_NR_OUTPUT_IRQS]; };
> > +
> > +static irqreturn_t irqmux_handler(int irq, void *data) {
> > +	struct irqmux_one *mux = data;
> > +	struct irqmux_priv *priv = mux->priv;
> > +	unsigned int virq;
> > +
> > +	virq = irq_find_mapping(priv->irq_domain, mux->src_hwirq);
> > +
> > +	generic_handle_irq(virq);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int irqmux_domain_map(struct irq_domain *h, unsigned int irq,
> > +			     irq_hw_number_t hwirq)
> > +{
> > +	irq_set_chip_data(irq, h->host_data);
> > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > handle_simple_irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops irqmux_domain_ops = {
> > +	.map = irqmux_domain_map,
> > +};
> > +
> > +static int irqmux_probe(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct resource *res;
> > +	u32 __iomem *regs;
> > +	struct irqmux_priv *priv;
> > +	unsigned int i;
> > +	int nr_irqs;
> > +	int ret;
> > +	const __be32 *imap;
> > +	int imaplen;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev = dev;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	regs = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(regs))
> > +		return PTR_ERR(regs);
> > +
> > +	nr_irqs = of_irq_count(np);
> > +	if (nr_irqs < 0)
> > +		return nr_irqs;
> > +
> > +	if (nr_irqs > MAX_NR_OUTPUT_IRQS) {
> > +		dev_err(dev, "too many output interrupts\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	priv->nr_irqs = nr_irqs;
> > +
> > +	/* Look for the interrupt-map */
> > +	imap = of_get_property(np, "interrupt-map", &imaplen);
> > +	if (!imap)
> > +		return -ENOENT;
> > +	imaplen /= IMAP_LENGTH * sizeof(__be32);
> > +
> > +	/* Sometimes not all muxs are used */
> > +	if (imaplen < priv->nr_irqs)
> > +		priv->nr_irqs = imaplen;
> > +
> > +	/* Create IRQ domain for the interrupts coming from the GPIO blocks
> > */
> > +	priv->irq_domain = irq_domain_add_linear(np,
> > MAX_NR_INPUT_IRQS,
> > +						 &irqmux_domain_ops, priv);
> > +	if (!priv->irq_domain)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < MAX_NR_INPUT_IRQS; i++)
> > +		irq_create_mapping(priv->irq_domain, i);
> > +
> > +	for (i = 0; i < priv->nr_irqs; i++) {
> > +		struct irqmux_one *mux = &priv->mux[i];
> > +
> > +		ret = irq_of_parse_and_map(np, i);
> > +		if (ret < 0) {
> > +			ret = -ENOENT;
> > +			goto err;
> > +		}
> > +
> > +		mux->irq = ret;
> > +		mux->priv = priv;
> > +
> > +		/*
> > +		 * We need the first cell of the interrupt-map to configure
> > +		 * the hardware.
> > +		 */
> > +		mux->src_hwirq = be32_to_cpu(*imap);
> > +		imap += IMAP_LENGTH;
> > +
> > +		dev_info(dev, "%u: %u mapped irq %u\n", i,  mux-  
> > >src_hwirq,  
> > +			 mux->irq);
> > +
> > +		ret = devm_request_irq(dev, mux->irq, irqmux_handler,
> > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > +				       "irqmux", mux);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to request IRQ: %d\n", ret);
> > +			goto err;
> > +		}
> > +
> > +		/* Set up the hardware to pass the interrupt through */
> > +		writel(mux->src_hwirq, &regs[i]);
> > +	}
> > +
> > +	dev_info(dev, "probed, %d gpio interrupts\n", priv->nr_irqs);
> > +
> > +	return 0;
> > +
> > +err:
> > +	while (i--)
> > +		irq_dispose_mapping(priv->mux[i].irq);
> > +	irq_domain_remove(priv->irq_domain);
> > +
> > +	return ret;
> > +}
> > +
> > +static int irqmux_remove(struct platform_device *pdev) {
> > +	struct irqmux_priv *priv = platform_get_drvdata(pdev);
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < priv->nr_irqs; i++)
> > +		irq_dispose_mapping(priv->mux[i].irq);
> > +	irq_domain_remove(priv->irq_domain);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id irqmux_match[] = {
> > +	{ .compatible = "renesas,rzn1-gpioirqmux", },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, irqmux_match);
> > +
> > +static struct platform_driver irqmux_driver = {
> > +	.driver = {
> > +		.name = "gpio_irq_mux",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = irqmux_match,
> > +	},
> > +	.probe = irqmux_probe,
> > +	.remove = irqmux_remove,
> > +};
> > +
> > +module_platform_driver(irqmux_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas RZ/N1 GPIO IRQ Multiplexer Driver");
> > +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1  
> 



-- 
Without deviation from the norm, progress is not possible.
