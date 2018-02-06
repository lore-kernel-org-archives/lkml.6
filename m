Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeBFIoF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:44:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751835AbeBFIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:43:58 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Philippe Cornu <philippe.cornu@st.com>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Sandy Huang" <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
Date: Tue, 6 Feb 2018 09:42:51 +0100
Message-ID: <20180206084251.303-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Synopsys DesignWare MIPI DSI version 1.31
Two registers need to be updated/added for supporting 1.31:
* PHY_TMR_CFG 0x9c (updated)
  1.30 [31:24] phy_hs2lp_time
       [23:16] phy_lp2hs_time
       [14: 0] max_rd_time

  1.31 [25:16] phy_hs2lp_time
       [ 9: 0] phy_lp2hs_time

* PHY_TMR_RD_CFG 0xf4 (new)
  1.31 [14: 0] max_rd_time

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
Modified in v2: Simplify the code thanks to comments from Andrzej Hajda &
Archit Taneja.

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index d2e5c026cd8c..4496687e6e67 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -25,7 +25,10 @@
 #include <drm/bridge/dw_mipi_dsi.h>
 #include <video/mipi_display.h>
 
+#define HWVER_131			0x31333100	/* IP version 1.31 */
+
 #define DSI_VERSION			0x00
+#define VERSION				GENMASK(31, 8)
 
 #define DSI_PWR_UP			0x04
 #define RESET				0
@@ -161,11 +164,12 @@
 #define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
 #define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
 
-/* TODO Next register is slightly different between 1.30 & 1.31 IP version */
 #define DSI_PHY_TMR_CFG			0x9c
 #define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
 #define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
 #define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
+#define PHY_HS2LP_TIME_V131(lbcc)	(((lbcc) & 0x3ff) << 16)
+#define PHY_LP2HS_TIME_V131(lbcc)	((lbcc) & 0x3ff)
 
 #define DSI_PHY_RSTZ			0xa0
 #define PHY_DISFORCEPLL			0
@@ -204,7 +208,9 @@
 #define DSI_INT_ST1			0xc0
 #define DSI_INT_MSK0			0xc4
 #define DSI_INT_MSK1			0xc8
+
 #define DSI_PHY_TMR_RD_CFG		0xf4
+#define MAX_RD_TIME_V131(lbcc)		((lbcc) & 0x7fff)
 
 #define PHY_STATUS_TIMEOUT_US		10000
 #define CMD_PKT_STATUS_TIMEOUT_US	20000
@@ -623,6 +629,8 @@ static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
 
 static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
 {
+	u32 hw_version;
+
 	/*
 	 * TODO dw drv improvements
 	 * data & clock lane timers should be computed according to panel
@@ -630,8 +638,17 @@ static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
 	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
 	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
 	 */
-	dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40)
-		  | PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
+
+	hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
+
+	if (hw_version >= HWVER_131) {
+		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V131(0x40) |
+			  PHY_LP2HS_TIME_V131(0x40));
+		dsi_write(dsi, DSI_PHY_TMR_RD_CFG, MAX_RD_TIME_V131(10000));
+	} else {
+		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40) |
+			  PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
+	}
 
 	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
 		  | PHY_CLKLP2HS_TIME(0x40));
-- 
2.15.1
