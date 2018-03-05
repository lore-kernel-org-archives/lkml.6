Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeCEWb7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:31:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37230 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbeCEWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:23:45 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 05/38] drm/bridge: analogix_dp: Don't change psr while bridge is disabled
Date: Mon,  5 Mar 2018 23:22:57 +0100
Message-Id: <20180305222324.5872-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

There is a race between AUX CH bring-up and enabling bridge which will
cause link training to fail. To avoid hitting it, don't change psr state
while enabling the bridge.

Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
[seanpaul fixed up the commit message a bit and renamed *_supported to *_enabled]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 15 ++++++++-------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  2 +-
 include/drm/bridge/analogix_dp.h                   |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e738aa6de1af..ee00d3d920e0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -98,18 +98,18 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 	return 0;
 }
 
-int analogix_dp_psr_supported(struct analogix_dp_device *dp)
+int analogix_dp_psr_enabled(struct analogix_dp_device *dp)
 {
 
-	return dp->psr_support;
+	return dp->psr_enable;
 }
-EXPORT_SYMBOL_GPL(analogix_dp_psr_supported);
+EXPORT_SYMBOL_GPL(analogix_dp_psr_enabled);
 
 int analogix_dp_enable_psr(struct analogix_dp_device *dp)
 {
 	struct edp_vsc_psr psr_vsc;
 
-	if (!dp->psr_support)
+	if (!dp->psr_enable)
 		return 0;
 
 	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
@@ -131,7 +131,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	struct edp_vsc_psr psr_vsc;
 	int ret;
 
-	if (!dp->psr_support)
+	if (!dp->psr_enable)
 		return 0;
 
 	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
@@ -871,8 +871,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	/* Enable video */
 	analogix_dp_start_video(dp);
 
-	dp->psr_support = analogix_dp_detect_sink_psr(dp);
-	if (dp->psr_support)
+	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
+	if (dp->psr_enable)
 		analogix_dp_enable_sink_psr(dp);
 }
 
@@ -1117,6 +1117,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	if (ret)
 		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
 
+	dp->psr_enable = false;
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index b039b28d8fcc..e135a42cb19e 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -170,7 +170,7 @@ struct analogix_dp_device {
 	int			dpms_mode;
 	int			hpd_gpio;
 	bool                    force_hpd;
-	bool			psr_support;
+	bool			psr_enable;
 
 	struct mutex		panel_lock;
 	bool			panel_is_modeset;
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 36334839a3f8..3e8bf79bea58 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -82,7 +82,7 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 	struct rockchip_dp_device *dp = to_dp(encoder);
 	int ret;
 
-	if (!analogix_dp_psr_supported(dp->adp))
+	if (!analogix_dp_psr_enabled(dp->adp))
 		return;
 
 	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 711fff9b6803..e9a1116d2f8e 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -41,7 +41,7 @@ struct analogix_dp_plat_data {
 			 struct drm_connector *);
 };
 
-int analogix_dp_psr_supported(struct analogix_dp_device *dp);
+int analogix_dp_psr_enabled(struct analogix_dp_device *dp);
 int analogix_dp_enable_psr(struct analogix_dp_device *dp);
 int analogix_dp_disable_psr(struct analogix_dp_device *dp);
 
-- 
2.16.1
