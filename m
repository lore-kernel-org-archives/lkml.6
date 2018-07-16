Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URI_HEX,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D76ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3780720BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5ERh8YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3780720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeGPKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:09:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43796 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeGPKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:09:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so31208910wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oS3xqMIpl+z4S4ul6WDSiiVEVRZ/IkVRh0cwp9iOrFg=;
        b=P5ERh8YBmFKIRFAVfJDgRb0eFQW/JV/Iy9OiiDmQyB2HmXBFYa7wIKjbltV0FDuumj
         XVQGEGuTlyA5EizCQC5wfC4kEh+f1yyychw3dRdZoQF9KT0qWtY4QYgvyQK7WMQjUBf9
         SFErZIIzG5/J1eE6RNoX2FcqR2nGab7ZzR7Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oS3xqMIpl+z4S4ul6WDSiiVEVRZ/IkVRh0cwp9iOrFg=;
        b=tQsbhdqa/6VGcHwGYhMVoN84/4TCWRh0DYsGCqGvQ1epyUWoGJVG569t/gpFJO43++
         5hCQbh/g22NzEhEpmjMYJDqUfroliMkXaGtxPWRJYtpRUgL4suW4dZpSfRgoapCjMqPQ
         8jJrekn8GKFaPxRMgdcLD2muxAcqLa3KudQKWSITAyGpbwIBRF25JfL3bwJTcPwCqXb+
         i/zjMCjTdpPveuxOtarNSxXzJ8ZV8zLgV6YW6wj2NeLkox7FzJESpd6yJHmU5/qmyrEK
         pmjWstlqNOgMDjI2nGtxovWgy0/1hIJOR6lQW+6iHXaytDV+mIWq9ONBklP978DKNcCF
         7L3A==
X-Gm-Message-State: AOUpUlHPttRBg2f6pGp5hOP+e7b7cy4vpe9AbDi/6JU7z4YvCzu9gmZ4
        wBoxMET1hcLmDWN7zbR3j08zXw==
X-Google-Smtp-Source: AAOMgpdkEh0AxrS+xHtUPZSeGMvZcvmfSQojONa9HNy1dgzx1IlabVvd5j0f0AHV5813TFtu6v9G5A==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr11019801wri.124.1531734147256;
        Mon, 16 Jul 2018 02:42:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 63-v6sm22647496wmo.22.2018.07.16.02.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 02:42:26 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:42:23 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "briannorris@google.com" <briannorris@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "amstan@google.com" <amstan@google.com>,
        "groeck@google.com" <groeck@google.com>
Subject: Re: REGRESSION: [RESEND PATCH v3 1/4] backlight: pwm_bl: linear
 interpolation between brightness-levels
Message-ID: <20180716094223.syzwviia4wdx74yh@holly.lan>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
 <20180409083333.1249-2-enric.balletbo@collabora.com>
 <1531580895.7579.7.camel@toradex.com>
 <20180715075732.GA2989@wychelm.lan>
 <1531664796.7579.13.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531664796.7579.13.camel@toradex.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 02:26:44PM +0000, Marcel Ziswiler wrote:
> On Sun, 2018-07-15 at 08:57 +0100, Daniel Thompson wrote:
> > On Sat, Jul 14, 2018 at 03:08:17PM +0000, Marcel Ziswiler wrote:
> > > On Mon, 2018-04-09 at 10:33 +0200, Enric Balletbo i Serra wrote:
> > > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > > b/drivers/video/backlight/pwm_bl.c
> > > > index 8e3f1245f5c5..f0a108ab570a 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -147,7 +147,11 @@ static int pwm_backlight_parse_dt(struct
> > > > device
> > > > *dev,
> > > >  				  struct
> > > > platform_pwm_backlight_data
> > > > *data)
> > > >  {
> > > >  	struct device_node *node = dev->of_node;
> > > > +	unsigned int num_levels = 0;
> > > > +	unsigned int levels_count;
> > > > +	unsigned int num_steps;
> > 
> > num_steps is not initialized...
> > 
> > 
> > > >  	struct property *prop;
> > > > +	unsigned int *table;
> > > >  	int length;
> > > >  	u32 value;
> > > >  	int ret;
> > > > @@ -167,6 +171,7 @@ static int pwm_backlight_parse_dt(struct
> > > > device
> > > > *dev,
> > > >  	/* read brightness levels from DT property */
> > > >  	if (data->max_brightness > 0) {
> > > >  		size_t size = sizeof(*data->levels) * data-
> > > > > max_brightness;
> > > > 
> > > > +		unsigned int i, j, n = 0;
> > > >  
> > > >  		data->levels = devm_kzalloc(dev, size,
> > > > GFP_KERNEL);
> > > >  		if (!data->levels)
> > > > @@ -184,6 +189,84 @@ static int pwm_backlight_parse_dt(struct
> > > > device
> > > > *dev,
> > > >  			return ret;
> > > >  
> > > >  		data->dft_brightness = value;
> > > > +
> > > > +		/*
> > > > +		 * This property is optional, if is set enables
> > > > linear
> > > > +		 * interpolation between each of the values of
> > > > brightness levels
> > > > +		 * and creates a new pre-computed table.
> > > > +		 */
> > > > +		of_property_read_u32(node, "num-interpolated-
> > > > steps",
> > > > +				     &num_steps);
> > 
> > ... this is not guaranteed to initialized num_steps ...
> 
> Yes, as it only does so if returning zero. I do further propose to
> check its return value as well. Isn't that what return values are used
> for?

I don't much mind either way.

I originally wrote the patch you shared below but then decided to ask you
to test and, since I didn't compile test before doing so, I opted for
something more immune to silly mistakes.


> Quoting from include/linux/of.h:
> 
> Search for a property in a device node and read 32-bit value(s) from
> it. Returns 0 on success, -EINVAL if the property does not exist,
> -ENODATA if property does not have a value, and -EOVERFLOW if the
> property data isn't large enough.
> 
> > > > +
> > > > +		/*
> > > > +		 * Make sure that there is at least two entries
> > > > in
> > > > the
> > > > +		 * brightness-levels table, otherwise we can't
> > > > interpolate
> > > > +		 * between two points.
> > > > +		 */
> > > > +		if (num_steps) {
> > 
> > ... and we make a decision on it here.
> > 
> > Marcel: Can you try the following quick fix? It's untested on my side
> >         but very simple...
> > 
> > From 6fa2fbeb017086147ac61981107a95cb8ae7b4e7 Mon Sep 17 00:00:00
> > 2001
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> > Date: Sun, 15 Jul 2018 08:49:05 +0100
> > Subject: [PATCH] backlight: pwm_bl: Fix uninitialized variable
> > 
> > Currently, if the DT does not define num-interpolated-steps then
> > num_steps is undefined meaning the interpolation code will deploy
> > randomly. Fix this.
> > 
> > Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> > brightness-levels")
> > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c
> > b/drivers/video/backlight/pwm_bl.c
> > index 9ee4c1b735b2..bdfcc0a71db1 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -250,7 +250,7 @@ static int pwm_backlight_parse_dt(struct device
> > *dev,
> >  	struct device_node *node = dev->of_node;
> >  	unsigned int num_levels = 0;
> >  	unsigned int levels_count;
> > -	unsigned int num_steps;
> > +	unsigned int num_steps = 0;
> >  	struct property *prop;
> >  	unsigned int *table;
> >  	int length;
> > --
> > 2.17.1
> 
> From dbb31d00c9f2873affedbceae917c9d7fce5f832 Mon Sep 17 00:00:00 2001
> Message-Id: <dbb31d00c9f2873affedbceae917c9d7fce5f832.1531664663.git.ma
> rcel.ziswiler@toradex.com>
> From: Daniel Thompson <daniel.thompson@linaro.org>
> Date: Sun, 15 Jul 2018 08:49:05 +0100
> Subject: [PATCH] backlight: pwm_bl: Fix uninitialized variable
> 
> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined meaning the interpolation code will deploy
> randomly. Fix this.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Is it Tested-by: too? It would be good to confirm I was right about the
cause of the problem.


> ---
>  drivers/video/backlight/pwm_bl.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c
> b/drivers/video/backlight/pwm_bl.c
> index 9ee4c1b735b2..e884d589378d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -250,7 +250,7 @@ static int pwm_backlight_parse_dt(struct device
> *dev,
>  	struct device_node *node = dev->of_node;
>  	unsigned int num_levels = 0;
>  	unsigned int levels_count;
> -	unsigned int num_steps;
> +	unsigned int num_steps = 0;

This can go. If we check the return code them this variable is no longer
used uninitialized [I'm OK to make the change though... since you've
kept my name at the top ;-) ].


Daniel.

>  	struct property *prop;
>  	unsigned int *table;
>  	int length;
> @@ -299,15 +299,13 @@ static int pwm_backlight_parse_dt(struct device
> *dev,
>  		 * interpolation between each of the values of
> brightness levels
>  		 * and creates a new pre-computed table.
>  		 */
> -		of_property_read_u32(node, "num-interpolated-steps",
> -				     &num_steps);
> -
> -		/*
> -		 * Make sure that there is at least two entries in the
> -		 * brightness-levels table, otherwise we can't
> interpolate
> -		 * between two points.
> -		 */
> -		if (num_steps) {
> +		if ((of_property_read_u32(node, "num-interpolated-
> steps",
> +					  &num_steps) == 0) &&
> (num_steps)) {
> +			/*
> +			 * Make sure that there is at least two
> entries in the
> +			 * brightness-levels table, otherwise we can't
> interpolate
> +			 * between two points.
> +			 */
>  			if (data->max_brightness < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;
> -- 
> 2.14.4
