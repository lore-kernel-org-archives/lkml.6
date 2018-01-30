Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeA3U37 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbeA3U3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:55 -0500
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
Subject: [PATCH v3 32/43] drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
Date: Tue, 30 Jan 2018 21:29:02 +0100
Message-Id: <20180130202913.28724-33-thierry.escande@collabora.com>
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

From: Douglas Anderson <dianders@chromium.org>

The comments in analogix_dp_init_aux() claim that we're disabling aux
channel retries, but then right below it for Rockchip it sets them to
3.  If we actually need 3 retries for Rockchip then we could adjust
the comment, but it seems more likely that we want the same retry
behavior across all platforms.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: 征增 王 <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 58e8a28e99aa..a5f2763d72e4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -481,15 +481,16 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
 
 	analogix_dp_reset_aux(dp);
 
-	/* Disable AUX transaction H/W retry */
+	/* AUX_BIT_PERIOD_EXPECTED_DELAY doesn't apply to Rockchip IP */
 	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
-		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(0) |
-		      AUX_HW_RETRY_COUNT_SEL(3) |
-		      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+		reg = 0;
 	else
-		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) |
-		      AUX_HW_RETRY_COUNT_SEL(0) |
-		      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3);
+
+	/* Disable AUX transaction H/W retry */
+	reg |= AUX_HW_RETRY_COUNT_SEL(0) |
+	       AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+
 	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_HW_RETRY_CTL);
 
 	/* Receive AUX Channel DEFER commands equal to DEFFER_COUNT*64 */
-- 
2.14.1
