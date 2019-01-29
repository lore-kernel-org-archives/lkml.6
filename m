Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C3AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4532082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfA2OSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:18:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55857 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2OSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:18:17 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1goUDJ-0003Cx-PE; Tue, 29 Jan 2019 15:18:09 +0100
Message-ID: <1548771487.6869.5.camel@pengutronix.de>
Subject: Re: [PATCH] ARC: [plat-hsdk]: Add support of Vivante GPU
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Date:   Tue, 29 Jan 2019 15:18:07 +0100
In-Reply-To: <20190129124146.5398-1-Eugeniy.Paltsev@synopsys.com>
References: <20190129124146.5398-1-Eugeniy.Paltsev@synopsys.com>
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

Am Dienstag, den 29.01.2019, 15:41 +0300 schrieb Eugeniy Paltsev:
> HSDK board has built-in Vivante GPU IP which works perfectly fine
> with Etnaviv driver, so let's use it.
> 
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> NOTE:
>  * this patch has prerequisite:
>    https://patchwork.kernel.org/patch/10766265/
> 
>  arch/arc/boot/dts/hsdk.dts      | 6 ++++++
>  arch/arc/configs/hsdk_defconfig | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
> index 43f17b51ee89..ef892994f024 100644
> --- a/arch/arc/boot/dts/hsdk.dts
> +++ b/arch/arc/boot/dts/hsdk.dts
> @@ -237,6 +237,12 @@
> >  				reg = <0>;
> >  			};
> >  		};
> +
> > > +		gpu_3d: gpu@90000 {
> > +			compatible = "vivante,gc";
> > +			reg = <0x90000 0x4000>;
> +			interrupts = <28>;

Really no clock inputs? While the driver does not enforce this due to
backward compatibility issues, the binding says that some of the clocks
are mandatory. So I would really like to see them hooked up here, even
if it's just fixed always-on clocks.

Regards,
Lucas

> +		};
> >  	};
>  
> >  	memory@80000000 {
> diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
> index 87b23b7fb781..915e1cca31f8 100644
> --- a/arch/arc/configs/hsdk_defconfig
> +++ b/arch/arc/configs/hsdk_defconfig
> @@ -52,6 +52,7 @@ CONFIG_GPIO_DWAPB=y
>  CONFIG_DRM=y
>  # CONFIG_DRM_FBDEV_EMULATION is not set
>  CONFIG_DRM_UDL=y
> +CONFIG_DRM_ETNAVIV=y
>  CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_USB_EHCI_HCD=y
> @@ -63,7 +64,6 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_DW=y
> -# CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXT3_FS=y
>  CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y
