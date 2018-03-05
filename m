Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeCEWYM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:24:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeCEWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:09 -0500
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
Subject: [PATCH v4 14/38] drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
Date: Mon,  5 Mar 2018 23:23:06 +0100
Message-Id: <20180305222324.5872-15-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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
2.16.1
