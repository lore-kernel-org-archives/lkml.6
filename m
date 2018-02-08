Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeBHSbE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:31:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeBHSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:31:01 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 6/8] drm/omap: panel-dsi-cm: add orientation support
Date: Thu,  8 Feb 2018 19:30:33 +0100
Message-Id: <20180208183035.8461-7-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to inform the DRM subsystem about the orientation
the display has been mounted to the casing.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 15399a1a666b..7a63d6775a27 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -68,6 +68,7 @@ struct panel_drv_data {
 
 	int width_mm;
 	int height_mm;
+	int orientation;
 
 	struct omap_dsi_pin_config pin_config;
 
@@ -1198,6 +1199,14 @@ static void dsicm_get_size(struct omap_dss_device *dssdev,
 	*height = ddata->height_mm;
 }
 
+static void dsicm_get_orientation(struct omap_dss_device *dssdev,
+				  int *orientation)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*orientation = ddata->orientation;
+}
+
 static struct omap_dss_driver dsicm_ops = {
 	.connect	= dsicm_connect,
 	.disconnect	= dsicm_disconnect,
@@ -1211,6 +1220,7 @@ static struct omap_dss_driver dsicm_ops = {
 	.get_timings	= dsicm_get_timings,
 	.check_timings	= dsicm_check_timings,
 	.get_size	= dsicm_get_size,
+	.get_orientation = dsicm_get_orientation,
 
 	.enable_te	= dsicm_enable_te,
 	.get_te		= dsicm_get_te,
@@ -1259,6 +1269,9 @@ static int dsicm_probe_of(struct platform_device *pdev)
 	ddata->height_mm = 0;
 	of_property_read_u32(node, "height-mm", &ddata->height_mm);
 
+	ddata->orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+	of_property_read_u32(node, "orientation", &ddata->orientation);
+
 	in = omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
 		dev_err(&pdev->dev, "failed to find video source\n");
-- 
2.15.1
