Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A4C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA182084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfAYDXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:23:24 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59362 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbfAYDXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:20 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 55CEA5FDD0; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] drm/sun4i: Add support for A23 display pipeline
Date:   Fri, 25 Jan 2019 11:23:09 +0800
Message-Id: <20190125032314.20915-7-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A23's display pipeline is similar to the A33. Differences include:

  - Display backend supports larger layers, 8192x8192 instead of 2048x2048

  - TCON has DMA input

  - There is no SAT module packed in the display backend

Add support for the display pipeline and its components.

As the MIPI DSI output device is not officially documented, and there
are no A23 reference devices to test it, it is not covered by this
patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_drv.c      | 2 ++
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c     | 1 +
 drivers/gpu/drm/sun4i/sun6i_drc.c      | 1 +
 5 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 85e64d02fb5f..2ada915a877e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -1012,6 +1012,10 @@ static const struct of_device_id sun4i_backend_of_table[] = {
 		.compatible = "allwinner,sun7i-a20-display-backend",
 		.data = &sun7i_backend_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-a23-display-backend",
+		.data = &sun8i_a33_backend_quirks,
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-backend",
 		.data = &sun8i_a33_backend_quirks,
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 93da837194cf..477957a865fb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -165,6 +165,7 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 		of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun7i-a20-display-frontend") ||
+		of_device_is_compatible(node, "allwinner,sun8i-a23-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun9i-a80-display-frontend");
 }
@@ -404,6 +405,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
 	{ .compatible = "allwinner,sun7i-a20-display-engine" },
+	{ .compatible = "allwinner,sun8i-a23-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
 	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-h3-display-engine" },
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index e8239d4d4dd5..346c8071bd38 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -719,6 +719,10 @@ const struct of_device_id sun4i_frontend_of_table[] = {
 		.compatible = "allwinner,sun7i-a20-display-frontend",
 		.data = &sun4i_a10_frontend
 	},
+	{
+		.compatible = "allwinner,sun8i-a23-display-frontend",
+		.data = &sun8i_a33_frontend
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-frontend",
 		.data = &sun8i_a33_frontend
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0420f5c978b9..565955a46b0b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1494,6 +1494,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
+	{ .compatible = "allwinner,sun8i-a23-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
diff --git a/drivers/gpu/drm/sun4i/sun6i_drc.c b/drivers/gpu/drm/sun4i/sun6i_drc.c
index 88eb268fdf73..442094a4af7a 100644
--- a/drivers/gpu/drm/sun4i/sun6i_drc.c
+++ b/drivers/gpu/drm/sun4i/sun6i_drc.c
@@ -101,6 +101,7 @@ static int sun6i_drc_remove(struct platform_device *pdev)
 static const struct of_device_id sun6i_drc_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-drc" },
 	{ .compatible = "allwinner,sun6i-a31s-drc" },
+	{ .compatible = "allwinner,sun8i-a23-drc" },
 	{ .compatible = "allwinner,sun8i-a33-drc" },
 	{ .compatible = "allwinner,sun9i-a80-drc" },
 	{ }
-- 
2.20.1

