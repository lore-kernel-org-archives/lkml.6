Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F426C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B8F2064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B8F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeIBLm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:28 -0400
Received: from mailoutvs27.siol.net ([185.57.226.218]:54873 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbeIBLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CB1F2520C5B;
        Sun,  2 Sep 2018 09:27:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JZzMr-UtoKfN; Sun,  2 Sep 2018 09:27:37 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 46F89520C96;
        Sun,  2 Sep 2018 09:27:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B8D7D520C5B;
        Sun,  2 Sep 2018 09:27:34 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 15/27] drm/sun4i: Not all DW HDMI controllers has scrambled addresses
Date:   Sun,  2 Sep 2018 09:26:31 +0200
Message-Id: <20180902072643.4917-16-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently supported Allwinner SoCs with DW HDMI controller have
scrambled addresses and read lock. However, that is not true in general.
For example, A80 and H6 have normal addresses and normal read access.

Move code for unscrambling addresses and unlocking read access to it's
own function and call it from init function.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 82502b351aec..ad4ba1cc83b4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -279,8 +279,21 @@ static const struct dw_hdmi_phy_ops sun8i_hdmi_phy_ops = {
 	.setup_hpd = &dw_hdmi_phy_setup_hpd,
 };
 
+static void sun8i_hdmi_phy_unlock(struct sun8i_hdmi_phy *phy)
+{
+	/* enable read access to HDMI controller */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_READ_EN_REG,
+		     SUN8I_HDMI_PHY_READ_EN_MAGIC);
+
+	/* unscramble register offsets */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_UNSCRAMBLE_REG,
+		     SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
+}
+
 static void sun8i_hdmi_phy_init_a83t(struct sun8i_hdmi_phy *phy)
 {
+	sun8i_hdmi_phy_unlock(phy);
+
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
 			   SUN8I_HDMI_PHY_DBG_CTRL_PX_LOCK,
 			   SUN8I_HDMI_PHY_DBG_CTRL_PX_LOCK);
@@ -298,6 +311,8 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
 {
 	unsigned int val;
 
+	sun8i_hdmi_phy_unlock(phy);
+
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG, 0);
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
 			   SUN8I_HDMI_PHY_ANA_CFG1_ENBI,
@@ -372,14 +387,6 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
 
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
 {
-	/* enable read access to HDMI controller */
-	regmap_write(phy->regs, SUN8I_HDMI_PHY_READ_EN_REG,
-		     SUN8I_HDMI_PHY_READ_EN_MAGIC);
-
-	/* unscramble register offsets */
-	regmap_write(phy->regs, SUN8I_HDMI_PHY_UNSCRAMBLE_REG,
-		     SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
-
 	phy->variant->phy_init(phy);
 }
 
-- 
2.18.0

