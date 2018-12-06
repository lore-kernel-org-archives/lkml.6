Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08E121479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08E121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeLFN7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:59:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40969 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbeLFN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:59:10 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gUuBE-0006FZ-Fb; Thu, 06 Dec 2018 14:59:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gUuBC-0005Zf-5N; Thu, 06 Dec 2018 14:59:02 +0100
Date:   Thu, 6 Dec 2018 14:59:02 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
> Normally the PWM output is held LOW when PWM is disabled. This can cause
> problems when inverted PWM signal polarity is needed. With this behavior
> the connected circuit is fed by 100% duty cycle instead of being shut-off.
> 
> Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
> state is selected when PWM is enabled and the gpio pinctrl state is
> selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
> configured as input and the internal pull-up resistor is used to pull the
> output level high.
> 
> If all the pinctrl states and the pwm-gpios GPIO are not correctly
> specified in DT the PWM work as usual.
> 
> As an example, with this patch a PWM controlled backlight with inversed
> signal polarity can be used in full brightness range. Without this patch
> the backlight can not be turned off as brightness = 0 disables the PWM
> and that in turn set PWM output LOW, that is full brightness.
> 
> Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
> 
> +--------------+------------+---------------+----------- +-------------+
> | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
> | 100k pull-up |            |               | enable 30% |   disable   |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |    default    |   default  |   default   |
> | out H   __________________                   __   __                 |
> | out L                     \_________________/  \_/  \_/\____________ |
> |                                           ^    ^    ^                |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
> | out H   __________________________________   __   __   _____________ |
> | out L                                     \_/  \_/  \_/              |
> |                                           ^    ^    ^                |
> +----------------------------------------------------------------------+
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes in v3:
>  - Commit message update.
>  - Minor fix in code comment (Uwe)
>  - Align function arguments to the opening parentheses. (Uwe)
>  - Do not test devm_pinctrl_get for NULL. (Thierry)
>  - Convert all messages to dev_dbg() (Thierry)
>  - Do not actively drive the pin in gpio state. Configure it as input
>    and rely solely on the internal pull-up. (Thierry)
> 
> Changes in v2:
>  - Utilize the "pwm" and "gpio" pinctrl states.
>  - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
>  - Select the right pinctrl state in probe.
> 
>  drivers/pwm/pwm-imx.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 1d5242c..84eaec8 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -12,10 +12,12 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  /* i.MX1 and i.MX21 share the same PWM function block: */
>  
> @@ -52,10 +54,44 @@ struct imx_chip {
>  	void __iomem	*mmio_base;
>  
>  	struct pwm_chip	chip;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_pins_gpio;
> +	struct pinctrl_state *pinctrl_pins_pwm;
> +	struct gpio_desc *pwm_gpiod;
>  };
>  
>  #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
>  
> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> +		struct platform_device *pdev)

Please indent the follow up line to the opening parenthesis.

> +{
> +	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(imx_chip->pinctrl)) {
> +		dev_dbg(&pdev->dev, "can not get pinctrl\n");
> +		return PTR_ERR(imx_chip->pinctrl);
> +	}
> +
> +	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
> +							  "pwm");
> +	imx_chip->pinctrl_pins_gpio = pinctrl_lookup_state(imx_chip->pinctrl,
> +							   "gpio");
> +	imx_chip->pwm_gpiod = devm_gpiod_get_optional(&pdev->dev, "pwm",
> +						      GPIOD_IN);
> +
> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(imx_chip->pwm_gpiod) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_gpio)) {
> +		dev_dbg(&pdev->dev, "PWM pinctrl information incomplete\n");
> +		devm_pinctrl_put(imx_chip->pinctrl);
> +		imx_chip->pinctrl = NULL;

Can it happen, that pinctrl_pins_pwm is PTR_ERR(-EPROBE_DEFER)?
Maybe you only want to ignore PTR_ERR(-ENODEV) and for example propagate
-EIO? I think you want to put the gpio if the failure is because there
is a pinctrl related error.

> +	}
> +
> +	return 0;
> +}
> +
>  static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> @@ -216,7 +252,25 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
>  			cr |= MX3_PWMCR_POUTC;
>  
>  		writel(cr, imx->mmio_base + MX3_PWMCR);
> +
> +		/*
> +		 * If we are in charge of pinctrl then switch output to
> +		 * the PWM signal.
> +		 */
> +		if (imx->pinctrl)
> +			pinctrl_select_state(imx->pinctrl,
> +					     imx->pinctrl_pins_pwm);
>  	} else if (cstate.enabled) {
> +		/*
> +		 * PWM block will be disabled. Normally its output will be set
> +		 * low no matter what output polarity is configured. Let's use
> +		 * pinctrl to switch the output pin to GPIO functon and keep
> +		 * the output at the same level as for duty-cycle = 0.
> +		 */
> +		if (imx->pinctrl)
> +			pinctrl_select_state(imx->pinctrl,
> +					     imx->pinctrl_pins_gpio);
> +
>  		writel(0, imx->mmio_base + MX3_PWMCR);
>  
>  		clk_disable_unprepare(imx->clk_per);
> @@ -263,6 +317,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id =
>  			of_match_device(imx_pwm_dt_ids, &pdev->dev);
>  	const struct imx_pwm_data *data;
> +	struct pwm_state cstate;
>  	struct imx_chip *imx;
>  	struct resource *r;
>  	int ret = 0;
> @@ -294,6 +349,10 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  		imx->chip.of_pwm_n_cells = 3;
>  	}
>  
> +	ret = imx_pwm_init_pinctrl_info(imx, pdev);
> +	if (ret)
> +		return ret;
> +
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(imx->mmio_base))
> @@ -303,6 +362,24 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (imx->pinctrl) {
> +		/*
> +		 * Update cstate after pwmchip_add() call as the core might
> +		 * call the get_state() function to read the PWM registers
> +		 * to get the actual HW state.
> +		 */
> +		pwm_get_state(imx->chip.pwms, &cstate);
> +		if (cstate.enabled) {
> +			dev_dbg(&pdev->dev,
> +				"PWM entered probe in enabled state\n");
> +			pinctrl_select_state(imx->pinctrl,
> +					     imx->pinctrl_pins_pwm);
> +		} else {
> +			pinctrl_select_state(imx->pinctrl,
> +					     imx->pinctrl_pins_gpio);
> +		}
> +	}
> +

ISTR that there was a patch that implements get_state for imx. Is there
a dependency on that one? Otherwise the state returned by
pwm_get_state() might not be what is actually configured.

Do you know if this is required for the old i.MX pwm, e.g. on i.MX21?
I ask because of https://patchwork.ozlabs.org/patch/1000071/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
