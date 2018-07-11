Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B95C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8CA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8CA20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeGKLbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:31:09 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:51284 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726644AbeGKLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:31:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 4C3EF521C58;
        Wed, 11 Jul 2018 13:27:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kD47YakUJmhU; Wed, 11 Jul 2018 13:27:13 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 9F7AD52199C;
        Wed, 11 Jul 2018 13:27:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id A448152115D;
        Wed, 11 Jul 2018 13:27:11 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3] drm/sun4i: mixer: Read id from DT
Date:   Wed, 11 Jul 2018 13:27:06 +0200
Message-Id: <20180711112706.30222-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
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
implement mixer id fetching from DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Hi all,

since all other patches were already applied, I'm sending this without
cover letter. Change from previous version is that I added comment why
there is no error handling when reading mixer id.

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 49 +++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index aa81b9838ae8..da34fc394902 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -22,6 +22,7 @@
 #include <linux/component.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <linux/reset.h>
 
 #include "sun4i_drv.h"
@@ -322,6 +323,42 @@ static struct regmap_config sun8i_mixer_regmap_config = {
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
+	/* try to find downstream endpoint */
+	for_each_available_child_of_node(port, ep) {
+		struct device_node *remote;
+		u32 reg;
+
+		remote = of_graph_get_remote_endpoint(ep);
+		if (!remote)
+			continue;
+
+		ret = of_property_read_u32(remote, "reg", &reg);
+		if (!ret) {
+			of_node_put(remote);
+			of_node_put(ep);
+			of_node_put(port);
+
+			return reg;
+		}
+
+		of_node_put(remote);
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
@@ -353,8 +390,16 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, mixer);
 	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
-	/* The ID of the mixer currently doesn't matter */
-	mixer->engine.id = -1;
+
+	/*
+	 * While this function can fail, we shouldn't do anything
+	 * if this happens. Some early DE2 DT entries don't provide
+	 * mixer id but work nevertheless because matching between
+	 * TCON and mixer is done by comparing node pointers (old
+	 * way) instead comparing ids. If this function fails and
+	 * id is needed, it will fail during id matching anyway.
+	 */
+	mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
 
 	mixer->cfg = of_device_get_match_data(dev);
 	if (!mixer->cfg)
-- 
2.18.0

