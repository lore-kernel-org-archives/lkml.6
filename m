Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBVUIw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:08:52 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42041 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBVUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:08:48 -0500
X-Google-Smtp-Source: AH8x225waQVuC1JHLBGHI24IQ11QN2S4rakmxUQzNq0lE+Qrj7LaLuNDbKEVW9K6JFulTGqI7J9FcA==
Subject: Re: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
To: Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20180222143825.1517-1-marcel@ziswiler.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <278c02d3-7fc2-a92e-b309-1da8116e7c41@gmail.com>
Date: Thu, 22 Feb 2018 23:08:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222143825.1517-1-marcel@ziswiler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.2018 17:38, Marcel Ziswiler wrote:
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
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Indeed CDEV2 clock doesn't exist on Tegra, but there is a CDEV2 pinmux pad
group. Looks like another clk-related relic from downstream driver that was
borrowed to upstream and stayed unnoticed for a long time.

I think in practice all T20 boards have CDEV2 configured to PLL_P_OUT4, so this
patch is correct to me. Probably it would also worth to set CDEV2 parent to
PLL_P_OUT4 in the clk driver for DT backwards compatibility or even make clk
driver to read the CDEV2 pinmux config and set the proper parent based on it.
CC'ed Peter.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

> ---
> 
> Changes in v2:
> - Updated device tree binding documentation as well.
> - CCing Dmitry as well.
> 
>  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt | 4 +++-
>  arch/arm/boot/dts/tegra20.dtsi                                   | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
> index a9aa79fb90ed..1aa6f2674af5 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
> @@ -21,7 +21,9 @@ Required properties :
>     - timer: The timeout clock (clk_m). Present if phy_type == utmi.
>     - utmi-pads: The clock needed to access the UTMI pad control registers.
>       Present if phy_type == utmi.
> -   - ulpi-link: The clock Tegra provides to the ULPI PHY (cdev2).
> +   - ulpi-link: The clock Tegra provides to the ULPI PHY (usually pad DAP_MCLK2
> +     with pad group aka "nvidia,pins" cdev2 and pin mux option config aka
> +     "nvidia,function" pllp_out4).
>       Present if phy_type == ulpi, and ULPI link mode is in use.
>   - resets : Must contain an entry for each entry in reset-names.
>     See ../reset/reset.txt for details.
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
> 
