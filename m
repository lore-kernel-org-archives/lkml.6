Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D6FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9056214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoJ8we1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9056214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbeKVEQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:16:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46795 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbeKVEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:16:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so6480164ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G/jwdRwRBoxz8jdeQgxZO+lY0ZSikyRIlDBiD+RIg+w=;
        b=SoJ8we1fSyD7KqDeg5dHEt1nN4IahWyZyCCPC/7vmNXPWqQYGsR3H7N1JQnTUM8OIA
         LPiYQhaEoAwZKB6GSpG8Y+aH26KmTSq3PqUWDMtAlB1mhQ0Z892Um6womHLf3sgdjoS4
         eRprd96qHbvhg5ujn3RlUld64ElYJcqbNn5m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G/jwdRwRBoxz8jdeQgxZO+lY0ZSikyRIlDBiD+RIg+w=;
        b=RenOAzrcLKWIOpdvP5tqBr1NfEvNpRoXx09jImA0BXAXchrIt4QpkH1jJLuBf7XxYh
         j2vO3QpjpVjGN9XbrlvYuArcGCDfSvubEA8kjk+ivjiDc1hcuoFuY7quGTHAHiHvGDD1
         V2VZ4t7AyEcpyB+TqTAtD+9gLP0HDMlODKqLx0Xza8MhPUOWXxWUAcmc9d13OQCRpDku
         9E5C81Ql5PK47OYlDu6OxivGw+eNwaZ179K7Yy2xaIFPq0icW45W/WscjMETngxtUd2E
         iYAy6TVOCU0cCjwOW6mfso+ve85JSjzLQEWu7D0+q6o8yilm77HPVdnTctCSowJCnPen
         31rg==
X-Gm-Message-State: AA+aEWYVQ0Q+nxxR7/c95MYl5OGibaoD2UWSMCHKQ6qnObJ3i1P4yvD7
        hTQiuGerLkyWuxOnxg5Y+AyR
X-Google-Smtp-Source: AFSGD/WDbDHjZBa242+FOLIRYJDpHqsAWEbb7YRLWmQzodZh142K8wzO6LU9MkipZNm6afabUTVTXA==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr6756964pgc.89.1542822072337;
        Wed, 21 Nov 2018 09:41:12 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6390:8477:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id p67sm2166558pfg.44.2018.11.21.09.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 09:41:11 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:11:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, overseas.sales@unisoc.com
Subject: Re: [PATCH v2 08/15] irqchip: Add RDA8810PL interrupt driver
Message-ID: <20181121174017.GA4411@Mani-XPS-13-9360>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-9-manivannan.sadhasivam@linaro.org>
 <83f70f64-79f1-c6e5-0328-09cc567f2686@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83f70f64-79f1-c6e5-0328-09cc567f2686@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Nov 21, 2018 at 08:41:25AM +0000, Marc Zyngier wrote:
> On 21/11/2018 03:36, Manivannan Sadhasivam wrote:
> > Add interrupt driver for RDA Micro RDA8810PL SoC.
> > 
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/mach-rda/Kconfig      |   1 +
> >  drivers/irqchip/Kconfig        |   4 ++
> >  drivers/irqchip/Makefile       |   1 +
> >  drivers/irqchip/irq-rda-intc.c | 113 +++++++++++++++++++++++++++++++++
> >  4 files changed, 119 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-rda-intc.c
> > 
> > diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> > index dafab78d7aab..29012bc68ca4 100644
> > --- a/arch/arm/mach-rda/Kconfig
> > +++ b/arch/arm/mach-rda/Kconfig
> > @@ -3,5 +3,6 @@ menuconfig ARCH_RDA
> >  	depends on ARCH_MULTI_V7
> >  	select COMMON_CLK
> >  	select GENERIC_IRQ_CHIP
> > +	select RDA_INTC
> >  	help
> >  	  This enables support for the RDA Micro 8810PL SoC family.
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 51a5ef0e96ed..9d54645870ad 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -195,6 +195,10 @@ config JCORE_AIC
> >  	help
> >  	  Support for the J-Core integrated AIC.
> >  
> > +config RDA_INTC
> > +	bool
> > +	select IRQ_DOMAIN
> > +
> >  config RENESAS_INTC_IRQPIN
> >  	bool
> >  	select IRQ_DOMAIN
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 794c13d3ac3d..417108027e40 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
> >  obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
> >  obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
> >  obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
> > +obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> > diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
> > new file mode 100644
> > index 000000000000..1b372bdb23bc
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-rda-intc.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * RDA8810PL SoC irqchip driver
> > + *
> > + * Copyright RDA Microelectronics Company Limited
> > + * Copyright (c) 2017 Andreas Färber
> > + * Copyright (c) 2018 Manivannan Sadhasivam
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_address.h>
> > +
> > +#include <asm/irq.h>
> 
> You shouldn't need to include this.
> 

Ack.

> > +#include <asm/exception.h>
> > +
> > +#define RDA_INTC_FINALSTATUS	0x00
> > +#define RDA_INTC_STATUS		0x04
> > +#define RDA_INTC_MASK_SET	0x08
> > +#define RDA_INTC_MASK_CLR	0x0c
> > +#define RDA_INTC_WAKEUP_MASK	0x18
> > +#define RDA_INTC_CPU_SLEEP	0x1c
> 
> Half of these constants are unused. Do we really need them?
> 

Usually I tend to define all registers to provide overall reg map. But
I have no issues to remove the not used ones.

> > +
> > +#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
> > +
> > +#define RDA_NR_IRQS 32
> 
> Surely the mask can be derived from the number of interrupts?
> 

Why not? Since each bit corresponds to a single interrupt, 0xFFFFFFFF
can cover all 32 bits which is equal to the total number of interrupts
supported by the controller. Am I missing anything here?

> > +
> > +static void __iomem *base;
> 
> Everything in this driver is prefixed with rda_. It would seem valuable
> to  do the same here, as "base" is a bit too generic.
> 

Ack.

> > +
> > +static void rda_intc_mask_irq(struct irq_data *d)
> > +{
> > +	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);
> > +}
> > +
> > +static void rda_intc_unmask_irq(struct irq_data *d)
> > +{
> > +	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_SET);
> 
> Are the names MASK_CLR and MASK_SET from the datasheet? They seem to be
> backward (you set the mask to unmask...), and seem to behave like an
> enable instead. That's not a big issue, just curious.
> 

Yes, this naming convention comes from the datasheet and it is a bit
wierd as you said ;-)

> > +}
> > +
> > +static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
> > +{
> > +	/* Hardware supports only level triggered interrupts */
> > +	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> > +		irq_set_handler(data->irq, handle_level_irq);
> 
> Why do you need to do this? You've already configured it at map time,
> and it is not changing under your feet. This should be written as:
> 
> if ((flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) == flow_type)
> 	return 0;
> 
> return -EINVAL;
> 

Okay.

> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct irq_domain *rda_irq_domain;
> 
> Please move this to the top of the file, next to "base".
> 

Ack.

> > +
> > +static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
> > +{
> > +	u32 stat = readl_relaxed(base + RDA_INTC_FINALSTATUS);
> > +	u32 hwirq;
> > +
> > +	while (stat) {
> > +		hwirq = __fls(stat);
> > +		handle_domain_irq(rda_irq_domain, hwirq, regs);
> > +		stat &= ~(1 << hwirq);
> > +	}
> > +}
> > +
> > +static struct irq_chip rda_irq_chip = {
> > +	.name		= "rda-intc",
> > +	.irq_mask	= rda_intc_mask_irq,
> > +	.irq_unmask	= rda_intc_unmask_irq,
> > +	.irq_set_type	= rda_intc_set_type,
> > +};
> > +
> > +static int rda_irq_map(struct irq_domain *d,
> > +		       unsigned int virq, irq_hw_number_t hw)
> > +{
> > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > +	irq_set_chip_and_handler(virq, &rda_irq_chip, handle_level_irq);
> > +	irq_set_chip_data(virq, d->host_data);
> > +	irq_set_probe(virq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops rda_irq_domain_ops = {
> > +	.map = rda_irq_map,
> > +	.xlate = irq_domain_xlate_onecell,
> > +};
> > +
> > +static int __init rda8810_intc_init(struct device_node *node,
> > +				    struct device_node *parent)
> > +{
> > +	base = of_io_request_and_map(node, 0, "rda-intc");
> > +	if (!base)
> > +		return -ENXIO;
> > +
> > +	/* Mask, and invalidate all interrupt sources */
> 
> What does "invalidate" mean here?
> 

Mean to say "disable" but yeah not appropriate. Will remove it.

> > +	writel_relaxed(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
> > +
> > +	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
> > +						  &rda_irq_domain_ops, base);
> > +	if (WARN_ON(!rda_irq_domain)) {
> > +		iounmap(base);
> > +		return -ENODEV;
> 
> Why ENODEV? ENOMEM seems more appropriate. The WARN_ON is a bit
> superfluous, as the failing probe should be noisy enough.
> 

Ack. ENOMEM comes from your suggestion in previous review.

> > +	}
> > +
> > +	set_handle_irq(rda_handle_irq);
> > +
> > +	return 0;
> > +}
> > +
> > +IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
> > 
> 
> You've already posted two versions in 3 days, please allow for a week
> between versions.
> 

Sorry for that. I thought the other way, allowing too much delay would
hinder the review process. Will post the next revision after few more days.

Thanks,
Mani

> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
