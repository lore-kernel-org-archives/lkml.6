Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeEYDCU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:02:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34724 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeEYDCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:02:16 -0400
X-Google-Smtp-Source: AB8JxZoTJXvKs1xbeFNGpeGRa1I9iF+UvzqGAhYr6tLllQjRIgGp3kSOy8Jt+HG1hCvoTFhjX9x4vQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
Date: Thu, 24 May 2018 20:01:53 -0700
Message-Id: <20180525030153.15986-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that MX51_PAD_GPIO1_1 does not remain configure as
ALT0/SD1_WP (it is out of reset). This is needed because of external
pull-up resistor attached to that pad that, when left unchanged, will
drive SD1_WP high preventing eSDHC1/eMMC from working correctly.

To fix that add a pinmux configuration line configureing the pad to
function as a GPIO. While we are at it, add a corresponding input GPIO
hog in an effort to minimize current consumption.

Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index df9eca94d812..d484e7e46b27 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -476,6 +476,17 @@
 	status = "okay";
 };
 
+&gpio1 {
+	unused-sd3-wp-gpio {
+		/*
+		 * See pinctrl_esdhc1 below for more details on this
+		 */
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		input;
+	};
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
@@ -660,6 +671,23 @@
 			MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
 			MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
 			MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
+			/*
+			 * GPIO1_1 is not directly used by eSDHC1 in
+			 * any capacity, but earlier versions of RDU1
+			 * used that pin as WP GPIO for eSDHC3 and
+			 * because of that that pad has an external
+			 * pull-up resistor. This is problematic
+			 * because out of reset the pad is configured
+			 * as ALT0 which serves as SD1_WP, which, when
+			 * pulled high by and external pull-up, will
+			 * inhibit execution of any write request to
+			 * attached eMMC device.
+			 *
+			 * To avoid this problem we configure the pad
+                	 * to ALT1/GPIO and avoid driving SD1_WP
+                	 * signal high.
+			 */
+			MX51_PAD_GPIO1_1__GPIO1_1		0x0000
 		>;
 	};
 
-- 
2.17.0
