Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeA3Ue2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:34:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56412 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbeA3U3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:52 -0500
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
Subject: [PATCH v3 28/43] drm/bridge: analogix_dp: Fix incorrect operations with register ANALOGIX_DP_FUNC_EN_1
Date: Tue, 30 Jan 2018 21:28:58 +0100
Message-Id: <20180130202913.28724-29-thierry.escande@collabora.com>
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
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 19 ++++++++++++++-----
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |  2 ++
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
2.14.1
