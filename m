Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7100FECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9A2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbeKEDoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:12 -0500
Received: from mailoutvs22.siol.net ([185.57.226.213]:47511 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387616AbeKEDoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7F227521257;
        Sun,  4 Nov 2018 19:28:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id coJbQlaTzQkU; Sun,  4 Nov 2018 19:28:17 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D71B75212AF;
        Sun,  4 Nov 2018 19:28:15 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 65A8B521292;
        Sun,  4 Nov 2018 19:28:13 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 16/28] drm/sun4i: dw-hdmi: Make mode_valid function configurable
Date:   Sun,  4 Nov 2018 19:26:53 +0100
Message-Id: <20181104182705.18047-17-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it is not possible to access sun8i-dw-hdmi driver private data
inside mode_valid function, make it configurable. That way different
versions of HDMI controllers can set different function, depending on
it's limitations.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 18 ++++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index ed2983770e9c..ec122136ee9d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -5,6 +5,7 @@
=20
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
=20
 #include <drm/drm_of.h>
@@ -33,8 +34,8 @@ static const struct drm_encoder_funcs sun8i_dw_hdmi_enc=
oder_funcs =3D {
 };
=20
 static enum drm_mode_status
-sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
-			 const struct drm_display_mode *mode)
+sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *connector,
+			      const struct drm_display_mode *mode)
 {
 	if (mode->clock > 297000)
 		return MODE_CLOCK_HIGH;
@@ -102,6 +103,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, str=
uct device *master,
 	hdmi->dev =3D &pdev->dev;
 	encoder =3D &hdmi->encoder;
=20
+	hdmi->quirks =3D of_device_get_match_data(dev);
+
 	encoder->possible_crtcs =3D
 		sun8i_dw_hdmi_find_possible_crtcs(drm, dev->of_node);
 	/*
@@ -168,7 +171,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, str=
uct device *master,
=20
 	sun8i_hdmi_phy_init(hdmi->phy);
=20
-	plat_data->mode_valid =3D &sun8i_dw_hdmi_mode_valid;
+	plat_data->mode_valid =3D hdmi->quirks->mode_valid;
 	plat_data->phy_ops =3D sun8i_hdmi_phy_get_ops();
 	plat_data->phy_name =3D "sun8i_dw_hdmi_phy";
 	plat_data->phy_data =3D hdmi->phy;
@@ -230,8 +233,15 @@ static int sun8i_dw_hdmi_remove(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
+static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks =3D {
+	.mode_valid =3D sun8i_dw_hdmi_mode_valid_a83t,
+};
+
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] =3D {
-	{ .compatible =3D "allwinner,sun8i-a83t-dw-hdmi" },
+	{
+		.compatible =3D "allwinner,sun8i-a83t-dw-hdmi",
+		.data =3D &sun8i_a83t_quirks,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
index 7fdc1ecd2892..a645b8bc9f58 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -170,6 +170,11 @@ struct sun8i_hdmi_phy {
 	struct sun8i_hdmi_phy_variant	*variant;
 };
=20
+struct sun8i_dw_hdmi_quirks {
+	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
+					   const struct drm_display_mode *mode);
+};
+
 struct sun8i_dw_hdmi {
 	struct clk			*clk_tmds;
 	struct device			*dev;
@@ -178,6 +183,7 @@ struct sun8i_dw_hdmi {
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
 	struct regulator		*regulator;
+	const struct sun8i_dw_hdmi_quirks *quirks;
 	struct reset_control		*rst_ctrl;
 };
=20
--=20
2.19.1

