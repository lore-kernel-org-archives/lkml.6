Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A2AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679472589B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679472589B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbeFYMFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:05:42 -0400
Received: from mailoutvs37.siol.net ([185.57.226.228]:48211 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933505AbeFYMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 44FFF52029A;
        Mon, 25 Jun 2018 14:05:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5MOqHz07xnUp; Mon, 25 Jun 2018 14:05:36 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 819BC5208B0;
        Mon, 25 Jun 2018 14:05:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5E7575208D5;
        Mon, 25 Jun 2018 14:05:33 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 19/24] drm/sun4i: Add support for second clock parent to DW HDMI PHY clk driver
Date:   Mon, 25 Jun 2018 14:02:59 +0200
Message-Id: <20180625120304.7543-20-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand HDMI PHY clock driver to support second clock parent.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  4 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     |  3 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 90 ++++++++++++++++------
 3 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 46a3aa6a53a9..aadbe0a10b0c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -99,6 +99,7 @@
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
 #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
 #define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
+#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT	26
 #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
 #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
@@ -190,6 +191,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
 const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
 
-int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
+int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
+			 bool second_parent);
 
 #endif /* _SUN8I_DW_HDMI_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index f0877b3f67e7..aea46b08f127 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -491,7 +491,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 			}
 		}
 
-		ret = sun8i_phy_clk_create(phy, dev);
+		ret = sun8i_phy_clk_create(phy, dev,
+					   phy->variant->has_second_pll);
 		if (ret) {
 			dev_err(dev, "Couldn't create the PHY clock\n");
 			goto err_put_clk_pll1;
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
index faea449812f8..a4d31fe3abff 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
@@ -22,35 +22,45 @@ static int sun8i_phy_clk_determine_rate(struct clk_hw *hw,
 {
 	unsigned long rate = req->rate;
 	unsigned long best_rate = 0;
+	struct clk_hw *best_parent = NULL;
 	struct clk_hw *parent;
 	int best_div = 1;
-	int i;
+	int i, p;
 
-	parent = clk_hw_get_parent(hw);
-
-	for (i = 1; i <= 16; i++) {
-		unsigned long ideal = rate * i;
-		unsigned long rounded;
-
-		rounded = clk_hw_round_rate(parent, ideal);
+	for (p = 0; p < clk_hw_get_num_parents(hw); p++) {
+		parent = clk_hw_get_parent_by_index(hw, p);
+		if (!parent)
+			continue;
 
-		if (rounded == ideal) {
-			best_rate = rounded;
-			best_div = i;
-			break;
+		for (i = 1; i <= 16; i++) {
+			unsigned long ideal = rate * i;
+			unsigned long rounded;
+
+			rounded = clk_hw_round_rate(parent, ideal);
+
+			if (rounded == ideal) {
+				best_rate = rounded;
+				best_div = i;
+				best_parent = parent;
+				break;
+			}
+
+			if (!best_rate ||
+			    abs(rate - rounded / i) <
+			    abs(rate - best_rate / best_div)) {
+				best_rate = rounded;
+				best_div = i;
+				best_parent = parent;
+			}
 		}
 
-		if (!best_rate ||
-		    abs(rate - rounded / i) <
-		    abs(rate - best_rate / best_div)) {
-			best_rate = rounded;
-			best_div = i;
-		}
+		if (best_rate / best_div == rate)
+			break;
 	}
 
 	req->rate = best_rate / best_div;
 	req->best_parent_rate = best_rate;
-	req->best_parent_hw = parent;
+	req->best_parent_hw = best_parent;
 
 	return 0;
 }
@@ -95,22 +105,58 @@ static int sun8i_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static u8 sun8i_phy_clk_get_parent(struct clk_hw *hw)
+{
+	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
+	u32 reg;
+
+	regmap_read(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, &reg);
+	reg = (reg & SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK) >>
+	      SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT;
+
+	return reg;
+}
+
+static int sun8i_phy_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
+
+	if (index > 1)
+		return -EINVAL;
+
+	regmap_update_bits(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
+			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
+			   index << SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT);
+
+	return 0;
+}
+
 static const struct clk_ops sun8i_phy_clk_ops = {
 	.determine_rate	= sun8i_phy_clk_determine_rate,
 	.recalc_rate	= sun8i_phy_clk_recalc_rate,
 	.set_rate	= sun8i_phy_clk_set_rate,
+
+	.get_parent	= sun8i_phy_clk_get_parent,
+	.set_parent	= sun8i_phy_clk_set_parent,
 };
 
-int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
+int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
+			 bool second_parent)
 {
 	struct clk_init_data init;
 	struct sun8i_phy_clk *priv;
-	const char *parents[1];
+	const char *parents[2];
 
 	parents[0] = __clk_get_name(phy->clk_pll0);
 	if (!parents[0])
 		return -ENODEV;
 
+	if (second_parent) {
+		parents[1] = __clk_get_name(phy->clk_pll1);
+		if (!parents[1])
+			return -ENODEV;
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -118,7 +164,7 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
 	init.name = "hdmi-phy-clk";
 	init.ops = &sun8i_phy_clk_ops;
 	init.parent_names = parents;
-	init.num_parents = 1;
+	init.num_parents = second_parent ? 2 : 1;
 	init.flags = CLK_SET_RATE_PARENT;
 
 	priv->phy = phy;
-- 
2.18.0

