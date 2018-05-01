Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756237AbeEAQUy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:20:54 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36945 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeEAQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:20:52 -0400
X-Google-Smtp-Source: AB8JxZrO7mHEVpMiD19h9Y0vj7pm9BVaTHV2mErkcqXu9VdfjOyWrHrV60lQuj9qdgRBM5/nsMj4jg==
Date: Tue, 1 May 2018 11:20:50 -0500
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
Message-ID: <20180501162050.GA4310@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-10-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
> HDMI on Allwinner A64 has similar behavior like H3/H5, so
> reuse the same dts node details for A64.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28 +++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun50i-a64-ccu.h    |  2 ++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 67b80bbe5bf5..da9128ae836d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -644,6 +644,34 @@
>  			#interrupt-cells = <3>;
>  		};
>  
> +		hdmi: hdmi@1ee0000 {
> +			compatible = "allwinner,sun50i-a64-dw-hdmi",
> +				     "allwinner,sun8i-a83t-dw-hdmi";
> +			reg = <0x01ee0000 0x10000>;
> +			reg-io-width = <1>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu CLK_HDMI>;
> +			clock-names = "iahb", "isfr", "tmds";
> +			resets = <&ccu RST_BUS_HDMI1>;
> +			reset-names = "ctrl";
> +			phys = <&hdmi_phy>;
> +			phy-names = "hdmi-phy";
> +			status = "disabled";
> +		};
> +
> +		hdmi_phy: hdmi-phy@1ef0000 {
> +			compatible = "allwinner,sun50i-a64-hdmi-phy",
> +				     "allwinner,sun8i-h3-hdmi-phy";
> +			reg = <0x01ef0000 0x10000>;
> +			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu CLK_PLL_VIDEO1>;
> +			clock-names = "bus", "mod", "pll-0";
> +			resets = <&ccu RST_BUS_HDMI0>;
> +			reset-names = "phy";
> +			#phy-cells = <0>;

HDMI is disabled by default, but the phy is not?

> +		};
> +
>  		rtc: rtc@1f00000 {
>  			compatible = "allwinner,sun6i-a31-rtc";
>  			reg = <0x01f00000 0x54>;
> diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
> index d66432c6e675..41c09df797ef 100644
> --- a/include/dt-bindings/clock/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
> @@ -45,6 +45,8 @@
>  
>  #define CLK_PLL_PERIPH0		11
>  
> +#define CLK_PLL_VIDEO1		15
> +

This belongs in the clock binding patch.

>  #define CLK_BUS_MIPI_DSI	28
>  #define CLK_BUS_CE		29
>  #define CLK_BUS_DMA		30
> -- 
> 2.14.3
> 
