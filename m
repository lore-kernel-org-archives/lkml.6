Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98822081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98822081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbeKEDnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:42 -0500
Received: from mailoutvs8.siol.net ([185.57.226.199]:47215 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387432AbeKEDnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CCBC5521294;
        Sun,  4 Nov 2018 19:27:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 97Ci53ca5Thv; Sun,  4 Nov 2018 19:27:46 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 47A9A521270;
        Sun,  4 Nov 2018 19:27:46 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C7E8D52128A;
        Sun,  4 Nov 2018 19:27:43 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 06/28] clk: sunxi-ng: Add support for H6 DE3 clocks
Date:   Sun,  4 Nov 2018 19:26:43 +0100
Message-Id: <20181104182705.18047-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for mixer0, mixer1, writeback and rotation units is added.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 71 ++++++++++++++++++++++++++--
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h |  4 +-
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index bae5ee67a797..1c9ae0a319c1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -31,6 +31,8 @@ static SUNXI_CCU_GATE(bus_mixer1_clk,	"bus-mixer1",	"bu=
s-de",
 		      0x04, BIT(1), 0);
 static SUNXI_CCU_GATE(bus_wb_clk,	"bus-wb",	"bus-de",
 		      0x04, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_rot_clk,	"bus-rot",	"bus-de",
+		      0x04, BIT(3), 0);
=20
 static SUNXI_CCU_GATE(mixer0_clk,	"mixer0",	"mixer0-div",
 		      0x00, BIT(0), CLK_SET_RATE_PARENT);
@@ -38,6 +40,8 @@ static SUNXI_CCU_GATE(mixer1_clk,	"mixer1",	"mixer1-div=
",
 		      0x00, BIT(1), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(wb_clk,		"wb",		"wb-div",
 		      0x00, BIT(2), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(rot_clk,		"rot",		"rot-div",
+		      0x00, BIT(3), CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
 		   CLK_SET_RATE_PARENT);
@@ -45,6 +49,8 @@ static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", =
0x0c, 4, 4,
 		   CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
 		   CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M(rot_div_clk, "rot-div", "de", 0x0c, 0x0c, 4,
+		   CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_M(mixer0_div_a83_clk, "mixer0-div", "pll-de", 0x0c, 0, =
4,
 		   CLK_SET_RATE_PARENT);
@@ -53,6 +59,24 @@ static SUNXI_CCU_M(mixer1_div_a83_clk, "mixer1-div", "=
pll-de", 0x0c, 4, 4,
 static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
 		   CLK_SET_RATE_PARENT);
=20
+static struct ccu_common *sun50i_h6_de3_clks[] =3D {
+	&mixer0_clk.common,
+	&mixer1_clk.common,
+	&wb_clk.common,
+
+	&bus_mixer0_clk.common,
+	&bus_mixer1_clk.common,
+	&bus_wb_clk.common,
+
+	&mixer0_div_clk.common,
+	&mixer1_div_clk.common,
+	&wb_div_clk.common,
+
+	&bus_rot_clk.common,
+	&rot_clk.common,
+	&rot_div_clk.common,
+};
+
 static struct ccu_common *sun8i_a83t_de2_clks[] =3D {
 	&mixer0_clk.common,
 	&mixer1_clk.common,
@@ -106,7 +130,7 @@ static struct clk_hw_onecell_data sun8i_a83t_de2_hw_c=
lks =3D {
 		[CLK_MIXER1_DIV]	=3D &mixer1_div_a83_clk.common.hw,
 		[CLK_WB_DIV]		=3D &wb_div_a83_clk.common.hw,
 	},
-	.num	=3D CLK_NUMBER,
+	.num	=3D CLK_NUMBER_WITHOUT_ROT,
 };
=20
 static struct clk_hw_onecell_data sun8i_h3_de2_hw_clks =3D {
@@ -123,7 +147,7 @@ static struct clk_hw_onecell_data sun8i_h3_de2_hw_clk=
s =3D {
 		[CLK_MIXER1_DIV]	=3D &mixer1_div_clk.common.hw,
 		[CLK_WB_DIV]		=3D &wb_div_clk.common.hw,
 	},
-	.num	=3D CLK_NUMBER,
+	.num	=3D CLK_NUMBER_WITHOUT_ROT,
 };
=20
 static struct clk_hw_onecell_data sun8i_v3s_de2_hw_clks =3D {
@@ -137,7 +161,27 @@ static struct clk_hw_onecell_data sun8i_v3s_de2_hw_c=
lks =3D {
 		[CLK_MIXER0_DIV]	=3D &mixer0_div_clk.common.hw,
 		[CLK_WB_DIV]		=3D &wb_div_clk.common.hw,
 	},
-	.num	=3D CLK_NUMBER,
+	.num	=3D CLK_NUMBER_WITHOUT_ROT,
+};
+
+static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks =3D {
+	.hws	=3D {
+		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
+		[CLK_MIXER1]		=3D &mixer1_clk.common.hw,
+		[CLK_WB]		=3D &wb_clk.common.hw,
+		[CLK_ROT]		=3D &rot_clk.common.hw,
+
+		[CLK_BUS_MIXER0]	=3D &bus_mixer0_clk.common.hw,
+		[CLK_BUS_MIXER1]	=3D &bus_mixer1_clk.common.hw,
+		[CLK_BUS_WB]		=3D &bus_wb_clk.common.hw,
+		[CLK_BUS_ROT]		=3D &bus_rot_clk.common.hw,
+
+		[CLK_MIXER0_DIV]	=3D &mixer0_div_clk.common.hw,
+		[CLK_MIXER1_DIV]	=3D &mixer1_div_clk.common.hw,
+		[CLK_WB_DIV]		=3D &wb_div_clk.common.hw,
+		[CLK_ROT_DIV]		=3D &rot_div_clk.common.hw,
+	},
+	.num	=3D CLK_NUMBER_WITH_ROT,
 };
=20
 static struct ccu_reset_map sun8i_a83t_de2_resets[] =3D {
@@ -156,6 +200,13 @@ static struct ccu_reset_map sun50i_a64_de2_resets[] =
=3D {
 	[RST_WB]	=3D { 0x08, BIT(2) },
 };
=20
+static struct ccu_reset_map sun50i_h6_de3_resets[] =3D {
+	[RST_MIXER0]	=3D { 0x08, BIT(0) },
+	[RST_MIXER1]	=3D { 0x08, BIT(1) },
+	[RST_WB]	=3D { 0x08, BIT(2) },
+	[RST_ROT]	=3D { 0x08, BIT(3) },
+};
+
 static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc =3D {
 	.ccu_clks	=3D sun8i_a83t_de2_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_a83t_de2_clks),
@@ -186,6 +237,16 @@ static const struct sunxi_ccu_desc sun50i_a64_de2_cl=
k_desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun50i_a64_de2_resets),
 };
=20
+static const struct sunxi_ccu_desc sun50i_h6_de3_clk_desc =3D {
+	.ccu_clks	=3D sun50i_h6_de3_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_h6_de3_clks),
+
+	.hw_clks	=3D &sun50i_h6_de3_hw_clks,
+
+	.resets		=3D sun50i_h6_de3_resets,
+	.num_resets	=3D ARRAY_SIZE(sun50i_h6_de3_resets),
+};
+
 static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
 	.ccu_clks	=3D sun8i_v3s_de2_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v3s_de2_clks),
@@ -296,6 +357,10 @@ static const struct of_device_id sunxi_de2_clk_ids[]=
 =3D {
 		.compatible =3D "allwinner,sun50i-h5-de2-clk",
 		.data =3D &sun50i_a64_de2_clk_desc,
 	},
+	{
+		.compatible =3D "allwinner,sun50i-h6-de3-clk",
+		.data =3D &sun50i_h6_de3_clk_desc,
+	},
 	{ }
 };
=20
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.h
index 530c006e0ae9..fc9c6b4c89a8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
@@ -22,7 +22,9 @@
 #define CLK_MIXER0_DIV	3
 #define CLK_MIXER1_DIV	4
 #define CLK_WB_DIV	5
+#define CLK_ROT_DIV	11
=20
-#define CLK_NUMBER	(CLK_WB + 1)
+#define CLK_NUMBER_WITH_ROT	(CLK_ROT_DIV + 1)
+#define CLK_NUMBER_WITHOUT_ROT	(CLK_WB + 1)
=20
 #endif /* _CCU_SUN8I_DE2_H_ */
--=20
2.19.1

