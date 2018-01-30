Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbeA3Uhm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:37:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56168 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeA3U3k (ORCPT
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
Subject: [PATCH v3 15/43] drm/bridge: analogix_dp: Don't use fast link training when panel just powered up
Date: Tue, 30 Jan 2018 21:28:45 +0100
Message-Id: <20180130202913.28724-16-thierry.escande@collabora.com>
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

Panel would reset its setting when it powers down. It would forget the last
succeeded link training setting. So we can't use the last successful link
training setting to do fast link training. Let's reset fast_train_enable in
analogix_dp_bridge_disable();

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 +++++----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8ef9e31c6713..179c2106b8a2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -579,14 +579,14 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 		if (retval != 1) {
 			dev_err(dp->dev, "failed to read downspread %d\n",
 				retval);
-			dp->fast_train_support = false;
+			dp->fast_train_enable = false;
 		} else {
-			dp->fast_train_support =
+			dp->fast_train_enable =
 				(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING) ?
 					true : false;
 		}
 		dev_dbg(dp->dev, "fast link training %s\n",
-			dp->fast_train_support ? "supported" : "unsupported");
+			dp->fast_train_enable ? "supported" : "unsupported");
 
 		/* set enhanced mode if available */
 		analogix_dp_set_enhanced_mode(dp);
@@ -793,7 +793,7 @@ static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 
 static int analogix_dp_train_link(struct analogix_dp_device *dp)
 {
-	if (dp->fast_train_support)
+	if (dp->fast_train_enable)
 		return analogix_dp_fast_link_train(dp);
 
 	return analogix_dp_full_link_train(dp, dp->video_info.max_lane_count,
@@ -1198,6 +1198,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
 
 	dp->psr_enable = false;
+	dp->fast_train_enable = false;
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 6a96ef7e6934..403ff853464b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -173,7 +173,7 @@ struct analogix_dp_device {
 	int			hpd_gpio;
 	bool                    force_hpd;
 	bool			psr_enable;
-	bool			fast_train_support;
+	bool			fast_train_enable;
 
 	struct mutex		panel_lock;
 	bool			panel_is_modeset;
-- 
2.14.1
