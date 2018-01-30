Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeA3U35 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56464 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeA3U3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:54 -0500
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
Subject: [PATCH v3 31/43] drm/bridge: analogix_dp: Properly log AUX CH errors
Date: Tue, 30 Jan 2018 21:29:01 +0100
Message-Id: <20180130202913.28724-32-thierry.escande@collabora.com>
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
2.14.1
