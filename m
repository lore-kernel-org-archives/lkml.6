Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeBGJKu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:10:50 -0500
Received: from mx.socionext.com ([202.248.49.38]:3330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753754AbeBGJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:10:42 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH v2 7/9] arm64: dts: uniphier: add sound node for UniPhier
Date: Wed,  7 Feb 2018 18:10:47 +0900
Message-Id: <20180207091049.24700-8-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
References: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio controller, codec and simple card node of
UniPhier AIO sound system for LD11/20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 72 ++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 31 ++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 72 ++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 35 +++++++++++
 4 files changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 2452b2243f42..4eb8d00a8c02 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -37,6 +37,29 @@
 		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
+
+	soc@0 {
+		sound {
+			compatible = "audio-graph-card";
+			label = "UniPhier LD11";
+			widgets = "Headphone", "Headphone Jack";
+
+			dais = <&i2s_port2
+				&i2s_port4
+				&spdif_port0>;
+		};
+
+		spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port@0 {
+				spdif_tx: endpoint {
+					remote-endpoint = <&spdif_hiecout1>;
+				};
+			};
+		};
+	};
 };
 
 &serial0 {
@@ -72,3 +95,52 @@
 &nand {
 	status = "okay";
 };
+
+&audio {
+	i2s_port0: port@0 {
+		i2s_hdmi: endpoint {
+		};
+	};
+
+	i2s_port1: port@1 {
+		i2s_pcmin2: endpoint {
+		};
+	};
+
+	i2s_port2: port@2 {
+		i2s_line: endpoint {
+			remote-endpoint = <&evea_line>;
+		};
+	};
+
+	i2s_port3: port@3 {
+		i2s_hpcmout1: endpoint {
+		};
+	};
+
+	i2s_port4: port@4 {
+		i2s_pcmout3: endpoint {
+			remote-endpoint = <&evea_hp>;
+		};
+	};
+
+	spdif_port0: port@5 {
+		spdif_hiecout1: endpoint {
+			remote-endpoint = <&spdif_tx>;
+		};
+	};
+};
+
+&evea {
+	port@0 {
+		evea_line: endpoint {
+			remote-endpoint = <&i2s_line>;
+		};
+	};
+
+	port@1 {
+		evea_hp: endpoint {
+			remote-endpoint = <&i2s_pcmout3>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index cd7c2d0a1f64..0e38252c05d7 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -187,6 +187,29 @@
 						     <21 217 3>;
 		};
 
+		audio: audio@56000000 {
+			compatible = "socionext,uniphier-ld11-aio";
+			reg = <0x56000000 0x80000>;
+			interrupts = <0 144 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_aout>;
+			clock-names = "aio";
+			clocks = <&sys_clk 40>;
+			reset-names = "aio";
+			resets = <&sys_rst 40>;
+			#sound-dai-cells = <1>;
+		};
+
+		evea: codec@57900000 {
+			compatible = "socionext,uniphier-evea";
+			reg = <0x57900000 0x1000>;
+			clock-names = "evea", "exiv";
+			clocks = <&sys_clk 41>, <&sys_clk 42>;
+			reset-names = "evea", "exiv", "adamv";
+			resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
+			#sound-dai-cells = <1>;
+		};
+
 		adamv@57920000 {
 			compatible = "socionext,uniphier-ld11-adamv",
 				     "simple-mfd", "syscon";
@@ -475,3 +498,11 @@
 };
 
 #include "uniphier-pinctrl.dtsi"
+
+&pinctrl_aout {
+	drive-strength = <4>;	/* default: 4mA */
+	group_1 {
+		pins = "AO1ARC";
+		drive-strength = <8>;	/* 8mA */
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index fc2bc9d75d35..ebcd65631bca 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -37,6 +37,29 @@
 		device_type = "memory";
 		reg = <0 0x80000000 0 0xc0000000>;
 	};
+
+	soc@0 {
+		sound {
+			compatible = "audio-graph-card";
+			label = "UniPhier LD20";
+			widgets = "Headphone", "Headphone Jack";
+
+			dais = <&i2s_port2
+				&i2s_port4
+				&spdif_port0>;
+		};
+
+		spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port@0 {
+				spdif_tx: endpoint {
+					remote-endpoint = <&spdif_hiecout1>;
+				};
+			};
+		};
+	};
 };
 
 &serial0 {
@@ -54,3 +77,52 @@
 &nand {
 	status = "okay";
 };
+
+&audio {
+	i2s_port0: port@0 {
+		i2s_hdmi: endpoint {
+		};
+	};
+
+	i2s_port1: port@1 {
+		i2s_pcmin2: endpoint {
+		};
+	};
+
+	i2s_port2: port@2 {
+		i2s_line: endpoint {
+			remote-endpoint = <&evea_line>;
+		};
+	};
+
+	i2s_port3: port@3 {
+		i2s_hpcmout1: endpoint {
+		};
+	};
+
+	i2s_port4: port@4 {
+		i2s_pcmout3: endpoint {
+			remote-endpoint = <&evea_hp>;
+		};
+	};
+
+	spdif_port0: port@5 {
+		spdif_hiecout1: endpoint {
+			remote-endpoint = <&spdif_tx>;
+		};
+	};
+};
+
+&evea {
+	port@0 {
+		evea_line: endpoint {
+			remote-endpoint = <&i2s_line>;
+		};
+	};
+
+	port@1 {
+		evea_hp: endpoint {
+			remote-endpoint = <&i2s_pcmout3>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8a3276ba2da1..0f74daa7eeb8 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -287,6 +287,29 @@
 						     <21 217 3>;
 		};
 
+		audio: audio@56000000 {
+			compatible = "socionext,uniphier-ld20-aio";
+			reg = <0x56000000 0x80000>;
+			interrupts = <0 144 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_aout>;
+			clock-names = "aio";
+			clocks = <&sys_clk 40>;
+			reset-names = "aio";
+			resets = <&sys_rst 40>;
+			#sound-dai-cells = <1>;
+		};
+
+		evea: codec@57900000 {
+			compatible = "socionext,uniphier-evea";
+			reg = <0x57900000 0x1000>;
+			clock-names = "evea", "exiv";
+			clocks = <&sys_clk 41>, <&sys_clk 42>;
+			reset-names = "evea", "exiv", "adamv";
+			resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
+			#sound-dai-cells = <1>;
+		};
+
 		adamv@57920000 {
 			compatible = "socionext,uniphier-ld20-adamv",
 				     "simple-mfd", "syscon";
@@ -528,3 +551,15 @@
 };
 
 #include "uniphier-pinctrl.dtsi"
+
+&pinctrl_aout {
+	drive-strength = <4>;	/* default: 3.5mA */
+	group_1 {
+		pins = "AO1DACCK";
+		drive-strength = <5>;	/* 5mA */
+	};
+	group_2 {
+		pins = "AO1ARC";
+		drive-strength = <11>;	/* 11mA */
+	};
+};
-- 
2.15.0
