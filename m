Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755148AbeDWKvH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:51:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeDWKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:53 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, wzz@rock-chips.com,
        hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 17/27] drm/bridge: analogix_dp: Move fast link training detect to set_bridge
Date: Mon, 23 Apr 2018 12:49:53 +0200
Message-Id: <20180423105003.9004-18-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
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
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 .../drm/bridge/analogix/analogix_dp_core.c    | 42 ++++++++++++-------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a72e454a7292..69b2c16e5776 100644
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
@@ -996,6 +982,22 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
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
@@ -1038,8 +1040,16 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
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
2.17.0
