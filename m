Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeA3Ugr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:36:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeA3U3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:41 -0500
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
Subject: [PATCH v3 18/43] drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
Date: Tue, 30 Jan 2018 21:28:48 +0100
Message-Id: <20180130202913.28724-19-thierry.escande@collabora.com>
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

From: zain wang <wzz@rock-chips.com>

Following the correct power up sequence:
dp_pd=ff => dp_pd=7f => wait 10us => dp_pd=00

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 10 ++++++++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index b47c5af43560..bb72f8b0e603 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -321,10 +321,16 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 		break;
 	case POWER_ALL:
 		if (enable) {
-			reg = DP_PHY_PD | AUX_PD | CH3_PD | CH2_PD |
-				CH1_PD | CH0_PD;
+			reg = DP_ALL_PD;
 			writel(reg, dp->reg_base + phy_pd_addr);
 		} else {
+			reg = DP_ALL_PD;
+			writel(reg, dp->reg_base + phy_pd_addr);
+			usleep_range(10, 15);
+			reg &= ~DP_INC_BG;
+			writel(reg, dp->reg_base + phy_pd_addr);
+			usleep_range(10, 15);
+
 			writel(0x00, dp->reg_base + phy_pd_addr);
 		}
 		break;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
index 40200c652533..9602668669f4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
@@ -342,12 +342,15 @@
 #define DP_PLL_REF_BIT_1_2500V			(0x7 << 0)
 
 /* ANALOGIX_DP_PHY_PD */
+#define DP_INC_BG				(0x1 << 7)
+#define DP_EXP_BG				(0x1 << 6)
 #define DP_PHY_PD				(0x1 << 5)
 #define AUX_PD					(0x1 << 4)
 #define CH3_PD					(0x1 << 3)
 #define CH2_PD					(0x1 << 2)
 #define CH1_PD					(0x1 << 1)
 #define CH0_PD					(0x1 << 0)
+#define DP_ALL_PD				(0xff)
 
 /* ANALOGIX_DP_PHY_TEST */
 #define MACRO_RST				(0x1 << 5)
-- 
2.14.1
