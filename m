Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A549720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A549720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbeGXKed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:34:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388314AbeGXKed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:34:33 -0400
Received: from 095-097-149-005.static.chello.nl ([95.97.149.5] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fhtcd-0004Vw-8Z; Tue, 24 Jul 2018 11:28:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        devicetree@vger.kernel.org, Jianqun Xu <jay.xu@rock-chips.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v0] arm64: dts: rockchip: add support for ROC-RK3399-PC board
Date:   Tue, 24 Jul 2018 11:28:45 +0200
Message-ID: <139327780.KNaNigg5Hs@phil>
In-Reply-To: <1532161826-2537-1-git-send-email-djw@t-chip.com.cn>
References: <1532161826-2537-1-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Samstag, 21. Juli 2018, 10:30:26 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> ROC-RK3399-PC is the first power efficient 4GB DDR4 single board

maybe "is a power efficient" instead of "the first" ;-)

[...]

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> new file mode 100644
> index 0000000..207f2e3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -0,0 +1,717 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Firefly ROC-RK3399-PC Board";
> +	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> +
> +	chosen {
> +		bootargs = "earlycon=uart8250,mmio32,0xff1a0000 swiotlb=1";

I don't think we want to hard-code linux bootargs in the generic devicetree

> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm0 0 25000 0>;
> +		brightness-levels = <
> +			  0   1   2   3   4   5   6   7

As Rob noted in the px30 evb patch, there is now a property helping
to drop these long lists of brightness levels, see
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1e5e7cc794b5a332c23216dade0a2e937d694b7f


> +			  8   9  10  11  12  13  14  15
> +			 16  17  18  19  20  21  22  23
> +			 24  25  26  27  28  29  30  31
> +			 32  33  34  35  36  37  38  39
> +			 40  41  42  43  44  45  46  47
> +			 48  49  50  51  52  53  54  55
> +			 56  57  58  59  60  61  62  63
> +			 64  65  66  67  68  69  70  71
> +			 72  73  74  75  76  77  78  79
> +			 80  81  82  83  84  85  86  87
> +			 88  89  90  91  92  93  94  95
> +			 96  97  98  99 100 101 102 103
> +			104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119
> +			120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135
> +			136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151
> +			152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167
> +			168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183
> +			184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199
> +			200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215
> +			216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231
> +			232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247
> +			248 249 250 251 252 253 254 255>;
> +		default-brightness-level = <200>;
> +	};

[...]

> +	vcc_vbus_typec0: vcc-vbus-typec0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_vbus_typec0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc12v_sys: mp8859-dcdc1 {

The mp8859 seems to be an i2c-device, as also shown by the
nearly empty mp8859 entry below, so shouldn't this regulator
be defined there?


> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		vin-supply = <&vcc_vbus_typec0>;
> +	};

[...]

> +	vcc_hub_en: vcc_hub_en-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hub_rst>;
> +		regulator-name = "vcc_hub_en";
> +		regulator-always-on;

missing vin-supply

> +	};
> +

[...]

> +	vdd_cpu_b: regulator@40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel1_gpio>;
> +		regulator-name = "vdd_cpu_b";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vsel-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;

vsel-gpios is not defined in the mainline dt-binding of the fan5355/syr82*

> +		vin-supply = <&vcc3v3_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_gpu: regulator@41 {
> +		compatible = "silergy,syr828";
> +		reg = <0x41>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel2_gpio>;
> +		regulator-name = "vdd_gpu";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vsel-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;

same as above

> +		vin-supply = <&vcc3v3_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	i2c-scl-rising-time-ns = <300>;
> +	i2c-scl-falling-time-ns = <15>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	i2c-scl-rising-time-ns = <450>;
> +	i2c-scl-falling-time-ns = <15>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	i2c-scl-rising-time-ns = <600>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +
> +	mp8859: mp8859@66 {
> +		compatible = "mps,mp8859";

missing a dt-binding and also a real regulator implementation?

> +		reg = <0x66>;
> +	};
> +
> +	fusb1: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fusb1_int>;
> +		fcs,int-n = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;

mainline binding expects an "interrupts" property not the
fcs,int-n from above

> +		status = "okay";
> +	};
> +
> +};
> +
> +&i2c7 {
> +	i2c-scl-rising-time-ns = <600>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +
> +	fusb0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fusb0_int>;
> +		fcs,int-n = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;

same as above

> +		status = "okay";
> +	};
> +};
> +
> +&i2s0 {
> +	rockchip,playback-channels = <8>;
> +	rockchip,capture-channels = <8>;
> +	#sound-dai-cells = <0>;

sound-dai-cells are in rk3399.dtsi now ... see
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?id=4486baca66e7a96a6ded3957cb522872a49870ce

> +	status = "okay";
> +};
> +
> +&i2s1 {
> +	rockchip,playback-channels = <2>;
> +	rockchip,capture-channels = <2>;
> +	#sound-dai-cells = <0>;

same as above

> +	status = "okay";
> +};
> +
> +&i2s2 {
> +	#sound-dai-cells = <0>;

same as above

> +	status = "okay";
> +};
> +

> +&tcphy0 {
> +	extcon = <&fusb0>;

the extcon is not described in the mainline fusb302 binding.

> +	status = "okay";
> +};
> +
> +&tcphy1 {
> +	extcon = <&fusb1>;

same as above

> +	status = "okay";
> +};
> +
> +&tsadc {
> +	/* tshut mode 0:CRU 1:GPIO */
> +	rockchip,hw-tshut-mode = <1>;
> +	/* tshut polarity 0:LOW 1:HIGH */
> +	rockchip,hw-tshut-polarity = <1>;
> +	status = "okay";
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +
> +	u2phy0_otg: otg-port {
> +		phy-supply = <&vcc5v0_host>;
> +		//status = "disabled";

don't leave commented stuff in the dt please.

> +		status = "okay";
> +	};
> +
> +	u2phy0_host: host-port {
> +		phy-supply = <&vcc5v0_host>;
> +		status = "okay";
> +	};
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +
> +	u2phy1_otg: otg-port {
> +		phy-supply = <&vcc5v0_host>;
> +		//status = "disabled";

same as above

> +		status = "okay";
> +	};
> +
> +	u2phy1_host: host-port {
> +		phy-supply = <&vcc5v0_host>;
> +		status = "okay";
> +	};
> +};


Thanks
Heiko


