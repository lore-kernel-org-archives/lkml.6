Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1637620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4InA7j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1637620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbeGXIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:06:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34306 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbeGXIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:06:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so2978861wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UwcBBYon9q4uiaK/xcW4u1PUIm/T+VqHz8pDEQbgGqQ=;
        b=K4InA7j0tMPgjwYu0PgOQq174/dyqD5KmPWSL6577nBTDjygg8sivAemFhj1VNhMEC
         pLkJuL+wyWj4b+nbgg6XhGx8vc2uT5Bn3fzbLrN0+4S72DQutkcEOClmoOl+HHUe0qMf
         0OdEEvgSULwxv5f59mnlgmeeHF9iqUeE6WnMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UwcBBYon9q4uiaK/xcW4u1PUIm/T+VqHz8pDEQbgGqQ=;
        b=TCACAln0jZXwK9bIFQHfvQvN/mGC8Maa8fKDqo/k5nAWshXSRMH0XsclXcKjU5mtK8
         ovya0Ccxtn+Mu+sE8qdAWgO0tHEh8LjxYFuRGtOgNTbuFsSayqC6Ho028/HpLjR0mvDd
         ZwllX7CUQ1D/xxyp7VkaGb1nwD1nisUJLjVechMVR5UmNB+0RYRxPx0A1EZD64NtRx4Y
         yqR17862Wo/930egv2BGehnv+q40BZUkj5yWBuel5U3yPeP2OJf9EUZfBToUHIdXZ+a0
         2uFR7AoZWROiQtSYVPaklRpOaua76Qlrv+p1FnFTPWW1YkEDHAi5pFpc3wX1q6TqGJoA
         Q6Ww==
X-Gm-Message-State: AOUpUlHp+Tnghdsm5Ehw8J41mjj6ezHcrWjedLCklj7aEKb/ozm1Tl/S
        HfkhXM5UXZGH0z36XPbQf9ycRQ==
X-Google-Smtp-Source: AAOMgpcPuysLZAK+HYDOOyWGU7q9KUVlAN+vQmgGsG3SMhgkwhGKhyVHxilW3x3jZt2M3RQCjhit3g==
X-Received: by 2002:adf:84e5:: with SMTP id 92-v6mr10804528wrg.56.1532415676626;
        Tue, 24 Jul 2018 00:01:16 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f3-v6sm686078wmb.22.2018.07.24.00.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 00:01:15 -0700 (PDT)
Date:   Tue, 24 Jul 2018 08:01:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180724070113.GA9871@wychelm.lan>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180719161923.21510-1-daniel.thompson@linaro.org>
 <20180723072343.GD4213@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180723072343.GD4213@dell>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 08:23:43AM +0100, Lee Jones wrote:
> On Thu, 19 Jul 2018, Daniel Thompson wrote:
> 
> > Currently, if the DT does not define num-interpolated-steps then
> > num_steps is undefined and the interpolation code will deploy randomly.
> > Fix this.
> > 
> > Additionally fix a small grammar error that was identified and
> > tighten up return code checking of DT properties, both of which came
> > up during review of this patch.
> > 
> > Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> > brightness-levels")
> > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > ---
> > 
> > Notes:
> >     v2:
> >      - Simplify SoB chain (with Marcel's permission)
> >      - Separate complex if statement and make other similar calls use same
> >        return code checking approach
> >      - Tidy up comment formatting and fix pre-existing grammar error
> > 
> >  drivers/video/backlight/pwm_bl.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> I'm hesitant to provide feedback on this, as I feel as though I've
> messed you around enough, however ... ;)
> 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 9ee4c1b735b2..f7799f62fea0 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -284,30 +284,29 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >  		ret = of_property_read_u32_array(node, "brightness-levels",
> >  						 data->levels,
> >  						 data->max_brightness);
> > -		if (ret < 0)
> > +		if (!ret)
> >  			return ret;
> > 
> >  		ret = of_property_read_u32(node, "default-brightness-level",
> >  					   &value);
> > -		if (ret < 0)
> > +		if (!ret)
> >  			return ret;
> 
> Just FYI (it didn't even make it to 'nit' status), this should really
> be done in a separate patch since it is unrelated to the rest of the
> patch.

Did wonder which way to go on this... I figured this close I'd accept
code either way so adopted fewest patches.

However I will split this out because I'm going to go back to the orignal
pre-v1 approach of just initializing the damn variable.


> >  		data->dft_brightness = value;
> > 
> >  		/*
> >  		 * This property is optional, if is set enables linear
> > -		 * interpolation between each of the values of brightness levels
> > -		 * and creates a new pre-computed table.
> > +		 * interpolation between each of the values of brightness
> > +		 * levels and creates a new pre-computed table.
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
> > +		ret = of_property_read_u32(node, "num-interpolated-steps",
> > +					   &num_steps);
> > +		if (!ret || num_steps) {
> 
> Not sure if it's even possible for of_property_read_u32() to fail AND
> still populate num_steps, however this check makes it sound like that's
> okay.  Is that correct?
> 
> I can't help but think that this all 'just goes away' if you
> pre-initialise num_steps.  I wouldn't let the "do not initialise too
> far away from the code using variable" affect this.  However, if
> you're insistent, perhaps consider moving the declaration to just
> below:
> 
>   if (data->max_brightness > 0) {
> 
> > +			/*
> > +			 * Make sure that there are at least two entries in
> > +			 * the brightness-levels table, otherwise we can't
> > +			 * interpolate between two points.
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
