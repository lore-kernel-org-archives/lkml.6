Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B570C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB2A20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB2A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeIBLmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:44 -0400
Received: from mailoutvs39.siol.net ([185.57.226.230]:55038 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbeIBLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6F62E520D20;
        Sun,  2 Sep 2018 09:27:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jIpKPy__iWkb; Sun,  2 Sep 2018 09:27:52 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id BE97C520D21;
        Sun,  2 Sep 2018 09:27:52 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3F70F520D20;
        Sun,  2 Sep 2018 09:27:50 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 20/27] drm/sun4i: Add support for Synopsys HDMI PHY
Date:   Sun,  2 Sep 2018 09:26:36 +0200
Message-Id: <20180902072643.4917-21-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sun8i-hdmi-phy driver supports only custom PHYs connected to
DW HDMI controller. Since newest Allwinner SoCs have unmodified Synopsys
PHY, driver has to be reorganized to support them.

Variant structure is expanded to allow differentiation between custom
and Sysnopsys PHYs and to hold Synopsys PHY settings.

Since DW HDMI bridge platform data has different fields for custom and
Sysnopsys PHY, function sun8i_hdmi_phy_get_ops() is replaced with
sun8i_hdmi_phy_set_ops().

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  4 +---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  7 ++++++-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 18 ++++++++++++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 44143c9f20d0..bf35975dd100 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -172,9 +172,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	sun8i_hdmi_phy_init(hdmi->phy);
 
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
-	plat_data->phy_ops = sun8i_hdmi_phy_get_ops();
-	plat_data->phy_name = "sun8i_dw_hdmi_phy";
-	plat_data->phy_data = hdmi->phy;
+	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
 
 	platform_set_drvdata(pdev, hdmi);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 94cf13d09abe..e48cd9b3cce3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -149,6 +149,10 @@ struct sun8i_hdmi_phy;
 struct sun8i_hdmi_phy_variant {
 	bool has_phy_clk;
 	bool has_second_pll;
+	bool is_custom_phy;
+	const struct dw_hdmi_curr_ctrl *cur_ctr;
+	const struct dw_hdmi_mpll_config *mpll_cfg;
+	const struct dw_hdmi_phy_config *phy_cfg;
 	void (*phy_init)(struct sun8i_hdmi_phy *phy);
 	void (*phy_disable)(struct dw_hdmi *hdmi,
 			    struct sun8i_hdmi_phy *phy);
@@ -196,7 +200,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node);
 void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
 
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
-const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
+void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
+			    struct dw_hdmi_plat_data *plat_data);
 
 int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
 			 bool second_parent);
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index ad4ba1cc83b4..ee2bf61cd4d2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -390,9 +390,20 @@ void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
 	phy->variant->phy_init(phy);
 }
 
-const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void)
+void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
+			    struct dw_hdmi_plat_data *plat_data)
 {
-	return &sun8i_hdmi_phy_ops;
+	struct sun8i_hdmi_phy_variant *variant = phy->variant;
+
+	if (variant->is_custom_phy) {
+		plat_data->phy_ops = &sun8i_hdmi_phy_ops;
+		plat_data->phy_name = "sun8i_dw_hdmi_phy";
+		plat_data->phy_data = phy;
+	} else {
+		plat_data->mpll_cfg = variant->mpll_cfg;
+		plat_data->cur_ctr = variant->cur_ctr;
+		plat_data->phy_config = variant->phy_cfg;
+	}
 }
 
 static struct regmap_config sun8i_hdmi_phy_regmap_config = {
@@ -405,6 +416,7 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 
 static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
 	.has_phy_clk = true,
+	.is_custom_phy = true,
 	.has_second_pll = true,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
@@ -412,6 +424,7 @@ static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
 };
 
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
+	.is_custom_phy = true,
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
 	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
 	.phy_config = &sun8i_hdmi_phy_config_a83t,
@@ -419,6 +432,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 
 static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 	.has_phy_clk = true,
+	.is_custom_phy = true,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
 	.phy_config = &sun8i_hdmi_phy_config_h3,
-- 
2.18.0

