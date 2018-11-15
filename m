Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D015223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBSQgnr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D015223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbeKPEfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:35:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46241 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbeKPEfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:35:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so10072234pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RobRBaJdt2tXAXxOllHUbmPOAJUJBNlH6IyjbUb8Y6s=;
        b=NBSQgnr92tC0uFwIr3x6FedifJtjQ/3w9Hd2voC+lCgudyw4ZgIX5nlsZ54qc3/217
         0en50BbyZZhuqjlaG7rBATqUewH/e2I1EoDEOZRqOghsAFdYuFlZbBnFyE6L12QNxyMr
         jZ2/EPu2vwCqdfauH0KsbYQGXaW7Mzwqovhw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RobRBaJdt2tXAXxOllHUbmPOAJUJBNlH6IyjbUb8Y6s=;
        b=AQWp3FqjhL6dWJKIaF1l0VjnBiPsPdpJwIma5AshziE8wVFLyLKcDygW84aJrOQTfN
         TVlwFG7XlBPQ/aAvlTo6nuH1ggdnagzMaSp+llhuFXgQ/GVuDebdotZrOj/OfIHtpSb/
         XiCIXh2jrc2uEFV4iSFZj+2k292lS8yS+tqlxqdJicJL1sXNjP+CvHqW/4AsA+6dUS/1
         neW5M4SIbtalcjTT6JXgUn4noxXdmqKdVAugqM1Gu4Q7PuS8dRTZuJs4c5+YnMGY21SU
         SMCMIwvOVZkXfrZtWnilvwCKxqCoF0vDrh79w8Ati8n+yrXGL9XpGHQ+q2+GdimQt1VA
         HZRg==
X-Gm-Message-State: AGRZ1gKpYJ3/ByS00D09AUUDzMMPf5NkrQSifePwPxXdnQRRHRPuvqTF
        df5UEtqZIowNDgJuIfXQxG9www==
X-Google-Smtp-Source: AJdET5dl2JMAHprL1bp56sFq5sSk4YZF9+95kzDlmIZb/xBpo53D/lvmdrWH/B0UT5/luN6XkanMrg==
X-Received: by 2002:a62:37c7:: with SMTP id e190-v6mr7411572pfa.145.1542306420481;
        Thu, 15 Nov 2018 10:27:00 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u5-v6sm38259169pgk.46.2018.11.15.10.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 10:26:59 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:26:56 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: msm8998: Add SDCC2
Message-ID: <20181115182656.GJ10915@tuxbook-pro>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-3-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542302291-6864-3-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15 Nov 09:18 PST 2018, Jeffrey Hugo wrote:

> SDCC2 is typically used as the controller for an external SD card slot.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index a948d4b..09deee0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -53,7 +53,7 @@
>  	};
>  
>  	clocks {
> -		xo {
> +		xo: xo {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <19200000>;
> @@ -605,6 +605,23 @@
>  			#mbox-cells = <1>;
>  		};
>  
> +		sdhc2: sdhci@c0a4900 {
> +			compatible = "qcom,sdhci-msm-v4";
> +			reg = <0xc0a4900 0x314>, <0xc0a4000 0x800>;
> +			reg-names = "hc_mem", "core_mem";
> +
> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clock-names = "iface", "core", "xo";
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&xo>;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		blsp2_uart1: serial@c1b0000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0xc1b0000 0x1000>;
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
