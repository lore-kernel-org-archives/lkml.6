Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB325C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60D920833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfAaJIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:08:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42777 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfAaJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:08:35 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gp8Kn-0007k0-RY; Thu, 31 Jan 2019 10:08:33 +0100
Message-ID: <1548925713.6869.37.camel@pengutronix.de>
Subject: Re: [PATCH V3 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Thu, 31 Jan 2019 10:08:33 +0100
In-Reply-To: <1548921464-28917-5-git-send-email-aisheng.dong@nxp.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
         <1548921464-28917-5-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 31.01.2019, 08:03 +0000 schrieb Aisheng Dong:
> One irqsteer channel can support up to 8 output interrupts.
> 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ChangeLog:
> v2->v3:
>  * add error check for imx_irqsteer_get_hwirq_base
>  * use DIV_ROUND_UP
>  * merge 'hwirq +=32' into for loop
>  * common error path in probe to avoid replicating clk_disable_unprepare
> v1->v2:
>  * calculate irq_count by fsl,num-irqs instead of parsing interrupts
>    property from devicetree to match the input interrupts and outputs
>  * improve output interrupt handler by searching only two registers
>    withint the same group
> ---
>  drivers/irqchip/irq-imx-irqsteer.c | 88 +++++++++++++++++++++++++++++---------
>  1 file changed, 68 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> index 67ed862..d1098f4 100644
> --- a/drivers/irqchip/irq-imx-irqsteer.c
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -10,6 +10,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/spinlock.h>
>  
> @@ -21,10 +22,13 @@
> >  #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
> >  #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
>  
> > +#define CHAN_MAX_OUTPUT_INT	0x8
> +
>  struct irqsteer_data {
> > >  	void __iomem		*regs;
> > >  	struct clk		*ipg_clk;
> > > -	int			irq;
> > > +	int			irq[CHAN_MAX_OUTPUT_INT];
> > > +	int			irq_count;
> > >  	raw_spinlock_t		lock;
> > >  	int			reg_num;
> > >  	int			channel;
> @@ -87,23 +91,47 @@ static const struct irq_domain_ops imx_irqsteer_domain_ops = {
> > >  	.xlate		= irq_domain_xlate_onecell,
>  };
>  
> +static int imx_irqsteer_get_hwirq_base(struct irqsteer_data *data, u32 irq)
> +{
> > +	int i;
> +
> > +	for (i = 0; i < data->irq_count; i++) {
> > +		if (data->irq[i] == irq)
> > +			return i * 64;
> > +	}
> +
> > +	return -EINVAL;
> +}
> +
>  static void imx_irqsteer_irq_handler(struct irq_desc *desc)
>  {
> >  	struct irqsteer_data *data = irq_desc_get_handler_data(desc);
> > -	int i;
> > +	int hwirq;
> > +	int irq, i;
>  
> >  	chained_irq_enter(irq_desc_get_chip(desc), desc);
>  
> > -	for (i = 0; i < data->reg_num * 32; i += 32) {
> > -		int idx = imx_irqsteer_get_reg_index(data, i);
> > +	irq = irq_desc_get_irq(desc);
> > +	hwirq = imx_irqsteer_get_hwirq_base(data, irq);
> > +	if (hwirq < 0) {
> > +		pr_warn("%s: unable to get hwirq base for irq %d\n",
> > +			__func__, irq);
> > +		return;
> > +	}
> +
> > +	for (i = 0; i < 2; i++, hwirq += 32) {
> > +		int idx = imx_irqsteer_get_reg_index(data, hwirq);
> >  		unsigned long irqmap;
> >  		int pos, virq;
>  
> > +		if (hwirq >= data->reg_num * 32)
> > +			break;
> +
> >  		irqmap = readl_relaxed(data->regs +
> >  				       CHANSTATUS(idx, data->reg_num));
>  
> >  		for_each_set_bit(pos, &irqmap, 32) {
> > -			virq = irq_find_mapping(data->domain, pos + i);
> > +			virq = irq_find_mapping(data->domain, pos + hwirq);
> >  			if (virq)
> >  				generic_handle_irq(virq);
> >  		}
> @@ -117,7 +145,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct irqsteer_data *data;
> >  	struct resource *res;
> > -	int ret;
> > +	u32 irqs_num;
> > +	int i, ret;
>  
> >  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> @@ -130,12 +159,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> >  		return PTR_ERR(data->regs);
> >  	}
>  
> > -	data->irq = platform_get_irq(pdev, 0);
> > -	if (data->irq <= 0) {
> > -		dev_err(&pdev->dev, "failed to get irq\n");
> > -		return -ENODEV;
> > -	}
> -
> >  	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> >  	if (IS_ERR(data->ipg_clk)) {
> >  		ret = PTR_ERR(data->ipg_clk);
> @@ -146,11 +169,15 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
>  
> >  	raw_spin_lock_init(&data->lock);
>  
> > -	of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
> > +	of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
> >  	of_property_read_u32(np, "fsl,channel", &data->channel);
>  
> > -	/* one register bit map represents 32 input interrupts */
> > -	data->reg_num /= 32;
> > +	/*
> > +	 * There is one output irq for each group of 64 inputs.
> > +	 * One register bit map can represent 32 input interrupts.
> > +	 */
> > +	data->irq_count = DIV_ROUND_UP(irqs_num, 64);
> > +	data->reg_num = irqs_num / 32;
>  
> >  	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> >  		data->saved_reg = devm_kzalloc(&pdev->dev,
> @@ -173,23 +200,44 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> >  					     &imx_irqsteer_domain_ops, data);
> >  	if (!data->domain) {
> >  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> > -		clk_disable_unprepare(data->ipg_clk);
> > -		return -ENOMEM;
> > +		ret = -ENOMEM;
> > +		goto out;
> >  	}
>  
> > -	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
> > -					 data);
> > +	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> +
> > +	for (i = 0; i < data->irq_count; i++) {
> > +		data->irq[i] = irq_of_parse_and_map(np, i);
> > +		if (!data->irq[i]) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> +
> > +		irq_set_chained_handler_and_data(data->irq[i],
> > +						 imx_irqsteer_irq_handler,
> > +						 data);
> > +	}
>  
> >  	platform_set_drvdata(pdev, data);
>  
> >  	return 0;
> +out:
> > +	clk_disable_unprepare(data->ipg_clk);
> > +	return ret;
>  }
>  
>  static int imx_irqsteer_remove(struct platform_device *pdev)
>  {
> >  	struct irqsteer_data *irqsteer_data = platform_get_drvdata(pdev);
> > +	int i;
> +
> > +	for (i = 0; i < irqsteer_data->irq_count; i++)
> > +		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
> > +						 NULL, NULL);
>  
> > -	irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
> >  	irq_domain_remove(irqsteer_data->domain);
>  
> >  	clk_disable_unprepare(irqsteer_data->ipg_clk);
