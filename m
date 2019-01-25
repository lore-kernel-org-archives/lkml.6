Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF936C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689AB21908
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ev4AggLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAYWUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:20:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44088 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:20:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so4740975pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H7OdGAb0UO9zth+XRVtpGEySdnfFI42zRIH9L9/H4OU=;
        b=ev4AggLarxI4iiv64lFv2obHKviFVARRyEEaQxCG3iz9e++aLiKGAEaAliAmfFPsnX
         fVNES1lxAYc9akE4zGmBqf4cnti2F/C3izKG9XS9JOE/5JhzsifU+aymA0DayKLRH5/x
         bMb2KW+Ft3FmaOlsjl3U5B/zrNTkbZ9rxfKq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H7OdGAb0UO9zth+XRVtpGEySdnfFI42zRIH9L9/H4OU=;
        b=RFdnFIS5MZaMJt/ZPX+Xa7+KLjj/OXjiTSpaiL7f52Xh1XbGVndrWZ+9mR7TRGBc3N
         0hWOl2fBggY/1oIP8BbeGVj5nBRGAJtUg40sBGfQfn08mjZqhaFHPtU5/KWsbm29Iiho
         xaJ17SfJUKigewoPAs7pVYpypJ7BGYwZ08O+ynHa5Zun569XBGezWAhq0qXFnPOcyvZ3
         IAxioq8TC8MJfxnwsPmD4hazVv4RkHSkcEYucLhHr3bMoYJ6p3dq89plbrrG+Jn5GoOU
         jIqxocxmoz1dqXIadqI/9MmessCmzgULehVCJOeimlGZc92lGoH+iVY2m9TZKVoB09kX
         VlxA==
X-Gm-Message-State: AJcUukeQfg4aBDZj9Z9s5oTaHLpmgBO6XtXLvdhqbFUi5op3K7OKRQeu
        uaK4VoWKwTLYVnYo1Up5o4Jdvw==
X-Google-Smtp-Source: ALg8bN4Di+JhpuYJiihP2S+o4T3AuftcL6lyCaTdmJonf0A53puTBJEVmege5d2uO4sfXiCMGBLgOg==
X-Received: by 2002:a65:590b:: with SMTP id f11mr11668956pgu.60.1548454853630;
        Fri, 25 Jan 2019 14:20:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y6sm39152229pfd.104.2019.01.25.14.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:20:52 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:20:51 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190125222051.GF81583@google.com>
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
 <20190123021251.GJ261387@google.com>
 <20190124233528.GA81583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124233528.GA81583@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:35:28PM -0800, Matthias Kaehlcke wrote:
> On Tue, Jan 22, 2019 at 06:12:51PM -0800, Matthias Kaehlcke wrote:
> > Hi Amit,
> > 
> > On Mon, Jan 21, 2019 at 11:38:34PM +0530, Amit Kucheria wrote:
> > > Since all cpus in the big and little clusters, respectively, are in the
> > > same frequency domain, use all of them for mitigation in the
> > > cooling-map. We end up with two cooling devices - one each for the big
> > > and little clusters.
> > > 
> > > We throttle lightly at the first trip point, just removing the boost
> > > frequency. At the next trip point we allow ourselves to be throttled to
> > > any extent.
> > > 
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 225 +++++++++++++++++++++++++--
> > >  1 file changed, 209 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index c27cbd3bcb0a..878f661d16eb 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -13,6 +13,7 @@
> > >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> > >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > > +#include <dt-bindings/thermal/thermal.h>
> > >  
> > >  / {
> > >  	interrupt-parent = <&intc>;
> > > @@ -99,6 +100,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x0>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_0>;
> > >  			L2_0: l2-cache {
> > >  				compatible = "cache";
> > > @@ -114,6 +116,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x100>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_100>;
> > >  			L2_100: l2-cache {
> > >  				compatible = "cache";
> > > @@ -126,6 +129,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x200>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_200>;
> > >  			L2_200: l2-cache {
> > >  				compatible = "cache";
> > > @@ -138,6 +142,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x300>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_300>;
> > >  			L2_300: l2-cache {
> > >  				compatible = "cache";
> > > @@ -150,6 +155,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x400>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_400>;
> > >  			L2_400: l2-cache {
> > >  				compatible = "cache";
> > > @@ -162,6 +168,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x500>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_500>;
> > >  			L2_500: l2-cache {
> > >  				compatible = "cache";
> > > @@ -174,6 +181,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x600>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_600>;
> > >  			L2_600: l2-cache {
> > >  				compatible = "cache";
> > > @@ -186,6 +194,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x700>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_700>;
> > >  			L2_700: l2-cache {
> > >  				compatible = "cache";
> > > @@ -1691,18 +1700,41 @@
> > >  			thermal-sensors = <&tsens0 1>;
> > >  
> > >  			trips {
> > > -				cpu_alert0: trip0 {
> > > +				cpu0_alert1: trip-point@0 {
> > >  					temperature = <75000>;
> > 
> > In my observations a 'switch on/threshold' temperature of 75 degrees
> > leads to aggressive throttling with IPA when the temperature is above
> > this threshold:
> > 
> > [  716.760804] cpu_cooling_ratelimit: 31 callbacks suppressed
> > [  716.760836] cpu cpu4: Cooling state set to 10. New max freq = 1920000
> > [  716.773390] power_allocator_ratelimit: 15 callbacks suppressed
> > [  716.773405] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=73500, curr_temp=75200 total_requested_power=39025 total_granted_power=18654
> > [  749.609336] cpu_cooling_ratelimit: 45 callbacks suppressed
> > [  749.609371] cpu cpu4: Cooling state set to 11. New max freq = 1843200
> > [  749.624300] power_allocator_ratelimit: 24 callbacks suppressed
> > [  749.624323] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=70800, curr_temp=77200 total_requested_power=40136 total_granted_power=17402
> > [  780.152633] cpu_cooling_ratelimit: 41 callbacks suppressed
> > [  780.152666] cpu cpu4: Cooling state set to 11. New max freq = 1843200
> > [  780.165247] power_allocator_ratelimit: 21 callbacks suppressed
> > [  780.165261] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=64800, curr_temp=76900 total_requested_power=39719 total_granted_power=1759
> > 
> > (the logs come from a local patch in our tree:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ec1c501a8093fed44a6697a5913ef2765f518e1f)
> > 
> > At this point I don't have a clear idea what would be a reasonable
> > value for the 'switch on/threshold' temperature, but probably it
> > should to be higher than 75 degrees, at least with IPA. If there is
> > no reasonable common configuration for different thermal governors I
> > guess we'll have to target a commonly used governor and systems
> > using other 'incompatible' governors need to override the config in
> > their <board>.dtsi.
> 
> On my system I don't see a significant delta in core temperatures for
> 'threshold' temperatures of 80, 85 or 90°C. However Dhrystone
> performance goes up by ~8% when changing the trip point from 80 to
> 85°C. For a switch from 85 to 90°C I see a ~2% performance delta. For
> all trip points the average core temperatures are ~80°C (silver) and
> ~85°C (gold). Interestingly I observed the highest average
> temperatures with the trip point at 80°C (repeated measurements were
> taken for different temperatures).
> 
> Supposedly LMH throttling is disabled in the firmware I used for
> these tests, however data suggests that it is still active
> (temperature doesn't rise beyond 95°C, even without throttling in
> Linux; Dhrystone performance drops when raising the temperature beyond
> 95°C with a heat gun. I will do some more testing when I get my hands
> on a FW that effectively disables LMH (or raises the threshold to
> something like 105°C).
> 
> From the data collected so far I'd suggest a 'threshold' temperature
> of 90°C or if that seems to high 85°C. Behavior might be different
> with other thermal governors or without LMH throttling..

Some more data from measurements with different trips points, for the
IPA and the Fair Share governors, LMH throttling was enabled:

			IPA
	Dhrystone	Temp Silver	Temp Gold
75	6M		78.4		84.9
80	6.21M		81.4		89.8
85	6.74M		81.7		88.2
90	6.88M		79.4		84.6

			Fair Share
	Dhrystone	Temp Silver	Temp Gold
75	6.63M		80.1		88.5
80	6.71M		80.1		88.5
85	6.77M		81.1		87.8
90	7.12M		81.2		87.8

Within this range the 'threshold' temperature doesn't seem to have a
large impact on the average CPU temperature. There is a bit of
fluctuation between individual measurements, I wouldn't be surprised
if the outliers of Temp Gold for 75 and 90°C converged more with the
other values with some more measurements.

I learned how to effectively disable LMH throttling, however with that
it was fairly easy to have the CPUs overheat, even with throttling in
Linux. If it is feasible at all to run with LMH disabled some more
actions will be needed (e.g. attaching a heatsink or interrupt support
for thermal sensors instead of polling, ...).

Cheers

Matthias
