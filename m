Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3111DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2222133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeLSNLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:11:53 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:54235 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:11:36 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 08:11:35 EST
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 1D03540037;
        Wed, 19 Dec 2018 14:05:12 +0100 (CET)
Received: from orc.pedanet (c-17f4e255.26241707-0-68616c6d7374616473746164736e6174.bbcust.telenor.se [85.226.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id C493840005;
        Wed, 19 Dec 2018 14:05:11 +0100 (CET)
From:   Peter Rosin <peda@lysator.liu.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] drm/bridge: add pwdn-gpios support to the lvds-encoder
Date:   Wed, 19 Dec 2018 14:04:49 +0100
Message-Id: <20181219130449.31641-4-peda@lysator.liu.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219130449.31641-1-peda@lysator.liu.se>
References: <20181219130449.31641-1-peda@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Optionally power down the LVDS-encoder when it is not in use.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..43d584a6a6b9 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -11,11 +11,13 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_panel.h>
 
+#include <linux/gpio/consumer.h>
 #include <linux/of_graph.h>
 
 struct lvds_encoder {
 	struct drm_bridge bridge;
 	struct drm_bridge *panel_bridge;
+	struct gpio_desc *pwdn_gpio;
 };
 
 static int lvds_encoder_attach(struct drm_bridge *bridge)
@@ -28,8 +30,30 @@ static int lvds_encoder_attach(struct drm_bridge *bridge)
 				 bridge);
 }
 
+static void lvds_encoder_enable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder = container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->pwdn_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->pwdn_gpio, 0);
+}
+
+static void lvds_encoder_disable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder = container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->pwdn_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->pwdn_gpio, 1);
+}
+
 static struct drm_bridge_funcs funcs = {
 	.attach = lvds_encoder_attach,
+	.enable = lvds_encoder_enable,
+	.disable = lvds_encoder_disable,
 };
 
 static int lvds_encoder_probe(struct platform_device *pdev)
@@ -45,6 +69,16 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	if (!lvds_encoder)
 		return -ENOMEM;
 
+	lvds_encoder->pwdn_gpio = devm_gpiod_get_optional(&pdev->dev, "pwdn",
+							  GPIOD_OUT_HIGH);
+	if (IS_ERR(lvds_encoder->pwdn_gpio)) {
+		int err = PTR_ERR(lvds_encoder->pwdn_gpio);
+
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "pwdn GPIO failure: %d\n", err);
+		return err;
+	}
+
 	/* Locate the panel DT node. */
 	port = of_graph_get_port_by_id(pdev->dev.of_node, 1);
 	if (!port) {
-- 
2.11.0

