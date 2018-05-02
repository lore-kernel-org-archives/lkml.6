Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeEBU3g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:29:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34520 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeEBU3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:29:34 -0400
Date: Wed, 2 May 2018 22:29:21 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix oops dereferencing DPI's connector since
 panel_bridge.
Message-ID: <20180502222921.4399847a@bbrezillon>
In-Reply-To: <20180309233256.1667-1-eric@anholt.net>
References: <20180309233256.1667-1-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 15:32:56 -0800
Eric Anholt <eric@anholt.net> wrote:

> In the cleanup, I didn't notice that we needed to dereference the
> connector for the bus_format.  Fix the regression by looking up the
> first (and only) connector attached to us, and assume that its
> bus_format is what we want.  Some day it would be good to have that
> part of display_info attached to the bridge, instead.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 7b1298e05310 ("drm/vc4: Switch DPI to using the panel-bridge helper.")
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/vc4/vc4_dpi.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
> index 72c9dbd81d7f..88783e143cc2 100644
> --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> @@ -96,7 +96,6 @@ struct vc4_dpi {
>  	struct platform_device *pdev;
>  
>  	struct drm_encoder *encoder;
> -	struct drm_connector *connector;
>  
>  	void __iomem *regs;
>  
> @@ -164,14 +163,31 @@ static void vc4_dpi_encoder_disable(struct drm_encoder *encoder)
>  
>  static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
>  {
> +	struct drm_device *dev = encoder->dev;
>  	struct drm_display_mode *mode = &encoder->crtc->mode;
>  	struct vc4_dpi_encoder *vc4_encoder = to_vc4_dpi_encoder(encoder);
>  	struct vc4_dpi *dpi = vc4_encoder->dpi;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector = NULL, *connector_scan;
>  	u32 dpi_c = DPI_ENABLE | DPI_OUTPUT_ENABLE_MODE;
>  	int ret;
>  
> -	if (dpi->connector->display_info.num_bus_formats) {
> -		u32 bus_format = dpi->connector->display_info.bus_formats[0];
> +	/* Look up the connector attached to DPI so we can get the
> +	 * bus_format.  Ideally the bridge would tell us the
> +	 * bus_format we want, but it doesn't yet, so assume that it's
> +	 * uniform throughout the bridge chain.
> +	 */
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector_scan, &conn_iter) {
> +		if (connector_scan->encoder == encoder) {
> +			connector = connector_scan;
> +			break;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	if (connector && connector->display_info.num_bus_formats) {
> +		u32 bus_format = connector->display_info.bus_formats[0];
>  
>  		switch (bus_format) {
>  		case MEDIA_BUS_FMT_RGB888_1X24:
> @@ -199,6 +215,9 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
>  			DRM_ERROR("Unknown media bus format %d\n", bus_format);
>  			break;
>  		}
> +	} else {
> +		/* Default to 24bit if no connector found. */
> +		dpi_c |= VC4_SET_FIELD(DPI_FORMAT_24BIT_888_RGB, DPI_FORMAT);
>  	}
>  
>  	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> @@ -264,7 +283,7 @@ static int vc4_dpi_init_bridge(struct vc4_dpi *dpi)
>  			return ret;
>  	}
>  
> -	if (panel)
> +	if (panel) 
>  		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DPI);
>  
>  	return drm_bridge_attach(dpi->encoder, bridge, NULL);
