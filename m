Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755173AbeDWKvJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:51:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38994 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755107AbeDWKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:59 -0400
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
Subject: [RESEND PATCH v6 20/27] drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
Date: Mon, 23 Apr 2018 12:49:56 +0200
Message-Id: <20180423105003.9004-21-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
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
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
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
2.17.0
