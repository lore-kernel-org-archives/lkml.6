Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA9FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A202173B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A202173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbeHGLvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:51:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeHGLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:51:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 01717260560
Subject: Re: [PATCH v2] backlight: pwm_bl: switch to using "atomic" PWM API
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        cl@rock-chips.com, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20180727151121.12296-1-enric.balletbo@collabora.com>
 <20180730111259.5qjtchfo67nquila@holly.lan>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d4f418dd-f5bb-c08a-e43b-f15fbc435961@collabora.com>
Date:   Tue, 7 Aug 2018 11:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730111259.5qjtchfo67nquila@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 30/07/18 13:12, Daniel Thompson wrote:
> On Fri, Jul 27, 2018 at 05:11:21PM +0200, Enric Balletbo i Serra wrote:
>> The "atomic" API allows us to configure PWM period and duty_cycle and
>> enable it in one call.
>>
>> The patch also moves the pwm_init_state just before any use of the
>> pwm_state struct, this fixes a potential bug where pwm_get_state
>> can be called before pwm_init_state.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2:
>> - Do not force the PWM be off in the first call to pwm_apply_state.
>> - Delayed applying the state until we know what the period is.
>> - Removed pb->period as after the conversion is not needed.
> 
> Re-reading this I have spotted a couple of things I probably could have
> mentioned against v1... sorry.
> 
> I think it's looking good though, I expect to be able to ack v3.
> 
> 
>>  drivers/video/backlight/pwm_bl.c | 71 ++++++++++++++++++--------------
>>  1 file changed, 41 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index bdfcc0a71db1..dd1cb29b5332 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -28,7 +28,6 @@
>>  struct pwm_bl_data {
>>  	struct pwm_device	*pwm;
>>  	struct device		*dev;
>> -	unsigned int		period;
>>  	unsigned int		lth_brightness;
>>  	unsigned int		*levels;
>>  	bool			enabled;
>> @@ -46,7 +45,8 @@ struct pwm_bl_data {
>>  	void			(*exit)(struct device *);
>>  };
>>  
>> -static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>> +static void pwm_backlight_power_on(struct pwm_bl_data *pb,
>> +				   struct pwm_state *state)
>>  {
>>  	int err;
>>  
>> @@ -57,7 +57,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>>  	if (err < 0)
>>  		dev_err(pb->dev, "failed to enable power supply\n");
>>  
>> -	pwm_enable(pb->pwm);
>> +	state->enabled = true;
>> +	pwm_apply_state(pb->pwm, state);
>>  
>>  	if (pb->post_pwm_on_delay)
>>  		msleep(pb->post_pwm_on_delay);
>> @@ -70,6 +71,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>>  
>>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>  {
>> +	struct pwm_state state;
>> +
>>  	if (!pb->enabled)
>>  		return;
>>  
>> @@ -79,8 +82,10 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>  	if (pb->pwm_off_delay)
>>  		msleep(pb->pwm_off_delay);
>>  
>> -	pwm_config(pb->pwm, 0, pb->period);
>> -	pwm_disable(pb->pwm);
>> +	pwm_get_state(pb->pwm, &state);
>> +	state.enabled = false;
>> +	state.duty_cycle = 0;
>> +	pwm_apply_state(pb->pwm, &state);
> 
> This is an in exact conversion because this code ignores a failure to
> set the duty cycle to zero whilst pwm_apply_state() does not.
> 
> This would only matter if pwm_config() returns an error and given that a
> PWM which does not support a duty cycle of zero is permitted to adjust
> zero to the smallest supported value there is no *need* for a driver to
> return an error here. In other words... this is a subtle change of
> behaviour and perhaps (even probably) irrelevant.
> 
> However I'm still interested whether you did any work to confirm or
> deny whether drivers that reports error on zero duty cycle actually
> exist.
> 

Interesting, actually I don't have a use case for this, and I think that there
is nothing in the kernel. I know that some devices (like chromebook minnie and
jaq) the pwm must be >= 1% or 3% for the first non-zero value but I don't know
any where 0 is a problem.

> 
>>  	regulator_disable(pb->power_supply);
>>  	pb->enabled = false;
>> @@ -89,14 +94,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>>  {
>>  	unsigned int lth = pb->lth_brightness;
>> +	struct pwm_state state;
>>  	u64 duty_cycle;
>>  
>> +	pwm_get_state(pb->pwm, &state);
>> +
>>  	if (pb->levels)
>>  		duty_cycle = pb->levels[brightness];
>>  	else
>>  		duty_cycle = brightness;
>>  
>> -	duty_cycle *= pb->period - lth;
>> +	duty_cycle *= state.period - lth;
>>  	do_div(duty_cycle, pb->scale);
>>  
>>  	return duty_cycle + lth;
>> @@ -106,6 +114,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>>  {
>>  	struct pwm_bl_data *pb = bl_get_data(bl);
>>  	int brightness = bl->props.brightness;
>> +	struct pwm_state state;
>>  	int duty_cycle;
>>  
>>  	if (bl->props.power != FB_BLANK_UNBLANK ||
>> @@ -118,8 +127,12 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>>  
>>  	if (brightness > 0) {
>>  		duty_cycle = compute_duty_cycle(pb, brightness);
>> -		pwm_config(pb->pwm, duty_cycle, pb->period);
> 
> In principle the same subtle change applies here... but if pwm_config()
> reported an error here then the backlight probably didn't work before
> your change either so less need to worry about it!
> 
> 
>> -		pwm_backlight_power_on(pb, brightness);
>> +		pwm_get_state(pb->pwm, &state);
>> +		state.duty_cycle = duty_cycle;
>> +		if (!state.enabled)
>> +			pwm_backlight_power_on(pb, &state);
> 
> It verges towards nit picking but I don't really like the way a half updated
> state is shared between ...update_status and ...power_on.
> 
> I'd rather it looked something like:
> 
> 		pwm_get_state(pb->pwm, &state);
> 		if (!state.enabled) {
> 			pwm_backlight_power_on(pb);  <-- no sharing here,
> 			                                 make on match off
> 		} else {
> 			pwm_backlight_update_duty_cycle(pb, &state, brightness);
> 			pwm_apply_state(pb->pwm, &state);
> 		}
> 	
> (and have pwm_backlight_power_on() also call ...update_duty_cycle too)
> 
> Thoughts?

What about something like this:

static int pwm_backlight_update_status(struct backlight_device *bl)
{
        ...

	if (brightness > 0) {
		pwm_get_state(pb->pwm, &state);
                /* we can get rid of duty_cycle temporal variable */
		state.duty_cycle = compute_duty_cycle(pb, brightness);
		pwm_apply_state(pb->pwm, &state);
		pwm_backlight_power_on(pb);
	} else
		pwm_backlight_power_off(pb);
        ...
}

static void pwm_backlight_power_on(struct pwm_bl_data *pb)
{
	struct pwm_state state;

	pwm_get_state(pb->pwm, &state);

	if (state.enabled)
		return;

        ...

	state.enabled = true;
	pwm_apply_state(pb->pwm, &state);

        ...
}

static void pwm_backlight_power_off(struct pwm_bl_data *pb)
{
	struct pwm_state state;

        ...

	pwm_get_state(pb->pwm, &state);
	state.enabled = false;
	state.duty_cycle = 0;
	pwm_apply_state(pb->pwm, &state);

        ...
}

And I think that we can get rid of pb->enabled variable.

Best regards,
 Enric

> 
> 
> Daniel.
> 
