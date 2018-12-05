Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECEC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9DB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9DB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeLEIig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:38:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36343 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeLEIh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:37:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 215BD20DC0; Wed,  5 Dec 2018 09:37:56 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96E1F20DC9;
        Wed,  5 Dec 2018 09:37:29 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 18/22] drm/sun4i: frontend: Add a quirk structure
Date:   Wed,  5 Dec 2018 09:36:59 +0100
Message-Id: <20181205083703.21488-19-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The ACCESS_CTRL bit is not found on all the variants of the frontend, so
let's introduce a structure that will hold whether or not we need to set
it, and associate it with the compatible.

This will be extended for further similar quirks later on.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 21 +++++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 ++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 88ac77518610..6636b1998a76 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -75,9 +76,10 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
 
-	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
+	if (frontend->data->has_coef_access_ctrl)
+		regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
 
 	for (i = 0; i < 32; i++) {
 		regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZCOEF0_REG(i),
@@ -553,6 +555,10 @@ static int sun4i_frontend_bind(struct device *dev, struct device *master,
 	frontend->dev = dev;
 	frontend->node = dev->of_node;
 
+	frontend->data = of_device_get_match_data(dev);
+	if (!frontend->data)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
@@ -665,8 +671,15 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 	.runtime_suspend	= sun4i_frontend_runtime_suspend,
 };
 
+static const struct sun4i_frontend_data sun8i_a33_frontend = {
+	.has_coef_access_ctrl	= true,
+};
+
 const struct of_device_id sun4i_frontend_of_table[] = {
-	{ .compatible = "allwinner,sun8i-a33-display-frontend" },
+	{
+		.compatible = "allwinner,sun8i-a33-display-frontend",
+		.data = &sun8i_a33_frontend
+	},
 	{ }
 };
 EXPORT_SYMBOL(sun4i_frontend_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 235109199b9d..01e68bb11c98 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -112,6 +112,10 @@ struct drm_plane;
 struct regmap;
 struct reset_control;
 
+struct sun4i_frontend_data {
+	bool	has_coef_access_ctrl;
+};
+
 struct sun4i_frontend {
 	struct list_head	list;
 	struct device		*dev;
@@ -122,6 +126,8 @@ struct sun4i_frontend {
 	struct clk		*ram_clk;
 	struct regmap		*regs;
 	struct reset_control	*reset;
+
+	const struct sun4i_frontend_data	*data;
 };
 
 extern const struct of_device_id sun4i_frontend_of_table[];
-- 
2.19.2

