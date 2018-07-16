Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URI_HEX,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993D020849
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuDXAJkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993D020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPOTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:19:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:19:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so31987453wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTYGA0T2e9ldR602+zOslBmmgIaC9IvCjU1yGP3yeR0=;
        b=HuDXAJktqhcClPCArgdwaATiigEN2wkFnFT2beN/zrP5jndy222NDTan24Jkav9dEY
         O2uZY223K3Q799D+Lw/jhAxCyJO0Tysd8Bt7Ma48yk0L095WORnw+LI5J6UWH0zXo0yD
         hxyhyg4zXAcPwVp6qAUNbht/qLV1FYs+VifRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTYGA0T2e9ldR602+zOslBmmgIaC9IvCjU1yGP3yeR0=;
        b=IFplnCi/bK24uRb6wx2jBTIKAKQX+9KgTq7ufzhmx8JnaHmI+swVLtkTdUHUHLvQ+q
         N5uUmS9kii1n5ubl7YJKQLT1H0kAjb0gsofNM7kguQonB70BjyaWf2gepi+tLybqu+Ep
         w3c9bnl3+Wnqgkm+JOltkjmIy2NVwNsaDaanr4gTSbq8GFQl1/q/3WZl5b0vxYu4Tooj
         jtZF8x9EoFg+ylmcvR4uG9gE+DiaVSRkl9G40Qr+mntmCV/ZFzlSiiQC13hwlj9FzV7Y
         zyMaAZu2ULfNVW0gp1kJtBT0g2ufFYWODrg7LO2FXu5emIB31IEcxM0dmvDXzU4zQnwM
         OCKw==
X-Gm-Message-State: AOUpUlFlaEDvk+DLT/aj28UXbs9Wmj1pE2mC/V5MEpaAfMyVgp7ljhJE
        +6nHuRo77IT6dziLUAmqOALmPg==
X-Google-Smtp-Source: AAOMgpdXoipoAyByVoL2XAW3+23OyneLer4kds882t/en4j0e0pZxWSdLJ2a3g7RDmIg8nCE30a+4g==
X-Received: by 2002:adf:d24a:: with SMTP id o10-v6mr12042745wri.229.1531749097627;
        Mon, 16 Jul 2018 06:51:37 -0700 (PDT)
Received: from holly.lan (82-132-223-42.dab.02.net. [82.132.223.42])
        by smtp.gmail.com with ESMTPSA id i1-v6sm20030555wrq.69.2018.07.16.06.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:51:36 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:51:27 +0100
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
Message-ID: <20180716135127.2hvlqxi6mibp7yrh@holly.lan>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
 <20180409083333.1249-2-enric.balletbo@collabora.com>
 <1531580895.7579.7.camel@toradex.com>
 <20180715075732.GA2989@wychelm.lan>
 <1531664796.7579.13.camel@toradex.com>
 <20180716094223.syzwviia4wdx74yh@holly.lan>
 <1531742247.6547.4.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531742247.6547.4.camel@toradex.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:57:29AM +0000, Marcel Ziswiler wrote:
> On Mon, 2018-07-16 at 10:42 +0100, Daniel Thompson wrote:
> > > 
> > > From dbb31d00c9f2873affedbceae917c9d7fce5f832 Mon Sep 17 00:00:00
> > > 2001
> > > Message-Id:
> > > <dbb31d00c9f2873affedbceae917c9d7fce5f832.1531664663.git.ma
> > > rcel.ziswiler@toradex.com>
> > > From: Daniel Thompson <daniel.thompson@linaro.org>
> > > Date: Sun, 15 Jul 2018 08:49:05 +0100
> > > Subject: [PATCH] backlight: pwm_bl: Fix uninitialized variable
> > > 
> > > Currently, if the DT does not define num-interpolated-steps then
> > > num_steps is undefined meaning the interpolation code will deploy
> > > randomly. Fix this.
> > > 
> > > Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation
> > > between
> > > brightness-levels")
> > > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Is it Tested-by: too? It would be good to confirm I was right about
> > the
> > cause of the problem.
> 
> Yes and I confirm you were right.

Thanks.


> > >  drivers/video/backlight/pwm_bl.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > b/drivers/video/backlight/pwm_bl.c
> > > index 9ee4c1b735b2..e884d589378d 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -250,7 +250,7 @@ static int pwm_backlight_parse_dt(struct device
> > > *dev,
> > >  	struct device_node *node = dev->of_node;
> > >  	unsigned int num_levels = 0;
> > >  	unsigned int levels_count;
> > > -	unsigned int num_steps;
> > > +	unsigned int num_steps = 0;
> > 
> > This can go. If we check the return code them this variable is no
> > longer
> > used uninitialized [I'm OK to make the change though... since you've
> > kept my name at the top ;-) ].
> 
> Yes, I confirm that this works for me. Are you gona send a proper patch
> out or should I do it?

I can send it out.


Daniel.
