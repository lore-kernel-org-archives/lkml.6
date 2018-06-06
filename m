Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AABA60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeFFTEg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:04:36 -0400
Received: from anholt.net ([50.246.234.109]:50096 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752265AbeFFTEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:04:35 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/3] drm/vc4: Make DSI call into the bridge after the DSI link is enabled.
Date: Wed,  6 Jun 2018 12:04:31 -0700
Message-Id: <20180606190431.1833-3-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606190431.1833-1-eric@anholt.net>
References: <20180606190431.1833-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows panels or bridges that need to send DSI commands during
pre_enable() to successfully send them.  We delay DISP0 (aka the
actual display) enabling until after pre_enable so that pixels aren't
streaming before then.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 37 +++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 8aa897835118..02cbfcc3cc4b 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -814,7 +814,9 @@ static void vc4_dsi_encoder_disable(struct drm_encoder *encoder)
 	struct vc4_dsi *dsi = vc4_encoder->dsi;
 	struct device *dev = &dsi->pdev->dev;
 
+	drm_bridge_disable(dsi->bridge);
 	vc4_dsi_ulps(dsi, true);
+	drm_bridge_post_disable(dsi->bridge);
 
 	clk_disable_unprepare(dsi->pll_phy_clock);
 	clk_disable_unprepare(dsi->escape_clock);
@@ -1089,21 +1091,6 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	/* Display reset sequence timeout */
 	DSI_PORT_WRITE(PR_TO_CNT, 100000);
 
-	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		DSI_PORT_WRITE(DISP0_CTRL,
-			       VC4_SET_FIELD(dsi->divider,
-					     DSI_DISP0_PIX_CLK_DIV) |
-			       VC4_SET_FIELD(dsi->format, DSI_DISP0_PFORMAT) |
-			       VC4_SET_FIELD(DSI_DISP0_LP_STOP_PERFRAME,
-					     DSI_DISP0_LP_STOP_CTRL) |
-			       DSI_DISP0_ST_END |
-			       DSI_DISP0_ENABLE);
-	} else {
-		DSI_PORT_WRITE(DISP0_CTRL,
-			       DSI_DISP0_COMMAND_MODE |
-			       DSI_DISP0_ENABLE);
-	}
-
 	/* Set up DISP1 for transferring long command payloads through
 	 * the pixfifo.
 	 */
@@ -1128,6 +1115,25 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 
 	vc4_dsi_ulps(dsi, false);
 
+	drm_bridge_pre_enable(dsi->bridge);
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		DSI_PORT_WRITE(DISP0_CTRL,
+			       VC4_SET_FIELD(dsi->divider,
+					     DSI_DISP0_PIX_CLK_DIV) |
+			       VC4_SET_FIELD(dsi->format, DSI_DISP0_PFORMAT) |
+			       VC4_SET_FIELD(DSI_DISP0_LP_STOP_PERFRAME,
+					     DSI_DISP0_LP_STOP_CTRL) |
+			       DSI_DISP0_ST_END |
+			       DSI_DISP0_ENABLE);
+	} else {
+		DSI_PORT_WRITE(DISP0_CTRL,
+			       DSI_DISP0_COMMAND_MODE |
+			       DSI_DISP0_ENABLE);
+	}
+
+	drm_bridge_enable(dsi->bridge);
+
 	if (debug_dump_regs) {
 		DRM_INFO("DSI regs after:\n");
 		vc4_dsi_dump_regs(dsi);
@@ -1639,6 +1645,7 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 		dev_err(dev, "bridge attach failed: %d\n", ret);
 		return ret;
 	}
+	dsi->bridge->disable_midlayer_calls = true;
 
 	pm_runtime_enable(dev);
 
-- 
2.17.0
