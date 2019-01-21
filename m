Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3099C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BC921726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfAUSqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:46:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51737 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfAUSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:46:45 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gleak-0003E7-Cu; Mon, 21 Jan 2019 19:46:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gleaj-0004Pp-RH; Mon, 21 Jan 2019 19:46:37 +0100
Date:   Mon, 21 Jan 2019 19:46:37 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH V2 2/4] drivers: pwm: pwm-bcm-kona: Switch to using
 atomic PWM Framework
Message-ID: <20190121184637.httmrtd3coz2m5ie@pengutronix.de>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547669716-20070-3-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547669716-20070-3-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 17, 2019 at 01:45:14AM +0530, Sheetal Tigadoli wrote:
> Switch to using atomic PWM Framework on broadcom PWM kona driver
> 
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 201 +++++++++++++++++++--------------------------
>  1 file changed, 83 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..fe63289 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -108,151 +108,116 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
>  	ndelay(400);
>  }
>  
> -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			    int duty_ns, int period_ns)
> -{
> -	struct kona_pwmc *kp = to_kona_pwmc(chip);
> -	u64 val, div, rate;
> -	unsigned long prescale = PRESCALE_MIN, pc, dc;
> -	unsigned int value, chan = pwm->hwpwm;
> -
> -	/*
> -	 * Find period count, duty count and prescale to suit duty_ns and
> -	 * period_ns. This is done according to formulas described below:
> -	 *
> -	 * period_ns = 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
> -	 * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
> -	 *
> -	 * PC = (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
> -	 * DC = (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
> -	 */
> -
> -	rate = clk_get_rate(kp->clk);
> -
> -	while (1) {
> -		div = 1000000000;
> -		div *= 1 + prescale;
> -		val = rate * period_ns;
> -		pc = div64_u64(val, div);
> -		val = rate * duty_ns;
> -		dc = div64_u64(val, div);
> -
> -		/* If duty_ns or period_ns are not achievable then return */
> -		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
> -			return -EINVAL;
> -
> -		/* If pc and dc are in bounds, the calculation is done */
> -		if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
> -			break;
> -
> -		/* Otherwise, increase prescale and recalculate pc and dc */
> -		if (++prescale > PRESCALE_MAX)
> -			return -EINVAL;
> -	}
> -
> -	/*
> -	 * Don't apply settings if disabled. The period and duty cycle are
> -	 * always calculated above to ensure the new values are
> -	 * validated immediately instead of on enable.
> -	 */
> -	if (pwm_is_enabled(pwm)) {
> -		kona_pwmc_prepare_for_settings(kp, chan);
> -
> -		value = readl(kp->base + PRESCALE_OFFSET);
> -		value &= ~PRESCALE_MASK(chan);
> -		value |= prescale << PRESCALE_SHIFT(chan);
> -		writel(value, kp->base + PRESCALE_OFFSET);
> -
> -		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
> -
> -		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> -
> -		kona_pwmc_apply_settings(kp, chan);
> -	}
> -
> -	return 0;
> -}
> -
> -static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> -				  enum pwm_polarity polarity)
> +static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct kona_pwmc *kp = to_kona_pwmc(chip);
>  	unsigned int chan = pwm->hwpwm;
>  	unsigned int value;
> -	int ret;
> -
> -	ret = clk_prepare_enable(kp->clk);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
> -		return ret;
> -	}
>  
>  	kona_pwmc_prepare_for_settings(kp, chan);
>  
> -	value = readl(kp->base + PWM_CONTROL_OFFSET);
> -
> -	if (polarity == PWM_POLARITY_NORMAL)
> -		value |= 1 << PWM_CONTROL_POLARITY_SHIFT(chan);
> -	else
> -		value &= ~(1 << PWM_CONTROL_POLARITY_SHIFT(chan));
> +	/* Simulate a disable by configuring for zero duty */
> +	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> +	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
>  
> -	writel(value, kp->base + PWM_CONTROL_OFFSET);
> +	/* Set prescale to 0 for this channel */

kona_pwmc_apply uses PRESCALE_MIN instead of a plain 0. To make the
comment more helpful tell *why* you do it instead of stating the obvious
for the fluent C programmer.

> +	value = readl(kp->base + PRESCALE_OFFSET);
> +	value &= ~PRESCALE_MASK(chan);
> +	writel(value, kp->base + PRESCALE_OFFSET);
>  
>  	kona_pwmc_apply_settings(kp, chan);
>  
>  	clk_disable_unprepare(kp->clk);
> -
> -	return 0;
>  }
>  
> -static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
>  {
>  	struct kona_pwmc *kp = to_kona_pwmc(chip);
> +	struct pwm_state cstate;
> +	u64 val, div, rate;
> +	unsigned long prescale = PRESCALE_MIN, pc, dc;
> +	unsigned int value, chan = pwm->hwpwm;
>  	int ret;
>  
> -	ret = clk_prepare_enable(kp->clk);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
> -			       pwm_get_period(pwm));
> -	if (ret < 0) {
> -		clk_disable_unprepare(kp->clk);
> -		return ret;
> -	}
> +	pwm_get_state(pwm, &cstate);

The pwm_get_state function is designed for PWM-consumers. It is an
implementation detail that it also works for drivers. So I'd like to see
its usage dropped in drivers. (Note that Thierry might not agree here.)

> +
> +	if (state->enabled) {
> +		/*
> +		 * Find period count, duty count and prescale to suit duty_ns
> +		 * and period_ns. This is done according to formulas described
> +		 * below:
> +		 *
> +		 * period_ns = 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
> +		 * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
> +		 *
> +		 * PC = (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
> +		 * DC = (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
> +		 */
> +		rate = clk_get_rate(kp->clk);
> +
> +		while (1) {
> +			div = 1000000000;
> +			div *= 1 + prescale;
> +			val = rate * state->period;
> +			pc = div64_u64(val, div);
> +			val = rate * state->duty_cycle;
> +			dc = div64_u64(val, div);
> +
> +			/* If duty_ns or period_ns are not achievable then

Please stick to the usual style for multi-line comments, i.e. "/*" on a
separate line.

> +			 * return
> +			 */
> +			if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
> +				return -EINVAL;
> +
> +			/* If pc & dc are in bounds, the calculation is done */
> +			if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
> +				break;
> +
> +			/* Otherwise, increase prescale & recalculate pc & dc */
> +			if (++prescale > PRESCALE_MAX)
> +				return -EINVAL;
> +		}
> +
> +		if (!cstate.enabled) {
> +			ret = clk_prepare_enable(kp->clk);
> +			if (ret < 0) {
> +				dev_err(chip->dev,
> +					"failed to enable clock: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  
> -	return 0;
> -}
> -
> -static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct kona_pwmc *kp = to_kona_pwmc(chip);
> -	unsigned int chan = pwm->hwpwm;
> -	unsigned int value;
> +		kona_pwmc_prepare_for_settings(kp, chan);
>  
> -	kona_pwmc_prepare_for_settings(kp, chan);
> +		value = readl(kp->base + PRESCALE_OFFSET);
> +		value &= ~PRESCALE_MASK(chan);
> +		value |= prescale << PRESCALE_SHIFT(chan);
> +		writel(value, kp->base + PRESCALE_OFFSET);
> +		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
> +		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
>  
> -	/* Simulate a disable by configuring for zero duty */
> -	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> -	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
> +		if (cstate.polarity != state->polarity) {
> +			value = readl(kp->base + PWM_CONTROL_OFFSET);
> +			if (state->polarity == PWM_POLARITY_NORMAL)
> +				value |= 1 << PWM_CONTROL_POLARITY_SHIFT(chan);
> +			else
> +				value &= ~(1 <<
> +					   PWM_CONTROL_POLARITY_SHIFT(chan));
>  
> -	/* Set prescale to 0 for this channel */
> -	value = readl(kp->base + PRESCALE_OFFSET);
> -	value &= ~PRESCALE_MASK(chan);
> -	writel(value, kp->base + PRESCALE_OFFSET);
> +			writel(value, kp->base + PWM_CONTROL_OFFSET);
> +		}
>  
> -	kona_pwmc_apply_settings(kp, chan);
> +		kona_pwmc_apply_settings(kp, chan);
> +	} else if (cstate.enabled) {
> +		kona_pwmc_disable(chip, pwm);

If I do:

	pwm_apply_state(pwm, { .polarity = PWM_POLARITY_NORMAL, .enabled = true, ... });
	pwm_apply_state(pwm, { .polarity = PWM_POLARITY_INVERSED, .enabled = false, ... });

the output is constant low, which is wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
