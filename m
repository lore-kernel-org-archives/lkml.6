Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeEGWFG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:05:06 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:42888 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752755AbeEGWFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:05:05 -0400
From: Paul Kocialkowski <contact@paulk.fr>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
Date: Tue,  8 May 2018 00:04:11 +0200
Message-Id: <20180507220413.21990-1-contact@paulk.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
as found on the Ainol AW1 tablet.

The panel also supports RGB888 output. When RGB666 mode is used instead,
the two extra lanes per component are grounded.

In the future, it might become necessary to introduce a dedicated
device-tree property to specify the bus format to use instead of the
default one for the panel. This will allow supporting different bus
formats for the same panel modes.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..32e30d5a8f08 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043tn24 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
 };
 
+static const struct drm_display_mode innolux_at070tn90_mode = {
+	.clock = 40000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 112,
+	.hsync_end = 800 + 112 + 1,
+	.htotal = 800 + 112 + 1 + 87,
+	.vdisplay = 480,
+	.vsync_start = 480 + 141,
+	.vsync_end = 480 + 141 + 1,
+	.vtotal = 480 + 141 + 1 + 38,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc innolux_at070tn90 = {
+	.modes = &innolux_at070tn90_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct drm_display_mode innolux_at070tn92_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -2151,6 +2174,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,at043tn24",
 		.data = &innolux_at043tn24,
+	}, {
+		.compatible = "innolux,at070tn90",
+		.data = &innolux_at070tn90,
 	}, {
 		.compatible = "innolux,at070tn92",
 		.data = &innolux_at070tn92,
-- 
2.17.0
