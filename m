Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeBHSa7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:30:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48630 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeBHSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:30:57 -0500
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
Subject: [PATCHv2 5/8] drm/omap: add support for orientation hints from display drivers
Date: Thu,  8 Feb 2018 19:30:32 +0100
Message-Id: <20180208183035.8461-6-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for setting DRM panel orientation property
based on information from the display driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h    |  2 ++
 drivers/gpu/drm/omapdrm/omap_connector.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index f8f83e826a56..72ebd82409d3 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -565,6 +565,8 @@ struct omap_dss_driver {
 			    struct videomode *vm);
 	void (*get_size)(struct omap_dss_device *dssdev,
 			 unsigned int *width, unsigned int *height);
+	void (*get_orientation)(struct omap_dss_device *dssdev,
+				int *orientation);
 
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index a33b51484b2d..2f296d29b74b 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -249,6 +249,7 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 	struct drm_connector *connector = NULL;
 	struct omap_connector *omap_connector;
 	bool hpd_supported = false;
+	int ret;
 
 	DBG("%s", dssdev->name);
 
@@ -267,7 +268,7 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 	drm_connector_helper_add(connector, &omap_connector_helper_funcs);
 
 	if (dssdev->driver->register_hpd_cb) {
-		int ret = dssdev->driver->register_hpd_cb(dssdev,
+		ret = dssdev->driver->register_hpd_cb(dssdev,
 							  omap_connector_hpd_cb,
 							  omap_connector);
 		if (!ret)
@@ -288,6 +289,13 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 	connector->interlace_allowed = 1;
 	connector->doublescan_allowed = 0;
 
+	if (dssdev->driver->get_orientation)
+		dssdev->driver->get_orientation(dssdev, &connector->display_info.panel_orientation);
+
+	ret = drm_connector_init_panel_orientation_property(connector, 0, 0);
+	if (ret)
+		DBG("%s: Failed to init orientation property (%d)", dssdev->name, ret);
+
 	return connector;
 
 fail:
-- 
2.15.1
