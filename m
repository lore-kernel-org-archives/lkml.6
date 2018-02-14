Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031461AbeBNUJ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:09:56 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:36805 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031390AbeBNUJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:09:48 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com, heiko@sntech.de
Subject: [PATCH v5 05/12] drm/bridge/synopsys: dw-hdmi: don't clobber drvdata
Date: Wed, 14 Feb 2018 21:08:59 +0100
Message-Id: <20180214200906.31509-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dw_hdmi shouldn't set drvdata since some drivers might need to store
it's own data there. Rework dw_hdmi in a way to return struct dw_hdmi
instead to store it in drvdata. This way drivers are responsible to
store and pass structure when needed.

Idea was taken from the following commit:
8242ecbd597d ("drm/bridge/synopsys: stop clobbering drvdata")

Cc: p.zabel@pengutronix.de
Cc: narmstrong@baylibre.com
Cc: Laurent.pinchart@ideasonboard.com
Cc: hjc@rock-chips.com
Cc: heiko@sntech.de
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 31 ++++++++++++-----------------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           | 13 +++++++++---
 drivers/gpu/drm/meson/meson_dw_hdmi.c       | 14 +++++++++----
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c      | 12 +++++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 13 +++++++++---
 include/drm/bridge/dw_hdmi.h                | 13 ++++++------
 6 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7d80f4b56683..f9802399cc0d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2543,8 +2543,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	if (hdmi->i2c)
 		dw_hdmi_i2c_init(hdmi);
 
-	platform_set_drvdata(pdev, hdmi);
-
 	return hdmi;
 
 err_iahb:
@@ -2594,25 +2592,23 @@ static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
 /* -----------------------------------------------------------------------------
  * Probe/remove API, used from platforms based on the DRM bridge API.
  */
-int dw_hdmi_probe(struct platform_device *pdev,
-		  const struct dw_hdmi_plat_data *plat_data)
+struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
+			      const struct dw_hdmi_plat_data *plat_data)
 {
 	struct dw_hdmi *hdmi;
 
 	hdmi = __dw_hdmi_probe(pdev, plat_data);
 	if (IS_ERR(hdmi))
-		return PTR_ERR(hdmi);
+		return hdmi;
 
 	drm_bridge_add(&hdmi->bridge);
 
-	return 0;
+	return hdmi;
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_probe);
 
-void dw_hdmi_remove(struct platform_device *pdev)
+void dw_hdmi_remove(struct dw_hdmi *hdmi)
 {
-	struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
-
 	drm_bridge_remove(&hdmi->bridge);
 
 	__dw_hdmi_remove(hdmi);
@@ -2622,31 +2618,30 @@ EXPORT_SYMBOL_GPL(dw_hdmi_remove);
 /* -----------------------------------------------------------------------------
  * Bind/unbind API, used from platforms based on the component framework.
  */
-int dw_hdmi_bind(struct platform_device *pdev, struct drm_encoder *encoder,
-		 const struct dw_hdmi_plat_data *plat_data)
+struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
+			     struct drm_encoder *encoder,
+			     const struct dw_hdmi_plat_data *plat_data)
 {
 	struct dw_hdmi *hdmi;
 	int ret;
 
 	hdmi = __dw_hdmi_probe(pdev, plat_data);
 	if (IS_ERR(hdmi))
-		return PTR_ERR(hdmi);
+		return hdmi;
 
 	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL);
 	if (ret) {
-		dw_hdmi_remove(pdev);
+		dw_hdmi_remove(hdmi);
 		DRM_ERROR("Failed to initialize bridge with drm\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	return 0;
+	return hdmi;
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_bind);
 
-void dw_hdmi_unbind(struct device *dev)
+void dw_hdmi_unbind(struct dw_hdmi *hdmi)
 {
-	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
-
 	__dw_hdmi_remove(hdmi);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index b62763aa8706..fe6becdcc29e 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -25,6 +25,7 @@
 struct imx_hdmi {
 	struct device *dev;
 	struct drm_encoder encoder;
+	struct dw_hdmi *hdmi;
 	struct regmap *regmap;
 };
 
@@ -239,14 +240,18 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_imx_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	ret = dw_hdmi_bind(pdev, encoder, plat_data);
+	platform_set_drvdata(pdev, hdmi);
+
+	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
 
 	/*
 	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
 	 * which would have called the encoder cleanup.  Do it manually.
 	 */
-	if (ret)
+	if (IS_ERR(hdmi->hdmi)) {
+		ret = PTR_ERR(hdmi->hdmi);
 		drm_encoder_cleanup(encoder);
+	}
 
 	return ret;
 }
@@ -254,7 +259,9 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
 static void dw_hdmi_imx_unbind(struct device *dev, struct device *master,
 			       void *data)
 {
-	return dw_hdmi_unbind(dev);
+	struct imx_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_unbind(hdmi->hdmi);
 }
 
 static const struct component_ops dw_hdmi_imx_ops = {
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index e8c3ef8a94ce..d49af17310c9 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -140,6 +140,7 @@ struct meson_dw_hdmi {
 	struct clk *venci_clk;
 	struct regulator *hdmi_supply;
 	u32 irq_stat;
+	struct dw_hdmi *hdmi;
 };
 #define encoder_to_meson_dw_hdmi(x) \
 	container_of(x, struct meson_dw_hdmi, encoder)
@@ -878,9 +879,12 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
-	ret = dw_hdmi_bind(pdev, encoder, &meson_dw_hdmi->dw_plat_data);
-	if (ret)
-		return ret;
+	platform_set_drvdata(pdev, meson_dw_hdmi);
+
+	meson_dw_hdmi->hdmi = dw_hdmi_bind(pdev, encoder,
+					   &meson_dw_hdmi->dw_plat_data);
+	if (IS_ERR(meson_dw_hdmi->hdmi))
+		return PTR_ERR(meson_dw_hdmi->hdmi);
 
 	DRM_DEBUG_DRIVER("HDMI controller initialized\n");
 
@@ -890,7 +894,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 static void meson_dw_hdmi_unbind(struct device *dev, struct device *master,
 				   void *data)
 {
-	dw_hdmi_unbind(dev);
+	struct meson_dw_hdmi *meson_dw_hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_unbind(meson_dw_hdmi->hdmi);
 }
 
 static const struct component_ops meson_dw_hdmi_ops = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
index dc85b53d58ef..3bebc6821e9c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
@@ -68,12 +68,20 @@ static const struct dw_hdmi_plat_data rcar_dw_hdmi_plat_data = {
 
 static int rcar_dw_hdmi_probe(struct platform_device *pdev)
 {
-	return dw_hdmi_probe(pdev, &rcar_dw_hdmi_plat_data);
+	struct dw_hdmi *hdmi;
+
+	hdmi = dw_hdmi_probe(pdev, &rcar_dw_hdmi_plat_data);
+	if (IS_ERR(hdmi))
+		return PTR_ERR(hdmi);
+
+	platform_set_drvdata(pdev, hdmi);
 }
 
 static int rcar_dw_hdmi_remove(struct platform_device *pdev)
 {
-	dw_hdmi_remove(pdev);
+	struct dw_hdmi *hdmi = platform_get_drvdata(dev);
+
+	dw_hdmi_remove(hdmi);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 1eb02a82fd91..3574b0ae2ad1 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -48,6 +48,7 @@ struct rockchip_hdmi {
 	const struct rockchip_hdmi_chip_data *chip_data;
 	struct clk *vpll_clk;
 	struct clk *grf_clk;
+	struct dw_hdmi *hdmi;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -377,14 +378,18 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	ret = dw_hdmi_bind(pdev, encoder, plat_data);
+	platform_set_drvdata(pdev, hdmi);
+
+	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
 
 	/*
 	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
 	 * which would have called the encoder cleanup.  Do it manually.
 	 */
-	if (ret)
+	if (IS_ERR(hdmi->hdmi)) {
+		ret = PTR_ERR(hdmi->hdmi);
 		drm_encoder_cleanup(encoder);
+	}
 
 	return ret;
 }
@@ -392,7 +397,9 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 				    void *data)
 {
-	return dw_hdmi_unbind(dev);
+	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_unbind(hdmi->hdmi);
 }
 
 static const struct component_ops dw_hdmi_rockchip_ops = {
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index f3f3f0e1b2d3..dd2a8cf7d20b 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -143,12 +143,13 @@ struct dw_hdmi_plat_data {
 			     unsigned long mpixelclock);
 };
 
-int dw_hdmi_probe(struct platform_device *pdev,
-		  const struct dw_hdmi_plat_data *plat_data);
-void dw_hdmi_remove(struct platform_device *pdev);
-void dw_hdmi_unbind(struct device *dev);
-int dw_hdmi_bind(struct platform_device *pdev, struct drm_encoder *encoder,
-		 const struct dw_hdmi_plat_data *plat_data);
+struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
+			      const struct dw_hdmi_plat_data *plat_data);
+void dw_hdmi_remove(struct dw_hdmi *hdmi);
+void dw_hdmi_unbind(struct dw_hdmi *hdmi);
+struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
+			     struct drm_encoder *encoder,
+			     const struct dw_hdmi_plat_data *plat_data);
 
 void dw_hdmi_setup_rx_sense(struct device *dev, bool hpd, bool rx_sense);
 
-- 
2.16.1
