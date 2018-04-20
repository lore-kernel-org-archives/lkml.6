Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeDTKGq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:06:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39450 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeDTKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:06:41 -0400
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
Subject: Re: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
Date: Fri, 20 Apr 2018 13:06:49 +0300
Message-ID: <2556566.3fxMPoIyx0@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180419162751.25223-8-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se> <20180419162751.25223-8-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Thursday, 19 April 2018 19:27:51 EEST Peter Rosin wrote:
> This makes this driver work with all(?) drivers that are not
> componentized and instead expect to connect to a panel/bridge. That
> said, the only one tested is atmel_hlcdc.
> 
> This hooks the relevant work function previously called by the encoder
> and the component also to the bridge, since the encoder goes away when
> connecting to the bridge interface of the driver and the equivalent of
> bind/unbind of the component is handled by bridge attach/detach.
> 
> The lifetime requirements of a bridge and a component are slightly
> different, which is the reason for struct tda998x_bridge.

Couldn't you move the allocation and initialization (tda998x_create) of the 
tda998x_priv structure to probe time ? I think you wouldn't need a separate 
structure in that case. Unless I'm mistaken there would be an added benefit of 
separating component and bridge initialization, resulting in the encoder not 
being initialized at all if the component isn't used. You wouldn't need to add 
a local_encoder parameter to the tda998x_init() function.

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 157 ++++++++++++++++++++++++++++++++---
>  1 file changed, 137 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c
> b/drivers/gpu/drm/i2c/tda998x_drv.c index 9c78f7bde49c..012dee61d817 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -36,6 +36,14 @@ struct tda998x_audio_port {
>  	u8 config;		/* AP value */
>  };
> 
> +struct tda998x_priv;
> +
> +struct tda998x_bridge {
> +	struct tda998x_priv *priv;
> +	struct device *dev;
> +	struct drm_bridge bridge;
> +};
> +
>  struct tda998x_priv {
>  	struct i2c_client *cec;
>  	struct i2c_client *hdmi;
> @@ -63,6 +71,8 @@ struct tda998x_priv {
>  	wait_queue_head_t edid_delay_waitq;
>  	bool edid_delay_active;
> 
> +	struct tda998x_bridge *bridge;
> +	bool local_encoder;
>  	struct drm_encoder encoder;
>  	struct drm_connector connector;
> 
> @@ -75,6 +85,9 @@ struct tda998x_priv {
>  #define enc_to_tda998x_priv(x) \
>  	container_of(x, struct tda998x_priv, encoder)
> 
> +#define bridge_to_tda998x_bridge(x) \
> +	container_of(x, struct tda998x_bridge, bridge)
> +
>  /* The TDA9988 series of devices use a paged register scheme.. to simplify
>   * things we encode the page # in upper bits of the register #.  To read/
>   * write a given register, we need to make sure CURPAGE register is set
> @@ -842,7 +855,8 @@ static int tda998x_audio_hw_params(struct device *dev,
> void *data, struct hdmi_codec_daifmt *daifmt,
>  				   struct hdmi_codec_params *params)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
>  	int i, ret;
>  	struct tda998x_audio_params audio = {
>  		.sample_width = params->sample_width,
> @@ -899,7 +913,8 @@ static int tda998x_audio_hw_params(struct device *dev,
> void *data,
> 
>  static void tda998x_audio_shutdown(struct device *dev, void *data)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
> 
>  	mutex_lock(&priv->audio_mutex);
> 
> @@ -912,7 +927,8 @@ static void tda998x_audio_shutdown(struct device *dev,
> void *data)
> 
>  int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
> {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
> 
>  	mutex_lock(&priv->audio_mutex);
> 
> @@ -925,7 +941,8 @@ int tda998x_audio_digital_mute(struct device *dev, void
> *data, bool enable) static int tda998x_audio_get_eld(struct device *dev,
> void *data,
>  				 uint8_t *buf, size_t len)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
> 
>  	mutex_lock(&priv->audio_mutex);
>  	memcpy(buf, priv->connector.eld,
> @@ -1126,7 +1143,10 @@ tda998x_connector_best_encoder(struct drm_connector
> *connector) {
>  	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
> 
> -	return &priv->encoder;
> +	if (priv->local_encoder)
> +		return &priv->encoder;
> +	else
> +		return priv->bridge->bridge.encoder;
>  }
> 
>  static
> @@ -1140,6 +1160,7 @@ static int tda998x_connector_init(struct tda998x_priv
> *priv, struct drm_device *drm)
>  {
>  	struct drm_connector *connector = &priv->connector;
> +	struct drm_encoder *encoder;
>  	int ret;
> 
>  	connector->interlace_allowed = 1;
> @@ -1156,7 +1177,8 @@ static int tda998x_connector_init(struct tda998x_priv
> *priv, if (ret)
>  		return ret;
> 
> -	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
> +	encoder = tda998x_connector_best_encoder(&priv->connector);
> +	drm_mode_connector_attach_encoder(&priv->connector, encoder);
> 
>  	return 0;
>  }
> @@ -1668,8 +1690,10 @@ static void tda998x_set_config(struct tda998x_priv
> *priv, priv->audio_params = p->audio_params;
>  }
> 
> -static int tda998x_init(struct device *dev, struct drm_device *drm)
> +static int tda998x_init(struct device *dev, struct drm_device *drm,
> +			bool local_encoder)
>  {
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>  	struct tda998x_encoder_params *params = dev->platform_data;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct tda998x_priv *priv;
> @@ -1680,7 +1704,9 @@ static int tda998x_init(struct device *dev, struct
> drm_device *drm) if (!priv)
>  		return -ENOMEM;
> 
> -	dev_set_drvdata(dev, priv);
> +	bridge->priv = priv;
> +	priv->bridge = bridge;
> +	priv->local_encoder = local_encoder;
> 
>  	if (dev->of_node)
>  		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
> @@ -1691,7 +1717,8 @@ static int tda998x_init(struct device *dev, struct
> drm_device *drm) crtcs = 1 << 0;
>  	}
> 
> -	priv->encoder.possible_crtcs = crtcs;
> +	if (local_encoder)
> +		priv->encoder.possible_crtcs = crtcs;
> 
>  	ret = tda998x_create(client, priv);
>  	if (ret)
> @@ -1700,11 +1727,15 @@ static int tda998x_init(struct device *dev, struct
> drm_device *drm) if (!dev->of_node && params)
>  		tda998x_set_config(priv, params);
> 
> -	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
> -	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
> -			       DRM_MODE_ENCODER_TMDS, NULL);
> -	if (ret)
> -		goto err_encoder;
> +	if (local_encoder) {
> +		drm_encoder_helper_add(&priv->encoder,
> +				       &tda998x_encoder_helper_funcs);
> +		ret = drm_encoder_init(drm, &priv->encoder,
> +				       &tda998x_encoder_funcs,
> +				       DRM_MODE_ENCODER_TMDS, NULL);
> +		if (ret)
> +			goto err_encoder;
> +	}
> 
>  	ret = tda998x_connector_init(priv, drm);
>  	if (ret)
> @@ -1713,7 +1744,8 @@ static int tda998x_init(struct device *dev, struct
> drm_device *drm) return 0;
> 
>  err_connector:
> -	drm_encoder_cleanup(&priv->encoder);
> +	if (local_encoder)
> +		drm_encoder_cleanup(&priv->encoder);
>  err_encoder:
>  	tda998x_destroy(priv);
>  	return ret;
> @@ -1721,10 +1753,12 @@ static int tda998x_init(struct device *dev, struct
> drm_device *drm)
> 
>  static void tda998x_fini(struct device *dev)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
> 
>  	drm_connector_cleanup(&priv->connector);
> -	drm_encoder_cleanup(&priv->encoder);
> +	if (priv->local_encoder)
> +		drm_encoder_cleanup(&priv->encoder);
>  	tda998x_destroy(priv);
>  }
> 
> @@ -1732,7 +1766,7 @@ static int tda998x_bind(struct device *dev, struct
> device *master, void *data) {
>  	struct drm_device *drm = data;
> 
> -	return tda998x_init(dev, drm);
> +	return tda998x_init(dev, drm, true);
>  }
> 
>  static void tda998x_unbind(struct device *dev, struct device *master,
> @@ -1746,19 +1780,102 @@ static const struct component_ops tda998x_ops = {
>  	.unbind = tda998x_unbind,
>  };
> 
> +/* DRM bridge functions */
> +
> +static int tda998x_bridge_attach(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct device *dev = bridge->dev;
> +	struct drm_device *drm = bridge->bridge.dev;
> +
> +	dev_info(dev, "attach\n");

You can drop all the dev_info messages.

> +	return tda998x_init(dev, drm, false);
> +}
> +
> +static void tda998x_bridge_detach(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct device *dev = bridge->dev;
> +
> +	dev_info(dev, "detach\n");
> +	tda998x_fini(dev);
> +}
> +
> +static void tda998x_bridge_enable(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct tda998x_priv *priv = bridge->priv;
> +
> +	dev_info(bridge->dev, "enable\n");
> +	tda998x_dpms(priv, DRM_MODE_DPMS_ON);
> +}
> +
> +static void tda998x_bridge_disable(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct tda998x_priv *priv = bridge->priv;
> +
> +	dev_info(bridge->dev, "disable\n");
> +	tda998x_dpms(priv, DRM_MODE_DPMS_OFF);
> +}
> +
> +static void tda998x_bridge_mode_set(struct drm_bridge *dbridge,
> +				    struct drm_display_mode *mode,
> +				    struct drm_display_mode *adjusted_mode)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct tda998x_priv *priv = bridge->priv;
> +
> +	tda998x_mode_set(priv, mode, adjusted_mode);
> +}
> +
> +static const struct drm_bridge_funcs tda998x_bridge_funcs = {
> +	.attach = tda998x_bridge_attach,
> +	.detach = tda998x_bridge_detach,
> +	.enable = tda998x_bridge_enable,
> +	.disable = tda998x_bridge_disable,
> +	.mode_set = tda998x_bridge_mode_set,
> +};
> +
>  static int
>  tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;
> +	struct tda998x_bridge *bridge;
> +	int ret;
> +
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>  		dev_warn(&client->dev, "adapter does not support I2C\n");
>  		return -EIO;
>  	}
> -	return component_add(&client->dev, &tda998x_ops);
> +
> +	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	bridge->dev = dev;
> +	dev_set_drvdata(dev, bridge);
> +
> +	bridge->bridge.funcs = &tda998x_bridge_funcs;
> +	bridge->bridge.of_node = dev->of_node;
> +	drm_bridge_add(&bridge->bridge);
> +
> +	ret = component_add(dev, &tda998x_ops);
> +
> +	if (ret)
> +		drm_bridge_remove(&bridge->bridge);
> +
> +	return ret;
>  }
> 
>  static int tda998x_remove(struct i2c_client *client)
>  {
> -	component_del(&client->dev, &tda998x_ops);
> +	struct device *dev = &client->dev;
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +
> +	drm_bridge_remove(&bridge->bridge);
> +	component_del(dev, &tda998x_ops);
> +
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
