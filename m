Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A5CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20089208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20089208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeGLOEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:04:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51545 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeGLOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:04:35 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fdc3B-0007K2-83; Thu, 12 Jul 2018 15:54:29 +0200
Message-ID: <1531403668.3163.72.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6sl: Add vivante gpu nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Marius Vlad <marius-cristian.vlad@nxp.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Date:   Thu, 12 Jul 2018 15:54:28 +0200
In-Reply-To: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
References: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
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

Am Donnerstag, den 12.07.2018, 16:37 +0300 schrieb Leonard Crestez:
> The imx6sl soc has gpu_2d and gpu_vg, no 3d support:
> 
> etnaviv-gpu 2200000.gpu: model: GC320, revision: 5007
> etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> 
> The IP blocks are close enough to supported hardware that they "just
> work" with etnaviv and x11.

According to the kernel log above, they aren't just close enough, but
actually the same revision as the cores on the i.MX6Q.

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

I think this DT is ordered by unit address, so both GPU nodes should
move to the end of the dts file, right?

With this fixed:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> 
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> Tested by using yocto fsl community bsp built in "mainline" mode.
> This
> patch makes x11 start up and turning on drm.debug shows that the
> etnaviv
> driver is being used.
> 
> I don't know if such a patch requires much more testing: all it
> really
> does is "describe the hardware".
> 
> Patch is against shawguo/imx/dt, it depends on newly accepted
> commit 13211eec7b0e ("ARM: dts: imx6sl: Convert gpc to new bindings")
> This is only because of the way it references the PU power domain.
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> b/arch/arm/boot/dts/imx6sl.dtsi
> index a6bc21433839..49a56b4fd393 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -130,10 +130,30 @@
>  			cache-level = <2>;
>  			arm,tag-latency = <4 2 3>;
>  			arm,data-latency = <4 2 3>;
>  		};
>  
> +		gpu_2d: gpu@2200000 {
> +			compatible = "vivante,gc";
> +			reg = <0x02200000 0x4000>;
> +			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +				 <&clks IMX6SL_CLK_GPU2D_OVG>;
> +			clock-names = "bus", "core";
> +			power-domains = <&pd_pu>;
> +		};
> +
> +		gpu_vg: gpu@2204000 {
> +			compatible = "vivante,gc";
> +			reg = <0x02204000 0x4000>;
> +			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +				 <&clks IMX6SL_CLK_GPU2D_OVG>;
> +			clock-names = "bus", "core";
> +			power-domains = <&pd_pu>;
> +		};
> +
>  		aips1: aips-bus@2000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02000000 0x100000>;
