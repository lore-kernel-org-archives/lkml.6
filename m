Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 92BF4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B72089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532B72089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934764AbeFLUEa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:04:30 -0400
Received: from mailoutvs61.siol.net ([185.57.226.252]:38753 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934506AbeFLUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 50A525221FA;
        Tue, 12 Jun 2018 22:02:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8OCjao2UFRUM; Tue, 12 Jun 2018 22:02:41 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id A4872522436;
        Tue, 12 Jun 2018 22:02:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 264495221FA;
        Tue, 12 Jun 2018 22:02:39 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 21/27] drm/sun4i: DW HDMI PHY: Add support for second PLL
Date:   Tue, 12 Jun 2018 22:00:30 +0200
Message-Id: <20180612200036.21483-22-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DW HDMI PHYs, like those found in A64 and R40 SoCs, can select
between two clock parents.

Add code which reads second PLL from DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 ++
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 3ba71aff92fc..46a3aa6a53a9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -147,6 +147,7 @@ struct sun8i_hdmi_phy;
 
 struct sun8i_hdmi_phy_variant {
 	bool has_phy_clk;
+	bool has_second_pll;
 	void (*phy_init)(struct sun8i_hdmi_phy *phy);
 	void (*phy_disable)(struct dw_hdmi *hdmi,
 			    struct sun8i_hdmi_phy *phy);
@@ -160,6 +161,7 @@ struct sun8i_hdmi_phy {
 	struct clk			*clk_mod;
 	struct clk			*clk_phy;
 	struct clk			*clk_pll0;
+	struct clk			*clk_pll1;
 	unsigned int			rcal;
 	struct regmap			*regs;
 	struct reset_control		*rst_phy;
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index cd07ceb71601..f50072ae054a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -482,10 +482,19 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 			goto err_put_clk_mod;
 		}
 
+		if (phy->variant->has_second_pll) {
+			phy->clk_pll1 = of_clk_get_by_name(node, "pll-1");
+			if (IS_ERR(phy->clk_pll1)) {
+				dev_err(dev, "Could not get pll-1 clock\n");
+				ret = PTR_ERR(phy->clk_pll1);
+				goto err_put_clk_pll0;
+			}
+		}
+
 		ret = sun8i_phy_clk_create(phy, dev);
 		if (ret) {
 			dev_err(dev, "Couldn't create the PHY clock\n");
-			goto err_put_clk_pll0;
+			goto err_put_clk_pll1;
 		}
 
 		clk_prepare_enable(phy->clk_phy);
@@ -528,9 +537,10 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	reset_control_put(phy->rst_phy);
 err_disable_clk_phy:
 	clk_disable_unprepare(phy->clk_phy);
+err_put_clk_pll1:
+	clk_put(phy->clk_pll1);
 err_put_clk_pll0:
-	if (phy->variant->has_phy_clk)
-		clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll0);
 err_put_clk_mod:
 	clk_put(phy->clk_mod);
 err_put_clk_bus:
@@ -551,8 +561,8 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 
 	reset_control_put(phy->rst_phy);
 
-	if (phy->variant->has_phy_clk)
-		clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll1);
 	clk_put(phy->clk_mod);
 	clk_put(phy->clk_bus);
 }
-- 
2.17.1

