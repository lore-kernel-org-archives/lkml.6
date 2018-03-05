Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeCEWYA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeCEWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:23:58 -0500
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
Subject: [PATCH v4 10/38] drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
Date: Mon,  5 Mar 2018 23:23:02 +0100
Message-Id: <20180305222324.5872-11-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

We should check AUX_EN bit to confirm the AUX CH operation is completed.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 25 +++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 9df2f3ef000c..e78c861b9e06 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1073,9 +1073,9 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 {
 	u32 reg;
 	u8 *buffer = msg->buffer;
-	int timeout_loop = 0;
 	unsigned int i;
 	int num_transferred = 0;
+	int ret;
 
 	/* Buffer size of AUX CH is 16 bytes */
 	if (WARN_ON(msg->size > 16))
@@ -1139,17 +1139,20 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 
 	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
 
-	/* Is AUX CH command reply received? */
+	ret = readx_poll_timeout(readl, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2,
+				 reg, !(reg & AUX_EN), 25, 500 * 1000);
+	if (ret) {
+		dev_err(dp->dev, "AUX CH enable timeout!\n");
+		return -ETIMEDOUT;
+	}
+
 	/* TODO: Wait for an interrupt instead of looping? */
-	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-	while (!(reg & RPLY_RECEIV)) {
-		timeout_loop++;
-		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
-			dev_err(dp->dev, "AUX CH command reply failed!\n");
-			return -ETIMEDOUT;
-		}
-		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-		usleep_range(10, 11);
+	/* Is AUX CH command reply received? */
+	ret = readx_poll_timeout(readl, dp->reg_base + ANALOGIX_DP_INT_STA,
+				 reg, reg & RPLY_RECEIV, 10, 20 * 1000);
+	if (ret) {
+		dev_err(dp->dev, "AUX CH cmd reply timeout!\n");
+		return -ETIMEDOUT;
 	}
 
 	/* Clear interrupt source for AUX CH command reply */
-- 
2.16.1
