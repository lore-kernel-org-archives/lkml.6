Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42400C677F5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D1520895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D1520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJGQq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:58 -0400
Received: from mailoutvs25.siol.net ([185.57.226.216]:40088 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728371AbeJGQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id EA32E52046A;
        Sun,  7 Oct 2018 11:40:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wvPgROXeLYGg; Sun,  7 Oct 2018 11:40:12 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 84B31520422;
        Sun,  7 Oct 2018 11:40:12 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 17E2052046A;
        Sun,  7 Oct 2018 11:40:10 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 22/29] drm/sun4i: Add support for Synopsys HDMI PHY
Date:   Sun,  7 Oct 2018 11:38:58 +0200
Message-Id: <20181007093905.11253-23-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 19 +++++++++++++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index 0306a51e1b35..492c938f119d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -185,9 +185,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, str=
uct device *master,
 	sun8i_hdmi_phy_init(hdmi->phy);
=20
 	plat_data->mode_valid =3D hdmi->quirks->mode_valid;
-	plat_data->phy_ops =3D sun8i_hdmi_phy_get_ops();
-	plat_data->phy_name =3D "sun8i_dw_hdmi_phy";
-	plat_data->phy_data =3D hdmi->phy;
+	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
=20
 	platform_set_drvdata(pdev, hdmi);
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
index f9eb663865a4..37646ff9a7a2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -150,6 +150,10 @@ struct sun8i_hdmi_phy;
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
@@ -198,7 +202,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, =
struct device_node *node);
 void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
=20
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
-const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
+void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
+			    struct dw_hdmi_plat_data *plat_data);
=20
 int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
 			 bool second_parent);
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
index adc3ba7df7e3..635825b55648 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -390,9 +390,20 @@ void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy)
 	phy->variant->phy_init(phy);
 }
=20
-const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void)
+void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
+			    struct dw_hdmi_plat_data *plat_data)
 {
-	return &sun8i_hdmi_phy_ops;
+	struct sun8i_hdmi_phy_variant *variant =3D phy->variant;
+
+	if (variant->is_custom_phy) {
+		plat_data->phy_ops =3D &sun8i_hdmi_phy_ops;
+		plat_data->phy_name =3D "sun8i_dw_hdmi_phy";
+		plat_data->phy_data =3D phy;
+	} else {
+		plat_data->mpll_cfg =3D variant->mpll_cfg;
+		plat_data->cur_ctr =3D variant->cur_ctr;
+		plat_data->phy_config =3D variant->phy_cfg;
+	}
 }
=20
 static struct regmap_config sun8i_hdmi_phy_regmap_config =3D {
@@ -404,6 +415,7 @@ static struct regmap_config sun8i_hdmi_phy_regmap_con=
fig =3D {
 };
=20
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy =3D {
+	.is_custom_phy =3D true,
 	.phy_init =3D &sun8i_hdmi_phy_init_a83t,
 	.phy_disable =3D &sun8i_hdmi_phy_disable_a83t,
 	.phy_config =3D &sun8i_hdmi_phy_config_a83t,
@@ -411,6 +423,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t=
_hdmi_phy =3D {
=20
 static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy =3D {
 	.has_phy_clk =3D true,
+	.is_custom_phy =3D true,
 	.phy_init =3D &sun8i_hdmi_phy_init_h3,
 	.phy_disable =3D &sun8i_hdmi_phy_disable_h3,
 	.phy_config =3D &sun8i_hdmi_phy_config_h3,
@@ -419,6 +432,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_h=
dmi_phy =3D {
 static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy =3D {
 	.has_phy_clk =3D true,
 	.has_second_pll =3D true,
+	.is_custom_phy =3D true,
 	.phy_init =3D &sun8i_hdmi_phy_init_h3,
 	.phy_disable =3D &sun8i_hdmi_phy_disable_h3,
 	.phy_config =3D &sun8i_hdmi_phy_config_h3,
@@ -426,6 +440,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_r40_=
hdmi_phy =3D {
=20
 static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy =3D {
 	.has_phy_clk =3D true,
+	.is_custom_phy =3D true,
 	.phy_init =3D &sun8i_hdmi_phy_init_h3,
 	.phy_disable =3D &sun8i_hdmi_phy_disable_h3,
 	.phy_config =3D &sun8i_hdmi_phy_config_h3,
--=20
2.19.0

