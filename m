Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76D72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfARIxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:53:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45395 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfARIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:53:30 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gkPu5-0008Pr-Js; Fri, 18 Jan 2019 09:53:29 +0100
Message-ID: <1547801609.2626.5.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
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
Date:   Fri, 18 Jan 2019 09:53:29 +0100
In-Reply-To: <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
         <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
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

Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> One irqsteer channel can support up to 8 output interrupts.

This has been discussed when upstreaming the driver. The controller may
support multiple output IRQs, but only one them is actually used
depending on the CHANCTRL config. There is no use in hooking up all the
output IRQs in DT, if only one of them is actually used. Some of the
outputs may not even be visible to the Linux system, but may belong to
a Cortex M4 subsystem. All of those configurations can be described in
DT by changing the upstream interrupt and "fsl,channel" in a coherent
way.

Please correct me if my understanding is totally wrong.

Regards,
Lucas

> Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/irqchip/irq-imx-irqsteer.c | 39 +++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> index 1bebf0a..54802fa 100644
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
> @@ -117,7 +121,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct irqsteer_data *data;
> >  	struct resource *res;
> > -	int ret;
> > +	int i, ret;
>  
> >  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> @@ -130,12 +134,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
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
> @@ -177,8 +175,23 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
>  
> > -	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
> > -					 data);
> > +	data->irq_count = of_irq_count(np);
> > +	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
> > +		clk_disable_unprepare(data->ipg_clk);
> > +		return -EINVAL;
> > +	}
> +
> > +	for (i = 0; i < data->irq_count; i++) {
> > +		data->irq[i] = irq_of_parse_and_map(np, i);
> > +		if (!data->irq[i]) {
> > +			clk_disable_unprepare(data->ipg_clk);
> > +			return -EINVAL;
> > +		}
> +
> > +		irq_set_chained_handler_and_data(data->irq[i],
> > +						 imx_irqsteer_irq_handler,
> > +						 data);
> > +	}
>  
> >  	platform_set_drvdata(pdev, data);
>  
> @@ -188,8 +201,12 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
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
