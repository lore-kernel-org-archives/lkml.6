Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeBGJKr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:10:47 -0500
Received: from mx.socionext.com ([202.248.49.38]:3345 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753768AbeBGJKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:10:43 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH v2 8/9] arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
Date: Wed,  7 Feb 2018 18:10:48 +0900
Message-Id: <20180207091049.24700-9-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
References: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds codec node for TI TAS571x on UniPhier LD11/20
global boards. And adds settings of AIO for speaker out.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts      | 20 ++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts      | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 4eb8d00a8c02..ca09251a3eab 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld11.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD11 Global Board (REF_LD11_GP)";
@@ -45,6 +46,7 @@
 			widgets = "Headphone", "Headphone Jack";
 
 			dais = <&i2s_port2
+				&i2s_port3
 				&i2s_port4
 				&spdif_port0>;
 		};
@@ -73,6 +75,20 @@
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
@@ -109,17 +125,21 @@
 
 	i2s_port2: port@2 {
 		i2s_line: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_line>;
 		};
 	};
 
 	i2s_port3: port@3 {
 		i2s_hpcmout1: endpoint {
+			dai-format = "i2s";
+			remote-endpoint = <&tas_speaker>;
 		};
 	};
 
 	i2s_port4: port@4 {
 		i2s_pcmout3: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_hp>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index ebcd65631bca..0728832ce552 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld20.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD20 Global Board (REF_LD20_GP)";
@@ -45,6 +46,7 @@
 			widgets = "Headphone", "Headphone Jack";
 
 			dais = <&i2s_port2
+				&i2s_port3
 				&i2s_port4
 				&spdif_port0>;
 		};
@@ -72,6 +74,20 @@
 
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
@@ -91,17 +107,21 @@
 
 	i2s_port2: port@2 {
 		i2s_line: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_line>;
 		};
 	};
 
 	i2s_port3: port@3 {
 		i2s_hpcmout1: endpoint {
+			dai-format = "i2s";
+			remote-endpoint = <&tas_speaker>;
 		};
 	};
 
 	i2s_port4: port@4 {
 		i2s_pcmout3: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_hp>;
 		};
 	};
-- 
2.15.0
