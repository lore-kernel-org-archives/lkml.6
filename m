Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCOLmP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:42:15 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59404 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751959AbeCOLlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:41:42 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drm/sun4i: Add driver support for A80 display pipeline
Date: Thu, 15 Mar 2018 19:41:33 +0800
Message-Id: <20180315114136.24747-6-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the compatible strings of the A80 display
pipeline.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c |  7 +++++++
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 12 ++++++++++--
 drivers/gpu/drm/sun4i/sun6i_drc.c     |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 092ade4ff6a5..ed36240048d5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -793,6 +793,9 @@ static const struct sun4i_backend_quirks sun7i_backend_quirks = {
 static const struct sun4i_backend_quirks sun8i_a33_backend_quirks = {
 };
 
+static const struct sun4i_backend_quirks sun9i_backend_quirks = {
+};
+
 static const struct of_device_id sun4i_backend_of_table[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-display-backend",
@@ -814,6 +817,10 @@ static const struct of_device_id sun4i_backend_of_table[] = {
 		.compatible = "allwinner,sun8i-a33-display-backend",
 		.data = &sun8i_a33_backend_quirks,
 	},
+	{
+		.compatible = "allwinner,sun9i-a80-display-backend",
+		.data = &sun9i_backend_quirks,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_backend_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index a0f43b81c64c..7f0705ef9f4e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -176,7 +176,13 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 		of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun7i-a20-display-frontend") ||
-		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend");
+		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend") ||
+		of_device_is_compatible(node, "allwinner,sun9i-a80-display-frontend");
+}
+
+static bool sun4i_drv_node_is_deu(struct device_node *node)
+{
+	return of_device_is_compatible(node, "allwinner,sun9i-a80-deu");
 }
 
 static bool sun4i_drv_node_is_supported_frontend(struct device_node *node)
@@ -257,7 +263,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	 * enabled frontend supported by the driver, we add it to our
 	 * component list.
 	 */
-	if (!sun4i_drv_node_is_frontend(node) ||
+	if (!(sun4i_drv_node_is_frontend(node) ||
+	      sun4i_drv_node_is_deu(node)) ||
 	    (sun4i_drv_node_is_supported_frontend(node) &&
 	     of_device_is_available(node))) {
 		/* Add current component */
@@ -361,6 +368,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-h3-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
+	{ .compatible = "allwinner,sun9i-a80-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun6i_drc.c b/drivers/gpu/drm/sun4i/sun6i_drc.c
index 09bba853e2a4..b5e071a49045 100644
--- a/drivers/gpu/drm/sun4i/sun6i_drc.c
+++ b/drivers/gpu/drm/sun4i/sun6i_drc.c
@@ -101,6 +101,7 @@ static const struct of_device_id sun6i_drc_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-drc" },
 	{ .compatible = "allwinner,sun6i-a31s-drc" },
 	{ .compatible = "allwinner,sun8i-a33-drc" },
+	{ .compatible = "allwinner,sun9i-a80-drc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_drc_of_table);
-- 
2.16.2
