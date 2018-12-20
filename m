Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A27C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A36B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WovJ7XO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeLTTu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:50:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34824 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731163AbeLTTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:50:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1360529plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjUg7R1XST2kzHO5K2dbel0SWVi+REGA4J6AxgTJpMc=;
        b=WovJ7XO7At0R61Ino4A5jayelH2VG7UMgBnTBBHNUNDFpejLf7Pp8JpGAXozd9w0j6
         6qxprNm5ll2wZx4YAB8xPHPRHpocrw7pIDeYp0PMpEKMKjBFYhyRR+UodDB46pEOeViE
         5TXg60l17My/5hO0aqaQ9YNnAz1WcyrC2iSL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjUg7R1XST2kzHO5K2dbel0SWVi+REGA4J6AxgTJpMc=;
        b=dhlAhJ8w0EVKidD3/2MNvKOzX4jSwp31HikA/5uONYxOrfpJrYObECiQnpSO5Ms5Zl
         RKS8I16/eE/Gw2Wr+Mlg+f2kU7SvEB6vt4kHxk6eVBMQDMAxMGECUekdZ1m4i74XRuFt
         UaFFdFTvQrPYd/FIVRqeczekqiwfJoYGxOiA6N4YgPi1ps1mB5mR9DarnhsxUsTSbf4j
         x4mGAktQIfPaKrAY0ixpybFsTGOPIf0VmBxzl1Fe6ejxEF1cpeyJM0+C1tXx4xVMwe9V
         bUrNgVjljlpRPGQYzlAPEZyu/mjxUN62mcoyEXksdUBfxWWV+GaypolFa7jx2WotqtFT
         A4PA==
X-Gm-Message-State: AA+aEWalkpOA6YdbMLyWOrX8f2d7vIfFQaR0vJ5H08xq6CZW/ycd7F2F
        Yzts3HqMf3+nw8qR7jt+pFKZJg==
X-Google-Smtp-Source: AFSGD/Us9E5aoWOcuSE+g7meXBc3oOpp07BsL2j7GWNxxO9i7vEZcC46ObER4fuxvqhhAAt7Njlyrg==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr24507168plm.45.1545335457115;
        Thu, 20 Dec 2018 11:50:57 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h8sm31463666pfo.162.2018.12.20.11.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 11:50:56 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
X-Google-Original-From: Matthias Kaehlcke <mka@google.com>
Date:   Thu, 20 Dec 2018 11:50:55 -0800
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add cpufreq device node
Message-ID: <20181220195055.GB261387@google.com>
References: <1545333530-30151-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545333530-30151-1-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On Fri, Dec 21, 2018 at 12:48:50AM +0530, Taniya Das wrote:
> This change adds the cpufreq node as per the bindings example for SDM845.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 23a253b..5db4fcc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -99,6 +99,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -114,6 +115,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -126,6 +128,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -138,6 +141,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -150,6 +154,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -162,6 +167,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -174,6 +180,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -186,6 +193,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -341,6 +349,17 @@
>  			#power-domain-cells = <1>;
>  		};
> 
> +		cpufreq_hw: cpufreq@17d43000 {
> +			compatible = "qcom,cpufreq-hw";
> +			reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +			reg-names = "freq-domain0", "freq-domain1";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +
> +			#freq-domain-cells = <1>;
> +		};
> +
>  		qfprom@784000 {
>  			compatible = "qcom,qfprom";
>  			reg = <0x784000 0x8ff>;

My understanding is that the entries in the SDM845 DT are sorted by
address. The address of the cpufreq node is 0x17d43000, hence it
should be the last entry of the 'soc' node, after 'timer@17c90000'.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
