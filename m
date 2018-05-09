Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934458AbeEIKXJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:23:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43992 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeEIKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:23:06 -0400
X-Google-Smtp-Source: AB8JxZrsfjEF5Ls0/N0LYWqdG2H7/jvxDuJkYYXHU1/0Awwpwra4S65mvcmbDfRujn0mXWtC9OmwbA==
From: Lin Huang <hl@rock-chips.com>
To: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com
Cc: dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 4/4] drm/rockchip: support dp training outside dp firmware
Date: Wed,  9 May 2018 18:22:44 +0800
Message-Id: <1525861364-26323-4-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP firmware uses fixed phy config values to do training, but some
boards need to adjust these values to fit for their unique hardware
design. So if the phy is using custom config values, do software
link training instead of relying on firmware, if software training
fail, keep firmware training as a fallback if sw training fails.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- update patch following Enric suggest

 drivers/gpu/drm/rockchip/Makefile               |   3 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
 drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 391 ++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  34 ++-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
 6 files changed, 479 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c

diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index a314e21..b932f62 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -9,7 +9,8 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
-rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
+rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o \
+					cdn-dp-link-training.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index cce64c1..2359d82 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -629,11 +629,13 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 			goto out;
 		}
 	}
-
-	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
-	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to idle video %d\n", ret);
-		goto out;
+	if (dp->sw_training_success == false) {
+		ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev,
+				      "Failed to idle video %d\n", ret);
+			goto out;
+		}
 	}
 
 	ret = cdn_dp_config_video(dp);
@@ -642,11 +644,15 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 		goto out;
 	}
 
-	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
-	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to valid video %d\n", ret);
-		goto out;
+	if (dp->sw_training_success == false) {
+		ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev,
+				"Failed to valid video %d\n", ret);
+			goto out;
+		}
 	}
+
 out:
 	mutex_unlock(&dp->lock);
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 46159b2..c6050ab 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -84,6 +84,7 @@ struct cdn_dp_device {
 	bool connected;
 	bool active;
 	bool suspended;
+	bool sw_training_success;
 
 	const struct firmware *fw;	/* cdn dp firmware */
 	unsigned int fw_version;	/* cdn fw version */
@@ -106,6 +107,7 @@ struct cdn_dp_device {
 	u8 ports;
 	u8 lanes;
 	int active_port;
+	u8 train_set[4];
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	bool sink_has_audio;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-link-training.c b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
new file mode 100644
index 0000000..25282de
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Author: Chris Zhong <zyw@rock-chips.com>
+ */
+
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/phy/phy.h>
+#include <soc/rockchip/rockchip_phy_typec.h>
+
+#include "cdn-dp-core.h"
+#include "cdn-dp-reg.h"
+
+static void cdn_dp_set_signal_levels(struct cdn_dp_device *dp)
+{
+	struct cdn_dp_port *port = dp->port[dp->active_port];
+	struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);
+
+	int rate = drm_dp_bw_code_to_link_rate(dp->link.rate);
+	u8 swing = (dp->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK) >>
+		   DP_TRAIN_VOLTAGE_SWING_SHIFT;
+	u8 pre_emphasis = (dp->train_set[0] & DP_TRAIN_PRE_EMPHASIS_MASK)
+			  >> DP_TRAIN_PRE_EMPHASIS_SHIFT;
+
+	tcphy->typec_phy_config(port->phy, rate, dp->link.num_lanes,
+				swing, pre_emphasis);
+}
+
+static int cdn_dp_set_pattern(struct cdn_dp_device *dp, uint8_t dp_train_pat)
+{
+	u32 phy_config, global_config;
+	int ret;
+	uint8_t pattern = dp_train_pat & DP_TRAINING_PATTERN_MASK;
+
+	global_config = NUM_LANES(dp->link.num_lanes - 1) | SST_MODE |
+			GLOBAL_EN | RG_EN | ENC_RST_DIS | WR_VHSYNC_FALL;
+
+	phy_config = DP_TX_PHY_ENCODER_BYPASS(0) |
+		     DP_TX_PHY_SKEW_BYPASS(0) |
+		     DP_TX_PHY_DISPARITY_RST(0) |
+		     DP_TX_PHY_LANE0_SKEW(0) |
+		     DP_TX_PHY_LANE1_SKEW(1) |
+		     DP_TX_PHY_LANE2_SKEW(2) |
+		     DP_TX_PHY_LANE3_SKEW(3) |
+		     DP_TX_PHY_10BIT_ENABLE(0);
+
+	if (pattern != DP_TRAINING_PATTERN_DISABLE) {
+		global_config |= NO_VIDEO;
+		phy_config |= DP_TX_PHY_TRAINING_ENABLE(1) |
+			      DP_TX_PHY_SCRAMBLER_BYPASS(1) |
+			      DP_TX_PHY_TRAINING_PATTERN(pattern);
+	}
+
+	ret = cdn_dp_reg_write(dp, DP_FRAMER_GLOBAL_CONFIG, global_config);
+	if (ret) {
+		DRM_ERROR("fail to set DP_FRAMER_GLOBAL_CONFIG, error: %d\n",
+			  ret);
+		return ret;
+	}
+
+	ret = cdn_dp_reg_write(dp, DP_TX_PHY_CONFIG_REG, phy_config);
+	if (ret) {
+		DRM_ERROR("fail to set DP_TX_PHY_CONFIG_REG, error: %d\n",
+			  ret);
+		return ret;
+	}
+
+	ret = cdn_dp_reg_write(dp, DPTX_LANE_EN, BIT(dp->link.num_lanes) - 1);
+	if (ret) {
+		DRM_ERROR("fail to set DPTX_LANE_EN, error: %d\n", ret);
+		return ret;
+	}
+
+	if (drm_dp_enhanced_frame_cap(dp->dpcd))
+		ret = cdn_dp_reg_write(dp, DPTX_ENHNCD, 1);
+	else
+		ret = cdn_dp_reg_write(dp, DPTX_ENHNCD, 0);
+	if (ret)
+		DRM_ERROR("failed to set DPTX_ENHNCD, error: %x\n", ret);
+
+	return ret;
+}
+
+static u8 cdn_dp_pre_emphasis_max(u8 voltage_swing)
+{
+	switch (voltage_swing & DP_TRAIN_VOLTAGE_SWING_MASK) {
+	case DP_TRAIN_VOLTAGE_SWING_LEVEL_0:
+		return DP_TRAIN_PRE_EMPH_LEVEL_3;
+	case DP_TRAIN_VOLTAGE_SWING_LEVEL_1:
+		return DP_TRAIN_PRE_EMPH_LEVEL_2;
+	case DP_TRAIN_VOLTAGE_SWING_LEVEL_2:
+		return DP_TRAIN_PRE_EMPH_LEVEL_1;
+	default:
+		return DP_TRAIN_PRE_EMPH_LEVEL_0;
+	}
+}
+
+static void cdn_dp_get_adjust_train(struct cdn_dp_device *dp,
+				    uint8_t link_status[DP_LINK_STATUS_SIZE])
+{
+	int i;
+	uint8_t v = 0, p = 0;
+	uint8_t preemph_max;
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		v = max(v, drm_dp_get_adjust_request_voltage(link_status, i));
+		p = max(p, drm_dp_get_adjust_request_pre_emphasis(link_status,
+								  i));
+	}
+
+	if (v >= VOLTAGE_LEVEL_2)
+		v = VOLTAGE_LEVEL_2 | DP_TRAIN_MAX_SWING_REACHED;
+
+	preemph_max = cdn_dp_pre_emphasis_max(v);
+	if (p >= preemph_max)
+		p = preemph_max | DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+
+	for (i = 0; i < dp->link.num_lanes; i++)
+		dp->train_set[i] = v | p;
+}
+
+/*
+ * Pick training pattern for channel equalization. Training Pattern 3 for HBR2
+ * or 1.2 devices that support it, Training Pattern 2 otherwise.
+ */
+static u32 cdn_dp_select_chaneq_pattern(struct cdn_dp_device *dp)
+{
+	u32 training_pattern = DP_TRAINING_PATTERN_2;
+
+	/*
+	 * cdn dp support HBR2 also support TPS3. TPS3 support is also mandatory
+	 * for downstream devices that support HBR2. However, not all sinks
+	 * follow the spec.
+	 */
+	if (drm_dp_tps3_supported(dp->dpcd))
+		training_pattern = DP_TRAINING_PATTERN_3;
+	else
+		DRM_DEBUG_KMS("5.4 Gbps link rate without sink TPS3 support\n");
+
+	return training_pattern;
+}
+
+
+static bool cdn_dp_link_max_vswing_reached(struct cdn_dp_device *dp)
+{
+	int lane;
+
+	for (lane = 0; lane < dp->link.num_lanes; lane++)
+		if ((dp->train_set[lane] & DP_TRAIN_MAX_SWING_REACHED) == 0)
+			return false;
+
+	return true;
+}
+
+static int cdn_dp_update_link_train(struct cdn_dp_device *dp)
+{
+	int ret;
+
+	cdn_dp_set_signal_levels(dp);
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
+				dp->train_set, dp->link.num_lanes);
+	if (ret != dp->link.num_lanes)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int cdn_dp_set_link_train(struct cdn_dp_device *dp,
+				  uint8_t dp_train_pat)
+{
+	uint8_t buf[sizeof(dp->train_set) + 1];
+	int ret, len;
+
+	buf[0] = dp_train_pat;
+	if ((dp_train_pat & DP_TRAINING_PATTERN_MASK) ==
+	    DP_TRAINING_PATTERN_DISABLE) {
+		/* don't write DP_TRAINING_LANEx_SET on disable */
+		len = 1;
+	} else {
+		/* DP_TRAINING_LANEx_SET follow DP_TRAINING_PATTERN_SET */
+		memcpy(buf + 1, dp->train_set, dp->link.num_lanes);
+		len = dp->link.num_lanes + 1;
+	}
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_PATTERN_SET,
+				buf, len);
+	if (ret != len)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int cdn_dp_reset_link_train(struct cdn_dp_device *dp,
+				    uint8_t dp_train_pat)
+{
+	int ret;
+
+	memset(dp->train_set, 0, sizeof(dp->train_set));
+
+	cdn_dp_set_signal_levels(dp);
+
+	ret = cdn_dp_set_pattern(dp, dp_train_pat);
+	if (ret)
+		return ret;
+
+	return cdn_dp_set_link_train(dp, dp_train_pat);
+}
+
+/* Enable corresponding port and start training pattern 1 */
+static int cdn_dp_link_training_clock_recovery(struct cdn_dp_device *dp)
+{
+	u8 voltage, link_config[2];
+	u8 link_status[DP_LINK_STATUS_SIZE];
+	u32 voltage_tries, max_vswing_tries;
+	u32 rate, sink_max, source_max;
+	int ret;
+
+	source_max = dp->lanes;
+	sink_max = drm_dp_max_lane_count(dp->dpcd);
+	dp->link.num_lanes = min(source_max, sink_max);
+
+	source_max = drm_dp_bw_code_to_link_rate(CDN_DP_MAX_LINK_RATE);
+	sink_max = drm_dp_max_link_rate(dp->dpcd);
+	rate = min(source_max, sink_max);
+	dp->link.rate = drm_dp_link_rate_to_bw_code(rate);
+
+	/* Write the link configuration data */
+	link_config[0] = dp->link.rate;
+	link_config[1] = dp->link.num_lanes;
+	if (drm_dp_enhanced_frame_cap(dp->dpcd))
+		link_config[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
+	drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, link_config, 2);
+
+	link_config[0] = 0;
+	link_config[1] = 0;
+	if (dp->dpcd[DP_MAIN_LINK_CHANNEL_CODING] & 0x01)
+		link_config[1] = DP_SET_ANSI_8B10B;
+
+	drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, link_config, 2);
+
+	/* clock recovery */
+	ret = cdn_dp_reset_link_train(dp, DP_TRAINING_PATTERN_1 |
+					  DP_LINK_SCRAMBLING_DISABLE);
+	if (ret) {
+		DRM_ERROR("failed to start link train\n");
+		return ret;
+	}
+
+	voltage_tries = 1;
+	max_vswing_tries = 0;
+	for (;;) {
+		drm_dp_link_train_clock_recovery_delay(dp->dpcd);
+		if (drm_dp_dpcd_read_link_status(&dp->aux, link_status) !=
+		    DP_LINK_STATUS_SIZE) {
+			DRM_ERROR("failed to get link status\n");
+			return -EINVAL;
+		}
+
+		if (drm_dp_clock_recovery_ok(link_status, dp->link.num_lanes)) {
+			DRM_DEBUG_KMS("clock recovery OK\n");
+			return 0;
+		}
+
+		if (voltage_tries >= 5) {
+			DRM_DEBUG_KMS("Same voltage tried 5 times\n");
+			return -EINVAL;
+		}
+
+		if (max_vswing_tries >= 1) {
+			DRM_DEBUG_KMS("Max Voltage Swing reached\n");
+			return -EINVAL;
+		}
+
+		voltage = dp->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK;
+
+		/* Update training set as requested by target */
+		cdn_dp_get_adjust_train(dp, link_status);
+		if (cdn_dp_update_link_train(dp)) {
+			DRM_ERROR("failed to update link training\n");
+			return -EINVAL;
+		}
+
+		if ((dp->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK) ==
+		    voltage)
+			++voltage_tries;
+		else
+			voltage_tries = 1;
+
+		if (cdn_dp_link_max_vswing_reached(dp))
+			++max_vswing_tries;
+	}
+}
+
+static int cdn_dp_link_training_channel_equalization(struct cdn_dp_device *dp)
+{
+	int tries, ret;
+	u32 training_pattern;
+	uint8_t link_status[DP_LINK_STATUS_SIZE];
+
+	training_pattern = cdn_dp_select_chaneq_pattern(dp);
+	training_pattern |= DP_LINK_SCRAMBLING_DISABLE;
+
+	ret = cdn_dp_set_pattern(dp, training_pattern);
+	if (ret)
+		return ret;
+
+	ret = cdn_dp_set_link_train(dp, training_pattern);
+	if (ret) {
+		DRM_ERROR("failed to start channel equalization\n");
+		return ret;
+	}
+
+	for (tries = 0; tries < 5; tries++) {
+		drm_dp_link_train_channel_eq_delay(dp->dpcd);
+		if (drm_dp_dpcd_read_link_status(&dp->aux, link_status) !=
+		    DP_LINK_STATUS_SIZE) {
+			DRM_ERROR("failed to get link status\n");
+			break;
+		}
+
+		/* Make sure clock is still ok */
+		if (!drm_dp_clock_recovery_ok(link_status,
+					      dp->link.num_lanes)) {
+			DRM_DEBUG_KMS("Clock recovery check failed\n");
+			break;
+		}
+
+		if (drm_dp_channel_eq_ok(link_status,  dp->link.num_lanes)) {
+			DRM_DEBUG_KMS("Channel EQ done\n");
+			return 0;
+		}
+
+		/* Update training set as requested by target */
+		cdn_dp_get_adjust_train(dp, link_status);
+		if (cdn_dp_update_link_train(dp)) {
+			DRM_ERROR("failed to update link training\n");
+			break;
+		}
+	}
+
+	/* Try 5 times, else fail and try at lower BW */
+	if (tries == 5)
+		DRM_DEBUG_KMS("Channel equalization failed 5 times\n");
+
+	return -EINVAL;
+}
+
+static int cdn_dp_stop_link_train(struct cdn_dp_device *dp)
+{
+	int ret = cdn_dp_set_pattern(dp, DP_TRAINING_PATTERN_DISABLE);
+
+	if (ret)
+		return ret;
+
+	return cdn_dp_set_link_train(dp, DP_TRAINING_PATTERN_DISABLE);
+}
+
+int cdn_dp_software_train_link(struct cdn_dp_device *dp)
+{
+	int ret, stop_err;
+
+	ret = drm_dp_dpcd_read(&dp->aux, DP_DPCD_REV, dp->dpcd,
+			       sizeof(dp->dpcd));
+	if (ret < 0) {
+		DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
+		return ret;
+	}
+
+	ret = cdn_dp_link_training_clock_recovery(dp);
+	if (ret) {
+		DRM_ERROR("training clock recovery fail, error: %d\n", ret);
+		goto out;
+	}
+
+	ret = cdn_dp_link_training_channel_equalization(dp);
+	if (ret) {
+		DRM_ERROR("training channel equalization fail, error: %d\n",
+			  ret);
+		goto out;
+	}
+out:
+	stop_err = cdn_dp_stop_link_train(dp);
+	if (stop_err) {
+		DRM_ERROR("stop training fail, error: %d\n", stop_err);
+		return stop_err;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index afdfda0..bd0aed5 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -17,7 +17,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/phy/phy.h>
 #include <linux/reset.h>
+#include <soc/rockchip/rockchip_phy_typec.h>
 
 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
@@ -189,7 +191,7 @@ static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
 	return 0;
 }
 
-static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
+int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
@@ -606,7 +608,35 @@ static int cdn_dp_get_training_status(struct cdn_dp_device *dp)
 int cdn_dp_train_link(struct cdn_dp_device *dp)
 {
 	int ret;
+	struct cdn_dp_port *port = dp->port[dp->active_port];
+	struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);
 
+	/*
+	 * DP firmware uses fixed phy config values to do training, but some
+	 * boards need to adjust these values to fit for their unique hardware
+	 * design. So if the phy is using custom config values, do software
+	 * link training instead of relying on firmware, if software training
+	 * fail, keep firmware training as a fallback if sw training fails.
+	 */
+	if (tcphy->need_software_training) {
+		ret = cdn_dp_software_train_link(dp);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev,
+				"Failed to do software training %d\n", ret);
+			goto do_fw_training;
+		}
+		ret = cdn_dp_reg_write(dp, SOURCE_HDTX_CAR, 0xf);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev,
+			"Failed to write SOURCE_HDTX_CAR register %d\n", ret);
+			goto do_fw_training;
+		}
+		dp->sw_training_success = true;
+		return 0;
+	}
+
+do_fw_training:
+	dp->sw_training_success = false;
 	ret = cdn_dp_training_start(dp);
 	if (ret) {
 		DRM_DEV_ERROR(dp->dev, "Failed to start training %d\n", ret);
@@ -621,7 +651,7 @@ int cdn_dp_train_link(struct cdn_dp_device *dp)
 
 	DRM_DEV_DEBUG_KMS(dp->dev, "rate:0x%x, lanes:%d\n", dp->link.rate,
 			  dp->link.num_lanes);
-	return ret;
+	return 0;
 }
 
 int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index 6580b11..3420771 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -137,7 +137,7 @@
 #define HPD_EVENT_MASK			0x211c
 #define HPD_EVENT_DET			0x2120
 
-/* dpyx framer addr */
+/* dptx framer addr */
 #define DP_FRAMER_GLOBAL_CONFIG		0x2200
 #define DP_SW_RESET			0x2204
 #define DP_FRAMER_TU			0x2208
@@ -431,6 +431,40 @@
 /* Reference cycles when using lane clock as reference */
 #define LANE_REF_CYC				0x8000
 
+/* register CM_VID_CTRL */
+#define LANE_VID_REF_CYC(x)                    (((x) & (BIT(24) - 1)) << 0)
+#define NMVID_MEAS_TOLERANCE(x)                        (((x) & 0xf) << 24)
+
+/* register DP_TX_PHY_CONFIG_REG */
+#define DP_TX_PHY_TRAINING_ENABLE(x)           ((x) & 1)
+#define DP_TX_PHY_TRAINING_TYPE_PRBS7          (0 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_TPS1           (1 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_TPS2           (2 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_TPS3           (3 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_TPS4           (4 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_PLTPAT         (5 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_D10_2          (6 << 1)
+#define DP_TX_PHY_TRAINING_TYPE_HBR2CPAT       (8 << 1)
+#define DP_TX_PHY_TRAINING_PATTERN(x)          ((x) << 1)
+#define DP_TX_PHY_SCRAMBLER_BYPASS(x)          (((x) & 1) << 5)
+#define DP_TX_PHY_ENCODER_BYPASS(x)            (((x) & 1) << 6)
+#define DP_TX_PHY_SKEW_BYPASS(x)               (((x) & 1) << 7)
+#define DP_TX_PHY_DISPARITY_RST(x)             (((x) & 1) << 8)
+#define DP_TX_PHY_LANE0_SKEW(x)                (((x) & 7) << 9)
+#define DP_TX_PHY_LANE1_SKEW(x)                (((x) & 7) << 12)
+#define DP_TX_PHY_LANE2_SKEW(x)                (((x) & 7) << 15)
+#define DP_TX_PHY_LANE3_SKEW(x)                (((x) & 7) << 18)
+#define DP_TX_PHY_10BIT_ENABLE(x)              (((x) & 1) << 21)
+
+/* register DP_FRAMER_GLOBAL_CONFIG */
+#define NUM_LANES(x)           ((x) & 3)
+#define SST_MODE               (0 << 2)
+#define RG_EN                  (0 << 4)
+#define GLOBAL_EN              BIT(3)
+#define NO_VIDEO               BIT(5)
+#define ENC_RST_DIS            BIT(6)
+#define WR_VHSYNC_FALL         BIT(7)
+
 enum voltage_swing_level {
 	VOLTAGE_LEVEL_0,
 	VOLTAGE_LEVEL_1,
@@ -476,6 +510,7 @@ int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
 int cdn_dp_event_config(struct cdn_dp_device *dp);
 u32 cdn_dp_get_event(struct cdn_dp_device *dp);
 int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
+int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val);
 ssize_t cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr,
 			  u8 *data, u16 len);
 ssize_t cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr,
@@ -489,4 +524,5 @@ int cdn_dp_config_video(struct cdn_dp_device *dp);
 int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
 int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
 int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
+int cdn_dp_software_train_link(struct cdn_dp_device *dp);
 #endif /* _CDN_DP_REG_H */
-- 
2.7.4
