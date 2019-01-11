Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D95C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDEC21848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6OpjDcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfAKSa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:30:28 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43025 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfAKSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:30:27 -0500
Received: by mail-pg1-f181.google.com with SMTP id v28so6634671pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLx9KY8aVCvQ3xoQiRX7b1nK2h1plnfqWyprCndpH5o=;
        b=C6OpjDcl3hLKk2QUAiPb4uSoEjjw+2kwNRwKPGwV3vPZAxsoa5+TDz5sV7YtbaDr0j
         2XUYEsGyl4OdeH/PSYjXvVmUgaCsz8OH80n/igDQvoXxfMTpQD8Hb0cJSI32ln65BHBm
         W0Z5GNWpJzri8XHVNrekt1JCXxAuqd/pHs78o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLx9KY8aVCvQ3xoQiRX7b1nK2h1plnfqWyprCndpH5o=;
        b=QLOLYjK1/FHW6jbFQfM64WSlK0rRPYWdRUxYJ60sCE/9wdnXpWOYgm/FHU/BDva0OI
         vtncqQ0xl8QeV4raeyHkS6akPTkG0S3W3TMxRbRZWMKnejZ1OG5JohoCM0TV/yfD64ym
         xrszAG6vBurdQiG9hohyYDyODGXeOMyTmFpYM9j5HjDwjPL0wlPNsewGBhgq9RDMrk3r
         l2X30KtprVdgDKAdw7CD2/erDt6Oo/70Hrn1mvy0eRF0NBKAb8bzBLKSKov3tESMRzq8
         EMwwLa4XSWPf3YiwRJnqqzkNKTz906+K5cth3HOPaPg4WMCCG6gMBWcBKkrL7/E6Qd5N
         jQ2A==
X-Gm-Message-State: AJcUukeU8W9NmhtGA3mPWN8U3WuIDNbS0pNCNrYOZYo2jd6sH1+OQOpT
        9HFDU3YEyUiPziGpLpIdixBfJQ==
X-Google-Smtp-Source: ALg8bN6ErmX0Ah7U0NjQUBeHhXGSj8nR3+0Z9budQoeFYXCerz46f415RpsSoooE6ELzLvZGI46OBw==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr12431904pgg.429.1547231425310;
        Fri, 11 Jan 2019 10:30:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 184sm108509585pfe.106.2019.01.11.10.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 10:30:24 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:30:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
Message-ID: <20190111183023.GE261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <20190110011533.GV261387@google.com>
 <CAHLCerPN3dxd=XBEkU2cMacFDkZjNhXEw7BDYNTEyfSUszSUzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHLCerPN3dxd=XBEkU2cMacFDkZjNhXEw7BDYNTEyfSUszSUzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:54:23PM +0530, Amit Kucheria wrote:
> On Thu, Jan 10, 2019 at 6:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Amit,
> >
> > On Thu, Jan 10, 2019 at 05:30:55AM +0530, Amit Kucheria wrote:
> > > 75 degrees is too aggressive for throttling the CPU. After speaking to
> > > Qualcomm engineers, increase it to 95 degrees.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index c27cbd3bcb0a..29e823b0caf4 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1692,7 +1692,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert0: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1713,7 +1713,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert1: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1734,7 +1734,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert2: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1755,7 +1755,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert3: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1776,7 +1776,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert4: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1797,7 +1797,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert5: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1818,7 +1818,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert6: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> > > @@ -1839,7 +1839,7 @@
> > >
> > >                       trips {
> > >                               cpu_alert7: trip0 {
> > > -                                     temperature = <75000>;
> > > +                                     temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> >
> > The change itself looks good to me, however I wonder if it would be
> > worth to eliminate redundancy and merge the current 8 thermal zones
> > into 2, one for the Silver and one for the Gold cluster (as done by
> > http://crrev.com/c/1381752). There is a single cooling device for
> > each cluster, so it's not clear to me if there is any gain from having
> > a separate thermal zone for each CPU. If it is important to monitor
> > the temperatures of the individual cores this can still be done by
> > configuring the thermal zone of the cluster with multiple thermal
> > sensors.
> 
> Reducing the number of thermal zones to 2 (by grouping 4 sensors per
> zone) is not possible due a limitation of the thermal framework[1]. It
> is something that we want to address. Previous attempts to fix this
> were rejected for various reasons. Eduardo was going to share a way to
> have more flexible mapping between sensors and zones after discussions
> at LPC.

I wasn't aware of this limitation, thanks for the clarification! With
this I understand that for now we indeed need the 8 thermal zones with
all the redundant information :(

> <nag> Eduardo, do you have anything we can review? </nag> :-)
> 
> Having said that, we'll need some aggregation functions when we add
> multiple sensors to a zone (e.g. max, mean) to reflect the zone. This
> will lose information about hotspots and prevent things like idle
> injection on a particular CPU that is causing most of the heat in the
> aggregated zone. So IMHO, it might be useful to have information about
> the hotspots (i.e TZ per sensor) and aggregated values (ambient
> temperature) that can be fed to the thermal policy.

Ok, it seems for now we need the 8 thermal zones in any case, when
support for multiple sensors becomes available we can evaluate whether
it's worth to change that or not.

Cheers

Matthias
