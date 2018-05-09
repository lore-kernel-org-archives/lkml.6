Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965121AbeEIPoW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:44:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36044 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935397AbeEIPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:44:20 -0400
X-Auth-Info: FvnlDdnSt70YP4dJG506J6AbrKPZWpWYfxPMWRB5ZLk=
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH RESEND] display: panel: Add KOE tx14d24vm1bpa display support (320x240)
Date: Wed,  9 May 2018 17:43:38 +0200
Message-Id: <20180509154338.2841-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412143715.6828-1-lukma@denx.de>
References: <20180412143715.6828-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for KOE's 5.7" display.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42 ++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt

diff --git a/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
new file mode 100644
index 000000000000..be7ac666807b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
@@ -0,0 +1,42 @@
+Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
+
+Required properties:
+- compatible: should be "koe,tx14d24vm1bpa"
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
+Example device-tree definition when connected to iMX53 based board
+
+	lcd_panel: lcd-panel {
+		compatible = "koe,tx14d24vm1bpa";
+		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
+Then one needs to extend the dispX node:
+
+	lcd_display: disp1 {
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d9984bdb5bb5..103b43ce7dee 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1268,6 +1268,29 @@ static const struct panel_desc innolux_zj070na_01p = {
 	},
 };
 
+static const struct display_timing koe_tx14d24vm1bpa_timing = {
+	.pixelclock = { 5580000, 5850000, 6200000 },
+	.hactive = { 320, 320, 320 },
+	.hfront_porch = { 30, 30, 30 },
+	.hback_porch = { 30, 30, 30 },
+	.hsync_len = { 1, 5, 17 },
+	.vactive = { 240, 240, 240 },
+	.vfront_porch = { 6, 6, 6 },
+	.vback_porch = { 5, 5, 5 },
+	.vsync_len = { 1, 2, 11 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc koe_tx14d24vm1bpa = {
+	.timings = &koe_tx14d24vm1bpa_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 115,
+		.height = 86,
+	},
+};
+
 static const struct display_timing koe_tx31d200vm0baa_timing = {
 	.pixelclock = { 39600000, 43200000, 48000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2204,6 +2227,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
 	}, {
+		.compatible = "koe,tx14d24vm1bpa",
+		.data = &koe_tx14d24vm1bpa,
+	}, {
 		.compatible = "koe,tx31d200vm0baa",
 		.data = &koe_tx31d200vm0baa,
 	}, {
-- 
2.11.0
