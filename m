Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeA3UiA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:38:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeA3U3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:39 -0500
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
Subject: [PATCH v3 14/43] drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
Date: Tue, 30 Jan 2018 21:28:44 +0100
Message-Id: <20180130202913.28724-15-thierry.escande@collabora.com>
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

From: Lin Huang <hl@rock-chips.com>

We should check AUX_EN bit to confirm the AUX CH operation is completed.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
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
2.14.1
