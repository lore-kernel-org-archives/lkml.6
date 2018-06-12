Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1F33CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DDA2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DDA2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934341AbeFLUC0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:02:26 -0400
Received: from mailoutvs51.siol.net ([185.57.226.242]:38513 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934283AbeFLUCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id E538B521ED2;
        Tue, 12 Jun 2018 22:02:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4DliIx12CIZl; Tue, 12 Jun 2018 22:02:18 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 649E3521DC5;
        Tue, 12 Jun 2018 22:02:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D8231521ED2;
        Tue, 12 Jun 2018 22:02:15 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 12/27] drm/sun4i: tcon: Generalize engine search algorithm
Date:   Tue, 12 Jun 2018 22:00:21 +0200
Message-Id: <20180612200036.21483-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current "old" method to find engine worked pretty well for DE2. However,
it doesn't work when TCON TOP is between  mixer (engine) and TCON. TCON
TOP has multiple input ports, but current engine search algorithm
expects only one.

This can be fixed by first looking for output port id and selecting
matching input by subtracting 1 for the next round. This work even if
there is only one input and output.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0afb5a94a414..5dae623968f7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -802,12 +802,14 @@ static int sun4i_tcon_init_regmap(struct device *dev,
  */
 static struct sunxi_engine *
 sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
-				struct device_node *node)
+				struct device_node *node,
+				u32 port_id)
 {
 	struct device_node *port, *ep, *remote;
 	struct sunxi_engine *engine = ERR_PTR(-EINVAL);
+	u32 reg = 0;
 
-	port = of_graph_get_port_by_id(node, 0);
+	port = of_graph_get_port_by_id(node, port_id);
 	if (!port)
 		return ERR_PTR(-EINVAL);
 
@@ -837,8 +839,20 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
 		if (remote == engine->node)
 			goto out_put_remote;
 
+	/*
+	 * According to device tree binding input ports have even id
+	 * number and output ports have odd id. Since component with
+	 * more than one input and one output (TCON TOP) exits, correct
+	 * remote input id has to be calculated by subtracting 1 from
+	 * remote output id. If this for some reason can't be done, 0
+	 * is used as input port id.
+	 */
+	port = of_graph_get_remote_port(ep);
+	if (!of_property_read_u32(port, "reg", &reg) && reg > 0)
+		reg -= 1;
+
 	/* keep looking through upstream ports */
-	engine = sun4i_tcon_find_engine_traverse(drv, remote);
+	engine = sun4i_tcon_find_engine_traverse(drv, remote, reg);
 
 out_put_remote:
 	of_node_put(remote);
@@ -961,7 +975,7 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 
 	/* Fallback to old method by traversing input endpoints */
 	of_node_put(port);
-	return sun4i_tcon_find_engine_traverse(drv, node);
+	return sun4i_tcon_find_engine_traverse(drv, node, 0);
 }
 
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
-- 
2.17.1

