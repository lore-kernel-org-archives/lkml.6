Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE79C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55B21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ncyr2DHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfAKUgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:36:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42665 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfAKUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:36:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so7240423plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xcWWIbOm2J3eFMuV+hJKXP1P/GfLQOPTvj4Lf/y9kvQ=;
        b=Ncyr2DHpTIrPPZypZXVwd6msWaghhaSaIifbfoghFWmQ1P7hMgBoocESotC1CJRE/o
         j3ijXKUMmfQEkgzTeMOARYRmY216mdeCsGQIj0vDzDGgtI11ZxvYmr7vO3LSc/UNvLqA
         cnW1yXSqYIpns7ZE04g/uXxqlBJJ5/rarZFtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xcWWIbOm2J3eFMuV+hJKXP1P/GfLQOPTvj4Lf/y9kvQ=;
        b=Bvc4XZOBFCUkDVMVMVtmgGx7QPhAl+cLxYaQM+cZjjZNt/PMhJXqJWNjOcLH8qHXid
         U1KQzVPWrZPRbWlzsocmlupLaUifBV2CULHysa+R4tXXCa9Nsc0uGPvuse6cFIMRhHGc
         M6z+onDmsih6Mhpov2xxOt2Bzim9Aje0RIYoi1TG6Pl2ovzr6s8XZqccqb5FCdVdUkmK
         1iwLMG65X71X0J/XvYT7a92NRkLTQv/Rpf8d8qJQKAg/gPgDEWQnWjwZ48uAGDNIoHy+
         Xqz0dUhEcBvlEKzqGnFOLw+myTZtK9jnQWDgAnNfGzI3aV4eZak95YmtFV1vThCyzjtK
         70CQ==
X-Gm-Message-State: AJcUukcw8I7jOquojlc0IZaqZ59R+cQAXw7RzS1iKq2ZcSV4yhdNSgVL
        6dQqomyObPxCrSzUJVg4IWFXgg==
X-Google-Smtp-Source: ALg8bN4P47H6XXdTmLX995PaTOzniZQ3jzeXpjNQ/7vjfEM4TMIqepzjtioH2v2nrRtPKnX6vPGy3Q==
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11mr15583359plb.251.1547238966885;
        Fri, 11 Jan 2019 12:36:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d69sm108775446pfg.168.2019.01.11.12.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:36:06 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:36:05 -0800
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
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190111203605.GG261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190111003014.GB261387@google.com>
 <CAHLCerP5ZyORkJm9E8kk-+4X6u6f2=vn_0hq7jSewr9O4=RKDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHLCerP5ZyORkJm9E8kk-+4X6u6f2=vn_0hq7jSewr9O4=RKDw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 04:47:15PM +0530, Amit Kucheria wrote:
> On Fri, Jan 11, 2019 at 6:00 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Thu, Jan 10, 2019 at 05:30:56AM +0530, Amit Kucheria wrote:
> > > Since the big and little cpus are in the same frequency domain, use all
> > > of them for mitigation in the cooling-map. At the lower trip points we
> > > restrict ourselves to throttling only a few OPPs. At higher trip
> > > temperatures, allow ourselves to be throttled to any extent.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 145 +++++++++++++++++++++++++++
> > >  1 file changed, 145 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 29e823b0caf4..cd6402a9aa64 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -13,6 +13,7 @@
> > >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> > >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > > +#include <dt-bindings/thermal/thermal.h>
> > >
> > >  / {
> > >       interrupt-parent = <&intc>;
> > > @@ -99,6 +100,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x0>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_0>;
> > >                       L2_0: l2-cache {
> > >                               compatible = "cache";
> > > @@ -114,6 +116,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x100>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_100>;
> > >                       L2_100: l2-cache {
> > >                               compatible = "cache";
> > > @@ -126,6 +129,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x200>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_200>;
> > >                       L2_200: l2-cache {
> > >                               compatible = "cache";
> > > @@ -138,6 +142,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x300>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_300>;
> > >                       L2_300: l2-cache {
> > >                               compatible = "cache";
> > > @@ -150,6 +155,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x400>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_400>;
> > >                       L2_400: l2-cache {
> > >                               compatible = "cache";
> > > @@ -162,6 +168,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x500>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_500>;
> > >                       L2_500: l2-cache {
> > >                               compatible = "cache";
> > > @@ -174,6 +181,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x600>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_600>;
> > >                       L2_600: l2-cache {
> > >                               compatible = "cache";
> > > @@ -186,6 +194,7 @@
> > >                       compatible = "qcom,kryo385";
> > >                       reg = <0x0 0x700>;
> > >                       enable-method = "psci";
> > > +                     #cooling-cells = <2>;
> > >                       next-level-cache = <&L2_700>;
> > >                       L2_700: l2-cache {
> > >                               compatible = "cache";
> > > @@ -1703,6 +1712,23 @@
> > >                                       type = "critical";
> > >                               };
> > >                       };
> > > +
> > > +                     cooling-maps {
> > > +                             map0 {
> > > +                                     trip = <&cpu_alert0>;
> > > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> > > +                                                      <&CPU1 THERMAL_NO_LIMIT 4>,
> > > +                                                      <&CPU2 THERMAL_NO_LIMIT 4>,
> > > +                                                      <&CPU3 THERMAL_NO_LIMIT 4>;
> > > +                             };
> > > +                             map1 {
> > > +                                     trip = <&cpu_crit0>;
> > > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                                      <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                                      <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                                      <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +                             };
> > > +                     };
> >
> > Slightly off-topic, buy maybe not so much since we are just starting
> > to use the trip points:
> >
> > Currently we use the naming scheme 'cpu_<type>N' for trip points. I
> > anticipate that we're going to add more passive trip points soon, to
> > keep the 'power_allocator' thermal governor happy, which expects a
> > 'switch_on' and a 'desired_temperature' trip point. With the current
> > naming scheme this could become a bit messy. I suggest to change it to
> > 'cpuN_<type>[X]', which would allow for something like 'cpuN_alert0'
> > and 'cpuN_alert1'.
> >
> > If you think the change makes sense you can consider to do it within
> > this series, I can also send a separate patch once it has landed.
> 
> Sure, I can change them to cpuN_alertX format.

Great, thanks!

Another concern about adding trip points later could be the node
name. We currently have:


trips {
  cpu0_alert0: trip0 {
    ...
  };

  cpu0_crit: trip1 {
    ...
  };
};

If we keep increasing enumeration with the node name this would become:

trips {
  cpu0_alert0: trip0 {
    ...
  };

  cpu0_alert1: trip1 {
    ...
  };

  cpu0_crit: trip2 {
    ...
  };
};

i.e. the node name of the critical trip-point changes, which might be
a concern for dtsi's that override a value, though they should
probably use the phandle &cpu0_crit anyway. If this is a concern we
could change the node names to 'alert0' and 'crit'.

I looked around a bit and actually I kinda like the naming scheme used
by hisilicon/hi6220.dtsi, mediatek/mt8173.dtsi and rockchip/rk3328.dtsi
(with minor variations):

trips {
        threshold: trip-point@0 {
                temperature = <68000>;
                hysteresis = <2000>;
                type = "passive";
        };

        target: trip-point@1 {
                temperature = <85000>;
                hysteresis = <2000>;
                type = "passive";
        };

        cpu_crit: cpu_crit@0 {
                temperature = <115000>;
                hysteresis = <2000>;
                type = "critical";
        };
};

If we were to use this we'd have to adapt it slightly since we have
multiple thermal zones. In line with the other scheme this could be
cpuN_threshold, cpuN_target and cpuN_crit.

Up to you, just providing some options ;-)

> > You could also consider to add the additional trip point in this
> > series if you agree that it will be needed.
> 
> I expect that we'll end up with at least 2 passive trip points but I
> don't know what temperature to set the next one at. So let's just go
> with 1 passive and 1 critical trip point in this series and you can
> send a patch adding more once we've characterised IPA.

Sounds good

Thanks!

Matthias
