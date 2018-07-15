Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8FECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C480520647
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKLebnQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C480520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeGOITm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 04:19:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39995 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeGOITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 04:19:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so12867619wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qn7AHJe0dTeyuO8lEgP6SC8Eme/jAWPcuA7m8Wzd+88=;
        b=GKLebnQTF7Sinz9XGaW1IW3y3+jOphW6T6Mo/y+kpN1C0nJPA+yRKgT5BR0lH78g4g
         bownZ6n7Cxw56vHTYl6gSvchVMCvkJtzxCDCEc3Q7aVMvncdnidImR97yyjIzkugjnFA
         JFfw5GRiG6ympVtYan90AV6CRdoeIY2habCcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qn7AHJe0dTeyuO8lEgP6SC8Eme/jAWPcuA7m8Wzd+88=;
        b=aGFswcqGvAaH7yIxIOrEpJEswlfGT4C5Gs6M61CVm35dzvyafqAdDn5ROHunbHoslW
         rRFZWW4MNf9BmfMVGUI1oylXjmex4v9wzMOfzz6L4a1y+5vN5F/hZl9EfqMUMBM1KBOI
         fMmpyZSBzeMkrGO9d/OEYfHOaLD53AhuRA/f536uTbZfYzhEfhIo3/g4aTRJ5PQIrm2Q
         dYM4Q5SYxxNeIsmzRXgD/EGQK+Uj7KSTsHAUwN3DKT6XKlwLCzheaG7EpSUk2p+u2XMa
         xeMpFUCUe1WlEkV17zYDn/XuGgoVIL8rjYS+cwvyWFYWvQM5bfy+K/iJsA50llUlH0y8
         C0QA==
X-Gm-Message-State: AOUpUlHVljEE06IfjbQ6NbnGk+tCyL08ZSVgtmB/NztGpsqLfy/AA7uy
        V3KGtWGUwpkkFLB/mWMre03EDw==
X-Google-Smtp-Source: AAOMgpdChXAz0wDok90xdN5riFgbrsYcFIggYYIjrxsI8zpoQ8NBWHwyjMTh3T+Li3ngM3xQyoO2DA==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr7704336wmd.77.1531641456287;
        Sun, 15 Jul 2018 00:57:36 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n8-v6sm42829169wrt.56.2018.07.15.00.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 00:57:34 -0700 (PDT)
Date:   Sun, 15 Jul 2018 08:57:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "dianders@google.com" <dianders@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "briannorris@google.com" <briannorris@google.com>,
        "amstan@google.com" <amstan@google.com>,
        "groeck@google.com" <groeck@google.com>
Subject: Re: REGRESSION: [RESEND PATCH v3 1/4] backlight: pwm_bl: linear
 interpolation between brightness-levels
Message-ID: <20180715075732.GA2989@wychelm.lan>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
 <20180409083333.1249-2-enric.balletbo@collabora.com>
 <1531580895.7579.7.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531580895.7579.7.camel@toradex.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 03:08:17PM +0000, Marcel Ziswiler wrote:
> On Mon, 2018-04-09 at 10:33 +0200, Enric Balletbo i Serra wrote:
> > diff --git a/drivers/video/backlight/pwm_bl.c
> > b/drivers/video/backlight/pwm_bl.c
> > index 8e3f1245f5c5..f0a108ab570a 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -147,7 +147,11 @@ static int pwm_backlight_parse_dt(struct device
> > *dev,
> >  				  struct platform_pwm_backlight_data
> > *data)
> >  {
> >  	struct device_node *node = dev->of_node;
> > +	unsigned int num_levels = 0;
> > +	unsigned int levels_count;
> > +	unsigned int num_steps;

num_steps is not initialized...


> >  	struct property *prop;
> > +	unsigned int *table;
> >  	int length;
> >  	u32 value;
> >  	int ret;
> > @@ -167,6 +171,7 @@ static int pwm_backlight_parse_dt(struct device
> > *dev,
> >  	/* read brightness levels from DT property */
> >  	if (data->max_brightness > 0) {
> >  		size_t size = sizeof(*data->levels) * data-
> > >max_brightness;
> > +		unsigned int i, j, n = 0;
> >  
> >  		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
> >  		if (!data->levels)
> > @@ -184,6 +189,84 @@ static int pwm_backlight_parse_dt(struct device
> > *dev,
> >  			return ret;
> >  
> >  		data->dft_brightness = value;
> > +
> > +		/*
> > +		 * This property is optional, if is set enables
> > linear
> > +		 * interpolation between each of the values of
> > brightness levels
> > +		 * and creates a new pre-computed table.
> > +		 */
> > +		of_property_read_u32(node, "num-interpolated-steps",
> > +				     &num_steps);

... this is not guaranteed to initialized num_steps ...

> > +
> > +		/*
> > +		 * Make sure that there is at least two entries in
> > the
> > +		 * brightness-levels table, otherwise we can't
> > interpolate
> > +		 * between two points.
> > +		 */
> > +		if (num_steps) {

... and we make a decision on it here.

Marcel: Can you try the following quick fix? It's untested on my side
        but very simple...

From 6fa2fbeb017086147ac61981107a95cb8ae7b4e7 Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Sun, 15 Jul 2018 08:49:05 +0100
Subject: [PATCH] backlight: pwm_bl: Fix uninitialized variable

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined meaning the interpolation code will deploy
randomly. Fix this.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..bdfcc0a71db1 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -250,7 +250,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	struct device_node *node = dev->of_node;
 	unsigned int num_levels = 0;
 	unsigned int levels_count;
-	unsigned int num_steps;
+	unsigned int num_steps = 0;
 	struct property *prop;
 	unsigned int *table;
 	int length;
-- 
2.17.1

