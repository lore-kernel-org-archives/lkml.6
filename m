Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC76ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F408720693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJlMZpNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F408720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeGRJDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:03:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38175 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeGRJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:03:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so1897937wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m+SsIjLlRyDeR+kc2Wtn+ND/o6S0cPhCdjfLuzrh+T4=;
        b=bJlMZpNEUoiIslqcpGD6h/y7oxGNTTZbTFrc77z19prZPCr5J2q5iAksdjYP+Ry3R6
         Sal0+HAHs32aHAszBEtrGPRfo6aC1OYRrWYoeNwOGB6M0eHbLM5Wtahnci5SorSRAX4L
         NMH0VvezQYIPSHeU1MylGL1La1H0zUSe0ZmfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m+SsIjLlRyDeR+kc2Wtn+ND/o6S0cPhCdjfLuzrh+T4=;
        b=JF8SZLP/zA7y5YNzULnXVcRI1V+R9DRvFZ9NiJAq4GP7Q3PEvAOAVyk30jlOr5scOw
         UHbsHIbWo1uVe1LXKbMKGHD0e2BTm4uNH3284prscdZnKuHy9h5pwhlIgEQt2w3BjC4E
         bC0BdLNVAdoZ3Nb0hq6ujaWtRmkHelGcC4FeuSN7SRddYQJFpxf4JEfCc6yUzRofjnwX
         hm6LY4WnS/ZgZYMSrAIcsUR1P3ZzU+7hYeUzOkQaEkP2eqoIXlPDZfFNUB547vaR/Nbo
         QlzormUm9YoQj1papZmFkE28Lz9W2lwAQSTQf962+X8glmmhie9EbqA1uq0rTHyepaXR
         SJfQ==
X-Gm-Message-State: AOUpUlFlDhREsmSQbt2hJpZYqNUi0Ocfa0hxwD/4CmDYWtCMGeAxk3Ga
        miviUW+nEe3FFxYvrjbhUhCNRA==
X-Google-Smtp-Source: AAOMgpd08n3WuWyVQ9woQ8IXLdB6yNP1UTCjPR9UxQzyzigI8ya/JSzAbQhVZu6tXkBsyOqVMnIXyA==
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr894175wmb.4.1531902385971;
        Wed, 18 Jul 2018 01:26:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h8-v6sm1268527wmb.32.2018.07.18.01.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 01:26:25 -0700 (PDT)
Date:   Wed, 18 Jul 2018 09:26:23 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180718082623.nycf2vhlt6yj4bxp@holly.lan>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718080913.GB4641@dell>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:09:13AM +0100, Lee Jones wrote:
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

Yes (although the manipulations were fairly mechanical).

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
> 
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
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
