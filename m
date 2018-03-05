Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeCEW16 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:27:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37490 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbeCEWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:17 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 17/38] drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
Date: Mon,  5 Mar 2018 23:23:09 +0100
Message-Id: <20180305222324.5872-18-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

Enhanced mode is required by the eDP 1.2 specification, and not doing it
early could result in a period of time where we have a link transmitting
idle packets without it. Since there is no reason to disable it, we just
enable it at the beginning of link training and then keep it on all the
time.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 0ff151f741a3..5489570ef010 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -281,6 +281,8 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	retval = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, 2);
 	if (retval < 0)
 		return retval;
+	/* set enhanced mode if available */
+	analogix_dp_set_enhanced_mode(dp);
 
 	/* Set TX pre-emphasis to minimum */
 	for (lane = 0; lane < lane_count; lane++)
@@ -593,8 +595,6 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 		dev_dbg(dp->dev, "fast link training %s\n",
 			dp->fast_train_enable ? "supported" : "unsupported");
 
-		/* set enhanced mode if available */
-		analogix_dp_set_enhanced_mode(dp);
 		dp->link_train.lt_state = FINISHED;
 
 		return 0;
@@ -940,8 +940,6 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	}
 
 	analogix_dp_enable_scramble(dp, 1);
-	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
-	analogix_dp_enable_enhanced_mode(dp, 1);
 
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
-- 
2.16.1
