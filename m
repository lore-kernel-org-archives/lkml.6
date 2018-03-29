Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeC2LFG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:05:06 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35895 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeC2LFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:05:04 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 29 Mar 2018 13:04:50 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree
 file
Message-ID: <20180329110450.GA24193@w540>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Michel

The subject of all your patches for arch/arm should start with:

ARM: dts:

A git log on that directory clearly shows that's the preferred one.

I would also say that you are missing a symbol definition in
arch/arm/mach-shmobile/Kconfig
(even if you got rid of any board file)

I would expect a symbol to select in menuconfig, with your
dependencies listed there (ie, the serial interface driver)

Something like this (I left the 'xx' out from the part name on purpose)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 280e731..9a519330 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -114,4 +114,8 @@ config ARCH_SH73A0
        bool "SH-Mobile AG5 (R8A73A00)"
        select ARCH_RMOBILE
        select RENESAS_INTC_IRQPIN
+
+config ARCH_R9A06G0
+       bool "RZ/N1 (R9A06G0)"
+       select SERIAL_8250_DW
 endif

But please wait for others (preferibly Geert or Simon) to confim this.

On Thu, Mar 29, 2018 at 08:47:02AM +0100, Michel Pollet wrote:
> This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
> bare bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r9a06g0xx.dtsi | 96 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi
>
> diff --git a/arch/arm/boot/dts/r9a06g0xx.dtsi b/arch/arm/boot/dts/r9a06g0xx.dtsi
> new file mode 100644
> index 0000000..c6eeee3
> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g0xx.dtsi
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1 SoC Family of devices
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "renesas,rzn1";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
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
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <1>;
> +		};
> +	};

I see you don't like empy lines, that's fine, it is not a strict
requiremen afaik, but I find a few empty lines here and there more
redable, expecially if the file is going to grow, as it will be.


> +	clocks {
> +		/*
> +		 * this is fixed clock for now,
> +		 * until the clock driver is merged
> +		 */
> +		clkuarts: clkuarts {

You can remove the node lable if it's the same as the node name afaik

> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <47619047>;
> +		};
> +	};

Grouping clock nodes under a "clocks" one is now deprecated.

Please see, ie.
"ARM: dts: r7s72100: stop grouping clocks under a "clocks" subnode"

Thanks
   j

> +	arch-timer {
> +		compatible = "arm,cortex-a7-timer",
> +			     "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		arm,cpu-registers-not-fw-configured;
> +		interrupts =
> +			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		interrupt-parent = <&gic>;
> +		ranges;
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
> +				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
> +					IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +		sysctrl: sysctrl@4000c000 {
> +			compatible = "renesas,rzn1-sysctrl", "syscon",
> +					"simple-mfd";
> +			reg = <0x4000c000 0x1000>;
> +
> +			reboot {
> +				compatible = "renesas,rzn1-reboot";
> +			};
> +		};
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
> +	};
> +};
> --
> 2.7.4
>

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJavMg/AAoJEHI0Bo8WoVY8BRUQAIqRZJ0nuiTPG2wCSVu/Zuxf
knEPRieqFsBOOaXlqoFU3DB5CQo8gedjNgYGipStR3yxxMF8IOCA5/nBq68pUq5r
EP9kMHl90wF70YNAgUXOqOka75YH9bbU2WAdePay3gx0OGqBpJY6OqgF+lFP41Ol
hvNeW0u8ltx5YjoIFp7DndUblBZfwqUPYlyH+Tvfme/+Hu2S2Cmu9Ebs+XrxX2xo
xwJKpbTWDHmihc4TBbDeyEyHpPOiNgdpWt083yUb67+ky5ADfI8XlZwMKysA84Jy
dxzYfK/thu6pitamUOCehR05xCLuNh1Vj1S9NunhgMYGLiXAaFCFkmZHyvk6zLaN
fBuYUMBNZNMVgBBZpFjBVGEzdmE090ibBZI3lZOqF4utIfrAPg/R+jl6zDHrQpoc
UyrXenpCx6Hu74+soBF164cXZdtVwR92d+U/wtJs2cu/sE/tzwtn3kjzutmNLqSH
blnMtn54ea7tEJ+KBeKIzhKNFTFyC55WQpmMaU9K8T3r6wgTBiWqdNdXeCzXrApS
qETFoP408kqLZnViujkpQI5LmtaN1pnI/7XaIpbA3ZhyQr7AwmItlyCgfFopU2rZ
qt8I12s3wB0lbYmm2rj6MM+98VFcMDg4rjvn8sQjpUG5ZOADghItyHLQpA3IoU3D
+wlHZLAj5MTO0gdU/YT9
=PM6l
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
