Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2924880
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F2924880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754575AbeGBMF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:05:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35431 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeGBMF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:05:56 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fZxaU-0004U5-5M; Mon, 02 Jul 2018 14:05:46 +0200
Message-ID: <1530533145.22468.85.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] soc: imx: gpc: Power off PU domain in
 suspend/resume on 6qp
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Mon, 02 Jul 2018 14:05:45 +0200
In-Reply-To: <cf9aaa345a27b3d5fcd306635270123f9d01e8c3.1530530881.git.leonard.crestez@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
         <cf9aaa345a27b3d5fcd306635270123f9d01e8c3.1530530881.git.leonard.crestez@nxp.com>
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

Am Montag, den 02.07.2018, 14:52 +0300 schrieb Leonard Crestez:
> On imx6qp power gating on the PU domain is disabled because of errata
> ERR009619. However power gating on suspend/resume can still work.
> 
> Enable this by calling the on/off functions directly from suspend code in
> mach-imx.

Sorry, but no. Please keep those two parts split. We don't want them to
interact.

What keeps you from using standard system suspend PM ops in the GPC
driver? The domain drivers within the GPC power management code are all
standard platform devices, so can implement PM ops themselves. There is
no need for any of this reaching between different drivers.

Regards,
Lucas

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
>  arch/arm/mach-imx/gpc.c | 10 +++++++
>  drivers/soc/imx/gpc.c   | 58 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index de535cb679b3..e99258238210 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -32,10 +32,14 @@
>  
>  static void __iomem *gpc_base;
>  static u32 gpc_wake_irqs[IMR_NUM];
>  static u32 gpc_saved_imrs[IMR_NUM];
>  
> +/* implemented in drivers/soc/imx/gpc.c */
> +extern void _imx6_pm_pu_power_off(void);
> +extern void _imx6_pm_pu_power_on(void);
> +
>  void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw)
>  {
> >  	writel_relaxed((sw2iso << GPC_PGC_SW2ISO_SHIFT) |
> >  		(sw << GPC_PGC_SW_SHIFT), gpc_base + GPC_PGC_CPU_PUPSCR);
>  }
> @@ -54,10 +58,13 @@ void imx_gpc_set_arm_power_in_lpm(bool power_off)
>  void imx_gpc_pre_suspend(bool arm_power_off)
>  {
> >  	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
> >  	int i;
>  
> > +	if (cpu_is_imx6q() && imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0)
> > +		_imx6_pm_pu_power_off();
> +
> >  	/* Tell GPC to power off ARM core when suspend */
> >  	if (arm_power_off)
> >  		imx_gpc_set_arm_power_in_lpm(arm_power_off);
>  
> >  	for (i = 0; i < IMR_NUM; i++) {
> @@ -69,10 +76,13 @@ void imx_gpc_pre_suspend(bool arm_power_off)
>  void imx_gpc_post_resume(void)
>  {
> >  	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
> >  	int i;
>  
> > +	if (cpu_is_imx6q() && imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0)
> > +		_imx6_pm_pu_power_on();
> +
> >  	/* Keep ARM core powered on for other low-power modes */
> >  	imx_gpc_set_arm_power_in_lpm(false);
>  
> >  	for (i = 0; i < IMR_NUM; i++)
> >  		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 83cb275592e9..dddc2469eaac 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -54,19 +54,16 @@ static inline struct imx_pm_domain *
>  to_imx_pm_domain(struct generic_pm_domain *genpd)
>  {
> >  	return container_of(genpd, struct imx_pm_domain, base);
>  }
>  
> -static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
> +static void _imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
>  {
> >  	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
> >  	int iso, iso2sw;
> >  	u32 val;
>  
> > -	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
> > -		return -EBUSY;
> -
> >  	/* Read ISO and ISO2SW power down delays */
> >  	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
> >  	iso = val & 0x3f;
> >  	iso2sw = (val >> 8) & 0x3f;
>  
> @@ -78,32 +75,33 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
> >  	val = BIT(pd->cntr_pdn_bit);
> >  	regmap_update_bits(pd->regmap, GPC_CNTR, val, val);
>  
> >  	/* Wait ISO + ISO2SW IPG clock cycles */
> >  	udelay(DIV_ROUND_UP(iso + iso2sw, pd->ipg_rate_mhz));
> +}
> +
> +static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
> +{
> > +	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
> +
> > +	if (to_imx_pm_domain(genpd)->flags & PGC_DOMAIN_FLAG_NO_PD)
> > +		return -EBUSY;
> +
> > +	_imx6_pm_domain_power_off(genpd);
>  
> >  	if (pd->supply)
> >  		regulator_disable(pd->supply);
>  
> >  	return 0;
>  }
>  
> -static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
> +static void _imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
>  {
> >  	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
> > -	int i, ret, sw, sw2iso;
> > +	int i, sw, sw2iso;
> >  	u32 val;
>  
> > -	if (pd->supply) {
> > -		ret = regulator_enable(pd->supply);
> > -		if (ret) {
> > -			pr_err("%s: failed to enable regulator: %d\n",
> > -			       __func__, ret);
> > -			return ret;
> > -		}
> > -	}
> -
> >  	/* Enable reset clocks for all devices in the domain */
> >  	for (i = 0; i < pd->num_clks; i++)
> >  		clk_prepare_enable(pd->clk[i]);
>  
> >  	/* Gate off domain when powered down */
> @@ -123,10 +121,27 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
> >  	udelay(DIV_ROUND_UP(sw + sw2iso, pd->ipg_rate_mhz));
>  
> >  	/* Disable reset clocks for all devices in the domain */
> >  	for (i = 0; i < pd->num_clks; i++)
> >  		clk_disable_unprepare(pd->clk[i]);
> +}
> +
> +static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
> +{
> > +	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
> > +	int ret;
> +
> > +	if (pd->supply) {
> > +		ret = regulator_enable(pd->supply);
> > +		if (ret) {
> > +			pr_err("%s: failed to enable regulator: %d\n",
> > +			       __func__, ret);
> > +			return ret;
> > +		}
> > +	}
> +
> > +	_imx6_pm_domain_power_on(genpd);
>  
> >  	return 0;
>  }
>  
>  static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
> @@ -337,10 +352,23 @@ static const struct regmap_config imx_gpc_regmap_config = {
> >  	.val_bits = 32,
> >  	.reg_stride = 4,
> >  	.max_register = 0x2ac,
>  };
>  
> +/* exported for suspend/resume code in arch/arm/mach-imx/gpc.c */
> +void _imx6_pm_pu_power_off(void)
> +{
> > +	_imx6_pm_domain_power_off(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
> +}
> +EXPORT_SYMBOL_GPL(_imx6_pm_pu_power_off);
> +
> +void _imx6_pm_pu_power_on(void)
> +{
> > +	_imx6_pm_domain_power_on(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
> +}
> +EXPORT_SYMBOL_GPL(_imx6_pm_pu_power_on);
> +
>  static struct generic_pm_domain *imx_gpc_onecell_domains[] = {
> >  	&imx_gpc_domains[0].base,
> >  	&imx_gpc_domains[1].base,
>  };
>  
