Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D468C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B51258BF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B51258BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933716AbeFYMJv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:09:51 -0400
Received: from mailoutvs7.siol.net ([185.57.226.198]:47899 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932569AbeFYMFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7F3245208B7;
        Mon, 25 Jun 2018 14:05:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zm2etHNEgNJv; Mon, 25 Jun 2018 14:05:04 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id F24B95208B6;
        Mon, 25 Jun 2018 14:05:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 37DDA5208B7;
        Mon, 25 Jun 2018 14:05:01 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 08/24] drm/sun4i: Add support for traversing graph with TCON TOP
Date:   Mon, 25 Jun 2018 14:02:48 +0200
Message-Id: <20180625120304.7543-9-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON TOP is different from other nodes in graph by having 3 input and 3
output ports. Additionally, connection to TV TCON might lead back to
HDMI mux input port, creating loops.

Add support for traversing such graph.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 20193d6f33ba..e6c62c079146 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -26,6 +26,7 @@
 #include "sun4i_frontend.h"
 #include "sun4i_framebuffer.h"
 #include "sun4i_tcon.h"
+#include "sun8i_tcon_top.h"
 
 DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
 
@@ -197,6 +198,11 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)
 	return !!of_match_node(sun4i_tcon_of_table, node);
 }
 
+static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
+{
+	return !!of_match_node(sun8i_tcon_top_of_table, node);
+}
+
 static int compare_of(struct device *dev, void *data)
 {
 	DRM_DEBUG_DRIVER("Comparing of node %pOF with %pOF\n",
@@ -258,6 +264,18 @@ static void sun4i_drv_traverse_endpoints(struct endpoint_list *list,
 		if (sun4i_drv_node_is_tcon(node)) {
 			struct of_endpoint endpoint;
 
+			/*
+			 * TCON TOP is always probed before TCON. However, TCON
+			 * points back to TCON TOP when it is source for HDMI.
+			 * We have to skip it here to prevent infinite looping
+			 * between TCON TOP and TCON.
+			 */
+			if (sun4i_drv_node_is_tcon_top(remote)) {
+				DRM_DEBUG_DRIVER("TCON output endpoint is TCON TOP... skipping\n");
+				of_node_put(remote);
+				continue;
+			}
+
 			if (of_graph_parse_endpoint(ep, &endpoint)) {
 				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
 				of_node_put(remote);
@@ -318,6 +336,12 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	/* each node has at least one output */
 	sun4i_drv_traverse_endpoints(list, node, 1);
 
+	/* TCON TOP has second and third output */
+	if (sun4i_drv_node_is_tcon_top(node)) {
+		sun4i_drv_traverse_endpoints(list, node, 3);
+		sun4i_drv_traverse_endpoints(list, node, 5);
+	}
+
 	return count;
 }
 
-- 
2.18.0

