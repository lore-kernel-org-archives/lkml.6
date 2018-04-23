Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755131AbeDWKvD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:51:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38874 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755032AbeDWKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:51 -0400
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
Subject: [RESEND PATCH v6 16/27] drm/bridge: analogix_dp: Fix incorrect operations with register ANALOGIX_DP_FUNC_EN_1
Date: Mon, 23 Apr 2018 12:49:52 +0200
Message-Id: <20180423105003.9004-17-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

Register ANALOGIX_DP_FUNC_EN_1(offset 0x18), Rockchip is different to
Exynos:

on Exynos edp phy,
BIT 7		MASTER_VID_FUNC_EN_N
BIT 6		reserved
BIT 5		SLAVE_VID_FUNC_EN_N

on Rockchip edp phy,
BIT 7		reserved
BIT 6		RK_VID_CAP_FUNC_EN_N
BIT 5		RK_VID_FIFO_FUNC_EN_N

So, we should do some private operations to Rockchip.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 19 ++++++++++++++-----
 .../gpu/drm/bridge/analogix/analogix_dp_reg.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 02ab1aaa9993..4eae206ec31b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -126,9 +126,14 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
 	analogix_dp_stop_video(dp);
 	analogix_dp_enable_video_mute(dp, 0);
 
-	reg = MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N |
-		AUD_FIFO_FUNC_EN_N | AUD_FUNC_EN_N |
-		HDCP_FUNC_EN_N | SW_FUNC_EN_N;
+	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+		reg = RK_VID_CAP_FUNC_EN_N | RK_VID_FIFO_FUNC_EN_N |
+			SW_FUNC_EN_N;
+	else
+		reg = MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N |
+			AUD_FIFO_FUNC_EN_N | AUD_FUNC_EN_N |
+			HDCP_FUNC_EN_N | SW_FUNC_EN_N;
+
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 
 	reg = SSC_FUNC_EN_N | AUX_FUNC_EN_N |
@@ -971,8 +976,12 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
 	u32 reg;
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
-	reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
-	reg |= MASTER_VID_FUNC_EN_N;
+	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
+		reg &= ~(RK_VID_CAP_FUNC_EN_N | RK_VID_FIFO_FUNC_EN_N);
+	} else {
+		reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
+		reg |= MASTER_VID_FUNC_EN_N;
+	}
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
index b633a4a5082a..0cf27c731727 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
@@ -127,7 +127,9 @@
 
 /* ANALOGIX_DP_FUNC_EN_1 */
 #define MASTER_VID_FUNC_EN_N			(0x1 << 7)
+#define RK_VID_CAP_FUNC_EN_N			(0x1 << 6)
 #define SLAVE_VID_FUNC_EN_N			(0x1 << 5)
+#define RK_VID_FIFO_FUNC_EN_N			(0x1 << 5)
 #define AUD_FIFO_FUNC_EN_N			(0x1 << 4)
 #define AUD_FUNC_EN_N				(0x1 << 3)
 #define HDCP_FUNC_EN_N				(0x1 << 2)
-- 
2.17.0
