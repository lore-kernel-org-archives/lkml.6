Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E22C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4146206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ICwF57aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeLNOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:15:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42098 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbeLNOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:15:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id x2so2318693ywc.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QGILX5ZO5eZc/l5EQU1PR2qLPMBe3eqixLTUZdadH/k=;
        b=ICwF57aNe2VbdRONM2zz7YqgFA4eLVjHyw5W8mG80Q0Kmy/ofC81ra7vaLiB4837HA
         w4g41KH5V736OkbIxnIxmPKsjCEVudzZ32mlvLbai4HESWlwTJoy0WMB13tJQds7JNy2
         zBE3Wy5y5va3SDrr96LZCv8fqEiotOqtcPAhHscdsIv76PlpvGuG7ivT/1q23GBm9o7+
         g4k2Yj5UcbHIdR1hZH3Q5SOH0pdEZ1GyoCtkvnNQ9a6jBZ1loJjhR9SLR/Tsf1GC0M5G
         9eaQDSbtaF9pTU5ej6O+ktKMcm8ojI/7xxQQn41RoQjJsge1jyvf0sWDPPtWofVlNwSH
         3CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QGILX5ZO5eZc/l5EQU1PR2qLPMBe3eqixLTUZdadH/k=;
        b=jYTEHeN6B7Q5COdj9qdi45HZh1cnOFOb+b9T1WzxRbJxlpLzr2qVrAaR4xHV6rN5At
         /P3b5u4Ts/oRu142SMisX7DaOngsi2+gccK2s6DmJi4zG1XO5tOw+iiXZlGp1stkdLE7
         ql2/NuAi9X78zZIId3ANlbenp4gRbqqFYZxKxG4C1Hg91lOSeteZWR9NdtfzF/ffqw5v
         7ozufAVMPsbStzDCAlRY1dF5fEjOAItCq+2mvkrnFzeBAz7ENwdD58dTrKbFvwj3+BuM
         CS2mRh26V/WWcJpRTN4f9jMtMhc4jC/K/1InueO1ShxH2OgWit/D9l4ab6kehMT1I4cI
         7PSA==
X-Gm-Message-State: AA+aEWZbbbJgHFmJGGnIXu9WUGenWlYTHo8R9Pkq+iMt4SsyfMMIRDT/
        RYvoOilTdKd8diErGV7i6IDyRbnRJ4FGMw==
X-Google-Smtp-Source: AFSGD/WPMHi4sx0LCASWAZa4KCSVJGgKlSQU+XCbWcBhaE5soDKWSJ6L7iTBk1nkyFT3YlOrXZH2jw==
X-Received: by 2002:a81:7c04:: with SMTP id x4mr3146142ywc.264.1544796941192;
        Fri, 14 Dec 2018 06:15:41 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id a65sm460127ywa.84.2018.12.14.06.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 06:15:40 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:15:39 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D
 MIPI-DSI LCD panel
Message-ID: <20181214141539.GN154160@art_vandelay>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com>
 <20181213150736.GL154160@art_vandelay>
 <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com>
 <20181213194804.GM154160@art_vandelay>
 <CAMty3ZCkGudTL9NLnWjTPD8+xqEzY2d0oLN9x=64Hk8MzKTM5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZCkGudTL9NLnWjTPD8+xqEzY2d0oLN9x=64Hk8MzKTM5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 04:35:11PM +0530, Jagan Teki wrote:
> On Fri, Dec 14, 2018 at 1:25 AM Sean Paul <sean@poorly.run> wrote:
> >
> > On Fri, Dec 14, 2018 at 12:56:03AM +0530, Jagan Teki wrote:
> > > On Thu, Dec 13, 2018 at 8:37 PM Sean Paul <sean@poorly.run> wrote:
> > > >
> > > > On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> > > > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > > > >
> > > > > Add panel driver for it.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >  MAINTAINERS                                   |   6 +
> > > > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > > > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > > > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
> > > > >  4 files changed, 302 insertions(+)
> > > > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > >
> >
> > /snip
> >
> > > > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > > new file mode 100644
> > > > > index 000000000000..a4b46bd8fdbe
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> >
> > /snip
> >
> > > > > +static int feiyang_prepare(struct drm_panel *panel)
> > > > > +{
> > > > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > > > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > > > > +     unsigned int i;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = regulator_enable(ctx->dvdd);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     msleep(100);
> > > >
> > > > nit: You should do your best to correlate the sleeps with the timing parameters
> > > > from the datasheet with a comment.
> > > >
> > > > ie:
> > > >         /* T1: > 100ms */
> > > >         msleep(100);
> > >
> > > Sorry, what does this mean?
> >
> > On page 9 of the datasheet you sent me [1], it has the delays required to safely
> > power up the panel. This delay is the time between dvdd going high and avdd
> > going high. On the figure in the datasheet, this would be T2 (T1 is dvdd rise
> 
> time between dvdd going high and avdd going high is T1 + T3 right?
> 
> T2 > 0ms
> T3 > 20ms
> 
> In this case the delay can be msleep(20) ?

Hmm, yeah, I didn't notice that T3 was > 20ms, that's kind of confusing. So I
think you're right, this should be T2 + T3 > 20ms (T1 is covered in the
regulator_enable of dvdd).

> 
> > time and should be handled in the regulator subsystem (iirc)). Also according to
> > the datasheet, T2 just needs to be > 0, so you don't even need this delay. You
> > could replace this with a comment like:
> >
> >         /* T1 (dvdd rise time) + T2 (dvdd->avdd) > 0 */
> >
> > So for all of the msleeps below you should get the delays from the datasheet and
> > add a comment referencing them.
> 
> T5 and T6 are delay between avdd to reset enable it can be 10 + 10
> =&gt; 20ms and finally T12 which is 200 after reset.
> 
> What about the delay between resets, I need to understand it a bit.

These are usually accounted for at the end of disable. Take a look at the sleep
parameters in panel-simple for an example.

Sean

-- 
Sean Paul, Software Engineer, Google / Chromium OS
