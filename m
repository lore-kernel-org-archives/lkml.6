Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF968C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6820878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeLFLhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:37:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34375 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbeLFLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:37:05 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gUrxg-0006GY-Ld; Thu, 06 Dec 2018 12:36:56 +0100
Message-ID: <1544096216.3709.63.camel@pengutronix.de>
Subject: Re: [PATCH 5/5] irqchip/irq-imx-gpcv2: Add support for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 12:36:56 +0100
In-Reply-To: <20181206073125.7255-6-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
         <20181206073125.7255-6-andrew.smirnov@gmail.com>
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

Am Mittwoch, den 05.12.2018, 23:31 -0800 schrieb Andrey Smirnov:
> Add code needed to support i.MX8MQ.
> 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/irqchip/irq-imx-gpcv2.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index c2b2b3128ddd..17a2dad2d4c2 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -17,6 +17,9 @@
>  
> >  #define GPC_IMR1_CORE0		0x30
> >  #define GPC_IMR1_CORE1		0x40
> > +#define GPC_IMR1_CORE2		0x1c0
> > +#define GPC_IMR1_CORE3		0x1d0
> +
>  
>  struct gpcv2_irqchip_data {
> > >  	struct raw_spinlock	rlock;
> @@ -192,11 +195,19 @@ static const struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
> > >  	.free		= irq_domain_free_irqs_common,
>  };
>  
> +static const struct of_device_id gpcv2_of_match[] = {
> > +	{ .compatible = "fsl,imx7d-gpc",  .data = (const void *) 2 },
> > +	{ .compatible = "fsl,imx8mq-gpc", .data = (const void *) 4 },
> > +	{ /* END */ }
> +};
> +
>  static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> >  			       struct device_node *parent)
>  {
> >  	struct irq_domain *parent_domain, *domain;
> >  	struct gpcv2_irqchip_data *cd;
> > +	const struct of_device_id *id;
> > +	unsigned long core_num;
> >  	int i;
>  
> >  	if (!parent) {
> @@ -204,6 +215,14 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> >  		return -ENODEV;
> >  	}
>  
> > +	id = of_match_node(gpcv2_of_match, node);
> > +	if (!id) {
> > +		pr_err("%pOF: unknown compatibility string\n", node);
> > +		return -ENODEV;
> > +	}
> +
> > +	core_num = (unsigned long)id->data;
> +
> >  	parent_domain = irq_find_host(parent);
> >  	if (!parent_domain) {
> >  		pr_err("%pOF: unable to get parent domain\n", node);
> @@ -236,8 +255,16 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
>  
> >  	/* Initially mask all interrupts */
> >  	for (i = 0; i < IMR_NUM; i++) {
> > -		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
> > -		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
> > +		void __iomem *reg = cd->gpc_base + i * 4;
> +
> > +		switch (core_num) {
> > +		case 4:
> > +			writel_relaxed(~0, reg + GPC_IMR1_CORE2);
> > +			writel_relaxed(~0, reg + GPC_IMR1_CORE3);
> > > +		case 2:	      /* FALLTHROUGH */
> > +			writel_relaxed(~0, reg + GPC_IMR1_CORE0);
> > +			writel_relaxed(~0, reg + GPC_IMR1_CORE1);
> +		}

The writes being not being in linear descending core order does trigger
something in me, but obviously this doesn't has any effect on the code,
so:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

>  		cd->wakeup_sources[i] = ~0;
> >  	}
>  
