Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B26C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26462147E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26462147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934587AbeGFRxx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:53 -0400
Received: from mailoutvs56.siol.net ([185.57.226.247]:41651 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934440AbeGFRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0D70F521137;
        Fri,  6 Jul 2018 19:53:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DpAr6oIWZPMh; Fri,  6 Jul 2018 19:53:46 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6C7E552099D;
        Fri,  6 Jul 2018 19:53:46 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E271F520BE8;
        Fri,  6 Jul 2018 19:53:43 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 16/17] drm/sun4i: tcon-top: Remove mux configuration at probe time
Date:   Fri,  6 Jul 2018 19:51:12 +0200
Message-Id: <20180706175113.26698-17-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that R40 TCON migrated to runtime mux configuration, old code can be
removed.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 81 +++-----------------------
 1 file changed, 7 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index c09b15b64192..78795d6cb174 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -87,34 +87,6 @@ int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon)
 }
 EXPORT_SYMBOL(sun8i_tcon_top_de_config);
 
-static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
-					      int port_id)
-{
-	struct device_node *ep, *remote, *port;
-	struct of_endpoint endpoint;
-
-	port = of_graph_get_port_by_id(node, port_id);
-	if (!port)
-		return -ENOENT;
-
-	for_each_available_child_of_node(port, ep) {
-		remote = of_graph_get_remote_port_parent(ep);
-		if (!remote)
-			continue;
-
-		if (of_device_is_available(remote)) {
-			of_graph_parse_endpoint(ep, &endpoint);
-
-			of_node_put(remote);
-
-			return endpoint.id;
-		}
-
-		of_node_put(remote);
-	}
-
-	return -ENOENT;
-}
 
 static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
 						   const char *parent,
@@ -149,11 +121,9 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	struct platform_device *pdev = to_platform_device(dev);
 	struct clk_hw_onecell_data *clk_data;
 	struct sun8i_tcon_top *tcon_top;
-	bool mixer0_unused = false;
 	struct resource *res;
 	void __iomem *regs;
-	int ret, i, id;
-	u32 val;
+	int ret, i;
 
 	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
 	if (!tcon_top)
@@ -198,49 +168,12 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		goto err_assert_reset;
 	}
 
-	val = 0;
-
-	/* check if HDMI mux output is connected */
-	if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >= 0) {
-		/* find HDMI input endpoint id, if it is connected at all*/
-		id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 4);
-		if (id >= 0)
-			val = FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id + 1);
-		else
-			DRM_DEBUG_DRIVER("TCON TOP HDMI input is not connected\n");
-	} else {
-		DRM_DEBUG_DRIVER("TCON TOP HDMI output is not connected\n");
-	}
-
-	writel(val, regs + TCON_TOP_GATE_SRC_REG);
-
-	val = 0;
-
-	/* process mixer0 mux output */
-	id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
-	if (id >= 0) {
-		val = FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
-	} else {
-		DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not connected\n");
-		mixer0_unused = true;
-	}
-
-	/* process mixer1 mux output */
-	id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
-	if (id >= 0) {
-		val |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
-
-		/*
-		 * mixer0 mux has priority over mixer1 mux. We have to
-		 * make sure mixer0 doesn't overtake TCON from mixer1.
-		 */
-		if (mixer0_unused && id == 0)
-			val |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
-	} else {
-		DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not connected\n");
-	}
-
-	writel(val, regs + TCON_TOP_PORT_SEL_REG);
+	/*
+	 * Default register values might have some reserved bits set, which
+	 * prevents TCON TOP from working properly. Set them to 0 here.
+	 */
+	writel(0, regs + TCON_TOP_GATE_SRC_REG);
+	writel(0, regs + TCON_TOP_PORT_SEL_REG);
 
 	/*
 	 * TCON TOP has two muxes, which select parent clock for each TCON TV
-- 
2.18.0

