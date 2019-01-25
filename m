Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A70FC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC264217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAYSvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:51:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59956 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYSvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:51:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 188B2207B6; Fri, 25 Jan 2019 19:51:22 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id D3EE020734;
        Fri, 25 Jan 2019 19:51:21 +0100 (CET)
Date:   Fri, 25 Jan 2019 19:51:22 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 16/22] arm64: dts: allwinner: a64: Add DSI pipeline
Message-ID: <20190125185122.idyipbgcgy5fzf7q@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-17-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124195900.22620-17-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 01:28:54AM +0530, Jagan Teki wrote:
> The A64 has a MIPI-DSI block which is similar to A31.
> 
> Add dsi, dphy nodes with A31 fallback compatible and finally
> connect the dsi node to tcon0 node to make proper DSI pipeline.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index cdc154b14a7e..e18d81aff813 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -358,6 +358,12 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <1>;
> +
> +					tcon0_out_dsi: endpoint@1 {
> +						reg = <1>;
> +						remote-endpoint = <&dsi_in_tcon0>;
> +						allwinner,tcon-channel = <1>;
> +					};
>  				};
>  			};
>  		};
> @@ -935,6 +941,47 @@
>  			status = "disabled";
>  		};
>  
> +		dsi: dsi@1ca0000 {
> +			compatible = "allwinner,sun50i-a64-mipi-dsi",
> +				     "allwinner,sun6i-a31-mipi-dsi";
> +			reg = <0x01ca0000 0x1000>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +				 <&ccu CLK_DSI_DPHY>;

This one looks weird. There's only a single clock in the A64, and it
seems to be for the D-PHY only.

And the rate is fixed at 148.5 MHz apparently, as opposed to the
current code that is running at twice that speed.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
