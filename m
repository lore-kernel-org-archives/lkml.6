Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10501C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02C520837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02C520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIBLmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:31 -0400
Received: from mailoutvs61.siol.net ([185.57.226.252]:54911 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbeIBLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6003C520C9D;
        Sun,  2 Sep 2018 09:27:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id of7ymJpEltlG; Sun,  2 Sep 2018 09:27:39 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CD716520C96;
        Sun,  2 Sep 2018 09:27:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4E09B520C9D;
        Sun,  2 Sep 2018 09:27:37 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 16/27] drm/sun4i: dw-hdmi: Make mode_valid function configurable
Date:   Sun,  2 Sep 2018 09:26:32 +0200
Message-Id: <20180902072643.4917-17-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it is not possible to access sun8i-dw-hdmi driver private data
inside mode_valid function, make it configurable. That way different
versions of HDMI controllers can set different function, depending on
it's limitations.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 18 ++++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 31875b636434..a5020fe8bd69 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -5,6 +5,7 @@
 
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <drm/drm_of.h>
@@ -33,8 +34,8 @@ static const struct drm_encoder_funcs sun8i_dw_hdmi_encoder_funcs = {
 };
 
 static enum drm_mode_status
-sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
-			 const struct drm_display_mode *mode)
+sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *connector,
+			      const struct drm_display_mode *mode)
 {
 	if (mode->clock > 297000)
 		return MODE_CLOCK_HIGH;
@@ -102,6 +103,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
+	hdmi->quirks = of_device_get_match_data(dev);
+
 	encoder->possible_crtcs =
 		sun8i_dw_hdmi_find_possible_crtcs(drm, dev->of_node);
 	/*
@@ -156,7 +159,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	sun8i_hdmi_phy_init(hdmi->phy);
 
-	plat_data->mode_valid = &sun8i_dw_hdmi_mode_valid;
+	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->phy_ops = sun8i_hdmi_phy_get_ops();
 	plat_data->phy_name = "sun8i_dw_hdmi_phy";
 	plat_data->phy_data = hdmi->phy;
@@ -215,8 +218,15 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
+	.mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
+};
+
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
-	{ .compatible = "allwinner,sun8i-a83t-dw-hdmi" },
+	{
+		.compatible = "allwinner,sun8i-a83t-dw-hdmi",
+		.data = &sun8i_a83t_quirks,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index aadbe0a10b0c..b718c47e00be 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -169,6 +169,11 @@ struct sun8i_hdmi_phy {
 	struct sun8i_hdmi_phy_variant	*variant;
 };
 
+struct sun8i_dw_hdmi_quirks {
+	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
+					   const struct drm_display_mode *mode);
+};
+
 struct sun8i_dw_hdmi {
 	struct clk			*clk_tmds;
 	struct device			*dev;
@@ -176,6 +181,7 @@ struct sun8i_dw_hdmi {
 	struct drm_encoder		encoder;
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
+	const struct sun8i_dw_hdmi_quirks *quirks;
 	struct reset_control		*rst_ctrl;
 };
 
-- 
2.18.0

