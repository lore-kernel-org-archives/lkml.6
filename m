Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A8C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7575218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EURyhjwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfAEDtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:49:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAEDtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:49:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so19153760pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 19:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oh50aT9Sm9VnfXmqmWbMsRDFspd7GJSylxhc9oS4/Qc=;
        b=EURyhjweHJqqa+dKma1VEUtLypc/mK4igi8UtQXoSOONVxpzuF1h0coWAGB3uB6XYz
         31+/81TC3AWDMqDi96YziOUTciRNx3N9FueVUTDz/+o+5Yxt1mqWBOhYV3CMEqlaSuiJ
         g8zcjihaiphltJAL9Eg4ee8XJ7CpHfshxf+30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oh50aT9Sm9VnfXmqmWbMsRDFspd7GJSylxhc9oS4/Qc=;
        b=a2SCTFYdwhU59Lfxc2C/Xnw3X4699OElKnHEmuBBHzSZoRloCNsrVMZakGqXKEI+1K
         t4F726/QG2w/K6gBZcLu+eMau6z9FYTq3eS5DlU8CKB1WHXIUKOVe8elrfrwpW6NAX5d
         ROzElkL37wMQw6nPf8w7stB1X8WsRPzNVXqnkDcOMY44JJCbqtYmS6ceKbjkREVLFHWd
         elyPZz7eYYQDIJum8fv++VCV8r6i66LVXs0y5/S3zMnZyFUGA/QKFMGIRkvOHVSbQJJ+
         7on7S/338bUbAyn2d01X9VCwRLrMkSE5G7gfvNz32ekkawDwQ93BOy4BOa4xM0dPxN8J
         jgaA==
X-Gm-Message-State: AJcUukfNgz8TZ6rh38vH4AAeahfpfiMrS9Efub1kQ0Ns33D8xQHx4QUK
        QvGfQ5JodSluk1UVzLUPAkNm
X-Google-Smtp-Source: ALg8bN5BrW898r7Ty7GQPu1+6XNIBpb+oq5zjcatPS2++069oAXEU6KqP7CLCDCVroV3r+iMh4GWaw==
X-Received: by 2002:a63:7f4f:: with SMTP id p15mr23024050pgn.296.1546660154870;
        Fri, 04 Jan 2019 19:49:14 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id w184sm68960902pgd.34.2019.01.04.19.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 19:49:14 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:19:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/8 v2] arm64: dts: hi3660: Add dma to uart nodes
Message-ID: <20190105034904.GD2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jan 04, 2019 at 12:56:26PM -0800, John Stultz wrote:
> Try to add DMA support to the uart nodes following
> the assignments made in the dts from the victoria vendor kernel
> here:
> https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 20ae40d..aaa2b04 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -466,6 +466,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf02000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 0 &dma0 1>;

Usage of DMA channel 0 contradicts with the description provided in
patch, "dma: k3dma: Add support to dma_avail_chan".

Thanks,
Mani

>  			clocks = <&crg_ctrl HI3660_CLK_MUX_UART0>,
>  				 <&crg_ctrl HI3660_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -478,6 +480,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf00000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 2 &dma0 3>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -490,6 +494,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf03000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 4 &dma0 5>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
>  				 <&crg_ctrl HI3660_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -514,6 +520,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf01000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 6 &dma0 7>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -526,6 +534,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf05000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 8 &dma0 9>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
>  			clock-names = "uartclk", "apb_pclk";
> -- 
> 2.7.4
> 
