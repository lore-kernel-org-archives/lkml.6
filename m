Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755250AbeDWKy4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:54:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755092AbeDWKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:57 -0400
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
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 19/27] drm/bridge: analogix_dp: Properly log AUX CH errors
Date: Mon, 23 Apr 2018 12:49:55 +0200
Message-Id: <20180423105003.9004-20-enric.balletbo@collabora.com>
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

The code in analogix_dp_transfer() that was supposed to print out:
  AUX CH error happened

Was actually dead code. That's because the previous check (whether
the interrupt status indicated any errors) would have hit for all
errors anyway.

Let's combine the two error checks so we can actually see AUX CH
errors.  We'll also downgrade the message to a warning since some of
these types of errors might be expected for some displays.  If this
gets too noisy we can downgrade again to debug.

Cc: 征增 王 <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 4eae206ec31b..58e8a28e99aa 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1105,6 +1105,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			     struct drm_dp_aux_msg *msg)
 {
 	u32 reg;
+	u32 status_reg;
 	u8 *buffer = msg->buffer;
 	unsigned int i;
 	int num_transferred = 0;
@@ -1193,16 +1194,12 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 
 	/* Clear interrupt source for AUX CH access error */
 	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-	if (reg & AUX_ERR) {
+	status_reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_STA);
+	if ((reg & AUX_ERR) || (status_reg & AUX_STATUS_MASK)) {
 		writel(AUX_ERR, dp->reg_base + ANALOGIX_DP_INT_STA);
-		goto aux_error;
-	}
 
-	/* Check AUX CH error access status */
-	reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_STA);
-	if ((reg & AUX_STATUS_MASK)) {
-		dev_err(dp->dev, "AUX CH error happened: %d\n\n",
-			reg & AUX_STATUS_MASK);
+		dev_warn(dp->dev, "AUX CH error happened: %#x (%d)\n",
+			 status_reg & AUX_STATUS_MASK, !!(reg & AUX_ERR));
 		goto aux_error;
 	}
 
-- 
2.17.0
