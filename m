Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A2BC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A575820856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddUrGFlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfAQQ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:56:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfAQQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:56:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so4698154pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0BZItxe72NDpqOUQeNAUH+rms79uSn5IzgLs/SIvig=;
        b=ddUrGFlWNS19wXFM4STS7+RiydNFM8v99ueCqW5IcmOvhrTSmLwj6ET+IH/E+neALK
         CkaygvdZADzRaPiDrbXEM02C2hZuLTDYE5chAtlt6fL8Zn0kf7yAfpCU5IXCrN424hnn
         K37bnxzs8gw+9D65rTdeJhtOl0MoaSFK0PX3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0BZItxe72NDpqOUQeNAUH+rms79uSn5IzgLs/SIvig=;
        b=VeB4osv9kCNrwvp/0+K6gzCTZEJ+KYNdxIb79zSV7ds6D8JMF6/TAkARiGar63MqOC
         V2UaQs7TThl7ZdoA1h6RGErghdQivoqJLB/XgrwxJhX9+DrXUuTJhijTqadiLw3NeOeN
         D8UW/lO5uJe7a6GHy8RDaGJAgPLRXa7xDRYQOtIy4VBgl/RpmL1PgYM+LXcOHON1mbEi
         PI8Mjo8v1yaKXC+WESXqH6ojKX7A23TSJDyqVGRSPAnfDTqhwRQB/xX7Q1fYHcKVF4fF
         vBykfwfqBZvPaaq6WMpKHmf55i5s7DgkEXMvDdPPGEkUiIWkEf5IbPwyvo8CsplxY62D
         lvvA==
X-Gm-Message-State: AJcUukebKGD8WqLDq0AtrJZEr2Qss1pA58/aOkbPnsLfvMyTqR6ky0sZ
        sVgnu7BZk9hDAClRDRTgLu0t
X-Google-Smtp-Source: ALg8bN63FEKZyB2rzG3V9pv9AcxURMuzrFF+wCB4YpcNM14RpdbIDE04FTvpddG2Yvwt0yxAE0tJZA==
X-Received: by 2002:a62:824c:: with SMTP id w73mr5105470pfd.150.1547744196768;
        Thu, 17 Jan 2019 08:56:36 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7344:aef4:e89a:577b:dc0a:3144])
        by smtp.gmail.com with ESMTPSA id g3sm3828317pfe.37.2019.01.17.08.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:56:36 -0800 (PST)
Date:   Thu, 17 Jan 2019 22:26:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/8 v3] arm64: dts: hi3660: Add dma to uart nodes
Message-ID: <20190117165629.GI5283@Mani-XPS-13-9360>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
 <1547141652-8660-7-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547141652-8660-7-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:34:10AM -0800, John Stultz wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> v3:
> * Remove dma enablment on uart0 which would use reserved channel 0
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 20ae40d..4c8d682 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -478,6 +478,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf00000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 2 &dma0 3>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -490,6 +492,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf03000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 4 &dma0 5>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
>  				 <&crg_ctrl HI3660_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -514,6 +518,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf01000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 6 &dma0 7>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -526,6 +532,8 @@
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
