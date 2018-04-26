Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeDZQp6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:45:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754553AbeDZQpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:45:54 -0400
Subject: Re: [linux-sunxi] [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
To: icenowy@aosc.io, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-3-icenowy@aosc.io>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
Date: Thu, 26 Apr 2018 17:45:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426140728.43155-3-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/04/18 15:07, Icenowy Zheng wrote:
> The Allwinner H6 SoC have 3 MMC controllers.
> 
> Add device tree nodes for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56 ++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 4debc3962830..3cbfc035c979 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -124,12 +124,68 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			mmc0_pins: mmc0-pins {
> +				pins = "PF0", "PF1", "PF2", "PF3",
> +				       "PF4", "PF5";
> +				function = "mmc0";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc2_pins: mmc2-pins {
> +				pins = "PC1", "PC4", "PC5", "PC6",
> +				       "PC7", "PC8", "PC9", "PC10",
> +				       "PC11", "PC12", "PC13", "PC14";
> +				function = "mmc2";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
>  			uart0_ph_pins: uart0-ph {
>  				pins = "PH0", "PH1";
>  				function = "uart0";
>  			};
>  		};
>  
> +		mmc0: mmc@4020000 {
> +			compatible = "allwinner,sun50i-h6-mmc";

This should be:
			compatible = "allwinner,sun50i-h6-mmc",
				     "allwinner,sun50i-a64-mmc";

> +			reg = <0x04020000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC0>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc1: mmc@4021000 {
> +			compatible = "allwinner,sun50i-h6-mmc";

same here

> +			reg = <0x04021000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC1>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc2: mmc@4022000 {
> +			compatible = "allwinner,sun50i-h6-emmc";

and here:
			compatible = "allwinner,sun50i-h6-emmc",
				     "allwinner,sun50i-a64-emmc";

The rest looks correct to me.

Cheers,
Andre.

> +			reg = <0x04022000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC2>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		uart0: serial@5000000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x05000000 0x400>;
> 
