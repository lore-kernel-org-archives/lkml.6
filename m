Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E41A21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Da+QNYHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfAJCWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:22:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42439 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfAJCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:22:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so4144735pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iz+yhSACsJcUJkjsky/UuCnBddMEOX/BB2HCGt7abuk=;
        b=Da+QNYHDfUIsEPVmeQ18jjehoMiKjVO/2lG/ohgrjHcn9wjQiRd4KutV3+GhzN3cQJ
         2ylAraKHXW6/BvJ6LgYqiVeZDwB/TBZARtUc0GnefXH6+6XJXVGXyjjtHEf9OiExu+HN
         qtmYGbaL9j7d5W9oRBa8BtvdYSbwri9/7dx9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iz+yhSACsJcUJkjsky/UuCnBddMEOX/BB2HCGt7abuk=;
        b=E9ctqdZqhvGoN1+o9xtS6R5teKxRt0EDB4pnwmx9N9QMIfjtd3Dfj68DBrhDF7H1hW
         X5wfqEZ5RChXos50v8A0+v+7KVI0s64OtIf20u5YuCb6nXZpdSLv1lshoVj1weDEX5uN
         iBaklXOgDznq/O6CKOCefPcuRDDEyiDiiTC+e+MRaRaUn8hezBKAMqwLgQqiBY4Di0AM
         hwQsy0UuIBvI2VKFjLGNvw6N8Ve19EZMOC9alb246uA1zNoPv6gUxnE3zuZH9pdMW6o9
         5IRns1DTjEDMVS9t+g9eNxIM38UVF6qeFkO7WidT14myhVe5nHaiwHCIeQgmUpLU1CM9
         MGVA==
X-Gm-Message-State: AJcUukdvXGhIKxdaw3ESzhRXM9KrSK17Qu0ftyvZFazT80AUKQ89r5lq
        HNa7a2faOvqYo+PuYq1RxLUdNw==
X-Google-Smtp-Source: ALg8bN6oBD1Zf73y9speT2/V5iaDOMv/qexOSBEUuyr7410IimH+8qJoWBrs4/cxscMoLtAZxqyXvg==
X-Received: by 2002:a63:193:: with SMTP id 141mr7746394pgb.136.1547086939174;
        Wed, 09 Jan 2019 18:22:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l74sm84276100pfb.145.2019.01.09.18.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 18:22:18 -0800 (PST)
Date:   Wed, 9 Jan 2019 18:22:17 -0800
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
Message-ID: <20190110022217.GX261387@google.com>
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

Hi Amit,

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

This is not needed (also applies to other for other non-policy
cores). A single cpufreq device is created per frequency domain /
cluster, hence a single cooling device is registered per cluster,
which IMO makes sense given that the CPUs of a cluster can't change
their frequencies independently.

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

As per above, there are no cooling devices for CPU1-3 and CPU5-7.

Cheers

Matthias

