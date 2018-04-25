Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbeDYRjt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:39:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44972 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbeDYRjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:39:46 -0400
X-Google-Smtp-Source: AIpwx49DVm9vtk9LRzEJN53YmFzXDxGXwU6tm9HBNYS+/nwMatPSceSebEoiUbnlUBBcW8p+QWsl4A==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/4] drm/panel: simple: Add support for Rocktech RK070ER9427 LCD panel
Date: Wed, 25 Apr 2018 23:09:29 +0530
Message-Id: <20180425173932.7213-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Rocktech Display Ltd. RK070ER9427
800(RGB)x480 TFT LCD panel, which can be supported by the
simple panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/rocktech,rk070er9427.txt         | 25 ++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
new file mode 100644
index 000000000000..eb1fb9f8d1f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
@@ -0,0 +1,25 @@
+Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Required properties:
+- compatible: should be "rocktech,rk070er9427"
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for LCD panel input.
+
+Example:
+	panel {
+		compatible = "rocktech,rk070er9427";
+		backlight = <&backlight_lcd>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..a6c633fd0559 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -745,6 +745,36 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct display_timing rocktech_rk070er9427_timing = {
+	.pixelclock = { 26400000, 33300000, 46800000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 210, 354 },
+	.hback_porch = { 46, 46, 46 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 22, 147 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 1, 1 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc rocktech_rk070er9427 = {
+	.timings = &rocktech_rk070er9427_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.delay = {
+		.prepare = 41,
+		.enable = 50,
+		.unprepare = 41,
+		.disable = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
 	{
 		.clock = 71900,
@@ -2226,6 +2256,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "qiaodian,qd43003c0-40",
 		.data = &qd43003c0_40,
+	}, {
+		.compatible = "rocktech,rk070er9427",
+		.data = &rocktech_rk070er9427,
 	}, {
 		.compatible = "samsung,lsn122dl01-c01",
 		.data = &samsung_lsn122dl01_c01,
-- 
2.14.3
