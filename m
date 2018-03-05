Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeCEWY4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbeCEWYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:53 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 28/38] drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
Date: Mon,  5 Mar 2018 23:23:20 +0100
Message-Id: <20180305222324.5872-29-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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
2.16.1
