Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeA3U3v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeA3U3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:49 -0500
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
Subject: [PATCH v3 26/43] drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
Date: Tue, 30 Jan 2018 21:28:56 +0100
Message-Id: <20180130202913.28724-27-thierry.escande@collabora.com>
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

There is no register named ANALOGIX_DP_PLL_CTL in Rockchip edp phy reg
list.  We should use BIT_4 in ANALOGIX_DP_PD to control the pll power
instead of ANALOGIX_DP_PLL_CTL.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
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
2.14.1
