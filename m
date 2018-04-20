Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeDTIwX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:52:23 -0400
Received: from mout01.posteo.de ([185.67.36.141]:56886 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754074AbeDTIwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:52:09 -0400
From: Marc Dietrich <marvin24@gmx.de>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Date: Fri, 20 Apr 2018 10:52:00 +0200
Message-ID: <6600596.BijQW1iq1K@ax5200p>
In-Reply-To: <20180219151252.29289-1-marcel@ziswiler.com>
References: <20180219151252.29289-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Montag, 19. Februar 2018, 16:12:52 CEST schrieb Marcel Ziswiler:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
> during registration") ULPI has been broken on Tegra20 leading to the
> following error message during boot:
> 
> [    1.974698] ulpi_phy_power_on: ulpi write failed
> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110
> 
> Debugging through the changes and finally also consulting the TRM
> revealed that rather than the CDEV2 clock off OSC requiring such pin
> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
> just worked by chance of that one having been enabled which Stephen's
> commit now changed when reparenting sclk away from pll_p_out4 leaving
> that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
> as the ULPI PHY clock.

I booted 4.17-rc1 (which includes this fix) on an AC100 (T20 paz00 board) and 
the error above is still there. Surprisingly the error vanishes when I revert 
your patch. So this patch actually *causes* the problem above on my board. 
Could it be, that we need all four clocks? Dimitry mentioned on IRC that it 
could also be a problem in the clock init table. I don't have the technical 
background myself to fix it, but I still wonder what could be so different 
between TrimSlice and AC100.

Marc


> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/tegra20.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 864a95872b8d..e05b6bb2599f 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -741,7 +741,7 @@
>  		phy_type = "ulpi";
>  		clocks = <&tegra_car TEGRA20_CLK_USB2>,
>  			 <&tegra_car TEGRA20_CLK_PLL_U>,
> -			 <&tegra_car TEGRA20_CLK_CDEV2>;
> +			 <&tegra_car TEGRA20_CLK_PLL_P_OUT4>;
>  		clock-names = "reg", "pll_u", "ulpi-link";
>  		resets = <&tegra_car 58>, <&tegra_car 22>;
>  		reset-names = "usb", "utmi-pads";
