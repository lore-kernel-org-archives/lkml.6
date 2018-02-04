Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeBDRz2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:55:28 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37195 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbeBDRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:55:12 -0500
X-Google-Smtp-Source: AH8x225BnE+/hJCsJs2IQIfFmNqtrMg2O5eDUSxvbdAewvxMqzXyOxJm/Fe1hOc3j9N7sjFhm8kqmg==
From: Jagan Teki <jagannadh.teki@gmail.com>
X-Google-Original-From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 6/7] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 7 initial support
Date: Sun,  4 Feb 2018 23:19:30 +0530
Message-Id: <1517766571-409-7-git-send-email-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.CoreM6 Quad/Dual OpenFrame modules are "system on modules plus
openframe display carriers" which are good solution for develop user
friendly graphic user interface.

ofcap 7 general features:
CPU           NXP Freescale i.MX6Q rev1.5 at 792 MHz
RAM           1GB, 32, 64 bit, DDR3-800/1066
NAND          SLC, 512MB
LVDS Display  TFT 7" industrial, 800x480 resolution
Touchscreen   EP0700M06 EDT Polytouch capacitive touch screen
Backlight     LED backlight, brightness 300 Cd/m2
Power supply  15 to 30 Vdc

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- Updated licence text - remove big notes, add SPDX and author

 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/imx6q-icore-ofcap7.dts | 65 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38..aa60320 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -458,6 +458,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-icore.dtb \
 	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-ofcap12.dtb \
+	imx6q-icore-ofcap7.dtb \
 	imx6q-icore-rqs.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb \
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap7.dts b/arch/arm/boot/dts/imx6q-icore-ofcap7.dts
new file mode 100644
index 0000000..6ff7a0a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap7.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2017 Engicam S.r.l.
+ * Copyright (C) 2017 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 Quad/Dual OpenFrame Capacitive touch 7 Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6q";
+
+	panel {
+		compatible = "ampire,am-800480aytzqw-00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	ep0700m06: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_edt_ft5x06>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <30 IRQ_TYPE_NONE>;
+		reset-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel@0 {
+		reg = <0>;
+		status = "okay";
+
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_edt_ft5x06:  edt-ft5x06grp  {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30 0x1b0b0 /*interrupt*/
+			MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00 0x1b0b0 /*reset edt*/
+		>;
+	};
+};
-- 
2.7.4
