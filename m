Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeDJNqD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:46:03 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46839 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753956AbeDJNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:46:00 -0400
X-Google-Smtp-Source: AIpwx4+76D6b39W4z6BkLS8ShTkADSq+PWkg+3HNhYv98yy8bdsRdCT3oMN/5tKKCsxwV2Bc93uUrg==
Date: Tue, 10 Apr 2018 08:45:58 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
Message-ID: <20180410134558.fzilfgqvavbdiget@rob-hp-laptop>
References: <20180403165945.3981-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403165945.3981-1-lukma@denx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 06:59:45PM +0200, Lukasz Majewski wrote:
> This commit adds device tree description of Kieback & Peter GmbH
> iMX6Q TPC board.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v2:
> - SDPX license identifiers used
> - Separate regulators
> - Proper beeper driver
> - Use of the lcd panel (with compatible) instead of timings provided in
>   device tree
> - Add IRQ types (like IRQ_TYPE_EDGE_FALLING) and GPIO active levels (like
>   GPIO_ACTIVE_HIGH)
> - Remove not needed nodes
> - Make W=1 dtbs compilation with no errors
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/imx6q-kp-tpc.dts                 |  23 ++
>  arch/arm/boot/dts/imx6q-kp.dtsi                    | 460 +++++++++++++++++++++
>  4 files changed, 485 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ae850d6c0ad3..8ff7eadc8bef 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -181,6 +181,7 @@ karo	Ka-Ro electronics GmbH
>  keithkoep	Keith & Koep GmbH
>  keymile	Keymile GmbH
>  khadas	Khadas
> +kiebackpeter    Kieback & Peter GmbH
>  kinetic Kinetic Technologies
>  kingnovel	Kingnovel Technology Co., Ltd.
>  kosagi	Sutajio Ko-Usagi PTE Ltd.
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..c148c4cf28f2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-icore-ofcap10.dtb \
>  	imx6q-icore-ofcap12.dtb \
>  	imx6q-icore-rqs.dtb \
> +	imx6q-kp-tpc.dtb \
>  	imx6q-marsboard.dtb \
>  	imx6q-mccmon6.dtb \
>  	imx6q-nitrogen6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> new file mode 100644
> index 000000000000..b5646040b516
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This goes on the first line. checkpatch.pl will tell you this.

> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q-kp.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 Qwuad K+P TPC Board";
> +	compatible = "kiebackpeter,imx6q-tpc", "fsl,imx6q";
> +
> +	memory: memory@10000000 {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&lcd_display_in>;
> +};
> diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
> new file mode 100644
> index 000000000000..acf6d40ca227
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> @@ -0,0 +1,460 @@
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/sound/fsl-imx-audmux.h>
> +
> +/ {
> +	backlight_lcd: backlight-lcd {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <  0   1   2   3   4   5   6   7   8   9

There's a property now so you don't have to list every single value and 
can just say "<0 255>". It's not landed yet though. See "dt-bindings: 
pwm-backlight: add a num-interpolation-steps property". 

> +				      10  11  12  13  14  15  16  17  18  19
> +				      20  21  22  23  24  25  26  27  28  29
> +				      30  31  32  33  34  35  36  37  38  39
> +				      40  41  42  43  44  45  46  47  48  49
> +				      50  51  52  53  54  55  56  57  58  59
> +				      60  61  62  63  64  65  66  67  68  69
> +				      70  71  72  73  74  75  76  77  78  79
> +				      80  81  82  83  84  85  86  87  88  89
> +				      90  91  92  93  94  95  96  97  98  99
> +				     100 101 102 103 104 105 106 107 108 109
> +				     110 111 112 113 114 115 116 117 118 119
> +				     120 121 122 123 124 125 126 127 128 129
> +				     130 131 132 133 134 135 136 137 138 139
> +				     140 141 142 143 144 145 146 147 148 149
> +				     150 151 152 153 154 155 156 157 158 159
> +				     160 161 162 163 164 165 166 167 168 169
> +				     170 171 172 173 174 175 176 177 178 179
> +				     180 181 182 183 184 185 186 187 188 189
> +				     190 191 192 193 194 195 196 197 198 199
> +				     200 201 202 203 204 205 206 207 208 209
> +				     210 211 212 213 214 215 216 217 218 219
> +				     220 221 222 223 224 225 226 227 228 229
> +				     230 231 232 233 234 235 236 237 238 239
> +				     240 241 242 243 244 245 246 247 248 249
> +				     250 251 252 253 254 255>;
> +		default-brightness-level = <250>;
> +		status = "okay";

This isn't an existing node, so you don't need to override status.

> +	};
> +
> +	beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm2 0 500000>; //2kHz
> +	};
> +
> +	lcd_display: disp0 {
> +		compatible = "fsl,imx-parallel-display";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ipu1>;
> +		status = "okay";

Necessary?

> +
> +		port@0 {
> +			reg = <0>;
> +
> +			lcd_display_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			lcd_display_out: endpoint {
> +				remote-endpoint = <&lcd_panel_in>;
> +			};
> +		};
> +	};
> +
> +	lcd_panel: lcd-panel {
> +		compatible = "auo,g070vvn01";
> +		backlight = <&backlight_lcd>;
> +		bus-format-override = "rgb565";

This is not documented.

> +		power-supply = <&reg_display>;
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint = <&lcd_display_out>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		green {
> +			label = "led1";
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "gpio";
> +			default-state = "off";
> +		};
> +
> +		red {
> +			label = "led0";
> +			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "gpio";
> +			default-state = "off";
> +		};
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_audio: regulator-audio {
> +		compatible = "regulator-fixed";
> +		regulator-name = "sgtl5000-supply";
> +		gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reg_display: regulator-display {
> +		compatible = "regulator-fixed";
> +		regulator-name = "display-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb_h1_vbus: regulator-usb_h1_vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "imx6q-sgtl5000-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&codec_dai>;
> +		simple-audio-card,frame-master = <&codec_dai>;
> +
> +		cpu_dai: simple-audio-card,cpu {
> +			sound-dai = <&ssi1>;
> +		};
> +
> +		codec_dai: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +		};
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +
> +	ssi1 {
> +		fsl,audmux-port = <0>;
> +		fsl,port-config = <
> +			(IMX_AUDMUX_V2_PTCR_SYN |
> +			IMX_AUDMUX_V2_PTCR_TFSEL(2) |
> +			IMX_AUDMUX_V2_PTCR_TCSEL(2) |
> +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> +			IMX_AUDMUX_V2_PTCR_TCLKDIR)
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(2)
> +		>;
> +	};
> +
> +	aud3 {
> +		fsl,audmux-port = <2>;
> +		fsl,port-config = <
> +			IMX_AUDMUX_V2_PTCR_SYN
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
> +		>;
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	fsl,magic-packet;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	goodix_ts@5d {

touchscreen@5d

> +		compatible = "goodix,gt911";
> +		reg = <0x5d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ts>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		irq-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	rx8025@32 {
> +		compatible = "dallas,rx8025";
> +		reg = <0x32>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	codec: sgtl5000@a {

audio-codec@a

> +		compatible = "fsl,sgtl5000";
> +		#sound-dai-cells = <0>;
> +		reg = <0x0a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_codec>;
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_audmux: audmuxgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
> +			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
> +			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
> +			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS	0x130b0
> +		>;
> +	};
> +
> +	pinctrl_codec: codecgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31   0x1b0b0
> +			/* sgtl5000 sys_mclk clock routed to CLKO1 */
> +			MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000b0
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO	0x1b0b0
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC	0x1b0b0
> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0	0x1b0b0
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1	0x1b0b0
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2	0x1b0b0
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3	0x1b0b0
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC	0x1b0b0
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0	0x1b0b0
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1	0x1b0b0
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2	0x1b0b0
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3	0x1b0b0
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
> +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: can1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX        0x1b0b0
> +			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX        0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: can2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX        0x1b0b0
> +			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX        0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
> +			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
> +			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
> +		 >;
> +	};
> +
> +	pinctrl_ipu1: ipu1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
> +			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
> +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
> +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
> +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
> +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
> +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
> +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
> +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
> +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
> +		>;
> +	};
> +
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_ts: tsgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
> +			MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D26__UART2_TX_DATA       0x1b0b1
> +			MX6QDL_PAD_EIM_D27__UART2_RX_DATA       0x1b0b1
> +			MX6QDL_PAD_EIM_D28__UART2_CTS_B         0x1b0b1
> +			MX6QDL_PAD_EIM_D29__UART2_RTS_B         0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
> +			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
> +			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
> +			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> +			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> +			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc4: usdhc4grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
> +			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
> +			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
> +			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
> +			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
> +			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
> +			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
> +			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
> +			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
> +			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
> +		>;
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	status = "okay";
> +};
> +
> +&ssi1 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	uart-has-rtscts;
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&usdhc4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc4>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	status = "okay";
> +};
> -- 
> 2.11.0
> 
