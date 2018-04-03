Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbeDCKPr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:15:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50149 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754838AbeDCKPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:15:46 -0400
X-Auth-Info: jH421ovmOFdgEFnq8pedUc8JHXFodeH0kG3Gs4UJCWY=
From: Lukasz Majewski <lukma@denx.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] display: panel: Add AUO g070vvn01 display support (800x480)
Date: Tue,  3 Apr 2018 12:15:25 +0200
Message-Id: <20180403101525.22369-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for AUO's 7.0" display.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../bindings/display/panel/auo,g070vvn01           | 30 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 31 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g070vvn01

diff --git a/Documentation/devicetree/bindings/display/panel/auo,g070vvn01 b/Documentation/devicetree/bindings/display/panel/auo,g070vvn01
new file mode 100644
index 000000000000..bd4017362094
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,g070vvn01
@@ -0,0 +1,30 @@
+AU Optronics Corporation 7.0" FHD (800 x 480) TFT LCD panel
+
+Required properties:
+- compatible: should be "auo,g070vvn01"
+- backlight: phandle of the backlight device attached to the panel
+- power-supply: single regulator to provide the supply voltage
+
+Required nodes:
+- port: Parallel port mapping to connect this display
+
+This panel needs single power supply voltage. Its backlight is conntrolled
+via PWM signal.
+
+Example:
+--------
+
+Example device-tree definition when connected to iMX6Q based board
+
+	lcd_panel: lcd-panel {
+		compatible = "auo,g070vvn01";
+		backlight = <&backlight_lcd>;
+		bus-format-override = "rgb565";
+		power-supply = <&reg_display>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5591984a392b..62314085b635 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -581,6 +581,34 @@ static const struct panel_desc auo_b133htn01 = {
 	},
 };
 
+static const struct display_timing auo_g070vvn01_timings = {
+	.pixelclock = { 33300000, 34209000, 45000000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 20, 40, 200 },
+	.hback_porch = { 87, 40, 1 },
+	.hsync_len = { 1, 48, 87 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 5, 13, 200 },
+	.vback_porch = { 31, 31, 29 },
+	.vsync_len = { 1, 1, 3 },
+};
+
+static const struct panel_desc auo_g070vvn01 = {
+	.timings = &auo_g070vvn01_timings,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.delay = {
+		.prepare = 200,
+		.enable = 50,
+		.disable = 50,
+		.unprepare = 1000,
+	},
+};
+
 static const struct display_timing auo_g133han01_timings = {
 	.pixelclock = { 134000000, 141200000, 149000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -2049,6 +2077,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "auo,b133xtn01",
 		.data = &auo_b133xtn01,
 	}, {
+		.compatible = "auo,g070vvn01",
+		.data = &auo_g070vvn01,
+	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
 	}, {
-- 
2.11.0
