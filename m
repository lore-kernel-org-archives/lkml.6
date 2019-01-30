Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353C218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfA3NWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:22:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51301 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3NWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:22:05 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gopoZ-0004m3-8i; Wed, 30 Jan 2019 14:22:03 +0100
Message-ID: <1548854523.6869.25.camel@pengutronix.de>
Subject: Re: [PATCH V2 3/4] irq: imx-irqsteer: change to use reg_num instead
 of irq_group
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
Date:   Wed, 30 Jan 2019 14:22:03 +0100
In-Reply-To: <1548853196-11447-4-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
         <1548853196-11447-4-git-send-email-aisheng.dong@nxp.com>
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

Am Mittwoch, den 30.01.2019, 13:06 +0000 schrieb Aisheng Dong:
> One group can manage 64 interrupts by using two registers (e.g. STATUS/SET).
> However, the integrated irqsteer may support only 32 interrupts which
> needs only one register in a group. But the current driver assume there's
> a mininum of two registers in a group which result in a wrong register map
> for 32 interrupts per channel irqsteer. Let's use the reg_num caculated by
> interrupts per channel instead of irq_group to cover this case.
> 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Minor nit below, otherwise:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> v1->v2:
>  * The using of property name updated accordingly
> ---
>  drivers/irqchip/irq-imx-irqsteer.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> index 5b3f1d7..67ed862 100644
> --- a/drivers/irqchip/irq-imx-irqsteer.c
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -13,7 +13,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/spinlock.h>
>  
> > -#define CTRL_STRIDE_OFF(_t, _r)	(_t * 8 * _r)
> > +#define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
> >  #define CHANCTRL		0x0
> >  #define CHANMASK(n, t)		(CTRL_STRIDE_OFF(t, 0) + 0x4 * (n) + 0x4)
> >  #define CHANSET(n, t)		(CTRL_STRIDE_OFF(t, 1) + 0x4 * (n) + 0x4)
> @@ -26,7 +26,7 @@ struct irqsteer_data {
> > >  	struct clk		*ipg_clk;
> > >  	int			irq;
> > >  	raw_spinlock_t		lock;
> > > -	int			irq_groups;
> > > +	int			reg_num;
> > >  	int			channel;
> > >  	struct irq_domain	*domain;
> > >  	u32			*saved_reg;
> @@ -35,7 +35,7 @@ struct irqsteer_data {
>  static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
> >  				      unsigned long irqnum)
>  {
> > -	return (data->irq_groups * 2 - irqnum / 32 - 1);
> > +	return (data->reg_num - irqnum / 32 - 1);
>  }
>  
>  static void imx_irqsteer_irq_unmask(struct irq_data *d)
> @@ -46,9 +46,9 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
> >  	u32 val;
>  
> >  	raw_spin_lock_irqsave(&data->lock, flags);
> > -	val = readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
> > +	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
> >  	val |= BIT(d->hwirq % 32);
> > -	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
> > +	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
> >  	raw_spin_unlock_irqrestore(&data->lock, flags);
>  }
>  
> @@ -60,9 +60,9 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
> >  	u32 val;
>  
> >  	raw_spin_lock_irqsave(&data->lock, flags);
> > -	val = readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
> > +	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
> >  	val &= ~BIT(d->hwirq % 32);
> > -	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
> > +	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
> >  	raw_spin_unlock_irqrestore(&data->lock, flags);
>  }
>  
> @@ -94,13 +94,13 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
>  
> >  	chained_irq_enter(irq_desc_get_chip(desc), desc);
>  
> > -	for (i = 0; i < data->irq_groups * 64; i += 32) {
> > +	for (i = 0; i < data->reg_num * 32; i += 32) {
> >  		int idx = imx_irqsteer_get_reg_index(data, i);
> >  		unsigned long irqmap;
> >  		int pos, virq;
>  
> >  		irqmap = readl_relaxed(data->regs +
> > -				       CHANSTATUS(idx, data->irq_groups));
> > +				       CHANSTATUS(idx, data->reg_num));
>  
> >  		for_each_set_bit(pos, &irqmap, 32) {
> >  			virq = irq_find_mapping(data->domain, pos + i);
> @@ -146,12 +146,15 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
>  
> >  	raw_spin_lock_init(&data->lock);
>  
> > -	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
> > +	of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
> >  	of_property_read_u32(np, "fsl,channel", &data->channel);
>  
> > +	/* one register bit map represents 32 input interrupts */
> > +	data->reg_num /= 32;
> +
> >  	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> >  		data->saved_reg = devm_kzalloc(&pdev->dev,
> > -					sizeof(u32) * data->irq_groups * 2,
> > +					sizeof(u32) * data->reg_num,
>  					GFP_KERNEL);

Does this last parameter now fit on the line above?

>  		if (!data->saved_reg)
> >  			return -ENOMEM;
> @@ -166,7 +169,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> >  	/* steer all IRQs into configured channel */
> >  	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
>  
> > -	data->domain = irq_domain_add_linear(np, data->irq_groups * 64,
> > +	data->domain = irq_domain_add_linear(np, data->reg_num * 32,
> >  					     &imx_irqsteer_domain_ops, data);
> >  	if (!data->domain) {
> >  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> @@ -199,9 +202,9 @@ static void imx_irqsteer_save_regs(struct irqsteer_data *data)
>  {
> >  	int i;
>  
> > -	for (i = 0; i < data->irq_groups * 2; i++)
> > +	for (i = 0; i < data->reg_num; i++)
> >  		data->saved_reg[i] = readl_relaxed(data->regs +
> > -						CHANMASK(i, data->irq_groups));
> > +						CHANMASK(i, data->reg_num));
>  }
>  
>  static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
> @@ -209,9 +212,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
> >  	int i;
>  
> >  	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
> > -	for (i = 0; i < data->irq_groups * 2; i++)
> > +	for (i = 0; i < data->reg_num; i++)
> >  		writel_relaxed(data->saved_reg[i],
> > -			       data->regs + CHANMASK(i, data->irq_groups));
> > +			       data->regs + CHANMASK(i, data->reg_num));
>  }
>  
>  static int imx_irqsteer_suspend(struct device *dev)
