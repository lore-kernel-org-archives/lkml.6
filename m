Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0FC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6682020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="klgwmCy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6682020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeGZC0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:26:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40226 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGZC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:26:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id e13-v6so12599pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EkOwYUza1/c+KjRNiIHUce7SgfYo+v3LDMiCh48VO8I=;
        b=klgwmCy05s968v3/BZjpQKjnscdKO7YN4f5NoYxRbXXuMYOMMEV5sJQf99Dcmm88kG
         TvKBXGb9CENTyI8zVWvM67sMqKQ8APSglRqeQupLrXlPTXOnp9lXJErjKCPlcROAGkFl
         Cw1J6NuQeUgnWApNTLrY+S3SiUjnFgkCYyTYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EkOwYUza1/c+KjRNiIHUce7SgfYo+v3LDMiCh48VO8I=;
        b=GVAHwcHjcCmpYTXceef+TDSpaf/y3ebmo7XbFeU36A61pNup0L+kG1sFcnpbY2PwA9
         /ErjILdsaGQg9p/slJ13V0sX7eKvhD/ALflnGzwAtFhpv7KQxMBQDk9J1Pb793cS6P7m
         fJAJGvrD7yu/BzqrCZAcOg73D2f7nEnPQ8SLXmQ/nfMIIA4AGHOUqoduI1B8fxNFz5CQ
         stush2ZTmUFDoPvR0pDz/TEh3TmhG+xQklxZ5LUjcH1bzMBTzdi/bKCIKxYe42w2hZ1z
         h6io7NmDYmFibBmIY5RIkV3IHAFj9B2yR6XakdpOJiAuBx/PJmoUqx5nQ4xU5W/YW27Y
         uuSg==
X-Gm-Message-State: AOUpUlEifu/WitXqkIc9U9/eBAHtDOyJn2Y5B8HJ3xuGHtP3zeuQZhS5
        QZEYmLowoeKcSoM+BGtWtZIG9A==
X-Google-Smtp-Source: AAOMgpdKv4xDGeH/LXONWsI7bJA7oEaU14WNRUWmkMSUPfcs4w+rcvLp1amguc7tJH73p41j2IfaPQ==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr23102875pgv.52.1532567549278;
        Wed, 25 Jul 2018 18:12:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b62-v6sm41246886pfm.97.2018.07.25.18.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 18:12:28 -0700 (PDT)
Date:   Wed, 25 Jul 2018 18:12:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Message-ID: <20180726011228.GV129942@google.com>
References: <20180724234636.57137-1-mka@chromium.org>
 <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Wed, Jul 25, 2018 at 04:19:56PM -0700, Doug Anderson wrote:

> On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> > +                                            int temp)
> > +{
> > +       u8 reg;
> > +       bool disable_s2_shutdown = false;
> > +       int ret;
> > +
> > +       WARN_ON(!mutex_is_locked(&chip->lock));
> > +
> > +       /*
> > +        * Default: S2 and S3 shutdown enabled, thresholds at
> > +        * 105C/125C/145C, monitoring at 25Hz
> > +        */
> > +       reg = SHUTDOWN_CTRL1_RATE_25HZ;
> > +
> > +       if ((temp == THERMAL_TEMP_INVALID) ||
> > +           (temp < STAGE2_THRESHOLD_MIN)) {
> > +               chip->thresh = THRESH_MIN;
> > +               goto skip;
> > +       }
> > +
> > +       if (temp <= STAGE2_THRESHOLD_MAX) {
> > +               chip->thresh = THRESH_MAX -
> > +                       ((STAGE2_THRESHOLD_MAX - temp) /
> > +                        TEMP_THRESH_STEP);
> > +               disable_s2_shutdown = true;
> > +       } else {
> > +               chip->thresh = THRESH_MAX;
> > +
> > +               if (!IS_ERR(chip->adc))
> > +                       disable_s2_shutdown = true;
> > +               else
> > +                       dev_warn(chip->dev,
> > +                                "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140°C! Configuring stage 2 shutdown at 140°C.\n");
> 
> Putting a non-ASCII character (the degree symbol) in your commit
> message is one thing, but are you sure it's wise to put it in the
> kernel logs?

A few other drivers also do this
(drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c,
drivers/macintosh/windfarm_pm121.c), however that doesn't mean it's a
good idea. Will change to degC or C.

> > +       }
> > +
> > +skip:
> > +       reg |= chip->thresh;
> > +       if (disable_s2_shutdown)
> > +               reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
> > +
> > +       ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return ret;
> 
> Simplify the above lines to:
> 
> return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);

Ouch, my code is indeed dumb ...

> > @@ -313,12 +441,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> > -                                                       &qpnp_tm_sensor_ops);
> > -       if (IS_ERR(chip->tz_dev)) {
> > -               dev_err(&pdev->dev, "failed to register sensor\n");
> > -               return PTR_ERR(chip->tz_dev);
> > -       }
> > +       chip->initialized = true;
> 
> Should we add "thermal_zone_device_update(chip->tz_dev,
> THERMAL_EVENT_UNSPECIFIED);" here

Seems reasonable, will do.

> ...also: do we care about any type of locking for chip->initialized?
> Technically we can be running on weakly ordered memory so if
> qpnp_tm_update_temp_no_adc() is running on a different processor then
> possibly it could still keep returning the default temperature for a
> little while.  We could try to analyze whether there's some sort of
> implicit barrier or we could add manual memory barriers, but generally
> I try to avoid that and just do the simple locking...  What about just
> setting chip-Initialized = true at the end of qpnp_tm_init() while the
> mutex is still held?

Thanks for pointing that out. I agree that we should keep things
simple, chip->initialized to true at the end of qpnp_tm_init() sounds
good to me.

> I'd also love to hear from someone with more thermal framework
> experience to make sure it's legit to return a default value if
> someone calls us while we're initting.  It seems sane to me but nice
> to confirm it's OK.

An alternative could be to return THERMAL_TEMP_INVALID, however I
don't see this handled outside of thermal_core.c, not sure if it could
throw some other code off.

Comments from thermal folks on either approach (or alternatives) are
definitely welcome :)

> Overall I like the idea of this patch so hopefully others do too.
> Thanks for sending it out!

Thanks for the review!

Matthias
