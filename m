Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E7AC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0C2250E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F0C2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeFUXSC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:18:02 -0400
Received: from anholt.net ([50.246.234.109]:58966 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbeFUXSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:18:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0A29D10A1633;
        Thu, 21 Jun 2018 16:18:01 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id YSLZr7AWszb2; Thu, 21 Jun 2018 16:17:59 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id ABE0010A0D3A;
        Thu, 21 Jun 2018 16:17:59 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 0CC8A2FE21D0; Thu, 21 Jun 2018 16:17:59 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v2] drm/vc4: Make DSI call into the bridge after the DSI link is enabled.
Date:   Thu, 21 Jun 2018 16:17:59 -0700
Message-Id: <20180621231759.29604-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows panels or bridges that need to send DSI commands during
pre_enable() to successfully send them.  We delay DISP0 (aka the
actual display) enabling until after pre_enable so that pixels aren't
streaming before then.

v2: Just clear out the encoder->bridge value to disable the midlayer
    calls (idea by Andrzej Hajda).

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 8aa897835118..9c8e89372d1c 100644
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
@@ -1639,6 +1645,12 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 		dev_err(dev, "bridge attach failed: %d\n", ret);
 		return ret;
 	}
+	/* Disable the atomic helper calls into the bridge.  We
+	 * manually call the bridge pre_enable / enable / etc. calls
+	 * from our driver, since we need to sequence them within the
+	 * encoder's enable/disable paths.
+	 */
+	dsi->encoder->bridge = NULL;
 
 	pm_runtime_enable(dev);
 
-- 
2.18.0.rc2

