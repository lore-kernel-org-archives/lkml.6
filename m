Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbeCEWYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37580 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbeCEWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:29 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 21/38] drm/rockchip: Restore psr->state when enable/disable psr failed
Date: Mon,  5 Mar 2018 23:23:13 +0100
Message-Id: <20180305222324.5872-22-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

If we failed disable psr, it would hang the display until next psr
cycle coming. So we should restore psr->state when it failed.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 +++-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 10 +++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        | 20 +++++++++++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |  2 +-
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 2d49ee6fd2f3..c93a0d125b87 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -153,8 +153,10 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	psr_vsc.DB1 = 0;
 
 	ret = drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
-	if (ret != 1)
+	if (ret != 1) {
 		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
+		return ret;
+	}
 
 	return analogix_dp_send_psr_spd(dp, &psr_vsc, false);
 }
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 3e8bf79bea58..8c884f9ce713 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -77,13 +77,13 @@ struct rockchip_dp_device {
 	struct analogix_dp_plat_data plat_data;
 };
 
-static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
+static int analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 {
 	struct rockchip_dp_device *dp = to_dp(encoder);
 	int ret;
 
 	if (!analogix_dp_psr_enabled(dp->adp))
-		return;
+		return 0;
 
 	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
 
@@ -91,13 +91,13 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 					 PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
 	if (ret) {
 		DRM_DEV_ERROR(dp->dev, "line flag interrupt did not arrive\n");
-		return;
+		return -ETIMEDOUT;
 	}
 
 	if (enabled)
-		analogix_dp_enable_psr(dp->adp);
+		return analogix_dp_enable_psr(dp->adp);
 	else
-		analogix_dp_disable_psr(dp->adp);
+		return analogix_dp_disable_psr(dp->adp);
 }
 
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index b339ca943139..9376f4396b6b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -36,7 +36,7 @@ struct psr_drv {
 
 	struct delayed_work	flush_work;
 
-	void (*set)(struct drm_encoder *encoder, bool enable);
+	int (*set)(struct drm_encoder *encoder, bool enable);
 };
 
 static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
@@ -93,19 +93,25 @@ static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
 		return;
 	}
 
-	psr->state = state;
-
 	/* Actually commit the state change to hardware */
-	switch (psr->state) {
+	switch (state) {
 	case PSR_ENABLE:
-		psr->set(psr->encoder, true);
+		if (psr->set(psr->encoder, true))
+			return;
 		break;
 
 	case PSR_DISABLE:
 	case PSR_FLUSH:
-		psr->set(psr->encoder, false);
+		if (psr->set(psr->encoder, false))
+			return;
 		break;
+
+	default:
+		pr_err("%s: Unknown state %d\n", __func__, state);
+		return;
 	}
+
+	psr->state = state;
 }
 
 static void psr_set_state(struct psr_drv *psr, enum psr_state state)
@@ -229,7 +235,7 @@ EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
  * Zero on success, negative errno on failure.
  */
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
-			void (*psr_set)(struct drm_encoder *, bool enable))
+			int (*psr_set)(struct drm_encoder *, bool enable))
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index b1ea0155e57c..06537ee27565 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -22,7 +22,7 @@ int rockchip_drm_psr_activate(struct drm_encoder *encoder);
 int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
 
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
-			void (*psr_set)(struct drm_encoder *, bool enable));
+			int (*psr_set)(struct drm_encoder *, bool enable));
 void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
 
 #endif /* __ROCKCHIP_DRM_PSR__ */
-- 
2.16.1
