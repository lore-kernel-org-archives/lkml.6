Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeCEWYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbeCEWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:36 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 23/38] drm/bridge: analogix_dp: Fix timeout of video streamclk config
Date: Mon,  5 Mar 2018 23:23:15 +0100
Message-Id: <20180305222324.5872-24-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

The STRM_VALID bit in register ANALOGIX_DP_SYS_CTL_3 may be unstable,
so we may hit the error log "Timeout of video streamclk ok" since
checked this unstable bit.
In fact, we can go continue and the streamclk is ok if we wait enough time,
it does no effect on display.
Let's change this error to warn.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index c93a0d125b87..2493a580e655 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -921,8 +921,9 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 			done_count = 0;
 		}
 		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
-			dev_err(dp->dev, "Timeout of video streamclk ok\n");
-			return -ETIMEDOUT;
+			dev_warn(dp->dev,
+				 "Ignoring timeout of video streamclk ok\n");
+			break;
 		}
 
 		usleep_range(1000, 1001);
-- 
2.16.1
