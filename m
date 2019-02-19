Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F14C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868C02147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfBSU2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:28:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfBSU2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:28:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A009EBD;
        Tue, 19 Feb 2019 12:28:51 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5885C3F690;
        Tue, 19 Feb 2019 12:28:49 -0800 (PST)
Date:   Tue, 19 Feb 2019 20:28:42 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Message-ID: <20190219202842.59bc7719@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219155511.28507-3-phil.edworthy@renesas.com>
References: <20190219155511.28507-1-phil.edworthy@renesas.com>
        <20190219155511.28507-3-phil.edworthy@renesas.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 15:55:11 +0000
Phil Edworthy <phil.edworthy@renesas.com> wrote:

+ LinusW, who seem to have taken an interest in irqchip hierarchies...

> On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> configured to have 32 interrupt outputs, so we have a total of 96 GPIO
> interrupts. All of these are passed to the GPIO IRQ Muxer, which selects
> 8 of the GPIO interrupts to pass onto the GIC. The interrupt signals
> aren't latched, so there is nothing to do in this driver when an interrupt
> is received, other than tell the corresponding GPIO block.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v4:
>  - No change.
> v3:
>  - Use 'interrupt-map' DT property to map the interrupts, this is very similar
>    to PCIe MSI. The only difference is that we need to get hold of the interrupt
>    specifier for the interupts coming into the irqmux.
>  - Do not use a chained interrupt controller.
> v2:
>  - Use interrupt-map to allow the GPIO controller info to be specified
>    as part of the irq.
>  - Renamed struct and funcs from 'girq' to a more comprehenisble 'irqmux'.
> ---
>  drivers/irqchip/Kconfig        |   9 ++
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/rzn1-irq-mux.c | 205 +++++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+)
>  create mode 100644 drivers/irqchip/rzn1-irq-mux.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 5dcb5456cd14..369f78d6b521 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -211,6 +211,15 @@ config RENESAS_IRQC
>  	select GENERIC_IRQ_CHIP
>  	select IRQ_DOMAIN
>  
> +config RENESAS_RZN1_IRQ_MUX
> +	bool "Renesas RZ/N1 GPIO IRQ multiplexer support"
> +	depends on ARCH_RZN1
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to add support for the GPIO IRQ multiplexer embedded
> +	  in Renesas RZ/N1 SoC devices. The GPIO IRQ Muxer selects which of
> +	  the interrupts coming from the GPIO controllers are used.
> +
>  config ST_IRQCHIP
>  	bool
>  	select REGMAP
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 7acd0e36d0b4..2edd42ef2182 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
>  obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
> +obj-$(CONFIG_RENESAS_RZN1_IRQ_MUX)	+= rzn1-irq-mux.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
>  obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
>  obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
> diff --git a/drivers/irqchip/rzn1-irq-mux.c b/drivers/irqchip/rzn1-irq-mux.c
> new file mode 100644
> index 000000000000..ee7810b9b3f3
> --- /dev/null
> +++ b/drivers/irqchip/rzn1-irq-mux.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/N1 GPIO Interrupt Multiplexer
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each configured
> + * to have 32 interrupt outputs, so we have a total of 96 GPIO interrupts.
> + * All of these are passed to the GPIO IRQ Muxer, which selects 8 of the GPIO
> + * interrupts to pass onto the GIC.

So that I get it right:

- 96 inputs
- 8 outputs

This driver picks 8 of the inputs (and at most 8), and pass then down
to the GIC. Do I understand that correctly?

> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +
> +#define MAX_NR_INPUT_IRQS	96
> +#define MAX_NR_OUTPUT_IRQS	8
> +
> +/*
> + * "interrupt-map" consists of 1 interrupt cell, 0 address cells, phandle to
> + * interrupt parent, and parent interrupt specifier (3 cells for GIC), giving
> + * a total of 5 cells.
> + */
> +#define IMAP_LENGTH		5

Although the maths do check out, I find it rather dangerous. The
versatile nature of DT makes me say that sooner or later, someone is
going to punt this in front of something that will need more than 3
interrupt cells for the parent irqchip, and things will be...
interesting. Even GICv3 in some configuration requires 4 cells.

You've been warned! ;-)

> +
> +struct irqmux_priv;
> +struct irqmux_one {
> +	unsigned int irq;
> +	unsigned int src_hwirq;
> +	struct irqmux_priv *priv;
> +};
> +
> +struct irqmux_priv {
> +	struct device *dev;
> +	struct irq_domain *irq_domain;
> +	unsigned int nr_irqs;
> +	struct irqmux_one mux[MAX_NR_OUTPUT_IRQS];
> +};
> +
> +static irqreturn_t irqmux_handler(int irq, void *data)
> +{
> +	struct irqmux_one *mux = data;
> +	struct irqmux_priv *priv = mux->priv;
> +	unsigned int virq;
> +
> +	virq = irq_find_mapping(priv->irq_domain, mux->src_hwirq);
> +
> +	generic_handle_irq(virq);
> +
> +	return IRQ_HANDLED;
> +}

Oh $DEITY. No, really not. I don't know where to start.

- This type of handler should almost never appear in an interrupt
  controller driver. Under the right circumstances, it will deadlock.

- If I understood the above correctly, this should be modelled as a
  hierarchy sitting on top of the GIC, and not as a mux. A good way to
  notice that this is not a mux is that there is no register to read
  and find out what fired.

- The fact that you have to invent src_hwirq instead of directly using
  data->hwirq is a clear sign that something is amiss.

> +
> +static int irqmux_domain_map(struct irq_domain *h, unsigned int irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_data(irq, h->host_data);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);

Another sure sign that this is wrong, the flow handler. In 99% of the
case, using handle_simple_irq is wrong. I'd expect something that
matches the underlying interrupt controller (a fasteoi handler).

> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops irqmux_domain_ops = {
> +	.map = irqmux_domain_map,
> +};
> +
> +static int irqmux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	u32 __iomem *regs;
> +	struct irqmux_priv *priv;
> +	unsigned int i;
> +	int nr_irqs;
> +	int ret;
> +	const __be32 *imap;
> +	int imaplen;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	nr_irqs = of_irq_count(np);
> +	if (nr_irqs < 0)
> +		return nr_irqs;
> +
> +	if (nr_irqs > MAX_NR_OUTPUT_IRQS) {
> +		dev_err(dev, "too many output interrupts\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->nr_irqs = nr_irqs;
> +
> +	/* Look for the interrupt-map */
> +	imap = of_get_property(np, "interrupt-map", &imaplen);
> +	if (!imap)
> +		return -ENOENT;
> +	imaplen /= IMAP_LENGTH * sizeof(__be32);
> +
> +	/* Sometimes not all muxs are used */
> +	if (imaplen < priv->nr_irqs)
> +		priv->nr_irqs = imaplen;
> +
> +	/* Create IRQ domain for the interrupts coming from the GPIO blocks */
> +	priv->irq_domain = irq_domain_add_linear(np, MAX_NR_INPUT_IRQS,
> +						 &irqmux_domain_ops, priv);
> +	if (!priv->irq_domain)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < MAX_NR_INPUT_IRQS; i++)
> +		irq_create_mapping(priv->irq_domain, i);

This should never happen. Mappings should be created from discovering
the interrupt specifiers for devices in the DT, and not eagerly at
probe time.

> +
> +	for (i = 0; i < priv->nr_irqs; i++) {
> +		struct irqmux_one *mux = &priv->mux[i];
> +
> +		ret = irq_of_parse_and_map(np, i);
> +		if (ret < 0) {
> +			ret = -ENOENT;
> +			goto err;
> +		}
> +
> +		mux->irq = ret;
> +		mux->priv = priv;
> +
> +		/*
> +		 * We need the first cell of the interrupt-map to configure
> +		 * the hardware.
> +		 */
> +		mux->src_hwirq = be32_to_cpu(*imap);
> +		imap += IMAP_LENGTH;
> +
> +		dev_info(dev, "%u: %u mapped irq %u\n", i,  mux->src_hwirq,
> +			 mux->irq);
> +
> +		ret = devm_request_irq(dev, mux->irq, irqmux_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "irqmux", mux);

And this is a result of using an interrupt handler in the driver. Bad.

> +		if (ret < 0) {
> +			dev_err(dev, "failed to request IRQ: %d\n", ret);
> +			goto err;
> +		}
> +
> +		/* Set up the hardware to pass the interrupt through */
> +		writel(mux->src_hwirq, &regs[i]);

It feels very odd that you configure the routing at probe time, and not
at runtime. This should really happen when the client devices are
probed...

> +	}
> +
> +	dev_info(dev, "probed, %d gpio interrupts\n", priv->nr_irqs);
> +
> +	return 0;
> +
> +err:
> +	while (i--)
> +		irq_dispose_mapping(priv->mux[i].irq);
> +	irq_domain_remove(priv->irq_domain);
> +
> +	return ret;
> +}
> +
> +static int irqmux_remove(struct platform_device *pdev)
> +{
> +	struct irqmux_priv *priv = platform_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i = 0; i < priv->nr_irqs; i++)
> +		irq_dispose_mapping(priv->mux[i].irq);
> +	irq_domain_remove(priv->irq_domain);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id irqmux_match[] = {
> +	{ .compatible = "renesas,rzn1-gpioirqmux", },
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, irqmux_match);
> +
> +static struct platform_driver irqmux_driver = {
> +	.driver = {
> +		.name = "gpio_irq_mux",
> +		.owner = THIS_MODULE,
> +		.of_match_table = irqmux_match,
> +	},
> +	.probe = irqmux_probe,
> +	.remove = irqmux_remove,
> +};
> +
> +module_platform_driver(irqmux_driver);
> +
> +MODULE_DESCRIPTION("Renesas RZ/N1 GPIO IRQ Multiplexer Driver");
> +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> +MODULE_LICENSE("GPL v2");

Can you please confirm that my understanding of how the HW works is
correct? If so, we can help you turning this around.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
