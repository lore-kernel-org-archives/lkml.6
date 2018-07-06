Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A14C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84FD20693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84FD20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934554AbeGFRxq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:46 -0400
Received: from mailoutvs61.siol.net ([185.57.226.252]:41527 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934440AbeGFRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AA6355211BA;
        Fri,  6 Jul 2018 19:53:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yVdyecdg75Zc; Fri,  6 Jul 2018 19:53:31 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 0824052107C;
        Fri,  6 Jul 2018 19:53:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 61A525211DC;
        Fri,  6 Jul 2018 19:53:28 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 10/17] drm/sun4i: tcon-top: Add helpers for switching mux
Date:   Fri,  6 Jul 2018 19:51:06 +0200
Message-Id: <20180706175113.26698-11-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to set TCON TOP muxes at runtime. Add helpers for
that.

Old, static configuration of muxes at probe time is preserved for now.
It will be removed when R40 TCON starts using them.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 74 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  4 ++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 9fb51940156f..c09b15b64192 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -14,6 +14,79 @@
 
 #include "sun8i_tcon_top.h"
 
+static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
+{
+	return !!of_match_node(sun8i_tcon_top_of_table, node);
+}
+
+int sun8i_tcon_top_set_hdmi_src(struct device *dev, int tcon)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	unsigned long flags;
+	u32 val;
+
+	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
+		dev_err(dev, "Device is not TCON TOP!\n");
+		return -EINVAL;
+	}
+
+	if (tcon < 2 || tcon > 3) {
+		dev_err(dev, "TCON index must be 2 or 3!\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&tcon_top->reg_lock, flags);
+
+	val = readl(tcon_top->regs + TCON_TOP_GATE_SRC_REG);
+	val &= ~TCON_TOP_HDMI_SRC_MSK;
+	val |= FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, tcon - 1);
+	writel(val, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
+
+	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_tcon_top_set_hdmi_src);
+
+int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	unsigned long flags;
+	u32 reg;
+
+	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
+		dev_err(dev, "Device is not TCON TOP!\n");
+		return -EINVAL;
+	}
+
+	if (mixer > 1) {
+		dev_err(dev, "Mixer index is too high!\n");
+		return -EINVAL;
+	}
+
+	if (tcon > 3) {
+		dev_err(dev, "TCON index is too high!\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&tcon_top->reg_lock, flags);
+
+	reg = readl(tcon_top->regs + TCON_TOP_PORT_SEL_REG);
+	if (mixer == 0) {
+		reg &= ~TCON_TOP_PORT_DE0_MSK;
+		reg |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, tcon);
+	} else {
+		reg &= ~TCON_TOP_PORT_DE1_MSK;
+		reg |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, tcon);
+	}
+	writel(reg, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
+
+	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_tcon_top_de_config);
+
 static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
 					      int port_id)
 {
@@ -109,6 +182,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
+	tcon_top->regs = regs;
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
index 39838bbfeaee..0390584a330e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
@@ -26,6 +26,7 @@
 struct sun8i_tcon_top {
 	struct clk			*bus;
 	struct clk_hw_onecell_data	*clk_data;
+	void __iomem			*regs;
 	struct reset_control		*rst;
 
 	/*
@@ -37,4 +38,7 @@ struct sun8i_tcon_top {
 
 extern const struct of_device_id sun8i_tcon_top_of_table[];
 
+int sun8i_tcon_top_set_hdmi_src(struct device *dev, int tcon);
+int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon);
+
 #endif /* _SUN8I_TCON_TOP_H_ */
-- 
2.18.0

