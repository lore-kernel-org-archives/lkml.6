Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB51C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24352089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIbLoUwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24352089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbeG0MyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:54:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36588 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbeG0MyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:54:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so5160751wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJB8m5NtepKoDalaQN1OYoy8O3md9N6qF7LHH6MoUCw=;
        b=HIbLoUweoYUG7XfsmOq7Mj2CpbtgnB0Nq6qs+2DaPwa7mSrUq2Bz4oyL20NhmaHpXk
         +ScXx/D12I+vbuslcktdNxc27BAe60It+wfroovdtLMLwOYtHEhFZH6ltv4wSGVozqvr
         4zZ0psxWxUNV/hyNszraVbfwcteBVhs9dKLo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJB8m5NtepKoDalaQN1OYoy8O3md9N6qF7LHH6MoUCw=;
        b=M70sIhKKEp7Cvysdy3RdQpKCGy1iOwPJOHhiWinWw4cu1YiZj0J747er6FbqA0zjMN
         0fe3UOLno5Js9ao03lKGUgbIFemVoH2iCYW2eRIMzr/0ZvT+u2h+TNPvEpVGCP3JQVaN
         1UR8Qo5YDlnOLyC0WVCFYcHkY5eWx2GyNKTSSKVdIee3v3I9DCTIgxUCwX49tnH08xgZ
         Atha11RKfR0Q9rU8TxUF9o2HHXb9lEgLQ+MPeN7UHjFvfV4Q8YxrVqGzOYk5oQ/icQzR
         zS9t8GFDAxnrYTj7hpnbVjufJjpX4TxJqCpJi/JKDvkpRfhmEYBLq1pq3e/d9bZwJX8w
         NlNQ==
X-Gm-Message-State: AOUpUlEX92Symi8/s3QooF54ZRILBQcQPDsBXo9j4gq30SQNif3hTn0R
        xIYIywr87hkCrL/t1DRRyZVPtQ==
X-Google-Smtp-Source: AAOMgpePuP0M2gFCbEV6q8VNTtYboKVgSFUewR2Tjacfo+v6NrVUak8t7wkOoPc5LwERH+SErTS5cA==
X-Received: by 2002:a1c:3:: with SMTP id 3-v6mr3789608wma.99.1532691156225;
        Fri, 27 Jul 2018 04:32:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id c124-v6sm5359918wma.47.2018.07.27.04.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:32:35 -0700 (PDT)
Subject: Re: [PATCH] backlight: pwm_bl: switch to using "atomic" PWM API
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, cl@rock-chips.com, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20180726091534.27521-1-enric.balletbo@collabora.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <2e157deb-de8d-9f12-b4f2-04e04ff2e5ed@linaro.org>
Date:   Fri, 27 Jul 2018 12:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726091534.27521-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/18 10:15, Enric Balletbo i Serra wrote:
> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   drivers/video/backlight/pwm_bl.c | 48 ++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index bdfcc0a71db1..2c734d55d607 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -46,7 +46,8 @@ struct pwm_bl_data {
>   	void			(*exit)(struct device *);
>   };
>   
> -static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
> +static void pwm_backlight_power_on(struct pwm_bl_data *pb,
> +				   struct pwm_state *state)
>   {
>   	int err;
>   
> @@ -57,7 +58,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>   	if (err < 0)
>   		dev_err(pb->dev, "failed to enable power supply\n");
>   
> -	pwm_enable(pb->pwm);
> +	state->enabled = true;
> +	pwm_apply_state(pb->pwm, state);
>   
>   	if (pb->post_pwm_on_delay)
>   		msleep(pb->post_pwm_on_delay);
> @@ -70,6 +72,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>   
>   static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   {
> +	struct pwm_state state;
> +
>   	if (!pb->enabled)
>   		return;
>   
> @@ -79,8 +83,11 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   	if (pb->pwm_off_delay)
>   		msleep(pb->pwm_off_delay);
>   
> -	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> +	pwm_get_state(pb->pwm, &state);
> +	state.enabled = false;
> +	state.period = pb->period;
> +	state.duty_cycle = 0;
> +	pwm_apply_state(pb->pwm, &state);
>   
>   	regulator_disable(pb->power_supply);
>   	pb->enabled = false;
> @@ -106,6 +113,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>   {
>   	struct pwm_bl_data *pb = bl_get_data(bl);
>   	int brightness = bl->props.brightness;
> +	struct pwm_state state;
>   	int duty_cycle;
>   
>   	if (bl->props.power != FB_BLANK_UNBLANK ||
> @@ -118,8 +126,13 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>   
>   	if (brightness > 0) {
>   		duty_cycle = compute_duty_cycle(pb, brightness);
> -		pwm_config(pb->pwm, duty_cycle, pb->period);
> -		pwm_backlight_power_on(pb, brightness);
> +		pwm_get_state(pb->pwm, &state);
> +		state.duty_cycle = duty_cycle;
> +		state.period = pb->period;
> +		if (!state.enabled)
> +			pwm_backlight_power_on(pb, &state);
> +		else
> +			pwm_apply_state(pb->pwm, &state);
>   	} else
>   		pwm_backlight_power_off(pb);
>   
> @@ -447,7 +460,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   	struct device_node *node = pdev->dev.of_node;
>   	struct pwm_bl_data *pb;
>   	struct pwm_state state;
> -	struct pwm_args pargs;
>   	unsigned int i;
>   	int ret;
>   
> @@ -539,10 +551,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   	dev_dbg(&pdev->dev, "got pwm for backlight\n");
>   
> -	if (!data->levels) {
> -		/* Get the PWM period (in nanoseconds) */
> -		pwm_get_state(pb->pwm, &state);
> +	/* Sync up PWM state and ensure it is off. */
> +	pwm_init_state(pb->pwm, &state);
> +	state.enabled = false;
> +	ret = pwm_apply_state(pb->pwm, &state);

Why do we ensure the PWM is off? Does this cause backlight flickers or 
make some of the code in pwm_backlight_initial_power_state() unreachable?


> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
> +			ret);
> +		goto err_alloc;
> +	}
>   
> +	if (!data->levels) {
>   		ret = pwm_backlight_brightness_default(&pdev->dev, data,
>   						       state.period);
>   		if (ret < 0) {
> @@ -559,20 +578,13 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   		pb->levels = data->levels;
>   	}
>   
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to
> -	 * the atomic PWM API.
> -	 */
> -	pwm_apply_args(pb->pwm);
> -
>   	/*
>   	 * The DT case will set the pwm_period_ns field to 0 and store the
>   	 * period, parsed from the DT, in the PWM device. For the non-DT case,
>   	 * set the period from platform data if it has not already been set
>   	 * via the PWM lookup table.
>   	 */
> -	pwm_get_args(pb->pwm, &pargs);
> -	pb->period = pargs.period;
> +	pb->period = state.period;
>   	if (!pb->period && (data->pwm_period_ns > 0))
>   		pb->period = data->pwm_period_ns;

Could we have delayed applying the state until we know what the period 
is supposed to be? No other call to pwm_apply_state() has its error 
value checked... so if there are problems with the period we could 
detect them here.

Note also that we can guarantee the period is set before the probe 
completes then I think pb->period could be removed entirely. It was only 
really being carried around to help with calls to pwm_config() and these 
no longer exist.


Daniel.
