Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40083C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFDF2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ndzx3w67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437518AbfBNIeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:34:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42777 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394645AbfBNIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:34:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so2684345pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bpd8PA3u3JrSVmuhmsHW2bxdpcyCmZx0PS6GlvD0wGA=;
        b=Ndzx3w67x7NWqoTwPDLzFK/8piJRNsTTOBDhdiKTA4T5wGgcaf0c07P26qOtXV4UrC
         76JcFtP4+/0bTTMaJsQppoTUJK94tfFsyw+EKdP/mjXSyxQCKrRa9IRNYDvLdbzKU36E
         OPHfyjz6S4QzNCeGKkKlbc/WlENEoLoexoVe2aCZa+WNEn4KDs3+ad3t42qoC5cnJRPF
         JfWY25cnwTg8ULl1MOSDshtKeQcPbesyPcIXNrKNh9KocvDY9b5nR3mg3wVRTdiZhk43
         pUpJNAJZxR1rwe8ekq6hRYanPcMz8INM4zmABpdoz1TpzCpe2olFkCYJvxr3PDun3FpH
         tj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bpd8PA3u3JrSVmuhmsHW2bxdpcyCmZx0PS6GlvD0wGA=;
        b=mpSoObHH/fekr180ndmrNq91Vlu1A/3H+1FpZ+SNa1TL6IP6v1kdN9+tC8Q3nFLPkW
         fjBtZKCw9/vZQodimFHQ9RaFuULJ0mUDoInRrjnvmkFkDc2lfYauAba2WQ02+k/Hicqn
         X8Yn+pl0/NS4czBdMY/ZAk7HNi4BO/qy21RAHCiy0Khvtu0fJlTiycSPCaZfcKqqCLLt
         z59eSTAJx70OE5jX9111OkpD8mZ5nMKg0JYWhYZAlZUwGRHkthbhhI1a2bxjuIUC/kGO
         hYBW25xtPtg2FAvt+hiGxqw75b7RDLlnstD54VKndnjnWG2BMcYDMmjIYk0nYU1voyPG
         t64A==
X-Gm-Message-State: AHQUAua/+G6bmhAfl22G9T2PAruioMhIKFiaHuxVGGgPhqg3MPglDmLC
        Ti78UXY9dt8sQFSxW5A2leGMqA==
X-Google-Smtp-Source: AHgI3IbVmCDf7+SMTXCPLQ5MmQj3W6jsZDsBvTmZvZ/Ip1kbcT7u+IRJSuILIjHyEGtMiQcY9ptF+g==
X-Received: by 2002:a63:516:: with SMTP id 22mr2525276pgf.353.1550133262179;
        Thu, 14 Feb 2019 00:34:22 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d16sm1789033pgj.21.2019.02.14.00.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 00:34:21 -0800 (PST)
Date:   Thu, 14 Feb 2019 14:04:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190214083419.slnuolyy5xhz4szy@vireshk-i7>
References: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-19, 08:02, Anson Huang wrote:
> Add i.MX8QXP CPU opp table to support cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V4:
> 	- remove redundant clock-latency property in A35_0;
> 	- add #cooling-cells for all A35 core.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4021f25..fad1259 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -34,6 +34,9 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;

As I said in my previous email, mentioning clocks is important too for
other CPUs.

> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_1: cpu@1 {
> @@ -42,6 +45,8 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_2: cpu@2 {
> @@ -50,6 +55,8 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_3: cpu@3 {
> @@ -58,6 +65,8 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_L2: l2-cache0 {
> @@ -65,6 +74,24 @@
>  		};
>  	};
>  
> +	a35_0_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-900000000 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <150000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <150000>;
> +			opp-suspend;
> +		};
> +	};
> +
>  	gic: interrupt-controller@51a00000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> -- 
> 2.7.4

-- 
viresh
