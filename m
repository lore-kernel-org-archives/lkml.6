Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeBEJCp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:02:45 -0500
Received: from mail.blih.net ([212.83.177.182]:59658 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeBEJCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:02:40 -0500
Date: Mon, 5 Feb 2018 09:55:58 +0100
From: Emmanuel Vadot <manu@bidouilliste.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Revert
 "ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2"
Message-Id: <20180205095558.2e713c24cdb7c3232943db52@bidouilliste.com>
In-Reply-To: <20180203112353.13497-1-icenowy@aosc.io>
References: <20180203112353.13497-1-icenowy@aosc.io>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

On Sat,  3 Feb 2018 19:23:53 +0800
Icenowy Zheng <icenowy@aosc.io> wrote:

> This reverts commit 7daa213700758b5b08fc0daab09bb139dd334165.
> 
> The original commit has several problems:
> 
> - vdd-cpus and aldo3 (AVCC of the SoC) are not set to always-on, which
> leads to system hang when disabling unused regulators.

 Indeed I should have make those always-on.

> - GMAC (which uses dldo1 and aldo2) and Wi-Fi (which uses aldo1) are not
> considered, and will fail to work after adding this commit.

 While I understand the problem with vdd-cpus and aldo3 I don't see why
when you don't declare regulator the code should do something with it.
DT is supposed to describe the hardware and the code should not use
hardware not described right ?
 The gmac node doesn't declare any regulators and the mmc2 uses
reg_vcc3v0 (haven't checked on the schematics yet if it is correct).

> This indicates that this patch should be not tested at all.

 This have indeed not been tested with linux.
 I think that this commit should not be reverted, I'll send a proper
patch tonight or tomorow night max.

 P.S.: Also as I'm the original sender I think I should have been in CC
no ?

 Cheers,

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 57 ------------------------
>  1 file changed, 57 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> index 51e6f1d21c32..a565316eb340 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> +++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> @@ -86,10 +86,6 @@
>  	};
>  };
>  
> -&cpu0 {
> -	cpu-supply = <&reg_dcdc3>;
> -};
> -
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -155,17 +151,6 @@
>  	status = "okay";
>  };
>  
> -&p2wi {
> -	status = "okay";
> -
> -	axp22x: pmic@68 {
> -		compatible = "x-powers,axp221";
> -		reg = <0x68>;
> -		interrupt-parent = <&nmi_intc>;
> -		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -};
> -
>  &pio {
>  	gmac_phy_reset_pin_bpi_m2: gmac_phy_reset_pin@0 {
>  		pins = "PA21";
> @@ -191,48 +176,6 @@
>  	};
>  };
>  
> -#include "axp22x.dtsi"
> -
> -&reg_dc5ldo {
> -	regulator-min-microvolt = <700000>;
> -	regulator-max-microvolt = <1320000>;
> -	regulator-name = "vdd-cpus";
> -};
> -
> -&reg_dcdc1 {
> -	regulator-always-on;
> -	regulator-min-microvolt = <3000000>;
> -	regulator-max-microvolt = <3000000>;
> -	regulator-name = "vdd-3v0";
> -};
> -
> -&reg_dcdc2 {
> -	regulator-min-microvolt = <700000>;
> -	regulator-max-microvolt = <1320000>;
> -	regulator-name = "vdd-gpu";
> -};
> -
> -&reg_dcdc3 {
> -	regulator-always-on;
> -	regulator-min-microvolt = <700000>;
> -	regulator-max-microvolt = <1320000>;
> -	regulator-name = "vdd-cpu";
> -};
> -
> -&reg_dcdc4 {
> -	regulator-always-on;
> -	regulator-min-microvolt = <700000>;
> -	regulator-max-microvolt = <1320000>;
> -	regulator-name = "vdd-sys-dll";
> -};
> -
> -&reg_dcdc5 {
> -	regulator-always-on;
> -	regulator-min-microvolt = <1500000>;
> -	regulator-max-microvolt = <1500000>;
> -	regulator-name = "vcc-dram";
> -};
> -
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> -- 
> 2.15.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
