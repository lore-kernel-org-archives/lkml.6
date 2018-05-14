Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeENVRb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:17:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34502 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752438AbeENVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:16:44 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 08/10] drm: rockchip: Add DDR devfreq support.
Date: Mon, 14 May 2018 23:16:08 +0200
Message-Id: <20180514211610.26618-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Add support for devfreq to dynamically control the DDR frequency. It
will activate when there is one CRTC active, and disable if more than
one becomes active (to avoid flickering on one of the screens).

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 46 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  9 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 35 ++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 34 +++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f814d37b1db2..e774f3c7c325 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -19,6 +19,8 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-event.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-iommu.h>
 #include <linux/pm_runtime.h>
@@ -77,6 +79,46 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 	iommu_detach_device(domain, dev);
 }
 
+#if IS_ENABLED(CONFIG_ARM_RK3399_DMC_DEVFREQ)
+static int rockchip_drm_init_devfreq(struct device *dev,
+				     struct rockchip_drm_private *priv)
+{
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *edev;
+	int ret;
+
+	devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	if (IS_ERR(devfreq)) {
+		ret = PTR_ERR(devfreq);
+		if (ret == -ENODEV) {
+			DRM_DEV_INFO(dev, "devfreq missing, skip\n");
+			return 0;
+		}
+		return ret;
+	}
+
+	edev = devfreq_event_get_edev_by_phandle(devfreq->dev.parent, 0);
+	if (IS_ERR(edev)) {
+		ret = PTR_ERR(edev);
+		if (ret == -ENODEV) {
+			DRM_DEV_INFO(dev, "devfreq edev missing, skip\n");
+			return 0;
+		}
+		return ret;
+	}
+
+	priv->devfreq = devfreq;
+	priv->devfreq_event_dev = edev;
+	return 0;
+}
+#else
+static int rockchip_drm_init_devfreq(struct device *dev,
+				     struct rockchip_drm_private *priv)
+{
+	return 0;
+}
+#endif
+
 static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
 {
 	struct rockchip_drm_private *private = drm_dev->dev_private;
@@ -136,6 +178,10 @@ static int rockchip_drm_bind(struct device *dev)
 	INIT_LIST_HEAD(&private->psr_list);
 	mutex_init(&private->psr_list_lock);
 
+	ret = rockchip_drm_init_devfreq(dev, private);
+	if (ret)
+		goto err_free;
+
 	ret = rockchip_drm_init_iommu(drm_dev);
 	if (ret)
 		goto err_free;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3a6ebfc26036..cc13fac59644 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -57,6 +57,10 @@ struct rockchip_drm_private {
 	struct drm_mm mm;
 	struct list_head psr_list;
 	struct mutex psr_list_lock;
+
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *devfreq_event_dev;
+	bool dmc_disable_flag;
 };
 
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
@@ -65,6 +69,11 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
+uint32_t rockchip_drm_get_vblank_ns(struct drm_display_mode *mode);
+
+void rockchip_drm_enable_dmc(struct rockchip_drm_private *priv);
+void rockchip_drm_disable_dmc(struct rockchip_drm_private *priv);
+
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_driver;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index d4f4118b482d..bf10f7982278 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -18,6 +18,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <soc/rockchip/rk3399_dmc.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
@@ -185,6 +186,16 @@ rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
 		rockchip_drm_psr_inhibit_get(encoder);
 }
 
+uint32_t rockchip_drm_get_vblank_ns(struct drm_display_mode *mode)
+{
+	uint64_t vblank_time = mode->vtotal - mode->vdisplay;
+
+	vblank_time *= (uint64_t)NSEC_PER_SEC * mode->htotal;
+	do_div(vblank_time, mode->clock * 1000);
+
+	return vblank_time;
+}
+
 static void
 rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
 {
@@ -207,9 +218,28 @@ static void
 rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	struct rockchip_drm_private *priv = dev->dev_private;
+	struct drm_crtc *crtc;
+	struct drm_display_mode *mode;
+	bool force_dmc_off = false;
+
+	drm_for_each_crtc(crtc, dev) {
+		if (crtc->state->active) {
+			mode = &crtc->state->adjusted_mode;
+			if (rockchip_drm_get_vblank_ns(mode) <
+			    DMC_MIN_VBLANK_NS)
+				force_dmc_off = true;
+		}
+	}
 
 	rockchip_drm_psr_inhibit_get_state(old_state);
 
+	/* If disabling dmc, disable it before committing mode set changes. */
+	if (force_dmc_off && !priv->dmc_disable_flag) {
+		rockchip_dmcfreq_block(priv->devfreq);
+		priv->dmc_disable_flag = true;
+	}
+
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
@@ -224,6 +254,11 @@ rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
+
+	if (!force_dmc_off && priv->dmc_disable_flag) {
+		rockchip_dmcfreq_unblock(priv->devfreq);
+		priv->dmc_disable_flag = false;
+	}
 }
 
 static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f14a10ca4792..32f052ee15b9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -36,6 +36,8 @@
 #include <linux/reset.h>
 #include <linux/delay.h>
 
+#include <soc/rockchip/rk3399_dmc.h>
+
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_fb.h"
@@ -103,7 +105,9 @@ struct vop {
 	struct drm_flip_work fb_unref_work;
 	unsigned long pending;
 
+	ktime_t line_flag_timestamp;
 	struct completion line_flag_completion;
+	struct notifier_block dmc_nb;
 
 	const struct vop_data *data;
 
@@ -569,10 +573,12 @@ static int vop_enable(struct drm_crtc *crtc)
 static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
+	struct rockchip_drm_private *priv = crtc->dev->dev_private;
 	struct vop *vop = to_vop(crtc);
 
 	WARN_ON(vop->event);
 
+	rockchip_dmcfreq_unregister_clk_sync_nb(priv->devfreq, &vop->dmc_nb);
 	mutex_lock(&vop->vop_lock);
 	drm_crtc_vblank_off(crtc);
 
@@ -861,6 +867,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	const struct vop_data *vop_data = vop->data;
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
 	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
+	struct rockchip_drm_private *priv = crtc->dev->dev_private;
 	u16 hsync_len = adjusted_mode->hsync_end - adjusted_mode->hsync_start;
 	u16 hdisplay = adjusted_mode->hdisplay;
 	u16 htotal = adjusted_mode->htotal;
@@ -951,6 +958,31 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	VOP_REG_SET(vop, common, standby, 0);
 	mutex_unlock(&vop->vop_lock);
+	rockchip_dmcfreq_register_clk_sync_nb(priv->devfreq, &vop->dmc_nb);
+}
+
+static int dmc_notify(struct notifier_block *nb,
+		      unsigned long action,
+		      void *data)
+{
+	struct vop *vop = container_of(nb, struct vop, dmc_nb);
+	struct drm_crtc *crtc = &vop->crtc;
+	ktime_t *timeout = data;
+	int ret;
+
+	if (WARN_ON(!vop->is_enabled))
+		return NOTIFY_BAD;
+
+	ret = rockchip_drm_wait_vact_end(crtc, 100);
+	*timeout = ktime_add_ns(vop->line_flag_timestamp,
+				rockchip_drm_get_vblank_ns(&crtc->mode));
+	if (ret) {
+		dev_err(vop->dev, "%s: Line flag interrupt did not arrive\n",
+			__func__);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_STOP;
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
@@ -1190,6 +1222,7 @@ static irqreturn_t vop_isr(int irq, void *data)
 	}
 
 	if (active_irqs & LINE_FLAG_INTR) {
+		vop->line_flag_timestamp = ktime_get();
 		complete(&vop->line_flag_completion);
 		active_irqs &= ~LINE_FLAG_INTR;
 		ret = IRQ_HANDLED;
@@ -1566,6 +1599,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	spin_lock_init(&vop->reg_lock);
 	spin_lock_init(&vop->irq_lock);
 	mutex_init(&vop->vop_lock);
+	vop->dmc_nb.notifier_call = dmc_notify;
 
 	ret = vop_create_crtc(vop);
 	if (ret)
-- 
2.17.0
