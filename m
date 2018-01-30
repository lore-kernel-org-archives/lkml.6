Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeA3Uev (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:34:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeA3U3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:51 -0500
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
Subject: [PATCH v3 27/43] drm/bridge: analogix_dp: Fix timeout of video streamclk config
Date: Tue, 30 Jan 2018 21:28:57 +0100
Message-Id: <20180130202913.28724-28-thierry.escande@collabora.com>
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
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e925c62eaadb..a64f0c3e795c 100644
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
2.14.1
