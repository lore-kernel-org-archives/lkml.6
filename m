Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeCEWXw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:23:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeCEWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:23:49 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 06/38] drm/rockchip: add mutex vop lock
Date: Mon,  5 Mar 2018 23:22:58 +0100
Message-Id: <20180305222324.5872-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

Add a lock to vop to avoid disabling the crtc while waiting for a line
flag while enabling psr. If we disable in the middle of waiting for the
line flag, we'll end up timing out or worse.

Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 63fbe789a5dd..184f980679af 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -117,6 +117,8 @@ struct vop {
 	spinlock_t reg_lock;
 	/* lock vop irq reg */
 	spinlock_t irq_lock;
+	/* protects crtc enable/disable */
+	struct mutex vop_lock;
 
 	unsigned int irq;
 
@@ -569,6 +571,7 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	WARN_ON(vop->event);
 
+	mutex_lock(&vop->vop_lock);
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -604,6 +607,7 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	clk_disable(vop->aclk);
 	clk_disable(vop->hclk);
 	pm_runtime_put(vop->dev);
+	mutex_unlock(&vop->vop_lock);
 
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
@@ -873,10 +877,13 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	uint32_t pin_pol, val;
 	int ret;
 
+	mutex_lock(&vop->vop_lock);
+
 	WARN_ON(vop->event);
 
 	ret = vop_enable(crtc);
 	if (ret) {
+		mutex_unlock(&vop->vop_lock);
 		DRM_DEV_ERROR(vop->dev, "Failed to enable vop (%d)\n", ret);
 		return;
 	}
@@ -940,6 +947,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_REG_SET(vop, common, standby, 0);
+	mutex_unlock(&vop->vop_lock);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
@@ -1478,15 +1486,21 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
 {
 	struct vop *vop = to_vop(crtc);
 	unsigned long jiffies_left;
+	int ret = 0;
 
 	if (!crtc || !vop->is_enabled)
 		return -ENODEV;
 
-	if (mstimeout <= 0)
-		return -EINVAL;
+	mutex_lock(&vop->vop_lock);
+	if (mstimeout <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (vop_line_flag_irq_is_enabled(vop))
-		return -EBUSY;
+	if (vop_line_flag_irq_is_enabled(vop)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	reinit_completion(&vop->line_flag_completion);
 	vop_line_flag_irq_enable(vop);
@@ -1497,10 +1511,13 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
 
 	if (jiffies_left == 0) {
 		DRM_DEV_ERROR(vop->dev, "Timeout waiting for IRQ\n");
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto out;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&vop->vop_lock);
+	return ret;
 }
 EXPORT_SYMBOL(rockchip_drm_wait_vact_end);
 
@@ -1550,6 +1567,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	spin_lock_init(&vop->reg_lock);
 	spin_lock_init(&vop->irq_lock);
+	mutex_init(&vop->vop_lock);
 
 	ret = devm_request_irq(dev, vop->irq, vop_isr,
 			       IRQF_SHARED, dev_name(dev), vop);
-- 
2.16.1
