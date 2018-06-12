Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CF730C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD502089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD502089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934169AbeFLUCO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:02:14 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:38389 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933611AbeFLUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id BF7E9521FAC;
        Tue, 12 Jun 2018 22:02:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZllEygUs96IH; Tue, 12 Jun 2018 22:02:08 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 30C1F522020;
        Tue, 12 Jun 2018 22:02:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id ACFE4521FAC;
        Tue, 12 Jun 2018 22:02:05 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 08/27] drm/sun4i: Add support for traversing graph with TCON TOP
Date:   Tue, 12 Jun 2018 22:00:17 +0200
Message-Id: <20180612200036.21483-9-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
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
2.17.1

