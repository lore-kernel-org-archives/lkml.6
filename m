Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3538C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7682183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfAKUyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:54:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39437 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfAKUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:54:09 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gi3oa-0006zN-RV; Fri, 11 Jan 2019 21:54:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gi3oZ-0002ty-Sm; Fri, 11 Jan 2019 21:54:04 +0100
Date:   Fri, 11 Jan 2019 21:54:03 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>
Subject: Re: [PATCH 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Message-ID: <20190111205403.e4bgszqbrq65jsgh@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 11, 2019 at 10:51:15AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add support for new version of pwm-kona.
> Add support to make PWM changes configured and stable.
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..2b44ad8 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -45,30 +45,39 @@
>   *    high or low depending on its state at that exact instant.
>   */
>  
> -#define PWM_CONTROL_OFFSET			(0x00000000)
> +#define PWM_CONTROL_OFFSET			0x00000000
>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
>  #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
>  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
>  
> -#define PRESCALE_OFFSET				(0x00000004)
> +#define PRESCALE_OFFSET				0x00000004
>  #define PRESCALE_SHIFT(chan)			((chan) << 2)
>  #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> -#define PRESCALE_MIN				(0x00000000)
> -#define PRESCALE_MAX				(0x00000007)
> +#define PRESCALE_MIN				0x00000000
> +#define PRESCALE_MAX				0x00000007
>  
>  #define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
> -#define PERIOD_COUNT_MIN			(0x00000002)
> -#define PERIOD_COUNT_MAX			(0x00ffffff)
> +#define PERIOD_COUNT_MIN			0x00000002
> +#define PERIOD_COUNT_MAX			0x00ffffff
>  
>  #define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
> -#define DUTY_CYCLE_HIGH_MIN			(0x00000000)
> -#define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
> +#define DUTY_CYCLE_HIGH_MIN			0x00000000
> +#define DUTY_CYCLE_HIGH_MAX			0x00ffffff

All these are unrelated changes.

> +#define PWM_MONITOR_OFFSET			0xb0
> +#define PWM_MONITOR_TIMEOUT_US			5
> +
> +enum kona_pwmc_ver {
> +	KONA_PWM_V1 = 1,
> +	KONA_PWM_V2
> +};
>  
>  struct kona_pwmc {
>  	struct pwm_chip chip;
>  	void __iomem *base;
>  	struct clk *clk;
> +	enum kona_pwmc_ver version;
>  };
>  
>  static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
> @@ -76,11 +85,40 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
>  	return container_of(_chip, struct kona_pwmc, chip);
>  }
>  
> +static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
> +				 unsigned int kona_ver)
> +{
> +	struct kona_pwmc *kp = to_kona_pwmc(chip);
> +	unsigned int value;
> +	unsigned int count = PWM_MONITOR_TIMEOUT_US * 1000;
> +
> +	switch (kona_ver) {
> +	case KONA_PWM_V1:
> +		/*
> +		 * There must be a min 400ns delay between clearing trigger and
> +		 * settingit. Failing to do this may result in no PWM signal.

Space missing.

> +		 */
> +		ndelay(400);
> +		return 0;
> +	case KONA_PWM_V2:
> +		do {
> +			value = readl(kp->base + PWM_MONITOR_OFFSET);
> +			if (!(value & (BIT(chan))))
> +				return 0;
> +			ndelay(1);
> +		} while (count--);
> +
> +		return -ETIMEDOUT;
> +	default:
> +		return -ENODEV;
> +	}

I wonder if v1 and v2 are different enough to justify a separate driver
for v2.

> +}
> +
>  /*
>   * Clear trigger bit but set smooth bit to maintain old output.
>   */
> -static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
> -	unsigned int chan)
> +static int kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
> +					  unsigned int chan)
>  {
>  	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
>  
> @@ -88,14 +126,10 @@ static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
>  	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  
> -	/*
> -	 * There must be a min 400ns delay between clearing trigger and setting
> -	 * it. Failing to do this may result in no PWM signal.
> -	 */
> -	ndelay(400);
> +	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
>  }
>  
> -static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
> +static int kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
>  {
>  	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
>  
> @@ -104,8 +138,7 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
>  	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  
> -	/* Trigger bit must be held high for at least 400 ns. */
> -	ndelay(400);
> +	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
>  }
>  
>  static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -115,6 +148,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,

It would be great if you converted the driver to new-style (that is
implementing .apply instead of .config, .enable, .disable and
.set_polarity). This usually simplifies the driver and maybe adding
support for v2 would be easier then, too.

>  	u64 val, div, rate;
>  	unsigned long prescale = PRESCALE_MIN, pc, dc;
>  	unsigned int value, chan = pwm->hwpwm;
> +	int ret;
>  
>  	/*
>  	 * Find period count, duty count and prescale to suit duty_ns and
> @@ -156,7 +190,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * validated immediately instead of on enable.
>  	 */
>  	if (pwm_is_enabled(pwm)) {
> -		kona_pwmc_prepare_for_settings(kp, chan);
> +		ret = kona_pwmc_prepare_for_settings(kp, chan);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "failed to prepare pwm settings: %d\n",
> +				ret);
> +			return ret;
> +		}
>  
>  		value = readl(kp->base + PRESCALE_OFFSET);
>  		value &= ~PRESCALE_MASK(chan);
> @@ -167,7 +206,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
>  
> -		kona_pwmc_apply_settings(kp, chan);
> +		ret = kona_pwmc_apply_settings(kp, chan);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "failed to apply settings: %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	return 0;
> @@ -187,7 +231,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return ret;
>  	}
>  
> -	kona_pwmc_prepare_for_settings(kp, chan);
> +	ret = kona_pwmc_prepare_for_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
> +		return ret;
> +	}
>  
>  	value = readl(kp->base + PWM_CONTROL_OFFSET);
>  
> @@ -198,7 +246,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  
> -	kona_pwmc_apply_settings(kp, chan);
> +	ret = kona_pwmc_apply_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to apply pwm settings: %d\n", ret);
> +		return ret;
> +	}
>  
>  	clk_disable_unprepare(kp->clk);
>  
> @@ -231,8 +283,13 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct kona_pwmc *kp = to_kona_pwmc(chip);
>  	unsigned int chan = pwm->hwpwm;
>  	unsigned int value;
> +	int ret;
>  
> -	kona_pwmc_prepare_for_settings(kp, chan);
> +	ret = kona_pwmc_prepare_for_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
> +		return;
> +	}
>  
>  	/* Simulate a disable by configuring for zero duty */
>  	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> @@ -243,7 +300,11 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	value &= ~PRESCALE_MASK(chan);
>  	writel(value, kp->base + PRESCALE_OFFSET);
>  
> -	kona_pwmc_apply_settings(kp, chan);
> +	ret = kona_pwmc_apply_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
> +		return;
> +	}
>  
>  	clk_disable_unprepare(kp->clk);
>  }
> @@ -256,14 +317,26 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	.owner = THIS_MODULE,
>  };
>  
> +static const struct of_device_id bcm_kona_pwmc_dt[] = {
> +	{ .compatible = "brcm,kona-pwm", .data = (void *)KONA_PWM_V1},
> +	{ .compatible = "brcm,kona-pwm-v2", .data = (void *)KONA_PWM_V2},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
> +
>  static int kona_pwmc_probe(struct platform_device *pdev)
>  {
>  	struct kona_pwmc *kp;
>  	struct resource *res;
> +	const struct of_device_id *of_id;
>  	unsigned int chan;
>  	unsigned int value = 0;
>  	int ret = 0;
>  
> +	of_id = of_match_node(bcm_kona_pwmc_dt, pdev->dev.of_node);
> +	if (!of_id)
> +		return -ENODEV;
> +
>  	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
>  	if (kp == NULL)
>  		return -ENOMEM;
> @@ -276,6 +349,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
>  	kp->chip.npwm = 6;
>  	kp->chip.of_xlate = of_pwm_xlate_with_flags;
>  	kp->chip.of_pwm_n_cells = 3;
> +	kp->version = (enum kona_pwmc_ver)of_id->data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	kp->base = devm_ioremap_resource(&pdev->dev, res);
> @@ -322,12 +396,6 @@ static int kona_pwmc_remove(struct platform_device *pdev)
>  	return pwmchip_remove(&kp->chip);
>  }
>  
> -static const struct of_device_id bcm_kona_pwmc_dt[] = {
> -	{ .compatible = "brcm,kona-pwm" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
> -
>  static struct platform_driver kona_pwmc_driver = {
>  	.driver = {
>  		.name = "bcm-kona-pwm",
> -- 
> 1.9.1
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
