Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeCLJkg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:40:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52666 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeCLJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:40:32 -0400
X-Google-Smtp-Source: AG47ELt3zR/p1/3k5qHNvnJtVnL9zD0RVQ6KzFxc2W1dK3bahQUBLLV5o8IqUy1AI7llu01noxxY1Q==
Subject: Re: [PATCH v1 05/19] arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR
 device nodes
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <ca071fec200f80d894523b11c94ddde19381f936.1519378871.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cea7b0bf-fcd9-6405-c437-d3251e7bb4bf@gmail.com>
Date: Mon, 12 Mar 2018 10:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ca071fec200f80d894523b11c94ddde19381f936.1519378871.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add BTIF, HSDMA and SPI-NOR device nodes and enable it on relevant boards

AFAIK hsdma controller is not upstream yet.
Please resubmit when at least the binding got merged.

Thanks,
Matthias

> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt7623.dtsi                 | 36 ++++++++++++++++++++++++++-
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  6 ++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 91317a1..da56c54 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2017 MediaTek Inc.
> + * Copyright (c) 2017-2018 MediaTek Inc.
>   * Author: John Crispin <john@phrozen.org>
>   *	   Sean Wang <sean.wang@mediatek.com>
>   *
> @@ -483,6 +483,18 @@
>  		nvmem-cell-names = "calibration-data";
>  	};
>  
> +	btif: serial@1100c000 {
> +		compatible = "mediatek,mt7623-btif",
> +			     "mediatek,mtk-btif";
> +		reg = <0 0x1100c000 0 0x1000>;
> +		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_BTIF>;
> +		clock-names = "main";
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		status = "disabled";
> +	};
> +
>  	nandc: nfi@1100d000 {
>  		compatible = "mediatek,mt7623-nfc",
>  			     "mediatek,mt2701-nfc";
> @@ -508,6 +520,18 @@
>  		status = "disabled";
>  	};
>  
> +	nor_flash: spi@11014000 {
> +		compatible = "mediatek,mt7623-nor",
> +			     "mediatek,mt8173-nor";
> +		reg = <0 0x11014000 0 0x1000>;
> +		clocks = <&pericfg CLK_PERI_FLASH>,
> +			 <&topckgen CLK_TOP_FLASH_SEL>;
> +		clock-names = "spi", "sf";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	spi1: spi@11016000 {
>  		compatible = "mediatek,mt7623-spi",
>  			     "mediatek,mt2701-spi";
> @@ -861,6 +885,16 @@
>  		#reset-cells = <1>;
>  	};
>  
> +	hsdma: dma-controller@1b007000 {
> +		compatible = "mediatek,mt7623-hsdma";
> +		reg = <0 0x1b007000 0 0x1000>;
> +		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
> +		clock-names = "hsdma";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
> +		#dma-cells = <1>;
> +	};
> +
>  	eth: ethernet@1b100000 {
>  		compatible = "mediatek,mt7623-eth",
>  			     "mediatek,mt2701-eth",
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 3efecc5..ec11e14 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2017 Sean Wang <sean.wang@mediatek.com>
> + * Copyright 2017-2018 Sean Wang <sean.wang@mediatek.com>
>   *
>   * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   */
> @@ -86,6 +86,10 @@
>  	};
>  };
>  
> +&btif {
> +	status = "okay";
> +};
> +
>  &cir {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&cir_pins_a>;
> 
