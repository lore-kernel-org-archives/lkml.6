Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44003C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2C420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbfAOUAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:00:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfAOUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:00:43 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjUsy-0003um-L9; Tue, 15 Jan 2019 21:00:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjUsx-0002ty-DQ; Tue, 15 Jan 2019 21:00:31 +0100
Date:   Tue, 15 Jan 2019 21:00:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Message-ID: <20190115200031.7vranuo6fpcaqvce@pengutronix.de>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 04:21:20PM +0800, Ryder Lee wrote:
> This adds a property "mediatek,num-pwms" to avoid having an endless
> list of compatibles with no other differences for the same driver.

I seem to recall having said something similar before, but maybe this
was a different series (there is no v2 or higher in the Subject ...)

I think it would be sensible to drop the vendor prefix and go with plain
"num-pwms" (or "npwms" to align to "ngpios" in the gpio bindings).

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index eb6674c..37daa84 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -55,7 +55,6 @@ enum {
>  };
>  
>  struct mtk_pwm_platform_data {
> -	unsigned int num_pwms;
>  	bool pwm45_fixup;
>  	bool has_clks;
>  };
> @@ -226,10 +225,11 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  static int mtk_pwm_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	const struct mtk_pwm_platform_data *data;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i;
> +	unsigned int i, num_pwms;
>  	int ret;
>  
>  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> @@ -246,7 +246,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->regs))
>  		return PTR_ERR(pc->regs);
>  
> -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);

This sounds wrong. "Failed to get number of pwms" sounds better to my
(non-native) ear.

> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
>  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
>  		if (IS_ERR(pc->clks[i])) {
>  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> @@ -260,7 +266,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	pc->chip.dev = &pdev->dev;
>  	pc->chip.ops = &mtk_pwm_ops;
>  	pc->chip.base = -1;
> -	pc->chip.npwm = data->num_pwms;
> +	pc->chip.npwm = num_pwms;
>  
>  	ret = pwmchip_add(&pc->chip);
>  	if (ret < 0) {
> @@ -279,32 +285,23 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>  }
>  
>  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
> -	.num_pwms = 8,
> -	.pwm45_fixup = false,
> -	.has_clks = true,
> -};
> -
> -static const struct mtk_pwm_platform_data mt7622_pwm_data = {
> -	.num_pwms = 6,
>  	.pwm45_fixup = false,
>  	.has_clks = true,

I agree with Matthias Brugger that at least for some time you should be
able to fall back to the right number of pwms if the device tree doesn't
have a num-pwms property.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
