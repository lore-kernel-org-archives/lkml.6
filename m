Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E36B8601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeFFJZM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:25:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbeFFJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:25:11 -0400
Message-ID: <1528277099.26063.11.camel@pengutronix.de>
Subject: Re: [RFC 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>
Cc: Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Marco Franchi <marco.franchi@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Date: Wed, 06 Jun 2018 11:24:59 +0200
In-Reply-To: <b75a4dc8fa208ca9f9009fd0b0c9789a8b1f28c6.1528218001.git.leonard.crestez@nxp.com>
References: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
         <b75a4dc8fa208ca9f9009fd0b0c9789a8b1f28c6.1528218001.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 05.06.2018, 20:11 +0300 schrieb Leonard Crestez:
> With old bindings imx_gpc_onecell_data always sets num_domains to 2 so
> the DISPMIX domain can't actually be referenced. The pd is still defined
> and pm core shuts it down as "unused" so display can't work.
> 
> Converting to new gpc bindings by adding pgc nodes, also reference
> referencing the newly-defined &pu_disp domain from &lcdif.
> 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> There are erratas regarding dispmix on 6sl so this might be wrong
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index ab6a7e2e7e8f..9982874fa39e 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -694,14 +694,42 @@
> >  				reg = <0x020dc000 0x4000>;
> >  				interrupt-controller;
> >  				#interrupt-cells = <3>;
> >  				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
> >  				interrupt-parent = <&intc>;
> > -				pu-supply = <&reg_pu>;
> > -				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
> > -					 <&clks IMX6SL_CLK_GPU2D_PODF>;
> > +				clocks = <&clks IMX6SL_CLK_IPG>;
> > +				clock-names = "ipg";
> >  				#power-domain-cells = <1>;

The above power-domain-cells needs to go away when using the new
binding.

Regards,
Lucas

> +				pgc {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> +
> > +					power-domain@0 {
> > +						reg = <0>;
> > +						#power-domain-cells = <0>;
> > +					};
> +
> > > +					pd_pu: power-domain@1 {
> > +						reg = <1>;
> > +						#power-domain-cells = <0>;
> > +						power-supply = <&reg_pu>;
> > +						clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
> > +						         <&clks IMX6SL_CLK_GPU2D_PODF>;
> > +					};
> +
> > > +					pd_disp: power-domain@2 {
> > +						reg = <2>;
> > +						#power-domain-cells = <0>;
> > +						clocks = <&clks IMX6SL_CLK_IPG>,
> > +							 <&clks IMX6SL_CLK_LCDIF_AXI>,
> > +							 <&clks IMX6SL_CLK_LCDIF_PIX>,
> > +							 <&clks IMX6SL_CLK_EPDC_AXI>,
> > +							 <&clks IMX6SL_CLK_EPDC_PIX>,
> > +							 <&clks IMX6SL_CLK_PXP_AXI>;
> > +					};
> > +				};
> >  			};
>  
> > >  			gpr: iomuxc-gpr@20e0000 {
> >  				compatible = "fsl,imx6sl-iomuxc-gpr",
> >  					     "fsl,imx6q-iomuxc-gpr", "syscon";
> @@ -752,10 +780,11 @@
> >  				clocks = <&clks IMX6SL_CLK_LCDIF_PIX>,
> >  					 <&clks IMX6SL_CLK_LCDIF_AXI>,
> >  					 <&clks IMX6SL_CLK_DUMMY>;
> >  				clock-names = "pix", "axi", "disp_axi";
> >  				status = "disabled";
> > +				power-domains = <&pd_disp>;
> >  			};
>  
> > >  			dcp: dcp@20fc000 {
> >  				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
> >  				reg = <0x020fc000 0x4000>;
