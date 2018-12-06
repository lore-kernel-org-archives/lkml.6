Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA11DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FD920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeLFLLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:11:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50073 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:11:46 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gUrZ3-0003Zt-Um; Thu, 06 Dec 2018 12:11:29 +0100
Message-ID: <1544094689.3709.59.camel@pengutronix.de>
Subject: Re: [PATCH 2/5] irqchip/irq-imx-gpcv2: Share reg offset calculation
 code
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 12:11:29 +0100
In-Reply-To: <20181206073125.7255-3-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
         <20181206073125.7255-3-andrew.smirnov@gmail.com>
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
> Move identical offset calculation code into a small helper function
> and make use of it in the rest of the code.
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

Nice cleanup!

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/irqchip/irq-imx-gpcv2.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index cbed00319315..b262ba8b2652 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -28,6 +28,11 @@ struct gpcv2_irqchip_data {
>  
>  static struct gpcv2_irqchip_data *imx_gpcv2_instance;
>  
> +static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
> +{
> > +	return cd->gpc_base + cd->cpu2wakeup + i * 4;
> +}
> +
>  static int gpcv2_wakeup_source_save(void)
>  {
> >  	struct gpcv2_irqchip_data *cd;
> @@ -39,7 +44,7 @@ static int gpcv2_wakeup_source_save(void)
> >  		return 0;
>  
> >  	for (i = 0; i < IMR_NUM; i++) {
> > -		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		reg = gpcv2_idx_to_reg(cd, i);
> >  		cd->saved_irq_mask[i] = readl_relaxed(reg);
> >  		writel_relaxed(cd->wakeup_sources[i], reg);
> >  	}
> @@ -50,17 +55,14 @@ static int gpcv2_wakeup_source_save(void)
>  static void gpcv2_wakeup_source_restore(void)
>  {
> >  	struct gpcv2_irqchip_data *cd;
> > -	void __iomem *reg;
> >  	int i;
>  
> >  	cd = imx_gpcv2_instance;
> >  	if (!cd)
> >  		return;
>  
> > -	for (i = 0; i < IMR_NUM; i++) {
> > -		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > -		writel_relaxed(cd->saved_irq_mask[i], reg);
> > -	}
> > +	for (i = 0; i < IMR_NUM; i++)
> > +		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
>  }
>  
>  static struct syscore_ops imx_gpcv2_syscore_ops = {
> @@ -97,7 +99,7 @@ static void imx_gpcv2_irq_unmask(struct irq_data *d)
> >  	u32 val;
>  
> >  	raw_spin_lock(&cd->rlock);
> > -	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> > +	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
> >  	val = readl_relaxed(reg);
> >  	val &= ~(1 << d->hwirq % 32);
> >  	writel_relaxed(val, reg);
> @@ -113,7 +115,7 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)
> >  	u32 val;
>  
> >  	raw_spin_lock(&cd->rlock);
> > -	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> > +	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
> >  	val = readl_relaxed(reg);
> >  	val |= 1 << (d->hwirq % 32);
> >  	writel_relaxed(val, reg);
