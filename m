Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90996C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60421841
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfAWIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:45:59 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:52691 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfAWIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:45:59 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5AC9230000CDA;
        Wed, 23 Jan 2019 09:45:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 331DA1E6BB; Wed, 23 Jan 2019 09:45:56 +0100 (CET)
Date:   Wed, 23 Jan 2019 09:45:56 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190123084556.gsospl6joh53qnzs@wunner.de>
References: <20190122141311.10445-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122141311.10445-1-ronald@innovation.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> INPUT. However, this causes problems with other drivers, in particular
> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> future commit):
> 
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> 
> According to the docs, select should only be used for non-visible
> symbols. Furthermore almost all other references to INPUT throughout the
> kernel config are depends, not selects. Hence this change.
> 
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I think this needs to be merged through the input tree as a prerequisite
for the applespi.c driver (keyboard + touchpad driver for 2015+ MacBook,
MacBook Air and MacBook Pro which uses SPI instead of USB) to avoid
breaking the build.  Adding Dmitry.

Thanks,

Lukas


> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..eabedc83f25c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
>  config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
> +	depends on INPUT
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
>  	select RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
