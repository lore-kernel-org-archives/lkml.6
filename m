Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9774C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985862133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qf2rbDt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfAKAaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:30:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38298 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfAKAaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:30:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so5921901plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DHyAdLF/ddM1tVkeJZ50/tigigj++VuMizBPMFP16s=;
        b=Qf2rbDt0SNqF/quJp7AWepqQsDbk3Z7TMY3X9ilNhmUMPsONtQq98zlLw930BbX0Um
         zutzSI+Vy7ZId5q9GFROcBlbBIoNKuUDC8OTiqZFsJyyejWnCVsORHjIsDi2yaXAsaoJ
         eyAKiX0gr5QarPdZ2DbeWEw7AhDdh8P/dga0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DHyAdLF/ddM1tVkeJZ50/tigigj++VuMizBPMFP16s=;
        b=oXpJXhjAecobEWICOyqEboAsTWP9S2THQ0BJ88lwE0ucZSkalgI1ikv4pEpxPWO72N
         oTmjRwacevEkkA80ejEULdZtTnRY1tpzFEbZKpvVrOkKzecGoMJLsxUAHbsKqV228ecL
         5Vk9dimsSjAPJiu1vX2cvVepMbRQyQGDdUPI4EHUcin1I5Eo3Aw60yI/ZIb+Uv04OW3l
         TtZEuWIK7H+yQYmLEtisbt0KVxnRr51d3kvy1FexOpITy4ZEKHWOre4KC/ifysNxXZF9
         j9GixX/kdmmb1hWZQAJ1TQJYo/ba2tYj0rnPQCqxJPUqmoMhEWDSmFBblQ35sTa89eUt
         jolg==
X-Gm-Message-State: AJcUukfOI8PKlaP9P5wjrmb4cEhCag5lO+vynxGs3qHoxxuuNXHlaC1P
        pCmLK49pjZzf5KQZBf/hKG382Q==
X-Google-Smtp-Source: ALg8bN5NzSVu1HY39HE7s2FR85BZj4Y5vaxJ/Q0OaipFIKkgA9LeMMkjvxltnx/YUmNHhQbTy3do5A==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr11954821plb.274.1547166615918;
        Thu, 10 Jan 2019 16:30:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o66sm149155921pgo.75.2019.01.10.16.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:30:15 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:30:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190111003014.GB261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:30:56AM +0530, Amit Kucheria wrote:
> Since the big and little cpus are in the same frequency domain, use all
> of them for mitigation in the cooling-map. At the lower trip points we
> restrict ourselves to throttling only a few OPPs. At higher trip
> temperatures, allow ourselves to be throttled to any extent.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 145 +++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 29e823b0caf4..cd6402a9aa64 100644
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
> @@ -1703,6 +1712,23 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> +							 <&CPU1 THERMAL_NO_LIMIT 4>,
> +							 <&CPU2 THERMAL_NO_LIMIT 4>,
> +							 <&CPU3 THERMAL_NO_LIMIT 4>;
> +				};
> +				map1 {
> +					trip = <&cpu_crit0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};

Slightly off-topic, buy maybe not so much since we are just starting
to use the trip points:

Currently we use the naming scheme 'cpu_<type>N' for trip points. I
anticipate that we're going to add more passive trip points soon, to
keep the 'power_allocator' thermal governor happy, which expects a
'switch_on' and a 'desired_temperature' trip point. With the current
naming scheme this could become a bit messy. I suggest to change it to
'cpuN_<type>[X]', which would allow for something like 'cpuN_alert0'
and 'cpuN_alert1'.

If you think the change makes sense you can consider to do it within
this series, I can also send a separate patch once it has landed.

You could also consider to add the additional trip point in this
series if you agree that it will be needed.

This is not necessarily a call for action, just thinking loudly about
a closely related topic ;-)

Cheers

Matthias
