Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D450C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FCB20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bfLvHiWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfAWCMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:12:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46281 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfAWCMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:12:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so302998ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jqYMURHUlGumCMfsneHSVa8n2RCpsrdyKR5VG3aS3M=;
        b=bfLvHiWE+hNmBsgVN7c80izSRXiQSzook3Qihlw5FNIcEgZ6BSNifyZwoK7WqH1aUj
         gjIxLPuA5k+o2IUZb/khp82fXmde0YN7ixTCjmhPhWJfKjCqfnL665kcWyVfGV3lQzk0
         zB+LbKgI+d4TJrtaHnanr2zDhbVOfInVkFX9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jqYMURHUlGumCMfsneHSVa8n2RCpsrdyKR5VG3aS3M=;
        b=JwjX1EqpQA089NCmfxb5sJVIQcbUfgEDBgzQeuJ24JKcMDldThEGUntmj+JChffhex
         NyKSaVNGh9bVzOf6SJtOfeuCm8uQV6WjZSVuUvkahTdkmXwlBOCFFaOVcg56wK3wG+uq
         6jSiyKY2IpmiudHWSgPjJLmq1nfFuk9w6ujZk2xmgvs3VmBv65qRYc+UZC51K5/pOKZ0
         MWK0YG01lWN3WKoQPZTIc4Cnk+35CbKFFpjnENts7vygBqqPVFwVrTNSQ27TQBvbLcKd
         EDNnwUwMT1LzyrERdMu2F7i3iByS37E5YEIcf2nz8DM6WZoW/m6C5ScuFgHQhtm3YPDo
         Dg5w==
X-Gm-Message-State: AJcUukfDM/3obB80YvewR2mtr2+82E3RuKuxoyDaWL2MRwiE8ofcaf4D
        yJZtvGMIGu36DLTCswxZI8ZN/g==
X-Google-Smtp-Source: ALg8bN5cdCV2h3kScjHx+013Px132PDqUH75kzMgSSnoGIn66o/g4P75zM2QCw42yp4J943k/k79xg==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr364415plb.113.1548209573188;
        Tue, 22 Jan 2019 18:12:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i62sm20134071pge.44.2019.01.22.18.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 18:12:52 -0800 (PST)
Date:   Tue, 22 Jan 2019 18:12:51 -0800
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
Message-ID: <20190123021251.GJ261387@google.com>
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Mon, Jan 21, 2019 at 11:38:34PM +0530, Amit Kucheria wrote:
> Since all cpus in the big and little clusters, respectively, are in the
> same frequency domain, use all of them for mitigation in the
> cooling-map. We end up with two cooling devices - one each for the big
> and little clusters.
> 
> We throttle lightly at the first trip point, just removing the boost
> frequency. At the next trip point we allow ourselves to be throttled to
> any extent.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 225 +++++++++++++++++++++++++--
>  1 file changed, 209 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..878f661d16eb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -99,6 +100,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -114,6 +116,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -126,6 +129,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -138,6 +142,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -150,6 +155,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -162,6 +168,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -174,6 +181,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -186,6 +194,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -1691,18 +1700,41 @@
>  			thermal-sensors = <&tsens0 1>;
>  
>  			trips {
> -				cpu_alert0: trip0 {
> +				cpu0_alert1: trip-point@0 {
>  					temperature = <75000>;

In my observations a 'switch on/threshold' temperature of 75 degrees
leads to aggressive throttling with IPA when the temperature is above
this threshold:

[  716.760804] cpu_cooling_ratelimit: 31 callbacks suppressed
[  716.760836] cpu cpu4: Cooling state set to 10. New max freq = 1920000
[  716.773390] power_allocator_ratelimit: 15 callbacks suppressed
[  716.773405] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=73500, curr_temp=75200 total_requested_power=39025 total_granted_power=18654
[  749.609336] cpu_cooling_ratelimit: 45 callbacks suppressed
[  749.609371] cpu cpu4: Cooling state set to 11. New max freq = 1843200
[  749.624300] power_allocator_ratelimit: 24 callbacks suppressed
[  749.624323] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=70800, curr_temp=77200 total_requested_power=40136 total_granted_power=17402
[  780.152633] cpu_cooling_ratelimit: 41 callbacks suppressed
[  780.152666] cpu cpu4: Cooling state set to 11. New max freq = 1843200
[  780.165247] power_allocator_ratelimit: 21 callbacks suppressed
[  780.165261] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=64800, curr_temp=76900 total_requested_power=39719 total_granted_power=1759

(the logs come from a local patch in our tree:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ec1c501a8093fed44a6697a5913ef2765f518e1f)

At this point I don't have a clear idea what would be a reasonable
value for the 'switch on/threshold' temperature, but probably it
should to be higher than 75 degrees, at least with IPA. If there is
no reasonable common configuration for different thermal governors I
guess we'll have to target a commonly used governor and systems
using other 'incompatible' governors need to override the config in
their <board>.dtsi.

I should also say that the system I'm testing on isn't a
representative environment (if such a thing exists at all...). It
isn't running an upstream kernel (it's a recent version though,
4.19). We try to stay as close to upstream as possible, however our
tree includes EAS related patches that affect thermal throttling which
haven't landed upstream yet. Also we currently use a guesstimated
value for 'dynamic-power-coefficient', which impacts IPA. And our
device doesn't have it's final thermal envelope yet, possible future
hardware changes (e.g. heatsink) may alter the behavior.

>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit0: trip1 {
> +				cpu0_alert0: trip-point@1 {

The labels of the two trip points (cpu0_alert0 and cpu0_alert1) are
inverted.

> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 1>,
> +							 <&CPU1 THERMAL_NO_LIMIT 1>,
> +							 <&CPU2 THERMAL_NO_LIMIT 1>,
> +							 <&CPU3 THERMAL_NO_LIMIT 1>;
> +				};

With IPA this doesn't really limit throttling to the boost
frequency. Not sure if it has a negative impact, some other platforms
with a thermal configuration that targets IPA only have a cooling map
entry for the 'desired/target' temperature.

Cheers

Matthias
