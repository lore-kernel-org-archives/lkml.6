Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82842C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4AE2588A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4AE2588A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeFYMFI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:05:08 -0400
Received: from mailoutvs56.siol.net ([185.57.226.247]:47878 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933436AbeFYMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id BB1255208A2;
        Mon, 25 Jun 2018 14:05:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vfqmLX6rusnu; Mon, 25 Jun 2018 14:05:01 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3095D5208B6;
        Mon, 25 Jun 2018 14:05:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4D3A65208A2;
        Mon, 25 Jun 2018 14:04:58 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 07/24] drm/sun4i: Split out code for enumerating endpoints in output port
Date:   Mon, 25 Jun 2018 14:02:47 +0200
Message-Id: <20180625120304.7543-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, each node has one input port and one output port. However,
with TCON TOP this is no longer true. It has 3 input and 3 output ports.

In order to prepare to this situation, split out the code which checks
all endpoints in input port and adds available components to fifo.

This patch doesn't do any functional change.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 84 +++++++++++++++++--------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e15fa2389e3f..20193d6f33ba 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -231,12 +231,55 @@ struct endpoint_list {
 	DECLARE_KFIFO(fifo, struct device_node *, 16);
 };
 
+static void sun4i_drv_traverse_endpoints(struct endpoint_list *list,
+					 struct device_node *node,
+					 int port_id)
+{
+	struct device_node *ep, *remote, *port;
+
+	port = of_graph_get_port_by_id(node, port_id);
+	if (!port) {
+		DRM_DEBUG_DRIVER("No output to bind on port %d\n", port_id);
+		return;
+	}
+
+	for_each_available_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote) {
+			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
+			continue;
+		}
+
+		/*
+		 * If the node is our TCON, the first port is used for
+		 * panel or bridges, and will not be part of the
+		 * component framework.
+		 */
+		if (sun4i_drv_node_is_tcon(node)) {
+			struct of_endpoint endpoint;
+
+			if (of_graph_parse_endpoint(ep, &endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				of_node_put(remote);
+				continue;
+			}
+
+			if (!endpoint.id) {
+				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+				of_node_put(remote);
+				continue;
+			}
+		}
+
+		kfifo_put(&list->fifo, remote);
+	}
+}
+
 static int sun4i_drv_add_endpoints(struct device *dev,
 				   struct endpoint_list *list,
 				   struct component_match **match,
 				   struct device_node *node)
 {
-	struct device_node *port, *ep, *remote;
 	int count = 0;
 
 	/*
@@ -272,43 +315,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		count++;
 	}
 
-	/* Inputs are listed first, then outputs */
-	port = of_graph_get_port_by_id(node, 1);
-	if (!port) {
-		DRM_DEBUG_DRIVER("No output to bind\n");
-		return count;
-	}
-
-	for_each_available_child_of_node(port, ep) {
-		remote = of_graph_get_remote_port_parent(ep);
-		if (!remote) {
-			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
-			continue;
-		}
-
-		/*
-		 * If the node is our TCON, the first port is used for
-		 * panel or bridges, and will not be part of the
-		 * component framework.
-		 */
-		if (sun4i_drv_node_is_tcon(node)) {
-			struct of_endpoint endpoint;
-
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
-			}
-		}
-
-		kfifo_put(&list->fifo, remote);
-	}
+	/* each node has at least one output */
+	sun4i_drv_traverse_endpoints(list, node, 1);
 
 	return count;
 }
-- 
2.18.0

