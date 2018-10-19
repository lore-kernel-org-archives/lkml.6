Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C921ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD972054F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iv33fPvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD972054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeJTFiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 01:38:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39251 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeJTFiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 01:38:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so16291527pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xD/+Jfw14NbMCVPGG70x9BaWQy5fDQEsyM3nb+i1ND8=;
        b=Iv33fPvccqxjj2MvLoom9/eL4EuPV5ZomMwgSjl5TwT3lr6YHazg0s6ggrg23vOyT+
         awRxENtPdbD4ilpjrFC1sHut3HeRDCwVsCeTcNWjuAOYJWZb7QEtNZxcn1ehNwKyBKy/
         tM0dN95rzBAeUSzahtVEMw8mRGkxRdOunod6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xD/+Jfw14NbMCVPGG70x9BaWQy5fDQEsyM3nb+i1ND8=;
        b=LzfhxJFZFSOncynXuP7YdDwo+y/4ij9N819PyALBMrRB7L5mXPqOPnFDtAlMl0Fqb9
         67PDaEQjfFCxm18HaorHubAyDITYfysrzVI2J/cCfxOjaLO1u8RtiRyWtn0WzKYE/zGn
         do41MvG10zdup1UG/M4P2ISvKB6cH80b76TEeI/aLp8c0xp+6qFUqVnn6tNA7554V57T
         cwy60t4vST9TfUO7M5vppVxJNc9mU4ePgCQ8biAz9h8kOYESpCxXBV6aK7X5BwT7HXXN
         kvvT6j/11qGyWeJLAolu6SRv95eNWRYPpo1SnbL1lMaj2xuPX6cnckSwKCT7g4bdw/l5
         Sb6g==
X-Gm-Message-State: ABuFfohdhFcxPxXAcPjzV8al7qg/3uiUHR6E2c324zERKixFQvIMD+Bp
        YlemSKDoMvZYlvXrNrtKFwnVQw==
X-Google-Smtp-Source: ACcGV61ENa+WunwmzqMyRDjttgEw4Ry9aHu6REBX8kPj2S112NDUy4+75RJX/A3r9YlmUo0SaZUTIQ==
X-Received: by 2002:a63:d917:: with SMTP id r23-v6mr34586637pgg.0.1539984614745;
        Fri, 19 Oct 2018 14:30:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id k72-v6sm42984026pfj.63.2018.10.19.14.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 14:30:13 -0700 (PDT)
Date:   Fri, 19 Oct 2018 14:30:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181019213013.GW22824@google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:06:00PM +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..712643f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,173 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-hw".
> +
> +- clocks
> +	Usage:		required
> +	Value type:	<phandle> From common clock binding.
> +	Definition:	clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +	Usage:		required
> +	Value type:	<string> From common clock binding.
> +	Definition:	must be "xo", "cpu_clk".
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the HW bases in
> +			each frequency domain.
> +- reg-names
> +	Usage:		Optional
> +	Value type:	<string>
> +	Definition:	Frequency domain name i.e.
> +			"freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:
> +	Usage:		required.
> +	Definition:	Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
> +
> +
> +Example:
> +
> +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
> +DCVS state together.
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
> +				      compatible = "cache";
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_100>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_100: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_200>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_200: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_300>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_300: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_400>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_400: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_500>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_500: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x600>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_600>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_600: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x700>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_700>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_700: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +	};
> +
> + soc {
> +	cpufreq_hw: cpufreq@17d43000 {
> +		compatible = "qcom,cpufreq-hw";
> +		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +		reg-names = "freq-domain0", "freq-domain1";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +		clock-names = "xo", "cpu_clk";
> +
> +		#freq-domain-cells = <1>

semicolon is missing.

> +

delete empty line

> +	};
> +}

Thanks

Matthias
