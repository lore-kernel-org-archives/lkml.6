Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBWPWa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:22:30 -0500
Received: from hermes.aosc.io ([199.195.250.187]:56116 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeBWPW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:22:28 -0500
Date: Fri, 23 Feb 2018 23:22:06 +0800
In-Reply-To: <20180223152038.2bflylwa6vj4gzfj@flea.lan>
References: <20180223123555.64009-6-icenowy@aosc.io> <20180223123555.64009-7-icenowy@aosc.io> <20180223152038.2bflylwa6vj4gzfj@flea.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 6/7] arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
To: Maxime Ripard <maxime.ripard@bootlin.com>
CC: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <81D53DC5-7622-430E-A530-ED0DE5397DC3@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月23日 GMT+08:00 下午11:20:38, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Fri, Feb 23, 2018 at 08:35:54PM +0800, Icenowy Zheng wrote:
>> Allwinner H6 is a new SoC with Cortex-A53 cores from Allwinner, with
>its
>> memory map fully reworked and some high-speed peripherals (PCIe, USB
>> 3.0) introduced.
>> 
>> This commit adds the basical DTSI file of it, including the clock
>> support and UART support.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changes in v3:
>> - SPDX license identifier fix.
>> 
>> Changes in v2:
>> - Add APB1 clock as PIO's APB clock.
>> - Switched to SPDX license identifier.
>> 
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 177
>+++++++++++++++++++++++++++
>>  1 file changed, 177 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> new file mode 100644
>> index 000000000000..4a6236bd9778
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -0,0 +1,177 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/sun50i-h6-ccu.h>
>> +#include <dt-bindings/reset/sun50i-h6-ccu.h>
>> +
>> +/ {
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			device_type = "cpu";
>> +			reg = <0>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			device_type = "cpu";
>> +			reg = <1>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		cpu2: cpu@2 {
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			device_type = "cpu";
>> +			reg = <2>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		cpu3: cpu@3 {
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			device_type = "cpu";
>> +			reg = <3>;
>> +			enable-method = "psci";
>> +		};
>> +	};
>> +
>> +	iosc: internal-osc-clk {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <16000000>;
>> +		clock-accuracy = <300000000>;
>> +		clock-output-names = "iosc";
>> +	};
>
>You're not using it anywhere
>
>> +	osc24M: osc24M_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "osc24M";
>> +	};
>> +
>> +	osc32k: osc32k_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <32768>;
>> +		clock-output-names = "osc32k";
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>
>Is it needed? The bootloader should fill it with whatever version it
>has, shouldn't it?

But we now use ATF rather than U-Boot PSCI. U-Boot will
not fill ATF info.

See A64/H5 device trees.

>
>Thanks!
>Maxime
