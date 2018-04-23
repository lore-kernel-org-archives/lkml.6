Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbeDWK7A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:59:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754729AbeDWKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:19 -0400
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
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 01/27] drm/bridge: analogix_dp: Move enable video into config_video()
Date: Mon, 23 Apr 2018 12:49:37 +0200
Message-Id: <20180423105003.9004-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

We need to enable video before analogix_dp_is_video_stream_on(), so
we can get the right video stream status.

We needed to increase the delay in the timeout loop because there is
random "Timeout of video streamclk ok" message happen when debug edp
panel, this time do not define in the spec.

Cc: 征增 王 <wzz@rock-chips.com>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5c52307146c7..05a0ca4af057 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -819,11 +819,10 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 		if (analogix_dp_is_slave_video_stream_clock_on(dp) == 0)
 			break;
 		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
-			dev_err(dp->dev, "Timeout of video streamclk ok\n");
+			dev_err(dp->dev, "Timeout of slave video streamclk ok\n");
 			return -ETIMEDOUT;
 		}
-
-		usleep_range(1, 2);
+		usleep_range(1000, 1001);
 	}
 
 	/* Set to use the register calculated M/N video */
@@ -838,6 +837,9 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 	/* Configure video slave mode */
 	analogix_dp_enable_video_master(dp, 0);
 
+	/* Enable video */
+	analogix_dp_start_video(dp);
+
 	timeout_loop = 0;
 
 	for (;;) {
@@ -948,9 +950,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 			DRM_ERROR("failed to enable the panel\n");
 	}
 
-	/* Enable video */
-	analogix_dp_start_video(dp);
-
 	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
 	if (dp->psr_enable)
 		analogix_dp_enable_sink_psr(dp);
-- 
2.17.0
