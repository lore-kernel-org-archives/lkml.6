Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeA3UgF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:36:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeA3U3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:45 -0500
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
Subject: [PATCH v3 21/43] drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
Date: Tue, 30 Jan 2018 21:28:51 +0100
Message-Id: <20180130202913.28724-22-thierry.escande@collabora.com>
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
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 9df92dc54dbe..846574d0dcb0 100644
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
@@ -944,8 +944,6 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	}
 
 	analogix_dp_enable_scramble(dp, 1);
-	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
-	analogix_dp_enable_enhanced_mode(dp, 1);
 
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
-- 
2.14.1
