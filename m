Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2133C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5F820852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMJ+atwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5F820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbeGXHxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:53:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38303 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbeGXHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:53:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so2931987wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9XvvxHx62kPldJUgplHkNa/jr5/VhOm1NzcJ0R1f/Z4=;
        b=iMJ+atwgCVlBCNdOjqnPBhKPimuAhnMsHHuJLGqvsdX+5pvI7RaFDgyiPF4Anf3fgx
         X+qCfYiona8F3Odyz+Hj3zetlCmZmYOwR+VNg3G+8bqAcISYi31CwSSA/Fny74LSVX+k
         5pUlTYWtFel7+8iawR6UTPtYPyiJx2HLATr8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9XvvxHx62kPldJUgplHkNa/jr5/VhOm1NzcJ0R1f/Z4=;
        b=EdenKfIGmc1tGsvVIDlAnLkpeb/JOxl8v91F8NEGjFyR3+C9F7MxmekHmLq/qtHgbX
         5Y1/Pc+2PnSRtw4SYLEZ1Y3LmbVuD486O5QpRxVVGijoDB7UUzD7+VI+HOuUrsAfKJk8
         tn0gw9GiNFuHE3KfPtTkSp83PU7QR6KkVE6LahT+g5fZ5POUPqgPybotwhnlOjlzfwS7
         ED9Z0FhgDP7YxSbLe8iIFN2//DvmW7UW9sL6sAqdEeDyCyrivJFJ+6RoZCLmwPJkk+al
         Wknb542/8m191UXDiMOuMAU9ChAqPmEGUdx8j/NcbFCOTJ7Vef3xf93liOQvAICnxQzq
         A3Cg==
X-Gm-Message-State: AOUpUlFy2lvOdCTlgJyfIAlsKlFISzEsof+gnrQSglSva/ratg+CnLcT
        oLexUb9LcKb2zoRA/n42IfhlPQ==
X-Google-Smtp-Source: AAOMgpfq519FsLj9LP44yuAI4Zls950oD60rcqgFpbcn97tR4E9u0OjGVTTBmQKqYNRp2KnAB9YYfw==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr10724705wrc.93.1532414927912;
        Mon, 23 Jul 2018 23:48:47 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z5-v6sm12901303wrv.2.2018.07.23.23.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 23:48:46 -0700 (PDT)
Date:   Tue, 24 Jul 2018 07:48:43 +0100
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
Message-ID: <20180724064843.GA3099@wychelm.lan>
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
> 
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

No, it's bogus. Looks like when I broke the if statement into two
clauses I ended up flipping the && to an ||.


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
