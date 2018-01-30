Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeA3U3e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeA3U3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:31 -0500
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
Subject: [PATCH v3 04/43] drm/bridge: analogix_dp: set psr activate/deactivate when enable/disable bridge
Date: Tue, 30 Jan 2018 21:28:34 +0100
Message-Id: <20180130202913.28724-5-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
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
index 7a137bc5708c..31304434847a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -577,8 +577,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	WARN_ON(vop->event);
 
-	rockchip_drm_psr_deactivate(&vop->crtc);
-
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -951,8 +949,6 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_REG_SET(vop, common, standby, 0);
-
-	rockchip_drm_psr_activate(&vop->crtc);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
-- 
2.14.1
