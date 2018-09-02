Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4157C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571632064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571632064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIBLmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:46 -0400
Received: from mailoutvs49.siol.net ([185.57.226.240]:55062 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbeIBLmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id ED54E520D2D;
        Sun,  2 Sep 2018 09:27:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3fNYfj6wK_ky; Sun,  2 Sep 2018 09:27:55 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4F762520D32;
        Sun,  2 Sep 2018 09:27:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C5F4F520D2D;
        Sun,  2 Sep 2018 09:27:52 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 21/27] drm/sun4i: Add support for H6 HDMI PHY
Date:   Sun,  2 Sep 2018 09:26:37 +0200
Message-Id: <20180902072643.4917-22-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 has Synopsys DWC HDMI 2.0 TX PHY.

mpll settings were calculated from specifications of similar Synopsys
HDMI PHY found in i.MX6. Other PHY settings were derived from BSP PHY
driver code.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 137 +++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index ee2bf61cd4d2..2f5499bd35ec 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -14,6 +14,122 @@
  */
 #define I2C_ADDR	0x69
 
+static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] = {
+	{
+		30666000, {
+			{ 0x00b3, 0x0000 },
+			{ 0x2153, 0x0000 },
+			{ 0x40f3, 0x0000 },
+		},
+	},  {
+		36800000, {
+			{ 0x00b3, 0x0000 },
+			{ 0x2153, 0x0000 },
+			{ 0x40a2, 0x0001 },
+		},
+	},  {
+		46000000, {
+			{ 0x00b3, 0x0000 },
+			{ 0x2142, 0x0001 },
+			{ 0x40a2, 0x0001 },
+		},
+	},  {
+		61333000, {
+			{ 0x0072, 0x0001 },
+			{ 0x2142, 0x0001 },
+			{ 0x40a2, 0x0001 },
+		},
+	},  {
+		73600000, {
+			{ 0x0072, 0x0001 },
+			{ 0x2142, 0x0001 },
+			{ 0x4061, 0x0002 },
+		},
+	},  {
+		92000000, {
+			{ 0x0072, 0x0001 },
+			{ 0x2145, 0x0002 },
+			{ 0x4061, 0x0002 },
+		},
+	},  {
+		122666000, {
+			{ 0x0051, 0x0002 },
+			{ 0x2145, 0x0002 },
+			{ 0x4061, 0x0002 },
+		},
+	},  {
+		147200000, {
+			{ 0x0051, 0x0002 },
+			{ 0x2145, 0x0002 },
+			{ 0x4064, 0x0003 },
+		},
+	},  {
+		184000000, {
+			{ 0x0051, 0x0002 },
+			{ 0x214c, 0x0003 },
+			{ 0x4064, 0x0003 },
+		},
+	},  {
+		226666000, {
+			{ 0x0040, 0x0003 },
+			{ 0x214c, 0x0003 },
+			{ 0x4064, 0x0003 },
+		},
+	},  {
+		272000000, {
+			{ 0x0040, 0x0003 },
+			{ 0x214c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	},  {
+		340000000, {
+			{ 0x0040, 0x0003 },
+			{ 0x3b4c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	},  {
+		600000000, {
+			{ 0x1a40, 0x0003 },
+			{ 0x3b4c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	}, {
+		~0UL, {
+			{ 0x0000, 0x0000 },
+			{ 0x0000, 0x0000 },
+			{ 0x0000, 0x0000 },
+		},
+	}
+};
+
+static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] = {
+	/* pixelclk    bpp8    bpp10   bpp12 */
+	{ 25175000,  { 0x0000, 0x0000, 0x0000 }, },
+	{ 27000000,  { 0x0012, 0x0000, 0x0000 }, },
+	{ 59400000,  { 0x0008, 0x0008, 0x0008 }, },
+	{ 72000000,  { 0x0008, 0x0008, 0x001b }, },
+	{ 74250000,  { 0x0013, 0x0013, 0x0013 }, },
+	{ 90000000,  { 0x0008, 0x001a, 0x001b }, },
+	{ 118800000, { 0x001b, 0x001a, 0x001b }, },
+	{ 144000000, { 0x001b, 0x001a, 0x0034 }, },
+	{ 180000000, { 0x001b, 0x0033, 0x0034 }, },
+	{ 216000000, { 0x0036, 0x0033, 0x0034 }, },
+	{ 237600000, { 0x0036, 0x0033, 0x001b }, },
+	{ 288000000, { 0x0036, 0x001b, 0x001b }, },
+	{ 297000000, { 0x0019, 0x001b, 0x0019 }, },
+	{ 330000000, { 0x0036, 0x001b, 0x001b }, },
+	{ 600000000, { 0x003f, 0x001b, 0x001b }, },
+	{ ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
+};
+
+static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
+	/*pixelclk   symbol   term   vlev*/
+	{ 74250000,  0x8009, 0x0004, 0x0232},
+	{ 148500000, 0x8029, 0x0004, 0x0273},
+	{ 600000000, 0x8039, 0x0004, 0x014a},
+	{ ~0UL,	     0x0000, 0x0000, 0x0000}
+};
+
 static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
 				      struct sun8i_hdmi_phy *phy,
 				      unsigned int clk_rate)
@@ -290,6 +406,16 @@ static void sun8i_hdmi_phy_unlock(struct sun8i_hdmi_phy *phy)
 		     SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
 }
 
+static void sun50i_hdmi_phy_init_h6(struct sun8i_hdmi_phy *phy)
+{
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
+			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
+			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
+
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
+			   0xffff0000, 0x80c00000);
+}
+
 static void sun8i_hdmi_phy_init_a83t(struct sun8i_hdmi_phy *phy)
 {
 	sun8i_hdmi_phy_unlock(phy);
@@ -423,6 +549,13 @@ static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
 	.phy_config = &sun8i_hdmi_phy_config_h3,
 };
 
+static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
+	.cur_ctr  = sun50i_h6_cur_ctr,
+	.mpll_cfg = sun50i_h6_mpll_cfg,
+	.phy_cfg  = sun50i_h6_phy_config,
+	.phy_init = &sun50i_hdmi_phy_init_h6,
+};
+
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 	.is_custom_phy = true,
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
@@ -443,6 +576,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 		.compatible = "allwinner,sun50i-a64-hdmi-phy",
 		.data = &sun50i_a64_hdmi_phy,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-hdmi-phy",
+		.data = &sun50i_h6_hdmi_phy,
+	},
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
 		.data = &sun8i_a83t_hdmi_phy,
-- 
2.18.0

