Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeE3PID (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:08:03 -0400
Received: from muru.com ([72.249.23.125]:45242 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753695AbeE3PIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:08:01 -0400
Date: Wed, 30 May 2018 08:07:57 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, t-kristo@ti.com
Subject: Re: [PATCH v2 6/6] ARM: dts: dra76x: Add MCAN node
Message-ID: <20180530150757.GF5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-7-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530141133.3711-7-faiz_abbas@ti.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
> From: Franklin S Cooper Jr <fcooper@ti.com>
> 
> Add support for the MCAN peripheral which supports both classic
> CAN messages along with the new CAN-FD message.
...
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -27,6 +27,21 @@
>  			ti,syss-mask = <1>;
>  			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
>  			clock-names = "fck";
> +
> +			m_can0: mcan@42c01a00 {
> +				compatible = "bosch,m_can";
> +				reg = <0x1a00 0x4000>, <0x0 0x18FC>;
> +				reg-names = "m_can", "message_ram";
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "int0", "int1";
> +				ti,hwmods = "mcan";

The "ti,hwmods" should be in the parent node now. But you may not even need
it, see the reset comment I made for the parent node patch.

> +				clocks = <&mcan_clk>, <&l3_iclk_div>;
> +				clock-names = "cclk", "hclk";
> +				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
> +				status = "disabled";

And then you should be able to also leave out status = "disabled" as the
hardware is there for sure and we can idle it. Then a board specific
dts file can set it to "disabled" if reallly needed. Setting everything
manually to "disabled" and then again to "enabled" is the wrong way
around, the default is "enabled".

Regards,

Tony
