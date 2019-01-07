Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4057D206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfAGPSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:18:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39897 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfAGPSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:18:00 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ggWf5-000716-TE; Mon, 07 Jan 2019 16:17:55 +0100
Message-ID: <1546874275.3580.18.camel@pengutronix.de>
Subject: Re: [PATCH RESEND] ARM: dts: imx6sx: Add DISPLAY power domain
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Date:   Mon, 07 Jan 2019 16:17:55 +0100
In-Reply-To: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
References: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 07.01.2019, 13:28 +0000 schrieb Leonard Crestez:
> This was implemented in the driver but not actually defined and
> referenced in dts. This makes it always on.
> 
> From reference manual in section "10.4.1.4.1 Power Distribution":
> 
> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
> PCIe, DCIC, and LDB. It is supplied by internal regulator."
> 
> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> actually inside the DISPLAY domain. Handle this by adding the pcie node
> in both power domains.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> This is the last part of a series which was previously accepted, it was
> delayed because it depends on PCI multi-pd support. All driver
> dependencies have landed in 5.0-rc1, resending for 5.1 as discussed:
> 
> 	https://lore.kernel.org/patchwork/patch/996812/#1190746
> 
> Only change is a minor conflict with removing a pxp clk.
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 272ff6133ec1..ecf3f3e5c0a0 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -783,10 +783,22 @@
> >  						#power-domain-cells = <0>;
> >  						power-supply = <&reg_soc>;
> >  						clocks = <&clks IMX6SX_CLK_GPU>;
> >  					};
>  
> > > +					pd_disp: power-domain@2 {
> > +						reg = <2>;
> > +						#power-domain-cells = <0>;
> > +						clocks = <&clks IMX6SX_CLK_PXP_AXI>,
> > +							 <&clks IMX6SX_CLK_DISPLAY_AXI>,
> > +							 <&clks IMX6SX_CLK_LCDIF1_PIX>,
> > +							 <&clks IMX6SX_CLK_LCDIF_APB>,
> > +							 <&clks IMX6SX_CLK_LCDIF2_PIX>,
> > +							 <&clks IMX6SX_CLK_CSI>,
> > +							 <&clks IMX6SX_CLK_VADC>;
> > +					};
> +
> > >  					pd_pci: power-domain@3 {
> >  						reg = <3>;
> >  						#power-domain-cells = <0>;
> >  						power-supply = <&reg_pcie>;
> >  					};
> @@ -1203,10 +1215,11 @@
> >  					compatible = "fsl,imx6sx-pxp", "fsl,imx6ull-pxp";
> >  					reg = <0x02218000 0x4000>;
> >  					interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> >  					clocks = <&clks IMX6SX_CLK_PXP_AXI>;
> >  					clock-names = "axi";
> > +					power-domains = <&pd_disp>;
> >  					status = "disabled";
> >  				};
>  
> > >  				csi2: csi@221c000 {
> >  					reg = <0x0221c000 0x4000>;
> @@ -1224,10 +1237,11 @@
> >  					interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
> >  					clocks = <&clks IMX6SX_CLK_LCDIF1_PIX>,
> >  						 <&clks IMX6SX_CLK_LCDIF_APB>,
> >  						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
> >  					clock-names = "pix", "axi", "disp_axi";
> > +					power-domains = <&pd_disp>;
> >  					status = "disabled";
> >  				};
>  
> > >  				lcdif2: lcdif@2224000 {
> >  					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
> @@ -1235,19 +1249,21 @@
> >  					interrupts = <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
> >  					clocks = <&clks IMX6SX_CLK_LCDIF2_PIX>,
> >  						 <&clks IMX6SX_CLK_LCDIF_APB>,
> >  						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
> >  					clock-names = "pix", "axi", "disp_axi";
> > +					power-domains = <&pd_disp>;
> >  					status = "disabled";
> >  				};
>  
> > >  				vadc: vadc@2228000 {
> >  					reg = <0x02228000 0x4000>, <0x0222c000 0x4000>;
> >  					reg-names = "vadc-vafe", "vadc-vdec";
> >  					clocks = <&clks IMX6SX_CLK_VADC>,
> >  						 <&clks IMX6SX_CLK_CSI>;
> >  					clock-names = "vadc", "csi";
> > +					power-domains = <&pd_disp>;
> >  					status = "disabled";
> >  				};
> >  			};
>  
> > >  			adc1: adc@2280000 {
> @@ -1368,10 +1384,11 @@
> >  			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
> >  				 <&clks IMX6SX_CLK_LVDS1_OUT>,
> >  				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
> >  				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
> >  			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
> > -			power-domains = <&pd_pci>;
> > +			power-domains = <&pd_disp>, <&pd_pci>;
> > +			power-domain-names = "pcie", "pcie_phy";
> >  			status = "disabled";
> >  		};
> >  	};
>  };
