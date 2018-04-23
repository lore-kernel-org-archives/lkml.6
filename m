Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeDWKOO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:14:14 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:44491 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbeDWKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:14:10 -0400
Date: Mon, 23 Apr 2018 12:14:06 +0200
From: Simon Horman <horms@verge.net.au>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 4/6] ARM: dts: Renesas RZ/N1 SoC base device tree file
Message-ID: <20180423101406.7vfx4yb525ycbk57@verge.net.au>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523963101-56725-5-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523963101-56725-5-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 12:04:19PM +0100, Michel Pollet wrote:
> This adds the Renesas RZ/N1D (Part #R9A06G032) SoC bare
> bone support.
> 
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r9a06g032.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi
> 
> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> new file mode 100644
> index 0000000..23c56d7
> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "renesas,r9a06g032", "renesas,rzn1";

As discussed elsewhere, please drop "renesas,rzn1".

> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	clkuarts: clkuarts {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <47619047>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0>;
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <1>;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		reboot@4000c120 {
> +			compatible = "renesas,r9a06g032-reboot",
> +					"renesas,rzn1-reboot";
> +			reg = <0x4000c120 4>,
> +				<0x4000c198 4>;
> +		};
> +
> +		uart0: serial@40060000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x40060000 0x400>;
> +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clocks = <&clkuarts>;
> +			clock-names = "baudclk";
> +			status = "disabled";
> +		};
> +
> +		gic: gic@44101000 {
> +			compatible = "arm,cortex-a7-gic", "arm,gic-400";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x44101000 0x1000>, /* Distributer */
> +			      <0x44102000 0x2000>, /* CPU interface */
> +			      <0x44104000 0x2000>, /* Virt interface control */
> +			      <0x44106000 0x2000>; /* Virt CPU interface */
> +			interrupts =
> +				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,cortex-a7-timer",
> +			     "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		arm,cpu-registers-not-fw-configured;
> +		always-on;
> +		interrupts =
> +			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;

Rather than using interrupt-parent, please use interrupts-extended,
something like this:

		interrupts-extended =
			<&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
			<&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
			<&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
			<&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;


> +	};
> +};
> -- 
> 2.7.4
> 
