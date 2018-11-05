Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB78820882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5pWyZCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB78820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbeKFEZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:25:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeKFEZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:25:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so4650547pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uVIVErXsCVdzVsP28DTEusKjlFUYy4X61zGCgTKtb0=;
        b=W5pWyZCdlKdOjjbXlD+YQiS2w3syAgoyxb0jLR1+Rf7+NFauqhZ54W70UmBy59+hkO
         PogtA/L7rjQxn5GDbUgTQ9j6nRxfJtBA6ddY0NHuEAN2M0sM0zGksSBlNZEYiOl38nmj
         YlHsJAmSPoi7k4y0LE9HC4EdIA6+mHw3euE18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uVIVErXsCVdzVsP28DTEusKjlFUYy4X61zGCgTKtb0=;
        b=pBIAsRdrCQLFrV8mg8MKCUaTWJOI/wHBXw4CHG+ruV4vEkg0+77IxdqXLlsBDAVFdH
         M+jWddXU5yh/UdSDeoTFI/c3GDQcVl54h8LqZEg+Uop3wOGb2IjjMqhs8uXbcoqrU+Yf
         XpYXKKx4Yrm5MtKAN1cDpV/3MEjYqzbMhcNAOnVHFaZc4OzZIa4pWsKlBN1YH6nJN1X7
         vDG55UBh86EmBik66y1XjHYOp/js0dFthpNQOxVNZhz5oT7TxZz+CDgkML5ruiIJy7mT
         eg/f2/qZatpeVVTchFNHYv0tRFFCQcST0k3Bhpna7Hdh9Lg0xvSelzlrSMc1veZNRE1P
         /l+g==
X-Gm-Message-State: AGRZ1gJGmbMaa5cBKviHc7zSnbElWM/v7npGvDAWnXemoDB/2COxbWRw
        nwj4ftew/JEZWHzJKGuQ6DzBNw==
X-Google-Smtp-Source: AJdET5frCZQZcqCz1fB9f2Qiwdc7tGWz4dp+DRF4613PjDonK7Lt5BiQ0HdxFQdTRS+4CKEIhjCR/Q==
X-Received: by 2002:a63:1560:: with SMTP id 32mr4240379pgv.383.1541444656627;
        Mon, 05 Nov 2018 11:04:16 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m10-v6sm89014118pfg.180.2018.11.05.11.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:04:15 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:04:13 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/17] arm64: dts: qcom: qcs404: add spmi node
Message-ID: <20181105190413.GO2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-10-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-10-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> PMS405 is used in QCS405-EVB so include that with SPMI nodes
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dts |  1 +
>  arch/arm64/boot/dts/qcom/qcs404.dtsi    | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dts b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> index b79969153fba..10ad05ba5ca9 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "qcs404.dtsi"
> +#include "pms405.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 970ca9a62530..4d47d5e11a5a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -242,6 +242,24 @@
>  			};
>  		};
>  
> +		spmi_bus: spmi@200f000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x200f000 0x001000>,
> +			      <0x2400000 0x800000>,
> +			      <0x2c00000 0x800000>,
> +			      <0x3800000 0x200000>,
> +			      <0x200a000 0x002100>;
> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +			interrupt-names = "periph_irq";
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
> +
>  		blsp1_uart2: serial@78b1000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0x78b1000 0x200>;
> -- 
> 2.14.4
> 
