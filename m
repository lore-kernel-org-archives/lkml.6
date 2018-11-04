Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C5ECDE47
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFBC2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFBC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbeKEDoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:32 -0500
Received: from mailoutvs47.siol.net ([185.57.226.238]:47684 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387692AbeKEDob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 49C7C52015C;
        Sun,  4 Nov 2018 19:28:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ygrmphSUTUlh; Sun,  4 Nov 2018 19:28:36 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D1622520373;
        Sun,  4 Nov 2018 19:28:36 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B3AED521292;
        Sun,  4 Nov 2018 19:28:33 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 24/28] drm: sun4i: add quirks for TCON TOP
Date:   Sun,  4 Nov 2018 19:27:01 +0100
Message-Id: <20181104182705.18047-25-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Some SoCs, such as H6, doesn't have a full-featured TCON TOP.

Add quirks support for TCON TOP.

Currently the presence of TCON_TV1 and DSI is controlled via the quirks
structure.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
[Fixed code style and removed unnecessary initialization]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 37 +++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
index 37158548b447..e94e3fb1736b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -9,11 +9,17 @@
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
=20
 #include "sun8i_tcon_top.h"
=20
+struct sun8i_tcon_top_quirks {
+	bool has_tcon_tv1;
+	bool has_dsi;
+};
+
 static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
 {
 	return !!of_match_node(sun8i_tcon_top_of_table, node);
@@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, =
struct device *master,
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct clk_hw_onecell_data *clk_data;
 	struct sun8i_tcon_top *tcon_top;
+	const struct sun8i_tcon_top_quirks *quirks;
 	struct resource *res;
 	void __iomem *regs;
 	int ret, i;
=20
+	quirks =3D of_device_get_match_data(&pdev->dev);
+
 	tcon_top =3D devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
 	if (!tcon_top)
 		return -ENOMEM;
@@ -187,15 +196,17 @@ static int sun8i_tcon_top_bind(struct device *dev, =
struct device *master,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_TV0_GATE, 0);
=20
-	clk_data->hws[CLK_TCON_TOP_TV1] =3D
-		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
-					     &tcon_top->reg_lock,
-					     TCON_TOP_TCON_TV1_GATE, 1);
+	if (quirks->has_tcon_tv1)
+		clk_data->hws[CLK_TCON_TOP_TV1] =3D
+			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
+						     &tcon_top->reg_lock,
+						     TCON_TOP_TCON_TV1_GATE, 1);
=20
-	clk_data->hws[CLK_TCON_TOP_DSI] =3D
-		sun8i_tcon_top_register_gate(dev, "dsi", regs,
-					     &tcon_top->reg_lock,
-					     TCON_TOP_TCON_DSI_GATE, 2);
+	if (quirks->has_dsi)
+		clk_data->hws[CLK_TCON_TOP_DSI] =3D
+			sun8i_tcon_top_register_gate(dev, "dsi", regs,
+						     &tcon_top->reg_lock,
+						     TCON_TOP_TCON_DSI_GATE, 2);
=20
 	for (i =3D 0; i < CLK_NUM; i++)
 		if (IS_ERR(clk_data->hws[i])) {
@@ -257,9 +268,17 @@ static int sun8i_tcon_top_remove(struct platform_dev=
ice *pdev)
 	return 0;
 }
=20
+const struct sun8i_tcon_top_quirks sun8i_r40_tcon_top_quirks =3D {
+	.has_tcon_tv1	=3D true,
+	.has_dsi	=3D true,
+};
+
 /* sun4i_drv uses this list to check if a device node is a TCON TOP */
 const struct of_device_id sun8i_tcon_top_of_table[] =3D {
-	{ .compatible =3D "allwinner,sun8i-r40-tcon-top" },
+	{
+		.compatible =3D "allwinner,sun8i-r40-tcon-top",
+		.data =3D &sun8i_r40_tcon_top_quirks
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
--=20
2.19.1

