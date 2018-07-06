Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CFAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2135F2400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XCeWAp8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135F2400A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeGFNgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:36:55 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43202 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753674AbeGFNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JAyKTv1gGRpRZITkkb3oadV+Y0xQiWKD9lqnOwkzeDE=; b=XCeWAp8SUnaOC5L2DA6l9fYei
        SddsmH+OIuyNLB90hOwP4z9TuoCnFvgJFqgMsrs/mO6y/w6pFfxcji8hq+YEQTNn0mGDIkENTFOzS
        OPRq0gF8jyv81JYhPfWQdZDcrV78/Ow9WvHTe1XxZd/xXcAaM5ekHJllU/BHeZE2eazz8=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39564)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fbQuh-000630-VU; Fri, 06 Jul 2018 14:36:44 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fbQud-0002Xq-RT; Fri, 06 Jul 2018 14:36:40 +0100
Date:   Fri, 6 Jul 2018 14:36:37 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v5 7/7] drm/i2c: tda998x: register as a drm bridge
Message-ID: <20180706133637.GZ17271@n2100.armlinux.org.uk>
References: <20180523093122.27859-1-peda@axentia.se>
 <20180523093122.27859-8-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523093122.27859-8-peda@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:31:22AM +0200, Peter Rosin wrote:
> This makes this driver work with all(?) drivers that are not
> componentized and instead expect to connect to a panel/bridge. That
> said, the only one tested is atmel-hlcdc.
> 
> This hooks the relevant work function previously called by the encoder
> and the component also to the bridge, since the encoder goes away when
> connecting to the bridge interface of the driver and the equivalent of
> bind/unbind of the component is handled by bridge attach/detach.
> 
> The lifetime requirements of a bridge and a component are slightly
> different, which is the reason for struct tda998x_bridge.

Why not do this conversion similarly to other "bridge" drivers that have
this same problem (eg, dw-hdmi, dw-mipi-dsi) and always create the
bridge device, but optionally create the encoder and bind the bridge
to the encoder?

That way we don't end up with the veneer functions for bridge-only vs
encoder-only, and we have just one control path to care about - that
being the bridge interface.

> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 170 ++++++++++++++++++++++++++++++++------
>  1 file changed, 143 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index d401b3d0095c..d47e49c2991a 100644
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
> @@ -842,7 +855,8 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
>  				   struct hdmi_codec_daifmt *daifmt,
>  				   struct hdmi_codec_params *params)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
>  	int i, ret;
>  	struct tda998x_audio_params audio = {
>  		.sample_width = params->sample_width,
> @@ -899,7 +913,8 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
>  
>  static void tda998x_audio_shutdown(struct device *dev, void *data)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
>  
>  	mutex_lock(&priv->audio_mutex);
>  
> @@ -912,7 +927,8 @@ static void tda998x_audio_shutdown(struct device *dev, void *data)
>  
>  int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
>  
>  	mutex_lock(&priv->audio_mutex);
>  
> @@ -925,7 +941,8 @@ int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
>  static int tda998x_audio_get_eld(struct device *dev, void *data,
>  				 uint8_t *buf, size_t len)
>  {
> -	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +	struct tda998x_priv *priv = bridge->priv;
>  
>  	mutex_lock(&priv->audio_mutex);
>  	memcpy(buf, priv->connector.eld,
> @@ -1126,7 +1143,10 @@ tda998x_connector_best_encoder(struct drm_connector *connector)
>  {
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
> @@ -1140,6 +1160,7 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
>  				  struct drm_device *drm)
>  {
>  	struct drm_connector *connector = &priv->connector;
> +	struct drm_encoder *encoder;
>  	int ret;
>  
>  	connector->interlace_allowed = 1;
> @@ -1156,7 +1177,8 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
>  	if (ret)
>  		return ret;
>  
> -	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
> +	encoder = tda998x_connector_best_encoder(&priv->connector);
> +	drm_mode_connector_attach_encoder(&priv->connector, encoder);
>  
>  	return 0;
>  }
> @@ -1671,8 +1693,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
>  	priv->audio_params = p->audio_params;
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
> @@ -1683,18 +1707,22 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(dev, priv);
> +	bridge->priv = priv;
> +	priv->bridge = bridge;
> +	priv->local_encoder = local_encoder;
>  
> -	if (dev->of_node)
> -		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
> +	if (local_encoder) {
> +		if (dev->of_node)
> +			crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
>  
> -	/* If no CRTCs were found, fall back to our old behaviour */
> -	if (crtcs == 0) {
> -		dev_warn(dev, "Falling back to first CRTC\n");
> -		crtcs = 1 << 0;
> -	}
> +		/* If no CRTCs were found, fall back to our old behaviour */
> +		if (crtcs == 0) {
> +			dev_warn(dev, "Falling back to first CRTC\n");
> +			crtcs = 1 << 0;
> +		}
>  
> -	priv->encoder.possible_crtcs = crtcs;
> +		priv->encoder.possible_crtcs = crtcs;
> +	}
>  
>  	ret = tda998x_create(client, priv);
>  	if (ret)
> @@ -1703,11 +1731,15 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
>  	if (!dev->of_node && params)
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
> @@ -1716,7 +1748,8 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
>  	return 0;
>  
>  err_connector:
> -	drm_encoder_cleanup(&priv->encoder);
> +	if (local_encoder)
> +		drm_encoder_cleanup(&priv->encoder);
>  err_encoder:
>  	tda998x_destroy(priv);
>  	return ret;
> @@ -1724,10 +1757,12 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
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
> @@ -1735,7 +1770,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct drm_device *drm = data;
>  
> -	return tda998x_init(dev, drm);
> +	return tda998x_init(dev, drm, true);
>  }
>  
>  static void tda998x_unbind(struct device *dev, struct device *master,
> @@ -1749,19 +1784,100 @@ static const struct component_ops tda998x_ops = {
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
> +	return tda998x_init(dev, drm, false);
> +}
> +
> +static void tda998x_bridge_detach(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct device *dev = bridge->dev;
> +
> +	tda998x_fini(dev);
> +}
> +
> +static void tda998x_bridge_enable(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct tda998x_priv *priv = bridge->priv;
> +
> +	tda998x_enable(priv);
> +}
> +
> +static void tda998x_bridge_disable(struct drm_bridge *dbridge)
> +{
> +	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
> +	struct tda998x_priv *priv = bridge->priv;
> +
> +	tda998x_disable(priv);
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
> +#ifdef CONFIG_OF
> +	bridge->bridge.of_node = dev->of_node;
> +#endif
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
>  
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
