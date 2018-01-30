Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeA3UhY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:37:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeA3U3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:40 -0500
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
Subject: [PATCH v3 16/43] drm/bridge: analogix_dp: Retry bridge enable when it failed
Date: Tue, 30 Jan 2018 21:28:46 +0100
Message-Id: <20180130202913.28724-17-thierry.escande@collabora.com>
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

When we enable bridge failed, we have to retry it, otherwise we would get
the abnormal display.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 65 +++++++++++++++++-----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  3 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  5 +-
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 179c2106b8a2..ba2506e17f6d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -43,8 +43,10 @@ struct bridge_init {
 	struct device_node *node;
 };
 
-static void analogix_dp_init_dp(struct analogix_dp_device *dp)
+static int analogix_dp_init_dp(struct analogix_dp_device *dp)
 {
+	int ret;
+
 	analogix_dp_reset(dp);
 
 	analogix_dp_swreset(dp);
@@ -56,10 +58,13 @@ static void analogix_dp_init_dp(struct analogix_dp_device *dp)
 	analogix_dp_enable_sw_function(dp);
 
 	analogix_dp_config_interrupt(dp);
-	analogix_dp_init_analog_func(dp);
+	ret = analogix_dp_init_analog_func(dp);
+	if (ret)
+		return ret;
 
 	analogix_dp_init_hpd(dp);
 	analogix_dp_init_aux(dp);
+	return 0;
 }
 
 static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
@@ -922,7 +927,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void analogix_dp_commit(struct analogix_dp_device *dp)
+static int analogix_dp_commit(struct analogix_dp_device *dp)
 {
 	int ret;
 
@@ -932,11 +937,10 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 			DRM_ERROR("failed to disable the panel\n");
 	}
 
-	ret = readx_poll_timeout(analogix_dp_train_link, dp, ret, !ret, 100,
-				 DP_TIMEOUT_TRAINING_US * 5);
+	ret = analogix_dp_train_link(dp);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train, ret=%d\n", ret);
-		return;
+		return ret;
 	}
 
 	analogix_dp_enable_scramble(dp, 1);
@@ -957,6 +961,7 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
 	if (dp->psr_enable)
 		analogix_dp_enable_sink_psr(dp);
+	return 0;
 }
 
 /*
@@ -1150,12 +1155,9 @@ static void analogix_dp_bridge_pre_enable(struct drm_bridge *bridge)
 		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
 }
 
-static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
+static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = bridge->driver_private;
-
-	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
-		return;
+	int ret;
 
 	pm_runtime_get_sync(dp->dev);
 
@@ -1163,11 +1165,46 @@ static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
 		dp->plat_data->power_on(dp->plat_data);
 
 	phy_power_on(dp->phy);
-	analogix_dp_init_dp(dp);
+
+	ret = analogix_dp_init_dp(dp);
+	if (ret)
+		goto out_dp_init;
+
+	ret = analogix_dp_commit(dp);
+	if (ret)
+		goto out_dp_init;
+
 	enable_irq(dp->irq);
-	analogix_dp_commit(dp);
+	return 0;
 
-	dp->dpms_mode = DRM_MODE_DPMS_ON;
+out_dp_init:
+	phy_power_off(dp->phy);
+	if (dp->plat_data->power_off)
+		dp->plat_data->power_off(dp->plat_data);
+	pm_runtime_put_sync(dp->dev);
+
+	return ret;
+}
+
+static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
+{
+	struct analogix_dp_device *dp = bridge->driver_private;
+	int timeout_loop = 0;
+
+	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
+		return;
+
+	while (timeout_loop < MAX_PLL_LOCK_LOOP) {
+		if (analogix_dp_set_bridge(dp) == 0) {
+			dp->dpms_mode = DRM_MODE_DPMS_ON;
+			return;
+		}
+		dev_err(dp->dev, "failed to set bridge, retry: %d\n",
+			timeout_loop);
+		timeout_loop++;
+		usleep_range(10, 11);
+	}
+	dev_err(dp->dev, "too many times retry set bridge, give it up\n");
 }
 
 static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 403ff853464b..769255dc6e99 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -19,6 +19,7 @@
 #define DP_TIMEOUT_LOOP_COUNT 100
 #define MAX_CR_LOOP 5
 #define MAX_EQ_LOOP 5
+#define MAX_PLL_LOCK_LOOP 5
 
 /* Training takes 22ms if AUX channel comm fails. Use this as retry interval */
 #define DP_TIMEOUT_TRAINING_US			22000
@@ -197,7 +198,7 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 				       enum analog_power_block block,
 				       bool enable);
-void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
+int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
 void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index e78c861b9e06..b47c5af43560 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -333,7 +333,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 	}
 }
 
-void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
+int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 {
 	u32 reg;
 	int timeout_loop = 0;
@@ -355,7 +355,7 @@ void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 			timeout_loop++;
 			if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
 				dev_err(dp->dev, "failed to get pll lock status\n");
-				return;
+				return -ETIMEDOUT;
 			}
 			usleep_range(10, 20);
 		}
@@ -366,6 +366,7 @@ void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
 		| AUX_FUNC_EN_N);
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
+	return 0;
 }
 
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
-- 
2.14.1
