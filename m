Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB70BECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07A320693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bzFR/7wQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07A320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGRAvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:51:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39467 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbeGRAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:51:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so1144124pgs.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7vMRPtPt4Yx7mr9RdLfsRuIRKUGVVTVYYf+Wows7Wc=;
        b=bzFR/7wQK+cHujwnEVd5/+NFeffSnKv+yojF7Gqxc1jnc7hsKHDMn0Nn9odbTzPu4X
         s/zXOvQBaDyARkgfFT2o0zsZxZOCcTonAEz0Rmpd6lGif2Xb3ATIFwg1IAEshCCvc7hz
         2oQDThCqTDjE8K5IBYAMKqmoxDKOcfnSpw3i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7vMRPtPt4Yx7mr9RdLfsRuIRKUGVVTVYYf+Wows7Wc=;
        b=d8LdPZHFzv4xfHyZMkH+ufzx8AKnH9Y8avxpj7kfhc1bP7yjISvTfIX9ZsHb4dafj/
         wTVXaXzrHrc1aniZLQn4m33oGrkZIAe5h8jn6b/tRxP8zvTh2SwCYm2lJlJoa4CZdDf6
         H2X8O6L7USTNBiJUt3l6EqUD3eO2LW998rM50fPnEkDP2sdRgqoW40QE77QRBadF1gOk
         H27GtEEV8rEDSwvqU1PLzM2pePD9N8JsA0B0gLahBl4ROhPw0V80sys2L3IJIkzLPqC4
         rsitIw3gWAl/kSmd4PNc7m/d7GSdmQpKz0YF6bCYQ2+bvVcI/kfkjVE1W9eVC8vYuhDL
         PLYQ==
X-Gm-Message-State: AOUpUlFhz6jVqQw8CXuBUnRYvObeTMvFhg1JtBbfdjbP0MxGgh+s7JIh
        L76HyidM6RFxupqPYIOrncQ6/A==
X-Google-Smtp-Source: AAOMgpfuwBQWf+T93HCvbFwMkywd2xT+YAvTlpdclhGHh8h/WTlx04rsX+pMvaVmMYS/sW5s+0zAuA==
X-Received: by 2002:a63:f206:: with SMTP id v6-v6mr3270883pgh.319.1531872955808;
        Tue, 17 Jul 2018 17:15:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b76-v6sm6190144pfj.184.2018.07.17.17.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:15:55 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:15:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 7/7] arm64: dts: sdm845: Add tsens nodes
Message-ID: <20180718001554.GH129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:09:08PM +0530, Amit Kucheria wrote:
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> allow more common code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..01ff146 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tsens0: thermal-sensor@c263000 {
> +			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +			reg = <0xc263000 0x1ff>, /* TM */
> +			      <0xc222000 0x1ff>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@c265000 {
> +			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +			reg = <0xc265000 0x1ff>, /* TM */
> +			      <0xc223000 0x1ff>; /* SROT */
> +			#qcom,sensors = <8>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xc440000 0x1100>,

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
