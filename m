Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbeEHL5k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:57:40 -0400
Received: from gloria.sntech.de ([95.129.55.99]:38012 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeEHL5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:57:38 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: djw@t-chip.com.cn, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Wayne Chou <zxf@t-chip.com.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
        David Wu <david.wu@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Liang Chen <cl@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH v0 2/2] arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc
Date: Tue, 08 May 2018 13:57:17 +0200
Message-ID: <4418544.G3kHmbejD5@phil>
In-Reply-To: <1525747704-8537-3-git-send-email-djw@t-chip.com.cn>
References: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn> <1525747704-8537-3-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Dienstag, 8. Mai 2018, 04:48:24 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> In roc-rk3328-cc board, the signal voltage of sdmmc is supplied by
> the vcc_sdio regulator, which is a mux between 1.8V and 3.3V,
> controlled by a special output only gpio pin.
> 
> However, this pin,  not being a normal gpio in the rockchip pinctrl,
> is set by bit 1 of system register GRF_SOC_CON10. Therefore a new
> gpio controller using gpio-syscon driver is defined in order to use
> regulator-gpio.
> 
> If the signal voltage changes, the io domain needs to change
> correspondingly.
> 
> To use this feature, the following options are required in kernel config:
>  - CONFIG_GPIO_SYSCON=y
>  - CONFIG_POWER_AVS=y
>  - CONFIG_ROCKCHIP_IODOMAIN=y
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
> index 246c317..792cb04 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
> @@ -14,6 +14,12 @@
>  		stdout-path = "serial2:1500000n8";
>  	};
>  
> +	gpio_syscon10: gpio-syscon10 {
> +		compatible = "rockchip,rk3328-gpio-syscon10";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +

please split this into a separate patch, move it to rk3328.dtsi and together
with the suggestions from patch 1/2 make it look like

grf: syscon@ff100000 {
	compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
	reg = <0x0 0xff100000 0x0 0x1000>;
...
		gpio_mute: gpio-mute {
		compatible = "rockchip,rk3328-gpio-mute";
		gpio-controller;
		#gpio-cells = <2>;
	};
...
};

So making the gpio-controller a child of the grf node.
And as this definition is not specific to the roc-cc it should be in the
main devicetree file for the rk3328.

>  	gmac_clkin: external-gmac-clock {
>  		compatible = "fixed-clock";
>  		clock-frequency = <125000000>;
> @@ -41,6 +47,19 @@
>  		vin-supply = <&vcc_io>;
>  	};
>  
> +	vcc_sdio: sdmmcio-regulator {
> +		compatible = "regulator-gpio";
> +		gpios = <&gpio_syscon10 1 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x1
> +			  3300000 0x0>;
> +		regulator-name = "vcc_sdio";
> +		regulator-type = "voltage";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
>  	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> @@ -208,6 +227,18 @@
>  	};
>  };
>  
> +&io_domains {
> +	status = "okay";
> +
> +	vccio1-supply = <&vcc_io>;
> +	vccio2-supply = <&vcc18_emmc>;
> +	vccio3-supply = <&vcc_sdio>;
> +	vccio4-supply = <&vcc_18>;
> +	vccio5-supply = <&vcc_io>;
> +	vccio6-supply = <&vcc_io>;
> +	pmuio-supply = <&vcc_io>;
> +};
> +

Please split this into a separate patch about
"adding io-domain supplies for roc-cc"


>  &pinctrl {
>  	pmic {
>  		pmic_int_l: pmic-int-l {
> @@ -227,10 +258,15 @@
>  	cap-mmc-highspeed;
>  	cap-sd-highspeed;
>  	disable-wp;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;

please sort properties alphabetically, so between pinctrl-0 and vmmc-supply


>  	max-frequency = <150000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
>  	vmmc-supply = <&vcc_sd>;
> +	vqmmc-supply = <&vcc_sdio>;
>  	status = "okay";
>  };


Thanks
Heiko
