Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F7AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625B920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeENP0AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625B920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeGTUId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:08:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbeGTUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:08:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so7627575pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tz9GR8Ziq+cR007EtKanpP4W5Xk2mPitFJaTv4pc794=;
        b=AeENP0AR2aVEqmbX8oj454GJpt1vksK6YHfjVoOiyocdfF/q7pOEB6gZHNtrEd3//Y
         Qyi4bYFDDt0104b57MuFWl+NmuB6JzPuQx+F01QBmHp8TKHT0rcVVvSX76LrcVs2LvX5
         N9uCbEjZP0ZlLw/a9k3ZGiHaa4VPa2nazgq5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tz9GR8Ziq+cR007EtKanpP4W5Xk2mPitFJaTv4pc794=;
        b=Ozf1cmK4bASrDbMOEWWMjKMM1V3kDc4iRrxxeqL4KGiJBbTin1ak4yOr22QRE34Au6
         /7mVNgqNYQqZRfa+0F+NPU6OISaFsxNSQso83CQGkHMQwejh/phQl0N6ikLhxOzKIY/7
         lec5YKwg4V+ShM/z1/qY890YA1Fqjf7ETNz0ZKEPRqNgYUDrx5m52wTShKNwunO/lboI
         oZkm/W7p7CsUiEfX/Kh10k85mDEYmaVdTydRfAcPokEksC3dKEB0S4YPXWKitiwcmJTF
         bOewN6PuPnSYqWl7l89dp9EqDAokkmN09jbSx00sNbDZsMb61BSy5LpCe3CNREGAiqly
         zmZA==
X-Gm-Message-State: AOUpUlG4VIw07l+oWDQChn0VaY7ZN6A8Nr9SWBszK+3FxgqFmvjXq5jU
        OmQywZIYklbW5BhLDIFOFVs6
X-Google-Smtp-Source: AAOMgpfbn75KTjokzjJXcH5b8qYy3/rED8oNTKF+JQ/EWAjU/jNlGDx9jX4lHvp/RJlcHwij6CH4yg==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr3119297pgb.95.1532114334858;
        Fri, 20 Jul 2018 12:18:54 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6302:6120:14db:6090:a7b8:8504])
        by smtp.gmail.com with ESMTPSA id p3-v6sm3630118pfo.130.2018.07.20.12.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 12:18:54 -0700 (PDT)
Date:   Sat, 21 Jul 2018 00:48:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v7 4/5] arm64: dts: actions: Add Clock Management Unit
 for S700
Message-ID: <20180720191842.GA2508@Mani-XPS-13-9360>
References: <20180719090649.12460-1-sravanhome@gmail.com>
 <20180719090649.12460-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719090649.12460-5-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:06:48AM +0200, Saravanan Sekar wrote:
> Add Clock Management Unit for Actions Semi S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 66dd5309f0a2..59d29e4ca404 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s700-cmu.h>
>  
>  / {
>  	compatible = "actions,s700";
> @@ -87,6 +88,12 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	losc: losc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> @@ -153,6 +160,13 @@
>  			status = "disabled";
>  		};
>  
> +		cmu: clock-controller@e0168000 {
> +			compatible = "actions,s700-cmu";
> +			reg = <0x0 0xe0168000 0x0 0x1000>;
> +			clocks = <&hosc>, <&losc>;
> +			#clock-cells = <1>;
> +		};
> +
>  		sps: power-controller@e01b0100 {
>  			compatible = "actions,s700-sps";
>  			reg = <0x0 0xe01b0100 0x0 0x100>;
> -- 
> 2.14.4
> 
