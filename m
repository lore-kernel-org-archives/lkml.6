Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeDTMAd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:00:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46892 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:00:31 -0400
Date: Fri, 20 Apr 2018 13:00:16 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
Message-ID: <20180420120015.GY16141@n2100.armlinux.org.uk>
References: <20180419162751.25223-1-peda@axentia.se>
 <20180419162751.25223-8-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419162751.25223-8-peda@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 06:27:51PM +0200, Peter Rosin wrote:
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

As we are talking about bridge stuff, the patch below is what I've had
for a while converting Armada to be able to use a bridge-based tda998x.
As you can see, it's far from satisfactory at the moment.  Specifically:

1) it assumes all bridges are TMDS bridges, because as far as I can see,
   there's no way to know any different.
2) there's no way to really know whether a missing bridge is because we
   should be using the component helpers or that the bridge device
   doesn't exist yet.

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 262409cae8bf..854d74466dec 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -20,6 +20,127 @@
 #include <drm/armada_drm.h>
 #include "armada_ioctlP.h"
 
+static const struct drm_encoder_helper_funcs dummy_encoder_helper_funcs = {
+};
+
+static const struct drm_encoder_funcs dummy_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int dummy_encoder_add(struct device *dev, struct drm_device *drm,
+			     struct drm_bridge *bridge, int type, u32 crtcs)
+{
+	struct drm_encoder *enc;
+	int ret;
+
+	enc = devm_kzalloc(dev, sizeof(*enc), GFP_KERNEL);
+	if (!enc)
+		return -ENOMEM;
+
+	drm_encoder_helper_add(enc, &dummy_encoder_helper_funcs);
+	ret = drm_encoder_init(drm, enc, &dummy_encoder_funcs, type, NULL);
+	if (ret)
+		return ret;
+
+	enc->possible_crtcs = crtcs;
+	enc->bridge = bridge;
+	bridge->encoder = enc;
+
+	ret = drm_bridge_attach(enc, bridge, NULL);
+	if (ret)
+		dev_err(dev, "drm_bridge_attach() failed: %d\n", ret);
+
+	return ret;
+}
+
+static int hack_of_add_crtc_encoders(struct drm_device *drm,
+				     struct device_node *port)
+{
+	struct device *dev = drm->dev;
+	struct device_node *ep, *remote;
+	struct drm_bridge *bridge;
+	u32 crtcs;
+	int ret;
+
+	for_each_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote || !of_device_is_available(remote) ||
+		    !of_device_is_available(remote->parent)) {
+			of_node_put(remote);
+			continue;
+		}
+
+		bridge = of_drm_find_bridge(remote);
+dev_info(dev, "found remote %s => bridge %p\n", of_node_full_name(remote), bridge);
+		if (!bridge) {
+			of_node_put(remote);
+			continue;
+		}
+
+		crtcs = drm_of_find_possible_crtcs(drm, remote);
+		/* If no CRTCs were found, fall back to our old behaviour */
+		if (crtcs == 0) {
+			dev_warn(dev, "Falling back to first CRTC\n");
+			crtcs = 1 << 0;
+		}
+
+		ret = dummy_encoder_add(dev, drm, bridge, DRM_MODE_ENCODER_TMDS,
+					crtcs);
+		if (ret) {
+			dev_err(dev, "drm_bridge_attach() failed: %d\n", ret);
+			of_node_put(ep);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int hack_create_encoders(struct drm_device *drm)
+{
+	struct device *dev = drm->dev;
+	struct device_node *port = NULL;
+	int i, ret = 0;
+
+	if (dev->of_node) {
+		for (i = 0; ; i++) {
+			port = of_parse_phandle(dev->of_node, "ports", i);
+			if (!port)
+				break;
+
+			if (of_device_is_available(port->parent))
+				ret = hack_of_add_crtc_encoders(drm, port);
+
+			of_node_put(port);
+
+			if (ret)
+				break;
+		}
+	} else if (dev->platform_data) {
+		const char **devices = dev->platform_data;
+		struct device *d;
+
+		for (i = 0; devices[i]; i++) {
+			d = bus_find_device_by_name(&platform_bus_type, NULL,
+						    devices[i]);
+			if (d && d->of_node) {
+				for_each_child_of_node(d->of_node, port) {
+					ret = hack_of_add_crtc_encoders(drm, port);
+					if (ret) {
+						of_node_put(port);
+						break;
+					}
+				}
+			}
+			put_device(d);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
 static void armada_drm_unref_work(struct work_struct *work)
 {
 	struct armada_private *priv =
@@ -153,6 +274,10 @@ static int armada_drm_bind(struct device *dev)
 	if (ret)
 		goto err_kms;
 
+	ret = hack_create_encoders(&priv->drm);
+	if (ret)
+		goto err_comp;
+
 	ret = drm_vblank_init(&priv->drm, priv->drm.mode_config.num_crtc);
 	if (ret)
 		goto err_comp;
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b78c0627e7cf..feb6debb1563 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -68,7 +68,7 @@ struct tda998x_priv {
 	wait_queue_head_t edid_delay_waitq;
 	bool edid_delay_active;
 
-	struct drm_encoder encoder;
+	struct drm_bridge bridge;
 	struct drm_connector connector;
 
 	struct tda998x_audio_port audio_port[2];
@@ -80,8 +80,8 @@ struct tda998x_priv {
 #define conn_to_tda998x_priv(x) \
 	container_of(x, struct tda998x_priv, connector)
 
-#define enc_to_tda998x_priv(x) \
-	container_of(x, struct tda998x_priv, encoder)
+#define bridge_to_tda998x_priv(x) \
+	container_of(x, struct tda998x_priv, bridge)
 
 /* The TDA9988 series of devices use a paged register scheme.. to simplify
  * things we encode the page # in upper bits of the register #.  To read/
@@ -753,7 +753,7 @@ static void tda998x_detect_work(struct work_struct *work)
 {
 	struct tda998x_priv *priv =
 		container_of(work, struct tda998x_priv, detect_work);
-	struct drm_device *dev = priv->encoder.dev;
+	struct drm_device *dev = priv->connector.dev;
 
 	if (dev)
 		drm_kms_helper_hotplug_event(dev);
@@ -1262,7 +1262,7 @@ tda998x_connector_best_encoder(struct drm_connector *connector)
 {
 	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 
-	return &priv->encoder;
+	return priv->bridge.encoder;
 }
 
 static
@@ -1292,36 +1292,27 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
-	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+	drm_mode_connector_attach_encoder(&priv->connector,
+					  priv->bridge.encoder);
 
 	return 0;
 }
 
-/* DRM encoder functions */
+/* DRM bridge functions */
 
-static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static int tda998x_bridge_attach(struct drm_bridge *bridge)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
-	bool on;
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	struct drm_device *drm = bridge->dev;
 
-	/* we only care about on or off: */
-	on = mode == DRM_MODE_DPMS_ON;
-
-	if (on == priv->is_on)
-		return;
+	return tda998x_connector_init(priv, drm);
+}
 
-	if (on) {
-		/* enable video ports, audio will be enabled later */
-		reg_write(priv, REG_ENA_VP_0, 0xff);
-		reg_write(priv, REG_ENA_VP_1, 0xff);
-		reg_write(priv, REG_ENA_VP_2, 0xff);
-		/* set muxing after enabling ports: */
-		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
-		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
-		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
+static void tda998x_bridge_disable(struct drm_bridge *bridge)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
-		priv->is_on = true;
-	} else {
+	if (priv->is_on) {
 		/* disable video ports */
 		reg_write(priv, REG_ENA_VP_0, 0x00);
 		reg_write(priv, REG_ENA_VP_1, 0x00);
@@ -1332,11 +1323,11 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 }
 
 static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			 struct drm_display_mode *mode,
-			 struct drm_display_mode *adjusted_mode)
+tda998x_bridge_mode_set(struct drm_bridge *bridge,
+			struct drm_display_mode *mode,
+			struct drm_display_mode *adjusted_mode)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1543,6 +1534,31 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	mutex_unlock(&priv->audio_mutex);
 }
 
+static void tda998x_bridge_enable(struct drm_bridge *bridge)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	if (!priv->is_on) {
+		/* enable video ports, audio will be enabled later */
+		reg_write(priv, REG_ENA_VP_0, 0xff);
+		reg_write(priv, REG_ENA_VP_1, 0xff);
+		reg_write(priv, REG_ENA_VP_2, 0xff);
+		/* set muxing after enabling ports: */
+		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
+		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
+		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
+
+		priv->is_on = true;
+	}
+}
+
+static const struct drm_bridge_funcs tda998x_bridge_funcs = {
+	.attach = tda998x_bridge_attach,
+	.disable = tda998x_bridge_disable,
+	.mode_set = tda998x_bridge_mode_set,
+	.enable = tda998x_bridge_enable,
+};
+
 static void tda998x_destroy(struct tda998x_priv *priv)
 {
 	/* disable all IRQs and free the IRQ handler */
@@ -1796,35 +1812,6 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	return ret;
 }
 
-static void tda998x_encoder_prepare(struct drm_encoder *encoder)
-{
-	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
-}
-
-static void tda998x_encoder_commit(struct drm_encoder *encoder)
-{
-	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
-}
-
-static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {
-	.dpms = tda998x_encoder_dpms,
-	.prepare = tda998x_encoder_prepare,
-	.commit = tda998x_encoder_commit,
-	.mode_set = tda998x_encoder_mode_set,
-};
-
-static void tda998x_encoder_destroy(struct drm_encoder *encoder)
-{
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
-
-	tda998x_destroy(priv);
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs tda998x_encoder_funcs = {
-	.destroy = tda998x_encoder_destroy,
-};
-
 static void tda998x_set_config(struct tda998x_priv *priv,
 			       const struct tda998x_encoder_params *p)
 {
@@ -1882,9 +1869,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
-	struct drm_device *drm = data;
 	struct tda998x_priv *priv;
-	u32 crtcs = 0;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -1893,16 +1878,6 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 
 	dev_set_drvdata(dev, priv);
 
-	if (dev->of_node)
-		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
-
-	/* If no CRTCs were found, fall back to our old behaviour */
-	if (crtcs == 0) {
-		dev_warn(dev, "Falling back to first CRTC\n");
-		crtcs = 1 << 0;
-	}
-
-	priv->encoder.possible_crtcs = crtcs;
 	priv->audio_params.config = BIT(2);
 	priv->audio_params.format = AFMT_SPDIF;
 	priv->audio_params.sample_rate = 44100;
@@ -1925,23 +1900,12 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	if (!dev->of_node && params)
 		tda998x_set_config(priv, params);
 
-	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
-	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
-			       DRM_MODE_ENCODER_TMDS, NULL);
-	if (ret)
-		goto err_encoder;
+	priv->bridge.funcs = &tda998x_bridge_funcs;
+	priv->bridge.of_node = dev->of_node;
 
-	ret = tda998x_connector_init(priv, drm);
-	if (ret)
-		goto err_connector;
+	drm_bridge_add(&priv->bridge);
 
 	return 0;
-
-err_connector:
-	drm_encoder_cleanup(&priv->encoder);
-err_encoder:
-	tda998x_destroy(priv);
-	return ret;
 }
 
 static void tda998x_unbind(struct device *dev, struct device *master,
@@ -1950,7 +1914,7 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
 	drm_connector_cleanup(&priv->connector);
-	drm_encoder_cleanup(&priv->encoder);
+	drm_bridge_remove(&priv->bridge);
 	tda998x_destroy(priv);
 }
 


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
