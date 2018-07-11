Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1567EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA502084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA502084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbeGKMVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:21:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48461 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeGKMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:21:40 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fdE3n-0004SX-Ol; Wed, 11 Jul 2018 14:17:31 +0200
Message-ID: <1531311451.3163.48.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Date:   Wed, 11 Jul 2018 14:17:31 +0200
In-Reply-To: <849ea1c3434c87316f15953089633854e01938d6.1531310547.git.leonard.crestez@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
         <849ea1c3434c87316f15953089633854e01938d6.1531310547.git.leonard.crestez@nxp.com>
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

Am Mittwoch, den 11.07.2018, 15:11 +0300 schrieb Leonard Crestez:
> With old bindings imx_gpc_onecell_data always sets num_domains to 2 so
> the DISPMIX domain can't actually be referenced. The pd is still defined
> and pm core shuts it down as "unused" so display can't work.
> 
> Fix this by converting to new gpc bindings by adding pgc nodes and
> referencing the newly-defined &pu_disp domain from &lcdif.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 102c575a6025..49a56b4fd393 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -698,14 +698,40 @@
> >  				reg = <0x020dc000 0x4000>;
> >  				interrupt-controller;
> >  				#interrupt-cells = <3>;
> >  				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
> >  				interrupt-parent = <&intc>;
> > -				pu-supply = <&reg_pu>;
> > -				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
> > -					 <&clks IMX6SL_CLK_GPU2D_PODF>;
> > -				#power-domain-cells = <1>;
> > +				clocks = <&clks IMX6SL_CLK_IPG>;
> > +				clock-names = "ipg";
> +
> > +				pgc {
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
> > +						clocks = <&clks IMX6SL_CLK_LCDIF_AXI>,
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
> @@ -756,10 +782,11 @@
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
