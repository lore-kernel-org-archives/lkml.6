Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeCEWXj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:23:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeCEWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:23:36 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 01/38] drm/bridge: analogix_dp: set psr activate/deactivate when enable/disable bridge
Date: Mon,  5 Mar 2018 23:22:53 +0100
Message-Id: <20180305222324.5872-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

There's a race between when bridge_disable and when vop_crtc_disable
are called. If the flush timer triggers a new psr work between these,
we will operate eDP without power shutdowned by bridge_disable. In this
case, moving activate/deactivate to enable/disable bridge to avoid it.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  7 +++++-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c     | 30 ++++++++++++++++++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h     |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  4 ----
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index eb88c52336a7..7d76ff47028d 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -150,12 +150,17 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 		return ret;
 	}
 
-	return 0;
+	return rockchip_drm_psr_activate(&dp->encoder);
 }
 
 static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
 {
 	struct rockchip_dp_device *dp = to_dp(plat_data);
+	int ret;
+
+	ret = rockchip_drm_psr_deactivate(&dp->encoder);
+	if (ret != 0)
+		return ret;
 
 	clk_disable_unprepare(dp->pclk);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 3acfd576b7df..b3fb99c5b1fd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -57,6 +57,24 @@ static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
 	return psr;
 }
 
+static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
+{
+	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
+	struct psr_drv *psr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	list_for_each_entry(psr, &drm_drv->psr_list, list) {
+		if (psr->encoder == encoder)
+			goto out;
+	}
+	psr = ERR_PTR(-ENODEV);
+
+out:
+	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	return psr;
+}
+
 static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
 {
 	/*
@@ -115,14 +133,14 @@ static void psr_flush_handler(struct timer_list *t)
 
 /**
  * rockchip_drm_psr_activate - activate PSR on the given pipe
- * @crtc: CRTC to obtain the PSR encoder
+ * @encoder: encoder to obtain the PSR encoder
  *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_psr_activate(struct drm_crtc *crtc)
+int rockchip_drm_psr_activate(struct drm_encoder *encoder)
 {
-	struct psr_drv *psr = find_psr_by_crtc(crtc);
+	struct psr_drv *psr = find_psr_by_encoder(encoder);
 	unsigned long flags;
 
 	if (IS_ERR(psr))
@@ -138,14 +156,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_activate);
 
 /**
  * rockchip_drm_psr_deactivate - deactivate PSR on the given pipe
- * @crtc: CRTC to obtain the PSR encoder
+ * @encoder: encoder to obtain the PSR encoder
  *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_psr_deactivate(struct drm_crtc *crtc)
+int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 {
-	struct psr_drv *psr = find_psr_by_crtc(crtc);
+	struct psr_drv *psr = find_psr_by_encoder(encoder);
 	unsigned long flags;
 
 	if (IS_ERR(psr))
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index b420cf1bf902..b1ea0155e57c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -18,8 +18,8 @@
 void rockchip_drm_psr_flush_all(struct drm_device *dev);
 int rockchip_drm_psr_flush(struct drm_crtc *crtc);
 
-int rockchip_drm_psr_activate(struct drm_crtc *crtc);
-int rockchip_drm_psr_deactivate(struct drm_crtc *crtc);
+int rockchip_drm_psr_activate(struct drm_encoder *encoder);
+int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
 
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			void (*psr_set)(struct drm_encoder *, bool enable));
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 9f72762532bf..63fbe789a5dd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -569,8 +569,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	WARN_ON(vop->event);
 
-	rockchip_drm_psr_deactivate(&vop->crtc);
-
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -942,8 +940,6 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_REG_SET(vop, common, standby, 0);
-
-	rockchip_drm_psr_activate(&vop->crtc);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
-- 
2.16.1
