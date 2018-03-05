Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeCEWX4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:23:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeCEWXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:23:53 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 08/38] drm/rockchip: Only wait for panel ACK on PSR entry
Date: Mon,  5 Mar 2018 23:23:00 +0100
Message-Id: <20180305222324.5872-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

We currently wait for the panel to mirror our intended PSR state
before continuing on both PSR enter and PSR exit. This is really
only important to do when we're entering PSR, since we want to
be sure the last frame we pushed is being served from the panel's
internal fb before shutting down the soc blocks (vop/analogix).

This patch changes the behavior such that we only wait for the
panel to complete the PSR transition when we're entering PSR, and
to skip verification when we're exiting.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 5 ++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 806c3878b3d6..5a2e35dc41e3 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -125,7 +125,7 @@ int analogix_dp_enable_psr(struct analogix_dp_device *dp)
 	psr_vsc.DB0 = 0;
 	psr_vsc.DB1 = EDP_VSC_PSR_STATE_ACTIVE | EDP_VSC_PSR_CRC_VALUES_VALID;
 
-	return analogix_dp_send_psr_spd(dp, &psr_vsc);
+	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_enable_psr);
 
@@ -151,7 +151,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	if (ret != 1)
 		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
 
-	return analogix_dp_send_psr_spd(dp, &psr_vsc);
+	return analogix_dp_send_psr_spd(dp, &psr_vsc, false);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_disable_psr);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 920607d7eb3e..6a96ef7e6934 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -253,7 +253,7 @@ void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp);
 int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
-			     struct edp_vsc_psr *vsc);
+			     struct edp_vsc_psr *vsc, bool blocking);
 ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			     struct drm_dp_aux_msg *msg);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 005a3f7005d2..9df2f3ef000c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1007,7 +1007,7 @@ static ssize_t analogix_dp_get_psr_status(struct analogix_dp_device *dp)
 }
 
 int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
-			     struct edp_vsc_psr *vsc)
+			     struct edp_vsc_psr *vsc, bool blocking)
 {
 	unsigned int val;
 	int ret;
@@ -1053,6 +1053,9 @@ int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
 	val |= IF_EN;
 	writel(val, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
 
+	if (!blocking)
+		return 0;
+
 	ret = readx_poll_timeout(analogix_dp_get_psr_status, dp, psr_status,
 		psr_status >= 0 &&
 		((vsc->DB1 && psr_status == DP_PSR_SINK_ACTIVE_RFB) ||
-- 
2.16.1
