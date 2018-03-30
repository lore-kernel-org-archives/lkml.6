Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeC3HZZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:25:25 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45772 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeC3HZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:25:22 -0400
Date: Fri, 30 Mar 2018 09:25:16 +0200
From: Simon Horman <horms@verge.net.au>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree
 file
Message-ID: <20180330072516.bqkygev7qxp4dpig@verge.net.au>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
 <20180329110450.GA24193@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329110450.GA24193@w540>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 01:04:50PM +0200, jacopo mondi wrote:
> Hi Michel
> 
> The subject of all your patches for arch/arm should start with:
> 
> ARM: dts:
> 
> A git log on that directory clearly shows that's the preferred one.
> 
> I would also say that you are missing a symbol definition in
> arch/arm/mach-shmobile/Kconfig
> (even if you got rid of any board file)
> 
> I would expect a symbol to select in menuconfig, with your
> dependencies listed there (ie, the serial interface driver)
> 
> Something like this (I left the 'xx' out from the part name on purpose)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 280e731..9a519330 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -114,4 +114,8 @@ config ARCH_SH73A0
>         bool "SH-Mobile AG5 (R8A73A00)"
>         select ARCH_RMOBILE
>         select RENESAS_INTC_IRQPIN
> +
> +config ARCH_R9A06G0
> +       bool "RZ/N1 (R9A06G0)"
> +       select SERIAL_8250_DW
>  endif
> 
> But please wait for others (preferibly Geert or Simon) to confim this.

I think that is covered by
"[PATCH v3 5/8] arm: shmobile: Add the RZ/N1 arch to the shmobile Kconfig"

> On Thu, Mar 29, 2018 at 08:47:02AM +0100, Michel Pollet wrote:
> > This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
> > bare bone support.
> >
> > This currently only handles generic parts (gic, architected timer)
> > and a UART.
> > For simplicity sake, this also relies on the bootloader to set the
> > pinctrl and clocks.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r9a06g0xx.dtsi | 96 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi
> >
> > diff --git a/arch/arm/boot/dts/r9a06g0xx.dtsi b/arch/arm/boot/dts/r9a06g0xx.dtsi
> > new file mode 100644
> > index 0000000..c6eeee3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r9a06g0xx.dtsi
> > @@ -0,0 +1,96 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base Device Tree Source for the Renesas RZ/N1 SoC Family of devices
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	compatible = "renesas,rzn1";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <0>;
> > +		};
> > +		cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <1>;
> > +		};
> > +	};
> 
> I see you don't like empy lines, that's fine, it is not a strict
> requiremen afaik, but I find a few empty lines here and there more
> redable, expecially if the file is going to grow, as it will be.

Please place one empty line between each node.

> > +	clocks {
> > +		/*
> > +		 * this is fixed clock for now,
> > +		 * until the clock driver is merged
> > +		 */
> > +		clkuarts: clkuarts {
> 
> You can remove the node lable if it's the same as the node name afaik
> 
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <47619047>;
> > +		};
> > +	};
> 
> Grouping clock nodes under a "clocks" one is now deprecated.
> 
> Please see, ie.
> "ARM: dts: r7s72100: stop grouping clocks under a "clocks" subnode"

Also, please sort sub-nodes of the root node alphabetically.

> Thanks
>    j
> 
> > +	arch-timer {
> > +		compatible = "arm,cortex-a7-timer",
> > +			     "arm,armv7-timer";
> > +		interrupt-parent = <&gic>;
> > +		arm,cpu-registers-not-fw-configured;
> > +		interrupts =
> > +			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> > +				IRQ_TYPE_LEVEL_LOW)>,
> > +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
> > +				IRQ_TYPE_LEVEL_LOW)>,
> > +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
> > +				IRQ_TYPE_LEVEL_LOW)>,
> > +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
> > +				IRQ_TYPE_LEVEL_LOW)>;

I think its nicer not to line-wrap the individual interrupts.
I.e. please make the above like this:

		interrupts =
			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;

> > +	};
> > +	soc {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		interrupt-parent = <&gic>;
> > +		ranges;
> > +
> > +		gic: gic@44101000 {

Please sort subnodes of the soc node using:
- Primary key of bus address
- Secondary key of IP block type (does not apply here)


> > +			compatible = "arm,cortex-a7-gic", "arm,gic-400";
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +			reg = <0x44101000 0x1000>, /* Distributer */
> > +			      <0x44102000 0x2000>, /* CPU interface */
> > +			      <0x44104000 0x2000>, /* Virt interface control */
> > +			      <0x44106000 0x2000>; /* Virt CPU interface */
> > +			interrupts =
> > +				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
> > +					IRQ_TYPE_LEVEL_HIGH)>;
> > +		};
> > +		sysctrl: sysctrl@4000c000 {
> > +			compatible = "renesas,rzn1-sysctrl", "syscon",
> > +					"simple-mfd";
> > +			reg = <0x4000c000 0x1000>;
> > +
> > +			reboot {
> > +				compatible = "renesas,rzn1-reboot";
> > +			};
> > +		};
> > +		uart0: serial@40060000 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x40060000 0x400>;
> > +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&clkuarts>;
> > +			clock-names = "baudclk";
> > +			status = "disabled";
> > +		};
> > +	};
> > +};
> > --
> > 2.7.4
> >
