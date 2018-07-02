Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E87C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1245F22B1E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVM6Ydo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1245F22B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeGBSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:45:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45500 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeGBSpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:45:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id bi1-v6so8341791plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWRQROmrjIciYLD3khEzuILTKLGlhBhHL79m00fYyg8=;
        b=TVM6Ydo0GRGS/D/pwaKwpYJmgaUzU0u8I2LxXpvVv6lwiPb4/Yw5GB2jD6gQQP8QfT
         4ZdINTnrV79FDs3GfqoFR2iR3pzhk2PdLP8EFNF/EGqxLEq2K1U/4yRbLO0IUY7swYzB
         rvv7ipDlYxjdSYNA8Q3NSmq1+TechBnx9BWQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWRQROmrjIciYLD3khEzuILTKLGlhBhHL79m00fYyg8=;
        b=OqXdNVFsWlkviMvByXwQvxoiSkq3AP8MihUGBsuFG+/3gQZbtBBfvlBnXbAQwqCGWp
         xOKkpYb3EQsKqir+AZjL4b5sVWrrD7TD4Xz5Z1kSXpIO8Vn4jdFmfPv8FYxyhuvB6EuB
         GrAndZy8G6bnEzW3+0BerflRnbweE8eUqoYoNxgRcL/Y3aORZ1J51HJ8JRx6grmCMQp4
         yMJEqf1gdtSxhAx2vZ5PX40JvxmouhdpmLNxqwxMheaIhQBTqvmRhLTlE9yzTuJ1UJZI
         AqdqGWkqgvJRq3WYwDEl/FBVOvcIX+Yty2xSXxg4LDt0Xjv386UZCiLKkZUemvbY+4sl
         uGwg==
X-Gm-Message-State: APt69E1uU5B2exYN4wyvEo6aLLbrJUIq2Pb7tL1Sfq1k/Ohl/SolO3x3
        6epKvETQi++is8qcdP/WxbgBOA==
X-Google-Smtp-Source: ADUXVKLyENXgIyPIRDpivj/l5sXT0Okcu/UxAAXbLOXvXy8CJEms6sjuPlg35YTLlQOH+uDm5dd++w==
X-Received: by 2002:a17:902:a508:: with SMTP id s8-v6mr27346221plq.223.1530557137431;
        Mon, 02 Jul 2018 11:45:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z66-v6sm5242275pfi.150.2018.07.02.11.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 11:45:36 -0700 (PDT)
Date:   Mon, 2 Jul 2018 11:48:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/6] dt: qcom: 8996: thermal: Move to DT initialisation
Message-ID: <20180702184806.GA2050@tuxbook-pro>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <80e54ddfa672ae05db24a90c5f5463fc7fcbec46.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e54ddfa672ae05db24a90c5f5463fc7fcbec46.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8c7f9ca..6c8a857 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -461,7 +461,17 @@
>  
>  		tsens0: thermal-sensor@4a8000 {
>  			compatible = "qcom,msm8996-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@4ac000 {
> +			compatible = "qcom,msm8996-tsens";
> +			reg = <0x4ad000 0x1000>, /* TM */
> +			      <0x4ac000 0x1000>; /* SROT */
> +			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -- 
> 2.7.4
> 
