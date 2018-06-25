Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC8CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB72588C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCB72588C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeFYMFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:05:12 -0400
Received: from mailoutvs51.siol.net ([185.57.226.242]:47924 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933481AbeFYMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 85C755208BD;
        Mon, 25 Jun 2018 14:05:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id laTB5BOk4hU8; Mon, 25 Jun 2018 14:05:07 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E68105208B6;
        Mon, 25 Jun 2018 14:05:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 04DAD5208BD;
        Mon, 25 Jun 2018 14:05:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if they don't have channel 0
Date:   Mon, 25 Jun 2018 14:02:49 +0200
Message-Id: <20180625120304.7543-10-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
Because of that, all output endpoints on such TCON node will point to a
encoder which is part of component framework.

Correct current graph traversing algorithm in such way that it doesn't
skip output enpoints with id 0 on TV TCONs.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 52 +++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e6c62c079146..6ddf4eaccb40 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -198,6 +198,22 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)
 	return !!of_match_node(sun4i_tcon_of_table, node);
 }
 
+static bool sun4i_drv_node_is_tcon_with_ch0(struct device_node *node)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(sun4i_tcon_of_table, node);
+	if (match) {
+		struct sun4i_tcon_quirks *quirks;
+
+		quirks = (struct sun4i_tcon_quirks *)match->data;
+
+		return quirks->has_channel_0;
+	}
+
+	return false;
+}
+
 static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 {
 	return !!of_match_node(sun8i_tcon_top_of_table, node);
@@ -256,14 +272,7 @@ static void sun4i_drv_traverse_endpoints(struct endpoint_list *list,
 			continue;
 		}
 
-		/*
-		 * If the node is our TCON, the first port is used for
-		 * panel or bridges, and will not be part of the
-		 * component framework.
-		 */
 		if (sun4i_drv_node_is_tcon(node)) {
-			struct of_endpoint endpoint;
-
 			/*
 			 * TCON TOP is always probed before TCON. However, TCON
 			 * points back to TCON TOP when it is source for HDMI.
@@ -276,16 +285,25 @@ static void sun4i_drv_traverse_endpoints(struct endpoint_list *list,
 				continue;
 			}
 
-			if (of_graph_parse_endpoint(ep, &endpoint)) {
-				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
-				of_node_put(remote);
-				continue;
-			}
-
-			if (!endpoint.id) {
-				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
-				of_node_put(remote);
-				continue;
+			/*
+			 * If the node is our TCON with channel 0, the first
+			 * port is used for panel or bridges, and will not be
+			 * part of the component framework.
+			 */
+			if (sun4i_drv_node_is_tcon_with_ch0(node)) {
+				struct of_endpoint endpoint;
+
+				if (of_graph_parse_endpoint(ep, &endpoint)) {
+					DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+					of_node_put(remote);
+					continue;
+				}
+
+				if (!endpoint.id) {
+					DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+					of_node_put(remote);
+					continue;
+				}
 			}
 		}
 
-- 
2.18.0

