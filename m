Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeA3U3h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeA3U3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:35 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 10/43] drm/rockchip: add mutex vop lock
Date: Tue, 30 Jan 2018 21:28:40 +0100
Message-Id: <20180130202913.28724-11-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
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
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 31304434847a..bf4b1a2f3fa4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -117,6 +117,8 @@ struct vop {
 	spinlock_t reg_lock;
 	/* lock vop irq reg */
 	spinlock_t irq_lock;
+	/* protects crtc enable/disable */
+	struct mutex vop_lock;
 
 	unsigned int irq;
 
@@ -577,6 +579,7 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	WARN_ON(vop->event);
 
+	mutex_lock(&vop->vop_lock);
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -612,6 +615,7 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	clk_disable(vop->aclk);
 	clk_disable(vop->hclk);
 	pm_runtime_put(vop->dev);
+	mutex_unlock(&vop->vop_lock);
 
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
@@ -882,10 +886,13 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
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
@@ -949,6 +956,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_REG_SET(vop, common, standby, 0);
+	mutex_unlock(&vop->vop_lock);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
@@ -1487,15 +1495,21 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
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
@@ -1506,10 +1520,13 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
 
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
 
@@ -1559,6 +1576,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	spin_lock_init(&vop->reg_lock);
 	spin_lock_init(&vop->irq_lock);
+	mutex_init(&vop->vop_lock);
 
 	ret = devm_request_irq(dev, vop->irq, vop_isr,
 			       IRQF_SHARED, dev_name(dev), vop);
-- 
2.14.1
