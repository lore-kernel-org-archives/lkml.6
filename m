Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCEA208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCEA208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeFUJsm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:48:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12186 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbeFUJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:48:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2b74600001>; Thu, 21 Jun 2018 02:48:17 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Jun 2018 02:48:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Jun 2018 02:48:40 -0700
Received: from [10.26.11.123] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Jun
 2018 09:48:36 +0000
Subject: Re: [PATCH v2 7/8] arm64: tegra: Add nodes for tcu on Tegra194
To:     Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-8-mperttunen@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <eb514b19-001b-0783-def5-101a03ab5a6c@nvidia.com>
Date:   Thu, 21 Jun 2018 10:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620122042.10950-8-mperttunen@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/18 13:20, Mikko Perttunen wrote:
> Add nodes required for communication through the Tegra Combined UART.
> This includes the AON HSP instance, addition of shared interrupts
> for the TOP0 HSP instance, and finally the TCU node itself. Also
> mark the HSP instances as compatible to tegra194-hsp, as the hardware
> is not identical but is compatible to tegra186-hsp.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6d699815a84f..d7f780b06fe2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -217,10 +217,31 @@
>  		};
>  
>  		hsp_top0: hsp@3c00000 {
> -			compatible = "nvidia,tegra186-hsp";
> +			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
>  			reg = <0x03c00000 0xa0000>;
> -			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "doorbell";
> +			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "doorbell", "shared0", "shared1", "shared2",
> +			                  "shared3", "shared4", "shared5", "shared6",
> +			                  "shared7";
> +			#mbox-cells = <2>;
> +		};
> +
> +		hsp_aon: hsp@c150000 {
> +			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
> +			reg = <0x0c150000 0xa0000>;
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "shared0", "shared1", "shared2", "shared3";
>  			#mbox-cells = <2>;
>  		};
>  
> @@ -382,6 +403,13 @@
>  		};
>  	};
>  
> +	tcu: tcu {
> +		compatible = "nvidia,tegra194-tcu";
> +		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
> +		         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
> +		mbox-names = "rx", "tx";
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
