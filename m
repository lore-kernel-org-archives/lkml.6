Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B7C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2C32064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2C32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeIBLmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:51 -0400
Received: from mailoutvs7.siol.net ([185.57.226.198]:55129 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeIBLmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 080CD520D43;
        Sun,  2 Sep 2018 09:28:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nzORNHw-6SWF; Sun,  2 Sep 2018 09:28:00 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6A790520D48;
        Sun,  2 Sep 2018 09:28:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id DF768520D43;
        Sun,  2 Sep 2018 09:27:57 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 23/27] drm: sun4i: add quirks for TCON TOP
Date:   Sun,  2 Sep 2018 09:26:39 +0200
Message-Id: <20180902072643.4917-24-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Some SoCs, such as H6, doesn't have a full-featured TCON TOP.

Add quirks support for TCON TOP.

Currently the presence of TCON_TV1 and DSI is controlled via the quirks
structure.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 37158548b447..ed13233cad88 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -9,11 +9,17 @@
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 
 #include "sun8i_tcon_top.h"
 
+struct sun8i_tcon_top_quirks {
+	bool has_tcon_tv1;
+	bool has_dsi;
+};
+
 static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
 {
 	return !!of_match_node(sun8i_tcon_top_of_table, node);
@@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	struct platform_device *pdev = to_platform_device(dev);
 	struct clk_hw_onecell_data *clk_data;
 	struct sun8i_tcon_top *tcon_top;
+	const struct sun8i_tcon_top_quirks *quirks;
 	struct resource *res;
 	void __iomem *regs;
 	int ret, i;
 
+	quirks = of_device_get_match_data(&pdev->dev);
+
 	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
 	if (!tcon_top)
 		return -ENOMEM;
@@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_TV0_GATE, 0);
 
-	clk_data->hws[CLK_TCON_TOP_TV1] =
-		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
-					     &tcon_top->reg_lock,
-					     TCON_TOP_TCON_TV1_GATE, 1);
+	if (quirks->has_tcon_tv1) {
+		clk_data->hws[CLK_TCON_TOP_TV1] =
+			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
+						     &tcon_top->reg_lock,
+						     TCON_TOP_TCON_TV1_GATE, 1);
+	} else {
+		clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
+	}
 
-	clk_data->hws[CLK_TCON_TOP_DSI] =
-		sun8i_tcon_top_register_gate(dev, "dsi", regs,
-					     &tcon_top->reg_lock,
-					     TCON_TOP_TCON_DSI_GATE, 2);
+	if (quirks->has_dsi) {
+		clk_data->hws[CLK_TCON_TOP_DSI] =
+			sun8i_tcon_top_register_gate(dev, "dsi", regs,
+						     &tcon_top->reg_lock,
+						     TCON_TOP_TCON_DSI_GATE, 2);
+	} else {
+		clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
+	}
 
 	for (i = 0; i < CLK_NUM; i++)
 		if (IS_ERR(clk_data->hws[i])) {
@@ -257,9 +274,17 @@ static int sun8i_tcon_top_remove(struct platform_device *pdev)
 	return 0;
 }
 
+const struct sun8i_tcon_top_quirks sun8i_r40_tcon_top_quirks = {
+	.has_tcon_tv1	= true,
+	.has_dsi	= true,
+};
+
 /* sun4i_drv uses this list to check if a device node is a TCON TOP */
 const struct of_device_id sun8i_tcon_top_of_table[] = {
-	{ .compatible = "allwinner,sun8i-r40-tcon-top" },
+	{
+		.compatible = "allwinner,sun8i-r40-tcon-top",
+		.data = &sun8i_r40_tcon_top_quirks
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
-- 
2.18.0

