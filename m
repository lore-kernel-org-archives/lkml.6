Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5EECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D03020673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc9zKycN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D03020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeGRIti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:49:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53695 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeGRIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:49:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so1828970wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+DpQZJb4O8SMmBin3advwJj/mGc2r5CrsnYAYFNCHWs=;
        b=Pc9zKycNkXoWfUghWb/EdsFFKpb/qP7MUP1t2jRVA456kpYJs/WQkBJ7O/XQb28tQ4
         KLi9KQpULwUQC7WJZIe/xTfDyhN184mqyLUSDvvHxBciBoGFbOjBpg7aLc+Wobh14V/R
         Z6xyQlfdPERZvG45bJDWg/ks8pPWCLDTimcpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+DpQZJb4O8SMmBin3advwJj/mGc2r5CrsnYAYFNCHWs=;
        b=EF1Y4RqbvqaTibB6srs0m8GgdIllQ6G2uvBQ7/blGWgnYHeKN30TLaGlKjhVwH/6WS
         hKftSkcET4Bs8GoJW/oVq5P6wDGRXLHwhTpyxlXJOIpw+D18Q1qUXRjZjJpldBQNN+cq
         +YxslsRASxhIHY7QDfgDOXXNs3VyM95vHOxsloGp4scHfP0n1MLBEkj6hGO/0K9Uiyph
         pcFdqO/fODkQ5++O5cCSSz1yqQXp8FW/8bPgjnV6LMjDQ0I+q1s3sqEOFQce//CkNbwi
         /13syv1XVC+xhe/DdjD8DKC16vKqlO4ldRfdCtY+afPxMx45i3FZXprEAN1C9PMiQAUN
         EE8w==
X-Gm-Message-State: AOUpUlHkXRSfgG4tRxzu0hyec2vTP0CB+hty/8j7fsvpEbrTniiQcbKc
        S6liqJLqqE+sWFIxbFVdMc2txQ==
X-Google-Smtp-Source: AAOMgpePpRddZ0LXA36h95meplcCHhpGbu9vZjw+DENRTk+pV9ehEXDe0nVM90Ll6cRyS+Firmw2xQ==
X-Received: by 2002:a1c:f703:: with SMTP id v3-v6mr881800wmh.48.1531901574965;
        Wed, 18 Jul 2018 01:12:54 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id t70-v6sm2273074wme.7.2018.07.18.01.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 01:12:54 -0700 (PDT)
Date:   Wed, 18 Jul 2018 09:12:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180718081252.GC4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718080913.GB4641@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Lee Jones wrote:

> On Mon, 16 Jul 2018, Daniel Thompson wrote:
> 
> > Currently, if the DT does not define num-interpolated-steps then
> > num_steps is undefined and the interpolation code will deploy randomly.
> > Fix this.
> > 
> > Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> > brightness-levels")
> > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This line is confusing.  Did you guys author this patch together?
> 
> My guess is that this line should be dropped and the RB and TB tags
> should remain?  If it was reviewed too, perhaps an AB too?
> 
> > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 9ee4c1b735b2..e3c22b79fbcd 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -299,15 +299,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >  		 * interpolation between each of the values of brightness levels
> >  		 * and creates a new pre-computed table.
> >  		 */
> > -		of_property_read_u32(node, "num-interpolated-steps",
> > -				     &num_steps);
> > -
> > -		/*
> > -		 * Make sure that there is at least two entries in the
> > -		 * brightness-levels table, otherwise we can't interpolate
> > -		 * between two points.
> > -		 */
> > -		if (num_steps) {
> > +		if ((of_property_read_u32(node, "num-interpolated-steps",
> > +					  &num_steps) == 0) && num_steps) {
> 
> This is pretty ugly, and isn't it suffering from over-bracketing?  My
> suggestion would be to break out the invocation of
> of_property_read_u32() from the if and test only the result.
> 
> 		of_property_read_u32(node, "num-interpolated-steps", &num_steps);
> 		if (!ret && num_steps) {

Whoops!  I was playing around with the 80-char limit and forgot to
revert.  The lines should read:

 		ret = of_property_read_u32(node, "num-interpolated-steps",
					   &num_steps);
 		if (!ret && num_steps) {

> I haven't checked the underling code, but is it even feasible for
> of_property_read_u32() to not succeed AND for num_steps to be set?
> 
> If not, the check for !ret if superfluous and you can drop it.
> 
> > +			/*
> > +			 * Make sure that there is at least two entries in the
> 
> s/is/are/
> 
> > +			 * brightness-levels table, otherwise we can't
> > +			 * interpolate
> 
> Why break the line here?
> 
> > +			 * between two points.
> > +			 */
> >  			if (data->max_brightness < 2) {
> >  				dev_err(dev, "can't interpolate\n");
> >  				return -EINVAL;
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
