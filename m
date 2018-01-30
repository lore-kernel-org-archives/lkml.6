Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeA3Ujq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:39:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeA3U3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:33 -0500
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
Subject: [PATCH v3 07/43] drm/bridge: analogix_dp: detect Sink PSR state after configuring the PSR
Date: Tue, 30 Jan 2018 21:28:37 +0100
Message-Id: <20180130202913.28724-8-thierry.escande@collabora.com>
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

From: Yakir Yang <ykk@rock-chips.com>

Make sure the request PSR state takes effect in analogix_dp_send_psr_spd()
function, or print the sink PSR error state if we failed to apply the
requested PSR setting.

Cc: 征增 王 <wzz@rock-chips.com>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
[seanpaul changed timeout loop to a readx poll]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  6 ++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  6 ++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 35 +++++++++++++++++++---
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 1477ea9ba85d..b52de046f5f1 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -122,8 +122,7 @@ int analogix_dp_enable_psr(struct analogix_dp_device *dp)
 	psr_vsc.DB0 = 0;
 	psr_vsc.DB1 = EDP_VSC_PSR_STATE_ACTIVE | EDP_VSC_PSR_CRC_VALUES_VALID;
 
-	analogix_dp_send_psr_spd(dp, &psr_vsc);
-	return 0;
+	return analogix_dp_send_psr_spd(dp, &psr_vsc);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_enable_psr);
 
@@ -149,8 +148,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	if (ret != 1)
 		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
 
-	analogix_dp_send_psr_spd(dp, &psr_vsc);
-	return 0;
+	return analogix_dp_send_psr_spd(dp, &psr_vsc);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_disable_psr);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 5c6a28806129..b039b28d8fcc 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -20,6 +20,8 @@
 #define MAX_CR_LOOP 5
 #define MAX_EQ_LOOP 5
 
+#define DP_TIMEOUT_PSR_LOOP_MS			300
+
 /* DP_MAX_LANE_COUNT */
 #define DPCD_ENHANCED_FRAME_CAP(x)		(((x) >> 7) & 0x1)
 #define DPCD_MAX_LANE_COUNT(x)			((x) & 0x1f)
@@ -247,8 +249,8 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp);
 void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp);
-void analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
-			      struct edp_vsc_psr *vsc);
+int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
+			     struct edp_vsc_psr *vsc);
 ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			     struct drm_dp_aux_msg *msg);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 303083ad28e3..005a3f7005d2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -10,10 +10,11 @@
  * option) any later version.
  */
 
-#include <linux/device.h>
-#include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
 
 #include <drm/bridge/analogix_dp.h>
 
@@ -992,10 +993,25 @@ void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp)
 	writel(PSR_VID_CRC_ENABLE, dp->reg_base + ANALOGIX_DP_CRC_CON);
 }
 
-void analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
-			      struct edp_vsc_psr *vsc)
+static ssize_t analogix_dp_get_psr_status(struct analogix_dp_device *dp)
+{
+	ssize_t val;
+	u8 status;
+
+	val = drm_dp_dpcd_readb(&dp->aux, DP_PSR_STATUS, &status);
+	if (val < 0) {
+		dev_err(dp->dev, "PSR_STATUS read failed ret=%zd", val);
+		return val;
+	}
+	return status;
+}
+
+int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
+			     struct edp_vsc_psr *vsc)
 {
 	unsigned int val;
+	int ret;
+	ssize_t psr_status;
 
 	/* don't send info frame */
 	val = readl(dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
@@ -1036,6 +1052,17 @@ void analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
 	val = readl(dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
 	val |= IF_EN;
 	writel(val, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
+
+	ret = readx_poll_timeout(analogix_dp_get_psr_status, dp, psr_status,
+		psr_status >= 0 &&
+		((vsc->DB1 && psr_status == DP_PSR_SINK_ACTIVE_RFB) ||
+		(!vsc->DB1 && psr_status == DP_PSR_SINK_INACTIVE)), 1500,
+		DP_TIMEOUT_PSR_LOOP_MS * 1000);
+	if (ret) {
+		dev_warn(dp->dev, "Failed to apply PSR %d\n", ret);
+		return ret;
+	}
+	return 0;
 }
 
 ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
-- 
2.14.1
