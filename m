Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeCEWYk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37600 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeCEWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:32 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 22/38] drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
Date: Mon,  5 Mar 2018 23:23:14 +0100
Message-Id: <20180305222324.5872-23-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

There is no register named ANALOGIX_DP_PLL_CTL in Rockchip edp phy reg
list.  We should use BIT_4 in ANALOGIX_DP_PD to control the pll power
instead of ANALOGIX_DP_PLL_CTL.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 7b7fd227e1f9..02ab1aaa9993 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -230,16 +230,20 @@ enum pll_status analogix_dp_get_pll_lock_status(struct analogix_dp_device *dp)
 void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable)
 {
 	u32 reg;
+	u32 mask = DP_PLL_PD;
+	u32 pd_addr = ANALOGIX_DP_PLL_CTL;
 
-	if (enable) {
-		reg = readl(dp->reg_base + ANALOGIX_DP_PLL_CTL);
-		reg |= DP_PLL_PD;
-		writel(reg, dp->reg_base + ANALOGIX_DP_PLL_CTL);
-	} else {
-		reg = readl(dp->reg_base + ANALOGIX_DP_PLL_CTL);
-		reg &= ~DP_PLL_PD;
-		writel(reg, dp->reg_base + ANALOGIX_DP_PLL_CTL);
+	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
+		pd_addr = ANALOGIX_DP_PD;
+		mask = RK_PLL_PD;
 	}
+
+	reg = readl(dp->reg_base + pd_addr);
+	if (enable)
+		reg |= mask;
+	else
+		reg &= ~mask;
+	writel(reg, dp->reg_base + pd_addr);
 }
 
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
-- 
2.16.1
