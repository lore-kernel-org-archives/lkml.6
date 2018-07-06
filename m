Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B6C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE619219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE619219AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934379AbeGFRxU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:20 -0400
Received: from mailoutvs20.siol.net ([185.57.226.211]:41381 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933883AbeGFRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 03B1352099D;
        Fri,  6 Jul 2018 19:53:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Fste9UTQSDCv; Fri,  6 Jul 2018 19:53:15 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 66E6A520BA1;
        Fri,  6 Jul 2018 19:53:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id D4564520EC6;
        Fri,  6 Jul 2018 19:53:12 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 04/17] drm/sun4i: tcon-top: Cleanup clock handling
Date:   Fri,  6 Jul 2018 19:51:00 +0200
Message-Id: <20180706175113.26698-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to acquire reference to clock just to get its name.

This commit just cleans up the code. There is no functional change.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 48 ++++++--------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 8da0460e0028..9fb51940156f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -44,15 +44,20 @@ static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
 }
 
 static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
-						   struct clk *parent,
+						   const char *parent,
 						   void __iomem *regs,
 						   spinlock_t *lock,
 						   u8 bit, int name_index)
 {
 	const char *clk_name, *parent_name;
-	int ret;
+	int ret, index;
+
+	index = of_property_match_string(dev->of_node, "clock-names", parent);
+	if (IS_ERR_VALUE(index))
+		return ERR_PTR(index);
+
+	parent_name = of_clk_get_parent_name(dev->of_node, index);
 
-	parent_name = __clk_get_name(parent);
 	ret = of_property_read_string_index(dev->of_node,
 					    "clock-output-names", name_index,
 					    &clk_name);
@@ -69,7 +74,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 			       void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct clk *dsi, *tcon_tv0, *tcon_tv1, *tve0, *tve1;
 	struct clk_hw_onecell_data *clk_data;
 	struct sun8i_tcon_top *tcon_top;
 	bool mixer0_unused = false;
@@ -103,36 +107,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		return PTR_ERR(tcon_top->bus);
 	}
 
-	dsi = devm_clk_get(dev, "dsi");
-	if (IS_ERR(dsi)) {
-		dev_err(dev, "Couldn't get the dsi clock\n");
-		return PTR_ERR(dsi);
-	}
-
-	tcon_tv0 = devm_clk_get(dev, "tcon-tv0");
-	if (IS_ERR(tcon_tv0)) {
-		dev_err(dev, "Couldn't get the tcon-tv0 clock\n");
-		return PTR_ERR(tcon_tv0);
-	}
-
-	tcon_tv1 = devm_clk_get(dev, "tcon-tv1");
-	if (IS_ERR(tcon_tv1)) {
-		dev_err(dev, "Couldn't get the tcon-tv1 clock\n");
-		return PTR_ERR(tcon_tv1);
-	}
-
-	tve0 = devm_clk_get(dev, "tve0");
-	if (IS_ERR(tve0)) {
-		dev_err(dev, "Couldn't get the tve0 clock\n");
-		return PTR_ERR(tve0);
-	}
-
-	tve1 = devm_clk_get(dev, "tve1");
-	if (IS_ERR(tve1)) {
-		dev_err(dev, "Couldn't get the tve1 clock\n");
-		return PTR_ERR(tve1);
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
@@ -203,17 +177,17 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	 * to TVE clock parent.
 	 */
 	clk_data->hws[CLK_TCON_TOP_TV0] =
-		sun8i_tcon_top_register_gate(dev, tcon_tv0, regs,
+		sun8i_tcon_top_register_gate(dev, "tcon-tv0", regs,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_TV0_GATE, 0);
 
 	clk_data->hws[CLK_TCON_TOP_TV1] =
-		sun8i_tcon_top_register_gate(dev, tcon_tv1, regs,
+		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_TV1_GATE, 1);
 
 	clk_data->hws[CLK_TCON_TOP_DSI] =
-		sun8i_tcon_top_register_gate(dev, dsi, regs,
+		sun8i_tcon_top_register_gate(dev, "dsi", regs,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_DSI_GATE, 2);
 
-- 
2.18.0

