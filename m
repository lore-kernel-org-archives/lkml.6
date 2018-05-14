Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeENV6e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:58:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41529 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeENV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:58:21 -0400
X-Google-Smtp-Source: AB8JxZpMGI7Q14wFA0NgOK92eWtxjvyk1fW9PPm7u9HV2fuCihQKCaldah764nFgf5m7Joef6kGCOw==
From: Thomas Hebb <tommyhebb@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Synaptics
        Berlin SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 2/2] ARM: dts: chromecast: use PWM for LEDs
Date: Mon, 14 May 2018 17:58:15 -0400
Message-Id: <90316a6c92204399a4fecfe7cd2a2b808548fa48.1526334654.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1526334654.git.tommyhebb@gmail.com>
References: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1526334654.git.tommyhebb@gmail.com>
In-Reply-To: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1526334654.git.tommyhebb@gmail.com>
References: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1526334654.git.tommyhebb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control the Chromecast's two LEDs using PWM instead of GPIO pins. This
allows for variable brightness.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 .../boot/dts/berlin2cd-google-chromecast.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 54221f55bfa2..fb71e5436420 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -66,18 +66,21 @@
 	};
 
 	leds {
-		compatible = "gpio-leds";
+		compatible = "pwm-leds";
+		pinctrl-0 = <&ledpwm_pmux>;
+		pinctrl-names = "default";
 
 		white {
 			label = "white";
-			gpios = <&portc 1 GPIO_ACTIVE_HIGH>;
-			default-state = "keep";
+			pwms = <&pwm 0 600000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 		};
 
 		red {
 			label = "red";
-			gpios = <&portc 2 GPIO_ACTIVE_HIGH>;
-			default-state = "keep";
+			pwms = <&pwm 1 600000 0>;
+			max-brightness = <255>;
 		};
 	};
 };
@@ -96,3 +99,10 @@
 &usb_phy1 { status = "okay"; };
 
 &usb1 { status = "okay"; };
+
+&soc_pinctrl {
+	ledpwm_pmux: ledpwm-pmux {
+		groups = "G0";
+		function = "pwm";
+	};
+};
-- 
2.17.0
