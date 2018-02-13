Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966118AbeBMX3l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:29:41 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46578 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966053AbeBMX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:29:38 -0500
X-Google-Smtp-Source: AH8x225C3CRk6AGmzZQHYGb4OOXsb4Dl4/BvkrPrzsj3VJDZcLBNh2U/omv2hBRbQW2g+Vd14IYnkw==
Date: Tue, 13 Feb 2018 17:29:35 -0600
From: Rob Herring <robh@kernel.org>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 06/12] dt-bindings: display: sun4i-drm: Add A83T HDMI
 pipeline
Message-ID: <20180213232935.jfzc7lkoppvwyecz@rob-hp-laptop>
References: <20180207211713.3638-1-jernej.skrabec@siol.net>
 <20180207211713.3638-7-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207211713.3638-7-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:17:07PM +0100, Jernej Skrabec wrote:
> This commit adds all necessary compatibles and descriptions needed to
> implement A83T HDMI pipeline.
> 
> Mixer is already properly described, so only compatible is added.
> 
> However, A83T TV TCON, which is connected to HDMI, doesn't have channel 0,
> contrary to all TCONs currently described. Because of that, TCON
> documentation is extended.
> 
> A83T features Synopsys DW HDMI controller with a custom PHY which looks
> like Synopsys Gen2 PHY with few additions. Since there is no
> documentation, needed properties were found out through experimentation
> and reading BSP code.
> 
> At the end, example is added for newer SoCs, which feature DE2 and DW
> HDMI.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 195 ++++++++++++++++++++-
>  1 file changed, 188 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index cd626ee1147a..db3d3adb1059 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -64,6 +64,52 @@ Required properties:
>      first port should be the input endpoint. The second should be the
>      output, usually to an HDMI connector.
>  
> +DWC HDMI TX Encoder
> +-------------------
> +
> +The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX controller IP
> +with Allwinner's own PHY IP. It supports audio and video outputs and CEC.
> +
> +These DT bindings follow the Synopsys DWC HDMI TX bindings defined in
> +Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt with the
> +following device-specific properties.
> +
> +Required properties:
> +
> +  - compatible: value must be one of:
> +    * "allwinner,sun8i-a83t-dw-hdmi"
> +  - reg: base address and size of memory-mapped region
> +  - reg-io-width: See dw_hdmi.txt. Shall be 1.
> +  - interrupts: HDMI interrupt number
> +  - clocks: phandles to the clocks feeding the HDMI encoder
> +    * iahb: the HDMI bus clock
> +    * isfr: the HDMI register clock
> +    * tmds: TMDS clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandle to the reset controller
> +  - reset-names: must be "ctrl"
> +  - phys: phandle to the DWC HDMI PHY
> +  - phy-names: must be "phy"
> +
> +  - ports: A ports node with endpoint definitions as defined in
> +    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +    first port should be the input endpoint. The second should be the
> +    output, usually to an HDMI connector.
> +
> +DWC HDMI PHY
> +------------
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun8i-a83t-hdmi-phy
> +  - reg: base address and size of memory-mapped region
> +  - clocks: phandles to the clocks feeding the HDMI PHY
> +    * bus: the HDMI PHY interface clock
> +    * mod: the HDMI PHY module clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandle to the reset controller driving the PHY
> +  - reset-names: must be "phy"
> +
>  TV Encoder
>  ----------
>  
> @@ -94,24 +140,26 @@ Required properties:
>     * allwinner,sun7i-a20-tcon
>     * allwinner,sun8i-a33-tcon
>     * allwinner,sun8i-a83t-tcon-lcd
> +   * allwinner,sun8i-a83t-tcon-tv
>     * allwinner,sun8i-v3s-tcon
>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
> - - clocks: phandles to the clocks feeding the TCON. Three are needed:
> + - clocks: phandles to the clocks feeding the TCON.
>     - 'ahb': the interface clocks
> -   - 'tcon-ch0': The clock driving the TCON channel 0
> +   - 'tcon-ch0': The clock driving the TCON channel 0, except for A83T TV TCON
>   - resets: phandles to the reset controllers driving the encoder
>     - "lcd": the reset line for the TCON channel 0
>  
>   - clock-names: the clock names mentioned above
>   - reset-names: the reset names mentioned above
> - - clock-output-names: Name of the pixel clock created
> + - clock-output-names: Name of the pixel clock created, if TCON supports
> +   channel 0.
>  
>  - ports: A ports node with endpoint definitions as defined in
>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
>    first port should be the input endpoint, the second one the output
>  
> -  The output may have multiple endpoints. The TCON has two channels,
> +  The output may have multiple endpoints. TCON can have 1 or 2 channels,
>    usually with the first channel being used for the panels interfaces
>    (RGB, LVDS, etc.), and the second being used for the outputs that
>    require another controller (TV Encoder, HDMI, etc.). The endpoints
> @@ -122,8 +170,8 @@ Required properties:
>  On SoCs other than the A33 and V3s, there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
>  
> -On SoCs that support LVDS (all SoCs but the A13, H3, H5 and V3s), you
> -need one more reset line:
> +When TCON support LVDS (all TCONs except TV TCON on A83T and those found
> +in A13, H3, H5 and V3s SoCs), you need one more reset line:
>     - 'lvds': The reset line driving the LVDS logic
>  
>  And on the A23, A31, A31s and A33, you need one more clock line:
> @@ -226,6 +274,7 @@ supported.
>  Required properties:
>    - compatible: value must be one of:
>      * allwinner,sun8i-a83t-de2-mixer-0
> +    * allwinner,sun8i-a83t-de2-mixer-1
>      * allwinner,sun8i-v3s-de2-mixer
>    - reg: base address and size of the memory-mapped region.
>    - clocks: phandles to the clocks feeding the mixer
> @@ -261,7 +310,7 @@ Required properties:
>    - allwinner,pipelines: list of phandle to the display engine
>      frontends (DE 1.0) or mixers (DE 2.0) available.
>  
> -Example:
> +Example 1:
>  
>  panel: panel {
>  	compatible = "olimex,lcd-olinuxino-43-ts";
> @@ -460,3 +509,135 @@ display-engine {
>  	compatible = "allwinner,sun5i-a13-display-engine";
>  	allwinner,pipelines = <&fe0>;
>  };
> +
> +Example 2:

Does this really warrant another example. One can go read dts files if 
they want every possible combination.

> +
> +connector {
> +	compatible = "hdmi-connector";
> +	type = "a";
> +
> +	port {
> +		hdmi_con_in: endpoint {
> +			remote-endpoint = <&hdmi_out_con>;
> +		};
> +	};
> +};
> +
> +de: display-engine {
> +	compatible = "allwinner,sun8i-a83t-display-engine";
> +	allwinner,pipelines = <&mixer1>;
> +};
> +
> +mixer1: mixer@1200000 {
> +	compatible = "allwinner,sun8i-a83t-de2-mixer-1";
> +	reg = <0x01200000 0x100000>;
> +	clocks = <&display_clocks CLK_BUS_MIXER1>,
> +		 <&display_clocks CLK_MIXER1>;
> +	clock-names = "bus",
> +		      "mod";
> +	resets = <&display_clocks RST_WB>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mixer1_out: port@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			mixer1_out_tcon1: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&tcon1_in_mixer1>;
> +			};
> +		};
> +	};
> +};
> +
> +tcon1: lcd-controller@1c0d000 {
> +	compatible = "allwinner,sun8i-a83t-tcon-tv";
> +	reg = <0x01c0d000 0x1000>;
> +	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_TCON1>, <&ccu CLK_TCON1>;
> +	clock-names = "ahb", "tcon-ch1";
> +	resets = <&ccu RST_BUS_TCON1>;
> +	reset-names = "lcd";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		tcon1_in: port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Don't need this with a single child.

> +			reg = <0>;
> +
> +			tcon1_in_mixer1: endpoint@0 {
> +				reg = <0>;

Nor this and the unit address.

> +				remote-endpoint = <&mixer1_out_tcon1>;
> +			};
> +		};
> +
> +		tcon1_out: port@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			tcon1_out_hdmi: endpoint@1 {
> +				reg = <1>;
> +				remote-endpoint = <&hdmi_in_tcon1>;
> +			};
> +		};
> +	};
> +};
> +
> +hdmi: hdmi@1ee0000 {
> +	compatible = "allwinner,sun8i-a83t-dw-hdmi";
> +	reg = <0x01ee0000 0x10000>;
> +	reg-io-width = <1>;
> +	interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_SLOW>,
> +		 <&ccu CLK_HDMI>;
> +	clock-names = "iahb", "isfr", "tmds";
> +	resets = <&ccu RST_BUS_HDMI1>;
> +	reset-names = "ctrl";
> +	phys = <&hdmi_phy>;
> +	phy-names = "hdmi-phy";
> +	status = "disabled";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hdmi_in: port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Same here. 

> +			reg = <0>;
> +
> +			hdmi_in_tcon1: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&tcon1_out_hdmi>;
> +			};
> +		};
> +
> +		hdmi_out: port@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Same here.

> +			reg = <1>;
> +
> +			hdmi_out_con: endpoint {
> +				remote-endpoint = <&hdmi_con_in>;
> +			};
> +		};
> +	};
> +};
> +
> +hdmi_phy: hdmi-phy@1ef0000 {
> +	compatible = "allwinner,sun8i-a83t-hdmi-phy";
> +	reg = <0x01ef0000 0x10000>;
> +	clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_SLOW>;
> +	clock-names = "bus", "mod";
> +	resets = <&ccu RST_BUS_HDMI0>;
> +	reset-names = "phy";
> +	#phy-cells = <0>;
> +};
> -- 
> 2.16.1
> 
