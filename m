Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeCEWY2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37538 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbeCEWYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:23 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 19/38] drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
Date: Mon,  5 Mar 2018 23:23:11 +0100
Message-Id: <20180305222324.5872-20-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

There are some different bits between Rockchip and Exynos in register
"AUX_PD". This patch fixes the incorrect operations about it.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 117 ++++++++++++----------
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |   2 +
 2 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index bb72f8b0e603..dee1ba109b5f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -248,76 +248,85 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 {
 	u32 reg;
 	u32 phy_pd_addr = ANALOGIX_DP_PHY_PD;
+	u32 mask;
 
 	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
 		phy_pd_addr = ANALOGIX_DP_PD;
 
 	switch (block) {
 	case AUX_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= AUX_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~AUX_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+			mask = RK_AUX_PD;
+		else
+			mask = AUX_PD;
+
+		reg = readl(dp->reg_base + phy_pd_addr);
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH0_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH0_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH0_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH0_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH1_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH1_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH1_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH1_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH2_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH2_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH2_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH2_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case CH3_BLOCK:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= CH3_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~CH3_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		mask = CH3_PD;
+		reg = readl(dp->reg_base + phy_pd_addr);
+
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		writel(reg, dp->reg_base + phy_pd_addr);
 		break;
 	case ANALOG_TOTAL:
-		if (enable) {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg |= DP_PHY_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		} else {
-			reg = readl(dp->reg_base + phy_pd_addr);
-			reg &= ~DP_PHY_PD;
-			writel(reg, dp->reg_base + phy_pd_addr);
-		}
+		/*
+		 * There is no bit named DP_PHY_PD, so We used DP_INC_BG
+		 * to power off everything instead of DP_PHY_PD in
+		 * Rockchip
+		 */
+		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+			mask = DP_INC_BG;
+		else
+			mask = DP_PHY_PD;
+
+		reg = readl(dp->reg_base + phy_pd_addr);
+		if (enable)
+			reg |= mask;
+		else
+			reg &= ~mask;
+
+		writel(reg, dp->reg_base + phy_pd_addr);
+		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+			usleep_range(10, 15);
 		break;
 	case POWER_ALL:
 		if (enable) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
index 9602668669f4..b633a4a5082a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
@@ -345,7 +345,9 @@
 #define DP_INC_BG				(0x1 << 7)
 #define DP_EXP_BG				(0x1 << 6)
 #define DP_PHY_PD				(0x1 << 5)
+#define RK_AUX_PD				(0x1 << 5)
 #define AUX_PD					(0x1 << 4)
+#define RK_PLL_PD				(0x1 << 4)
 #define CH3_PD					(0x1 << 3)
 #define CH2_PD					(0x1 << 2)
 #define CH1_PD					(0x1 << 1)
-- 
2.16.1
