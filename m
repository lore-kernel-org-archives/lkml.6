Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbeE1IC4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:02:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35818 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbeE1ICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:02:52 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maciej Purski <m.purski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] drm/bridge: fix dependency for lvds-encoder
Date: Mon, 28 May 2018 11:02:53 +0300
Message-ID: <2050411.pJQe2GrhOB@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180525155030.3667352-7-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Friday, 25 May 2018 18:50:14 EEST Arnd Bergmann wrote:
> The DRM panel bridge code is built into the kms helpers module, so we
> get a link error when trying to use it from a built-in driver while the
> kms helper is a loadable module:
> 
> drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
> lvds-encoder.c:(.text+0x124): undefined reference to
> `devm_drm_panel_bridge_add'
> 
> This adds a the same dependency in the lvds-encoder that we use for all
> the other users of the panel bridge. I did not bisect the problem, but
> from inspection it seems to date back to the patch that separated out
> the panel bridge from lvds encoder.
> 
> Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the
> lvds-encoder bridge.") Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 6caa47834194..cf47bfa7a050 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -46,6 +46,7 @@ config DRM_DUMB_VGA_DAC
>  config DRM_LVDS_ENCODER
>  	tristate "Transparent parallel to LVDS encoder support"
>  	depends on OF
> +	select DRM_KMS_HELPER
>  	select DRM_PANEL_BRIDGE
>  	help
>  	  Support for transparent parallel to LVDS encoders that don't require

Wouldn't it be better to apply the following ?

config DRM_PANEL_BRIDGE
	def_bool y
	depends on DRM_BRIDGE
-	depends on DRM_KMS_HELPER
+	select DRM_KMS_HELPER
	select DRM_PANEL
	help
	   DRM bridge wrapper of DRM panels

Otherwise you'll potentially have to patch every user of DRM_PANEL_BRIDGE as 
done in this patch.

-- 
Regards,

Laurent Pinchart
