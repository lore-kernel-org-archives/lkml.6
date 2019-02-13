Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FC1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5EE21872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392939AbfBMRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:23:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33751 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392925AbfBMRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:23:21 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtyFe-0006ZZ-5t; Wed, 13 Feb 2019 18:23:14 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtyFd-0007A8-Pe; Wed, 13 Feb 2019 18:23:13 +0100
Date:   Wed, 13 Feb 2019 18:23:13 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mathieu Othacehe <m.othacehe@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Message-ID: <20190213172313.dafgkqq4wyo6zbhc@pengutronix.de>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
 <20190212094927.5900-2-m.othacehe@gmail.com>
 <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
 <20190213123002.GC647@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213123002.GC647@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:30:02PM +0100, Thierry Reding wrote:
> On Tue, Feb 12, 2019 at 03:28:50PM +0100, Uwe Kleine-König wrote:
> > On Tue, Feb 12, 2019 at 10:49:27AM +0100, Mathieu Othacehe wrote:
> > > Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> > > platforms. They require a special quirk: pwm has to be enabled again
> > > to force duty_cycle refresh.
> > > 
> > > Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
> > >  1 file changed, 23 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> > > index 27c107e78d59..bf33aa24433c 100644
> > > --- a/drivers/pwm/pwm-hibvt.c
> > > +++ b/drivers/pwm/pwm-hibvt.c
> > > @@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
> > >  	struct clk *clk;
> > >  	void __iomem *base;
> > >  	struct reset_control *rstc;
> > > +	bool quirk_force_enable;
> > >  };
> > >  
> > >  struct hibvt_pwm_soc {
> > > @@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
> > >  };
> > >  
> > >  static const struct hibvt_pwm_soc pwm_soc[2] = {
> > > +	{ .num_pwms = 2 },
> > >  	{ .num_pwms = 4 },
> > >  	{ .num_pwms = 8 },
> > 
> > The members of this struct are used as of-data (in struct
> > of_device_id::data below). When looking at the usage:
> > 
> > 	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[1] },
> > 	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[2] },
> > 	{ .compatible = "hisilicon,hi3559v100-shub-pwm", .data = &pwm_soc[2] },
> > 	{ .compatible = "hisilicon,hi3559v100-pwm", .data = &pwm_soc[0] },
> > 
> > this isn't exactly easy to understand. I would prefer to do it as
> > follows:
> > 
> > 	static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
> > 		.num_pwms = 2,
> > 	};
> > 	...
> > 
> > 	static const struct of_device_id hibvt_pwm_of_match[] = {
> > 		{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &hi3516cv300_soc_info },
> > 		...
> > 	};
> > 
> > Then you could also add a member to hibvt_pwm_soc to signal if that
> > force_enable quirk is necessary and would not need to use
> > of_device_is_compatible() to determine this. The result is that you have
> > a description of all relevant differences in a single place.
> > 
> > @Thierry: Also this is yet another driver instance where a num-pwms
> > property would simplify the driver because up to before this patch this
> > was the only difference between the different variants.
> 
> We don't need the num-pwms in device tree if it can be derived from the
> compatible string.

Right, this not about a must. It can be done without this property.
This is just about putting the number of pwms in another place to
describe the pwm differently. Then you'd put

	num-pwms = <2>;

in the device tree and then don't need to bother if which hisilicon SoC
this is in the driver. Sure, you can implicitly know this using the
compatible. This is just another shade of gray. If put to an extreme
you can also claim your machine is completely defined by just

	/ {
		compatible = "technexion,imx6ul-pico-hobbit";
	}

and determine all other relevant stuff from the compatible.

A similar case is the i2c rtc ds1307. This is described in the device
tree as:

	rtc@68 {
		compatible = "dallas,ds1307";
		reg = <0x68>;
	}

even though the ds1307 can only ever be used at address 0x68. So you
could argue there is no good reason to specify the reg property because
that could be determined from the compatible.
Still for the sake of a generic way to describe i2c devices it was
agreed on that it should be there and generic i2c code can benefit from
it.

If we decided to put num-pwms consistenly into the device trees (and we
would have done so earlier and not have to care to handle old device
trees) the following patch would be possible:

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..accc91eba287 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -51,15 +51,6 @@ struct hibvt_pwm_chip {
 	struct reset_control *rstc;
 };
 
-struct hibvt_pwm_soc {
-	u32 num_pwms;
-};
-
-static const struct hibvt_pwm_soc pwm_soc[2] = {
-	{ .num_pwms = 4 },
-	{ .num_pwms = 8 },
-};
-
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct hibvt_pwm_chip, chip);
@@ -174,8 +165,6 @@ static const struct pwm_ops hibvt_pwm_ops = {
 
 static int hibvt_pwm_probe(struct platform_device *pdev)
 {
-	const struct hibvt_pwm_soc *soc =
-				of_device_get_match_data(&pdev->dev);
 	struct hibvt_pwm_chip *pwm_chip;
 	struct resource *res;
 	int ret;
@@ -195,7 +184,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.ops = &hibvt_pwm_ops;
 	pwm_chip->chip.dev = &pdev->dev;
 	pwm_chip->chip.base = -1;
-	pwm_chip->chip.npwm = soc->num_pwms;
+	pwm_chip->chip.npwm = pwm_get_npwm_from_dt();
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
 
@@ -250,8 +239,8 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
-	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3516cv300-pwm",  },
+	{ .compatible = "hisilicon,hi3519v100-pwm", },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674ce995f..f621b6b23150 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -55,7 +55,6 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 };
 
 struct mtk_pwm_platform_data {
-	unsigned int num_pwms;
 	bool pwm45_fixup;
 	bool has_clks;
 };
@@ -260,7 +259,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = data->num_pwms;
+	pc->chip.npwm = pwm_get_npwm_from_dt();
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -279,25 +278,21 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
-	.num_pwms = 8,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
-	.num_pwms = 6,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
-	.num_pwms = 5,
 	.pwm45_fixup = true,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7628_pwm_data = {
-	.num_pwms = 4,
 	.pwm45_fixup = true,
 	.has_clks = false,
 };
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 470d4f71e7eb..7ba3d52430ae 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -73,7 +73,6 @@ static const u32 prescaler_table[] = {
 
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
-	unsigned int npwm;
 };
 
 struct sun4i_pwm_chip {
@@ -314,17 +313,14 @@ static const struct pwm_ops sun4i_pwm_ops = {
 
 static const struct sun4i_pwm_data sun4i_pwm_dual_nobypass = {
 	.has_prescaler_bypass = false,
-	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_dual_bypass = {
 	.has_prescaler_bypass = true,
-	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.has_prescaler_bypass = true,
-	.npwm = 1,
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
@@ -375,7 +371,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
-	pwm->chip.npwm = pwm->data->npwm;
+	pwm->chip.npwm = pwm_get_npwm_from_dt();
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
 
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 48c4595a0ffc..53bb30e26245 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -40,8 +40,6 @@
 #define PWM_SCALE_SHIFT	0
 
 struct tegra_pwm_soc {
-	unsigned int num_channels;
-
 	/* Maximum IP frequency for given SoCs */
 	unsigned long max_frequency;
 };
@@ -230,7 +228,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &tegra_pwm_ops;
 	pwm->chip.base = -1;
-	pwm->chip.npwm = pwm->soc->num_channels;
+	pwm->chip.npwm = pwm_get_npwm_from_dt();
 
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
@@ -286,12 +284,10 @@ static int tegra_pwm_resume(struct device *dev)
 #endif
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
-	.num_channels = 4,
 	.max_frequency = 48000000UL,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
-	.num_channels = 1,
 	.max_frequency = 102000000UL,
 };
 
together with a generic implementation of the function to get the number
of pwms from the device tree. This looks like a good change and that's
why I'm convinced it is sensible to put this into the device trees.

And if you ask me having num-pwms in the device tree like:

	bls: pwm@1400a000 {
		compatible = "mediatek,mt2701-disp-pwm";
		reg = <..>;
		#pwm-cells = <2>;
		clocks = <&mmsys CLK_MM_MDP_BLS_26M>, <&mmsys CLK_MM_DISP_BLS>;
		clock-names = "main", "mm";
		num-pwms = <8>;
	}

is also a nice addition because then the author of a machine device tree
(or a reviewer, or even a generic dtb linter) would easier spot how many
pwms there are and that

	pwms = <&bls 6 200000>

can be used without looking into the reference manual or the driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
