Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeDTJvL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:51:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39298 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbeDTJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:51:10 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/7] drm/i2c: tda998x: split encoder and component functions from the work
Date: Fri, 20 Apr 2018 12:51:18 +0300
Message-ID: <2442184.bXNxhGy9qM@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180419162751.25223-7-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se> <20180419162751.25223-7-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Thursday, 19 April 2018 19:27:50 EEST Peter Rosin wrote:
> This enables reuse of the machinery for the case where a drm_bridge
> needs to do the same work via different interfaces.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 46 ++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c
> b/drivers/gpu/drm/i2c/tda998x_drv.c index 8f6e013f2b87..9c78f7bde49c 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1163,9 +1163,8 @@ static int tda998x_connector_init(struct tda998x_priv
> *priv,
> 
>  /* DRM encoder functions */
> 
> -static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +static void tda998x_dpms(struct tda998x_priv *priv, int mode)

I'd split this function into tda998x_enable() and tda998x_disable(), as the 
DRM bridge API doesn't need to care about DPMS. The core of the driver would 
then be DPMS-free.

Apart from that the patch looks good to me.

>  {
> -	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
>  	bool on;
> 
>  	/* we only care about on or off: */
> @@ -1195,12 +1194,18 @@ static void tda998x_encoder_dpms(struct drm_encoder
> *encoder, int mode) }
>  }
> 
> -static void
> -tda998x_encoder_mode_set(struct drm_encoder *encoder,
> -			 struct drm_display_mode *mode,
> -			 struct drm_display_mode *adjusted_mode)
> +static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
>  {
>  	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	tda998x_dpms(priv, mode);
> +}
> +
> +static void
> +tda998x_mode_set(struct tda998x_priv *priv,
> +		 struct drm_display_mode *mode,
> +		 struct drm_display_mode *adjusted_mode)
> +{
>  	u16 ref_pix, ref_line, n_pix, n_line;
>  	u16 hs_pix_s, hs_pix_e;
>  	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
> @@ -1407,6 +1412,16 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
> mutex_unlock(&priv->audio_mutex);
>  }
> 
> +static void
> +tda998x_encoder_mode_set(struct drm_encoder *encoder,
> +			 struct drm_display_mode *mode,
> +			 struct drm_display_mode *adjusted_mode)
> +{
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	tda998x_mode_set(priv, mode, adjusted_mode);
> +}
> +
>  static void tda998x_destroy(struct tda998x_priv *priv)
>  {
>  	/* disable all IRQs and free the IRQ handler */
> @@ -1653,11 +1668,10 @@ static void tda998x_set_config(struct tda998x_priv
> *priv, priv->audio_params = p->audio_params;
>  }
> 
> -static int tda998x_bind(struct device *dev, struct device *master, void
> *data)
> +static int tda998x_init(struct device *dev, struct drm_device *drm)
> {
>  	struct tda998x_encoder_params *params = dev->platform_data;
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct drm_device *drm = data;
>  	struct tda998x_priv *priv;
>  	u32 crtcs = 0;
>  	int ret;
> @@ -1705,8 +1719,7 @@ static int tda998x_bind(struct device *dev, struct
> device *master, void *data) return ret;
>  }
> 
> -static void tda998x_unbind(struct device *dev, struct device *master,
> -			   void *data)
> +static void tda998x_fini(struct device *dev)
>  {
>  	struct tda998x_priv *priv = dev_get_drvdata(dev);
> 
> @@ -1715,6 +1728,19 @@ static void tda998x_unbind(struct device *dev, struct
> device *master, tda998x_destroy(priv);
>  }
> 
> +static int tda998x_bind(struct device *dev, struct device *master, void
> *data)
> +{
> +	struct drm_device *drm = data;
> +
> +	return tda998x_init(dev, drm);
> +}
> +
> +static void tda998x_unbind(struct device *dev, struct device *master,
> +			   void *data)
> +{
> +	tda998x_fini(dev);
> +}
> +
>  static const struct component_ops tda998x_ops = {
>  	.bind = tda998x_bind,
>  	.unbind = tda998x_unbind,

-- 
Regards,

Laurent Pinchart
