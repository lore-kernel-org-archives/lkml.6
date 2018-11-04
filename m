Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70517ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388912085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388912085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbeKEDo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:28 -0500
Received: from mailoutvs47.siol.net ([185.57.226.238]:47684 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387652AbeKEDo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A67B35212A6;
        Sun,  4 Nov 2018 19:28:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id viC8X3ONyPiJ; Sun,  4 Nov 2018 19:28:31 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3B630521292;
        Sun,  4 Nov 2018 19:28:31 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C8B895212A6;
        Sun,  4 Nov 2018 19:28:28 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 22/28] drm/sun4i: Add support for H6 HDMI PHY
Date:   Sun,  4 Nov 2018 19:26:59 +0100
Message-Id: <20181104182705.18047-23-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 has Synopsys DWC HDMI 2.0 TX PHY.

There is no freely available documentation for it, only code found in
BSP kernel. However, judging by the code, PHY is very similar to older
Synopsys HDMI PHY described in i.MX6 documentation. Most registers seem
to be the same.

According to i.MX6 documentation, mpll settings are based on pixel clock
and are not specific to each SoC. Because of that, mpll table in this
commit is based on that documentation and not on BSP code. Other PHY
settings were derived from BSP PHY driver code.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 137 +++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
index 635825b55648..66ea3a902e36 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -14,6 +14,122 @@
  */
 #define I2C_ADDR	0x69
=20
+static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] =3D {
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
+		594000000, {
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
+static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] =3D {
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
+	{ 594000000, { 0x003f, 0x001b, 0x001b }, },
+	{ ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
+};
+
+static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] =3D {
+	/*pixelclk   symbol   term   vlev*/
+	{ 74250000,  0x8009, 0x0004, 0x0232},
+	{ 148500000, 0x8029, 0x0004, 0x0273},
+	{ 594000000, 0x8039, 0x0004, 0x014a},
+	{ ~0UL,	     0x0000, 0x0000, 0x0000}
+};
+
 static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
 				      struct sun8i_hdmi_phy *phy,
 				      unsigned int clk_rate)
@@ -290,6 +406,16 @@ static void sun8i_hdmi_phy_unlock(struct sun8i_hdmi_=
phy *phy)
 		     SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
 }
=20
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
@@ -446,6 +572,13 @@ static const struct sun8i_hdmi_phy_variant sun50i_a6=
4_hdmi_phy =3D {
 	.phy_config =3D &sun8i_hdmi_phy_config_h3,
 };
=20
+static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy =3D {
+	.cur_ctr  =3D sun50i_h6_cur_ctr,
+	.mpll_cfg =3D sun50i_h6_mpll_cfg,
+	.phy_cfg  =3D sun50i_h6_phy_config,
+	.phy_init =3D &sun50i_hdmi_phy_init_h6,
+};
+
 static const struct of_device_id sun8i_hdmi_phy_of_table[] =3D {
 	{
 		.compatible =3D "allwinner,sun8i-a83t-hdmi-phy",
@@ -463,6 +596,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_t=
able[] =3D {
 		.compatible =3D "allwinner,sun50i-a64-hdmi-phy",
 		.data =3D &sun50i_a64_hdmi_phy,
 	},
+	{
+		.compatible =3D "allwinner,sun50i-h6-hdmi-phy",
+		.data =3D &sun50i_h6_hdmi_phy,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.19.1

