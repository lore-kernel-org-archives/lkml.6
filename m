Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeDSO6K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbeDSO6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:58:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF362177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 19 Apr 2018 22:57:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com,
        sboyd@kernel.org, shengjiu.wang@nxp.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
Message-ID: <20180419145725.GX25429@dragon>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:30:44AM +0800, Anson Huang wrote:
> i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> And this lvds2, along with lvds1, can be used to provide
> external clock source to the internal pll, such as pll4_audio
> and pll5_video.
> 
> This patch mainly adds the lvds2 to the clock tree and fix its
> relationship with pll accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sx.c             | 8 ++++++--
>  include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
> index e6d389e..478ad0d 100644
> --- a/drivers/clk/imx/clk-imx6sx.c
> +++ b/drivers/clk/imx/clk-imx6sx.c
> @@ -80,7 +80,7 @@ static const char *lvds_sels[]	= {
>  	"arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy", "pll5_video_div",
>  	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
>  };
> -static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
> +static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", "lvds2_in", "dummy", };
>  static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
>  static const char *pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
>  static const char *pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
> @@ -158,8 +158,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6SX_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node, "ipp_di0");
>  	clks[IMX6SX_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node, "ipp_di1");
>  
> -	/* Clock source from external clock via CLK1 PAD */
> +	/* Clock source from external clock via CLK1/2 PAD */
>  	clks[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
> +	clks[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);

It seems to me that anaclk clocks are similar to ipp_di, and could be
handled in the same way as ipp_di clocks.  If that's the case, I would
suggest we do the following.

1. Kill clocks container node by dropping 'reg' property and naming
   clock nodes uniquely.  This is not strictly related to what we try
   to do here, but just to address DT maintainers' concern on 'clocks'
   container node.

	clk_ckil: clock-ckil {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <32768>;
		clock-output-names = "ckil";
	};

	clk_osc: clock-osc {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <24000000>;
		clock-output-names = "osc";
	};

	clk_ipp_di0: clock-ipp-di0 {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <0>;
		clock-output-names = "ipp_di0";
	};

	clk_ipp_di1: clock-ipp-di1 {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <0>;
		clock-output-names = "ipp_di1";
	};

	clks: ccm@20c4000 {
		compatible = "fsl,imx6sx-ccm";
		reg = <0x020c4000 0x4000>;
		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
		#clock-cells = <1>;
		clocks = <&clk_ckil>, <&clk_osc>, <&clk_ipp_di0>, <&clk_ipp_di1>;
		clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
	};

2. Patch clock driver to have anaclk1 and anaclk2 handled in the same
   way as ipp_di clocks.

	clks[IMX6SX_CLK_ANACLK1] = of_clk_get_by_name(ccm_node, "anaclk1");
	clks[IMX6SX_CLK_ANACLK2] = of_clk_get_by_name(ccm_node, "anaclk2");

3. Add anaclk1 and anaclk2 with clock-frequency being 0 by default, just
   like ipp_di clocks.

	clk_anaclk1: clock-anaclk1 {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <0>;
		clock-output-names = "anaclk1";
	};

	clk_anaclk2: clock-anaclk2 {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <0>;
		clock-output-names = "anaclk2";
	};

	clks: ccm@20c4000 {
		compatible = "fsl,imx6sx-ccm";
		reg = <0x020c4000 0x4000>;
		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
		#clock-cells = <1>;
		clocks = <&clk_ckil>, <&clk_osc>,
			 <&clk_ipp_di0>, <&clk_ipp_di1>,
			 <&clk_anaclk1>, <&clk_anaclk2>;
		clock-names = "ckil", "osc",
			      "ipp_di0", "ipp_di1",
			      "anaclk1", "anaclk2";
	};

4. Overwrite anaclk2 clock-frequency in imx6sx-sabreauto.dts.

&clk_anaclk2 {
	clock-frequency = <24576000>;
};

Please test and let me know whether it works or not.  Thanks.

Shawn

>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
>  	base = of_iomap(np, 0);
> @@ -228,7 +229,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
>  
>  	clks[IMX6SX_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out", "lvds1_sel", base + 0x160, 10, BIT(12));
> +	clks[IMX6SX_CLK_LVDS2_OUT] = imx_clk_gate_exclusive("lvds2_out", "lvds2_sel", base + 0x160, 11, BIT(13));
>  	clks[IMX6SX_CLK_LVDS1_IN]  = imx_clk_gate_exclusive("lvds1_in",  "anaclk1",   base + 0x160, 12, BIT(10));
> +	clks[IMX6SX_CLK_LVDS2_IN]  = imx_clk_gate_exclusive("lvds2_in",  "anaclk2",   base + 0x160, 13, BIT(11));
>  
>  	clks[IMX6SX_CLK_ENET_REF] = clk_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
>  			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
> @@ -270,6 +273,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
>  
>  	/*                                                name                reg           shift   width   parent_names       num_parents */
>  	clks[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_mux("lvds1_sel",        base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
> +	clks[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_mux("lvds2_sel",        base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
>  
>  	np = ccm_node;
>  	base = of_iomap(np, 0);
> diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
> index 36f0324..cd2d6c5 100644
> --- a/include/dt-bindings/clock/imx6sx-clock.h
> +++ b/include/dt-bindings/clock/imx6sx-clock.h
> @@ -275,6 +275,10 @@
>  #define IMX6SX_PLL6_BYPASS		262
>  #define IMX6SX_PLL7_BYPASS		263
>  #define IMX6SX_CLK_SPDIF_GCLK		264
> -#define IMX6SX_CLK_CLK_END		265
> +#define IMX6SX_CLK_LVDS2_SEL		265
> +#define IMX6SX_CLK_LVDS2_OUT		266
> +#define IMX6SX_CLK_LVDS2_IN		267
> +#define IMX6SX_CLK_ANACLK2		268
> +#define IMX6SX_CLK_CLK_END		269
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
