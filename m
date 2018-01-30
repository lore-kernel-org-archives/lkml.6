Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeA3UeM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:34:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeA3U3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:52 -0500
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
Subject: [PATCH v3 29/43] drm/bridge: analogix_dp: Move fast link training detect to set_bridge
Date: Tue, 30 Jan 2018 21:28:59 +0100
Message-Id: <20180130202913.28724-30-thierry.escande@collabora.com>
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

It's too early to detect fast link training, if other step after it
failed, we will set fast_link flag to 1, and retry set_bridge again. In
this case we will power down and power up panel power supply, and we
will do fast link training since we have set fast_link flag to 1. In
fact, we should do full link training now, not the fast link training.
So we should move the fast link detection at the end of set_bridge.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 42 +++++++++++++---------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a64f0c3e795c..f82e2a3d13bf 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -601,7 +601,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 {
 	int lane, lane_count, retval;
 	u32 reg;
-	u8 link_align, link_status[2], adjust_request[2], spread;
+	u8 link_align, link_status[2], adjust_request[2];
 
 	usleep_range(400, 401);
 
@@ -645,20 +645,6 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 		dev_dbg(dp->dev, "final lane count = %.2x\n",
 			dp->link_train.lane_count);
 
-		retval = drm_dp_dpcd_readb(&dp->aux, DP_MAX_DOWNSPREAD,
-					   &spread);
-		if (retval != 1) {
-			dev_err(dp->dev, "failed to read downspread %d\n",
-				retval);
-			dp->fast_train_enable = false;
-		} else {
-			dp->fast_train_enable =
-				(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING) ?
-					true : false;
-		}
-		dev_dbg(dp->dev, "fast link training %s\n",
-			dp->fast_train_enable ? "supported" : "unsupported");
-
 		dp->link_train.lt_state = FINISHED;
 
 		return 0;
@@ -1003,6 +989,22 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int analogix_dp_fast_link_train_detection(struct analogix_dp_device *dp)
+{
+	int ret;
+	u8 spread;
+
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_MAX_DOWNSPREAD, &spread);
+	if (ret != 1) {
+		dev_err(dp->dev, "failed to read downspread %d\n", ret);
+		return ret;
+	}
+	dp->fast_train_enable = !!(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+	dev_dbg(dp->dev, "fast link training %s\n",
+		dp->fast_train_enable ? "supported" : "unsupported");
+	return 0;
+}
+
 static int analogix_dp_commit(struct analogix_dp_device *dp)
 {
 	int ret;
@@ -1045,8 +1047,16 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	if (ret)
 		return ret;
 
-	if (dp->psr_enable)
+	if (dp->psr_enable) {
 		ret = analogix_dp_enable_sink_psr(dp);
+		if (ret)
+			return ret;
+	}
+
+	/* Check whether panel supports fast training */
+	ret =  analogix_dp_fast_link_train_detection(dp);
+	if (ret)
+		dp->psr_enable = false;
 
 	return ret;
 }
-- 
2.14.1
