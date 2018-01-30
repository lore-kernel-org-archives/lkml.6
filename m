Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeA3Ufq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:35:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56296 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeA3U3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:47 -0500
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
Subject: [PATCH v3 22/43] drm/bridge: analogix_dp: Check dpcd write/read status
Date: Tue, 30 Jan 2018 21:28:52 +0100
Message-Id: <20180130202913.28724-23-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

We need to check the dpcd write/read return value to see whether the
write/read was successful

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 182 +++++++++++++++------
 1 file changed, 135 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 846574d0dcb0..082b4e024052 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -160,80 +160,137 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 }
 EXPORT_SYMBOL_GPL(analogix_dp_disable_psr);
 
-static bool analogix_dp_detect_sink_psr(struct analogix_dp_device *dp)
+static int analogix_dp_detect_sink_psr(struct analogix_dp_device *dp)
 {
 	unsigned char psr_version;
+	int ret;
+
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_PSR_SUPPORT, &psr_version);
+	if (ret != 1) {
+		dev_err(dp->dev, "failed to get PSR version, disable it\n");
+		return ret;
+	}
 
-	drm_dp_dpcd_readb(&dp->aux, DP_PSR_SUPPORT, &psr_version);
 	dev_dbg(dp->dev, "Panel PSR version : %x\n", psr_version);
 
-	return (psr_version & DP_PSR_IS_SUPPORTED) ? true : false;
+	dp->psr_enable = (psr_version & DP_PSR_IS_SUPPORTED) ? true : false;
+
+	return 0;
 }
 
-static void analogix_dp_enable_sink_psr(struct analogix_dp_device *dp)
+static int analogix_dp_enable_sink_psr(struct analogix_dp_device *dp)
 {
 	unsigned char psr_en;
+	int ret;
 
 	/* Disable psr function */
-	drm_dp_dpcd_readb(&dp->aux, DP_PSR_EN_CFG, &psr_en);
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_PSR_EN_CFG, &psr_en);
+	if (ret != 1) {
+		dev_err(dp->dev, "failed to get psr config\n");
+		goto end;
+	}
+
 	psr_en &= ~DP_PSR_ENABLE;
-	drm_dp_dpcd_writeb(&dp->aux, DP_PSR_EN_CFG, psr_en);
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_PSR_EN_CFG, psr_en);
+	if (ret != 1) {
+		dev_err(dp->dev, "failed to disable panel psr\n");
+		goto end;
+	}
 
 	/* Main-Link transmitter remains active during PSR active states */
 	psr_en = DP_PSR_MAIN_LINK_ACTIVE | DP_PSR_CRC_VERIFICATION;
-	drm_dp_dpcd_writeb(&dp->aux, DP_PSR_EN_CFG, psr_en);
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_PSR_EN_CFG, psr_en);
+	if (ret != 1) {
+		dev_err(dp->dev, "failed to set panel psr\n");
+		goto end;
+	}
 
 	/* Enable psr function */
 	psr_en = DP_PSR_ENABLE | DP_PSR_MAIN_LINK_ACTIVE |
 		 DP_PSR_CRC_VERIFICATION;
-	drm_dp_dpcd_writeb(&dp->aux, DP_PSR_EN_CFG, psr_en);
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_PSR_EN_CFG, psr_en);
+	if (ret != 1) {
+		dev_err(dp->dev, "failed to set panel psr\n");
+		goto end;
+	}
 
 	analogix_dp_enable_psr_crc(dp);
+
+	return 0;
+end:
+	dev_err(dp->dev, "enable psr fail, force to disable psr\n");
+	dp->psr_enable = false;
+
+	return ret;
 }
 
-static void
+static int
 analogix_dp_enable_rx_to_enhanced_mode(struct analogix_dp_device *dp,
 				       bool enable)
 {
 	u8 data;
+	int ret;
 
-	drm_dp_dpcd_readb(&dp->aux, DP_LANE_COUNT_SET, &data);
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_LANE_COUNT_SET, &data);
+	if (ret != 1)
+		return ret;
 
 	if (enable)
-		drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET,
-				   DP_LANE_COUNT_ENHANCED_FRAME_EN |
-					DPCD_LANE_COUNT_SET(data));
+		ret = drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET,
+					 DP_LANE_COUNT_ENHANCED_FRAME_EN |
+					 DPCD_LANE_COUNT_SET(data));
 	else
-		drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET,
-				   DPCD_LANE_COUNT_SET(data));
+		ret = drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET,
+					 DPCD_LANE_COUNT_SET(data));
+
+	return ret < 0 ? ret : 0;
 }
 
-static int analogix_dp_is_enhanced_mode_available(struct analogix_dp_device *dp)
+static int analogix_dp_is_enhanced_mode_available(struct analogix_dp_device *dp,
+						  u8 *enhanced_mode_support)
 {
 	u8 data;
-	int retval;
+	int ret;
 
-	drm_dp_dpcd_readb(&dp->aux, DP_MAX_LANE_COUNT, &data);
-	retval = DPCD_ENHANCED_FRAME_CAP(data);
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_MAX_LANE_COUNT, &data);
+	if (ret != 1) {
+		*enhanced_mode_support = 0;
+		return ret;
+	}
 
-	return retval;
+	*enhanced_mode_support = DPCD_ENHANCED_FRAME_CAP(data);
+
+	return 0;
 }
 
-static void analogix_dp_set_enhanced_mode(struct analogix_dp_device *dp)
+static int analogix_dp_set_enhanced_mode(struct analogix_dp_device *dp)
 {
 	u8 data;
+	int ret;
+
+	ret = analogix_dp_is_enhanced_mode_available(dp, &data);
+	if (ret < 0)
+		return ret;
+
+	ret = analogix_dp_enable_rx_to_enhanced_mode(dp, data);
+	if (ret < 0)
+		return ret;
 
-	data = analogix_dp_is_enhanced_mode_available(dp);
-	analogix_dp_enable_rx_to_enhanced_mode(dp, data);
 	analogix_dp_enable_enhanced_mode(dp, data);
+
+	return 0;
 }
 
-static void analogix_dp_training_pattern_dis(struct analogix_dp_device *dp)
+static int analogix_dp_training_pattern_dis(struct analogix_dp_device *dp)
 {
+	int ret;
+
 	analogix_dp_set_training_pattern(dp, DP_NONE);
 
-	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
-			   DP_TRAINING_PATTERN_DISABLE);
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+				 DP_TRAINING_PATTERN_DISABLE);
+
+	return ret < 0 ? ret : 0;
 }
 
 static void
@@ -282,7 +339,11 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	if (retval < 0)
 		return retval;
 	/* set enhanced mode if available */
-	analogix_dp_set_enhanced_mode(dp);
+	retval = analogix_dp_set_enhanced_mode(dp);
+	if (retval < 0) {
+		dev_err(dp->dev, "failed to set enhance mode\n");
+		return retval;
+	}
 
 	/* Set TX pre-emphasis to minimum */
 	for (lane = 0; lane < lane_count; lane++)
@@ -567,10 +628,11 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 
 	if (!analogix_dp_channel_eq_ok(link_status, link_align, lane_count)) {
 		/* traing pattern Set to Normal */
-		analogix_dp_training_pattern_dis(dp);
+		retval = analogix_dp_training_pattern_dis(dp);
+		if (retval < 0)
+			return retval;
 
 		dev_info(dp->dev, "Link Training success!\n");
-
 		analogix_dp_get_link_bandwidth(dp, &reg);
 		dp->link_train.link_rate = reg;
 		dev_dbg(dp->dev, "final bandwidth = %.2x\n",
@@ -807,7 +869,6 @@ static int analogix_dp_train_link(struct analogix_dp_device *dp)
 
 static int analogix_dp_config_video(struct analogix_dp_device *dp)
 {
-	int retval = 0;
 	int timeout_loop = 0;
 	int done_count = 0;
 
@@ -865,30 +926,42 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 		usleep_range(1000, 1001);
 	}
 
-	if (retval != 0)
-		dev_err(dp->dev, "Video stream is not detected!\n");
-
-	return retval;
+	return 0;
 }
 
-static void analogix_dp_enable_scramble(struct analogix_dp_device *dp,
-					bool enable)
+static int analogix_dp_enable_scramble(struct analogix_dp_device *dp,
+				       bool enable)
 {
 	u8 data;
+	int ret;
 
 	if (enable) {
 		analogix_dp_enable_scrambling(dp);
 
-		drm_dp_dpcd_readb(&dp->aux, DP_TRAINING_PATTERN_SET, &data);
-		drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+		ret = drm_dp_dpcd_readb(&dp->aux, DP_TRAINING_PATTERN_SET,
+					&data);
+		if (ret != 1)
+			return ret;
+
+		ret = drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
 				   (u8)(data & ~DP_LINK_SCRAMBLING_DISABLE));
+		if (ret < 0)
+			return ret;
 	} else {
 		analogix_dp_disable_scrambling(dp);
 
-		drm_dp_dpcd_readb(&dp->aux, DP_TRAINING_PATTERN_SET, &data);
-		drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+		ret = drm_dp_dpcd_readb(&dp->aux, DP_TRAINING_PATTERN_SET,
+					&data);
+		if (ret != 1)
+			return ret;
+
+		ret = drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
 				   (u8)(data | DP_LINK_SCRAMBLING_DISABLE));
+		if (ret < 0)
+			return ret;
 	}
+
+	return 0;
 }
 
 static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
@@ -943,23 +1016,36 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 		return ret;
 	}
 
-	analogix_dp_enable_scramble(dp, 1);
+	ret = analogix_dp_enable_scramble(dp, 1);
+	if (ret < 0) {
+		dev_err(dp->dev, "can not enable scramble\n");
+		return ret;
+	}
 
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
-	if (ret)
+	if (ret) {
 		dev_err(dp->dev, "unable to config video\n");
+		return ret;
+	}
 
 	/* Safe to enable the panel now */
 	if (dp->plat_data->panel) {
-		if (drm_panel_enable(dp->plat_data->panel))
+		ret = drm_panel_enable(dp->plat_data->panel);
+		if (ret) {
 			DRM_ERROR("failed to enable the panel\n");
+			return ret;
+		}
 	}
 
-	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
+	ret = analogix_dp_detect_sink_psr(dp);
+	if (ret)
+		return ret;
+
 	if (dp->psr_enable)
-		analogix_dp_enable_sink_psr(dp);
-	return 0;
+		ret = analogix_dp_enable_sink_psr(dp);
+
+	return ret;
 }
 
 /*
@@ -1186,8 +1272,10 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 	}
 
 	ret = analogix_dp_commit(dp);
-	if (ret)
+	if (ret) {
+		DRM_ERROR("dp commit error, ret = %d\n", ret);
 		goto out_dp_init;
+	}
 
 	enable_irq(dp->irq);
 	return 0;
-- 
2.14.1
