Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A7C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9CC21546
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPzztvOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9CC21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeHOQwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:52:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51760 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbeHOQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:52:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so1488913wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asyGrl7Gev65E09xvdHepRzOnDi8rUjr5y3LqeNJyOU=;
        b=fPzztvOs1v3uN6B0ARbl1O0uwE/se6BQyDDgUBUIU3vhdrSSmcjaNVlzoXxGbX2/f5
         8sVfh8+dY+/TCVimb5fxI2cs7n4LmxzxX/F8+d+EPaHlRjwsPAVJ51EAs6dHARLOJ+cx
         75hgtKT7SiFEP15HRYxbvDq4juKq2BIsmVl28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asyGrl7Gev65E09xvdHepRzOnDi8rUjr5y3LqeNJyOU=;
        b=UXlcmJWmRYZN59MGDt7ElDSJl6qkTN0GCJfVVMhRxnbtEf5yN2rPppHKmUTX2/BSD7
         EylntQnXEcYYCUAMOVoBok0hYiJ8orl8R7m3H828a2y3Gu5YeF9FqnpTqGkIUtP9Uh69
         WEpD2tbPDaEWfzllxyAS2EZ1z3T+LVY3afWYxbBNk4kcEmVqdjO50co5nTqCFzDqDWcB
         6E42IGk3nS6wsKcNMpgY5r4kaOtfBaVvxjys1a8uDrJf1RW1SOTE1YDh5z7pRSFyt23o
         DzA0ZzfGAhisU9Lui6sg1xWTfymmjhj3fsq0KGmJG9jPYP9PDzD1Syks3zHkVO9/XhOd
         lYlA==
X-Gm-Message-State: AOUpUlFXSp90XKoOlNYGA00RWXCBYAN9AJ8LtK/s1WanKpjq39ElTB9T
        L4tcM3kqHgJa1K9F1kOt1AIrtQ==
X-Google-Smtp-Source: AA+uWPwyuArkWOcq397B+PuZBNrENGUQAUpLL0n6eZ/Mfhaoj1Trw8IE52MuoHqZtChIUZnLikZ7ZA==
X-Received: by 2002:a1c:8a0f:: with SMTP id m15-v6mr13793483wmd.33.1534341579318;
        Wed, 15 Aug 2018 06:59:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x16-v6sm10934235wro.84.2018.08.15.06.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 06:59:37 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:59:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        cl@rock-chips.com, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Message-ID: <20180815135935.7fpsuzbiproqoqyb@holly.lan>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814165059.13219-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 06:50:59PM +0200, Enric Balletbo i Serra wrote:
> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> Changes in v3:
> - Get rid of duty_cycle variable from pwm_backlight_update_status.
> - Get rid of pb->enabled and use only the status.enabled variable.
> - Make power_on match power_off.
> - Do not share status between ...update_status and ...power_on
> 
> Changes in v2:
> - Do not force the PWM be off in the first call to pwm_apply_state.
> - Delayed applying the state until we know what the period is.
> - Removed pb->period as after the conversion is not needed.
> 
>  drivers/video/backlight/pwm_bl.c | 81 +++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index bdfcc0a71db1..678b27063198 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -28,10 +28,8 @@
>  struct pwm_bl_data {
>  	struct pwm_device	*pwm;
>  	struct device		*dev;
> -	unsigned int		period;
>  	unsigned int		lth_brightness;
>  	unsigned int		*levels;
> -	bool			enabled;
>  	struct regulator	*power_supply;
>  	struct gpio_desc	*enable_gpio;
>  	unsigned int		scale;
> @@ -46,31 +44,35 @@ struct pwm_bl_data {
>  	void			(*exit)(struct device *);
>  };
>  
> -static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
> +static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>  {
> +	struct pwm_state state;
>  	int err;
>  
> -	if (pb->enabled)
> +	pwm_get_state(pb->pwm, &state);
> +	if (state.enabled)
>  		return;
>  
>  	err = regulator_enable(pb->power_supply);
>  	if (err < 0)
>  		dev_err(pb->dev, "failed to enable power supply\n");
>  
> -	pwm_enable(pb->pwm);
> +	state.enabled = true;
> +	pwm_apply_state(pb->pwm, &state);
>  
>  	if (pb->post_pwm_on_delay)
>  		msleep(pb->post_pwm_on_delay);
>  
>  	if (pb->enable_gpio)
>  		gpiod_set_value_cansleep(pb->enable_gpio, 1);
> -
> -	pb->enabled = true;
>  }
>  
>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  {
> -	if (!pb->enabled)
> +	struct pwm_state state;
> +
> +	pwm_get_state(pb->pwm, &state);
> +	if (!state.enabled)
>  		return;
>  
>  	if (pb->enable_gpio)
> @@ -79,24 +81,27 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  	if (pb->pwm_off_delay)
>  		msleep(pb->pwm_off_delay);
>  
> -	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> +	state.enabled = false;
> +	state.duty_cycle = 0;
> +	pwm_apply_state(pb->pwm, &state);
>  
>  	regulator_disable(pb->power_supply);
> -	pb->enabled = false;
>  }
>  
>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>  {
>  	unsigned int lth = pb->lth_brightness;
> +	struct pwm_state state;
>  	u64 duty_cycle;
>  
> +	pwm_get_state(pb->pwm, &state);
> +
>  	if (pb->levels)
>  		duty_cycle = pb->levels[brightness];
>  	else
>  		duty_cycle = brightness;
>  
> -	duty_cycle *= pb->period - lth;
> +	duty_cycle *= state.period - lth;
>  	do_div(duty_cycle, pb->scale);
>  
>  	return duty_cycle + lth;
> @@ -106,7 +111,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  {
>  	struct pwm_bl_data *pb = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
> -	int duty_cycle;
> +	struct pwm_state state;
>  
>  	if (bl->props.power != FB_BLANK_UNBLANK ||
>  	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> @@ -117,9 +122,10 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  		brightness = pb->notify(pb->dev, brightness);
>  
>  	if (brightness > 0) {
> -		duty_cycle = compute_duty_cycle(pb, brightness);
> -		pwm_config(pb->pwm, duty_cycle, pb->period);
> -		pwm_backlight_power_on(pb, brightness);
> +		pwm_get_state(pb->pwm, &state);
> +		state.duty_cycle = compute_duty_cycle(pb, brightness);
> +		pwm_apply_state(pb->pwm, &state);
> +		pwm_backlight_power_on(pb);
>  	} else
>  		pwm_backlight_power_off(pb);
>  
> @@ -447,7 +453,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	struct device_node *node = pdev->dev.of_node;
>  	struct pwm_bl_data *pb;
>  	struct pwm_state state;
> -	struct pwm_args pargs;
>  	unsigned int i;
>  	int ret;
>  
> @@ -478,7 +483,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->check_fb = data->check_fb;
>  	pb->exit = data->exit;
>  	pb->dev = &pdev->dev;
> -	pb->enabled = false;
>  	pb->post_pwm_on_delay = data->post_pwm_on_delay;
>  	pb->pwm_off_delay = data->pwm_off_delay;
>  
> @@ -539,10 +543,26 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
>  
> -	if (!data->levels) {
> -		/* Get the PWM period (in nanoseconds) */
> -		pwm_get_state(pb->pwm, &state);
> +	/* Sync up PWM state. */
> +	pwm_init_state(pb->pwm, &state);
>  
> +	/*
> +	 * The DT case will set the pwm_period_ns field to 0 and store the
> +	 * period, parsed from the DT, in the PWM device. For the non-DT case,
> +	 * set the period from platform data if it has not already been set
> +	 * via the PWM lookup table.
> +	 */
> +	if (!state.period && (data->pwm_period_ns > 0))
> +		state.period = data->pwm_period_ns;
> +
> +	ret = pwm_apply_state(pb->pwm, &state);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
> +			ret);
> +		goto err_alloc;
> +	}
> +
> +	if (!data->levels) {
>  		ret = pwm_backlight_brightness_default(&pdev->dev, data,
>  						       state.period);
>  		if (ret < 0) {
> @@ -559,24 +579,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->levels = data->levels;
>  	}
>  
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to
> -	 * the atomic PWM API.
> -	 */
> -	pwm_apply_args(pb->pwm);
> -
> -	/*
> -	 * The DT case will set the pwm_period_ns field to 0 and store the
> -	 * period, parsed from the DT, in the PWM device. For the non-DT case,
> -	 * set the period from platform data if it has not already been set
> -	 * via the PWM lookup table.
> -	 */
> -	pwm_get_args(pb->pwm, &pargs);
> -	pb->period = pargs.period;
> -	if (!pb->period && (data->pwm_period_ns > 0))
> -		pb->period = data->pwm_period_ns;
> -
> -	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
> +	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
>  
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type = BACKLIGHT_RAW;
> -- 
> 2.18.0
> 
