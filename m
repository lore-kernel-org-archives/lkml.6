Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935261AbeBMNCH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:02:07 -0500
Received: from mx.socionext.com ([202.248.49.38]:19014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935119AbeBMNCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:02:05 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v3 2/3] arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
Date: Tue, 13 Feb 2018 22:01:55 +0900
Message-Id: <20180213130156.27827-3-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
References: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds codec node for TI TAS571x on UniPhier LD11/20
global boards. And adds settings of AIO for speaker out.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v3:
  - Use phandle of endpoint directly instead of port node
---
 .../boot/dts/socionext/uniphier-ld11-global.dts     | 21 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts     | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index fb6bf435dc96..f057ee80f38e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld11.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD11 Global Board (REF_LD11_GP)";
@@ -44,6 +45,7 @@
 		widgets = "Headphone", "Headphone Jack";
 
 		dais = <&i2s_port2
+			&i2s_port3
 			&i2s_port4
 			&spdif_port0>;
 	};
@@ -71,6 +73,20 @@
 &i2c0 {
 	status = "okay";
 
+	tas5707a@1d {
+		compatible = "ti,tas5711";
+		reg = <0x1d>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(23, 4) GPIO_ACTIVE_LOW>;
+		pdn-gpios = <&gpio UNIPHIER_GPIO_PORT(23, 5) GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			tas_speaker: endpoint {
+				remote-endpoint = <&i2s_hpcmout1>;
+			};
+		};
+	};
+
 	eeprom@50 {
 		compatible = "st,24c64", "atmel,24c64";
 		reg = <0x50>;
@@ -94,6 +110,11 @@
 	status = "okay";
 };
 
+&i2s_hpcmout1 {
+	dai-format = "i2s";
+	remote-endpoint = <&tas_speaker>;
+};
+
 &spdif_hiecout1 {
 	remote-endpoint = <&spdif_tx>;
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 2d49163cfde4..b2e197bc968c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld20.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD20 Global Board (REF_LD20_GP)";
@@ -44,6 +45,7 @@
 		widgets = "Headphone", "Headphone Jack";
 
 		dais = <&i2s_port2
+			&i2s_port3
 			&i2s_port4
 			&spdif_port0>;
 	};
@@ -70,12 +72,31 @@
 
 &i2c0 {
 	status = "okay";
+
+	tas5707@1b {
+		compatible = "ti,tas5711";
+		reg = <0x1b>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(0, 0) GPIO_ACTIVE_LOW>;
+		pdn-gpios = <&gpio UNIPHIER_GPIO_PORT(0, 1) GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			tas_speaker: endpoint {
+				remote-endpoint = <&i2s_hpcmout1>;
+			};
+		};
+	};
 };
 
 &nand {
 	status = "okay";
 };
 
+&i2s_hpcmout1 {
+	dai-format = "i2s";
+	remote-endpoint = <&tas_speaker>;
+};
+
 &spdif_hiecout1 {
 	remote-endpoint = <&spdif_tx>;
 };
-- 
2.15.1
