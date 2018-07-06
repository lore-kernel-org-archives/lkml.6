Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5080320693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5080320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934455AbeGFRxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:34 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:41493 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934414AbeGFRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DB07A521137;
        Fri,  6 Jul 2018 19:53:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QP4t-uaZED9k; Fri,  6 Jul 2018 19:53:28 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 574815211D8;
        Fri,  6 Jul 2018 19:53:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C5E1A521137;
        Fri,  6 Jul 2018 19:53:25 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 09/17] drm/sun4i: mixer: Read id from DT
Date:   Fri,  6 Jul 2018 19:51:05 +0200
Message-Id: <20180706175113.26698-10-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, TCON supports 2 ways to match TCON with engine (mixer in this
case). Old way is to just traverse of graph backwards and compare node
pointer. New way is to match TCON and engine by their respective ids.
All SoCs with DE2 enabled till now used the old way, which means mixer
id was never used and thus never implemented.

However, for R40, only the new way will be used. To prepare for that,
implemend fetching mixer id from DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 35 +++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index ee8febb25903..11221f96746d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -23,6 +23,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/reset.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 
 #include "sun4i_drv.h"
 #include "sun8i_mixer.h"
@@ -322,6 +323,37 @@ static struct regmap_config sun8i_mixer_regmap_config = {
 	.max_register	= 0xbfffc, /* guessed */
 };
 
+static int sun8i_mixer_of_get_id(struct device_node *node)
+{
+	struct device_node *port, *ep;
+	int ret = -EINVAL;
+
+	/* output is port 1 */
+	port = of_graph_get_port_by_id(node, 1);
+	if (!port)
+		return -EINVAL;
+
+	/* try finding an upstream endpoint */
+	for_each_available_child_of_node(port, ep) {
+		struct device_node *remote;
+		u32 reg;
+
+		remote = of_graph_get_remote_endpoint(ep);
+		if (!remote)
+			continue;
+
+		ret = of_property_read_u32(remote, "reg", &reg);
+		if (ret)
+			continue;
+
+		ret = reg;
+	}
+
+	of_node_put(port);
+
+	return ret;
+}
+
 static int sun8i_mixer_bind(struct device *dev, struct device *master,
 			      void *data)
 {
@@ -353,8 +385,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, mixer);
 	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
-	/* The ID of the mixer currently doesn't matter */
-	mixer->engine.id = -1;
+	mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
 
 	mixer->cfg = of_device_get_match_data(dev);
 	if (!mixer->cfg)
-- 
2.18.0

