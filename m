Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935317AbeBMNCo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:02:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:19017 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935118AbeBMNCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:02:05 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v3 1/3] arm64: dts: uniphier: add sound node for UniPhier
Date: Tue, 13 Feb 2018 22:01:54 +0900
Message-Id: <20180213130156.27827-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
References: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio controller, codec and simple card node of
UniPhier AIO sound system for LD11/20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v3:
  - Move sound and spdif-out nodes to root from soc node
  - Use phandle of endpoint directly instead of port node
  - Describe connections between AIO and EVEA in *.dtsi
    because these cores are in inside of SoC
---
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 25 ++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 92 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 25 ++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 96 ++++++++++++++++++++++
 4 files changed, 238 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 2452b2243f42..fb6bf435dc96 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -37,6 +37,27 @@
 		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "UniPhier LD11";
+		widgets = "Headphone", "Headphone Jack";
+
+		dais = <&i2s_port2
+			&i2s_port4
+			&spdif_port0>;
+	};
+
+	spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			spdif_tx: endpoint {
+				remote-endpoint = <&spdif_hiecout1>;
+			};
+		};
+	};
 };
 
 &serial0 {
@@ -72,3 +93,7 @@
 &nand {
 	status = "okay";
 };
+
+&spdif_hiecout1 {
+	remote-endpoint = <&spdif_tx>;
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index cd7c2d0a1f64..f4eb1c6353a5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -187,6 +187,90 @@
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
+
+			i2s_port0: port@0 {
+				i2s_hdmi: endpoint {
+				};
+			};
+
+			i2s_port1: port@1 {
+				i2s_pcmin2: endpoint {
+				};
+			};
+
+			i2s_port2: port@2 {
+				i2s_line: endpoint {
+					dai-format = "i2s";
+					remote-endpoint = <&evea_line>;
+				};
+			};
+
+			i2s_port3: port@3 {
+				i2s_hpcmout1: endpoint {
+				};
+			};
+
+			i2s_port4: port@4 {
+				i2s_hp: endpoint {
+					dai-format = "i2s";
+					remote-endpoint = <&evea_hp>;
+				};
+			};
+
+			spdif_port0: port@5 {
+				spdif_hiecout1: endpoint {
+				};
+			};
+
+			src_port0: port@6 {
+				i2s_epcmout2: endpoint {
+				};
+			};
+
+			src_port1: port@7 {
+				i2s_epcmout3: endpoint {
+				};
+			};
+
+			comp_spdif_port0: port@8 {
+				comp_spdif_hiecout1: endpoint {
+				};
+			};
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
+
+			evea_line_port: port@0 {
+				evea_line: endpoint {
+					remote-endpoint = <&i2s_line>;
+				};
+			};
+
+			evea_hp_port: port@1 {
+				evea_hp: endpoint {
+					remote-endpoint = <&i2s_hp>;
+				};
+			};
+		};
+
 		adamv@57920000 {
 			compatible = "socionext,uniphier-ld11-adamv",
 				     "simple-mfd", "syscon";
@@ -475,3 +559,11 @@
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
index fc2bc9d75d35..2d49163cfde4 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -37,6 +37,27 @@
 		device_type = "memory";
 		reg = <0 0x80000000 0 0xc0000000>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "UniPhier LD20";
+		widgets = "Headphone", "Headphone Jack";
+
+		dais = <&i2s_port2
+			&i2s_port4
+			&spdif_port0>;
+	};
+
+	spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			spdif_tx: endpoint {
+				remote-endpoint = <&spdif_hiecout1>;
+			};
+		};
+	};
 };
 
 &serial0 {
@@ -54,3 +75,7 @@
 &nand {
 	status = "okay";
 };
+
+&spdif_hiecout1 {
+	remote-endpoint = <&spdif_tx>;
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8a3276ba2da1..9d0f23f100df 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -287,6 +287,90 @@
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
+
+			i2s_port0: port@0 {
+				i2s_hdmi: endpoint {
+				};
+			};
+
+			i2s_port1: port@1 {
+				i2s_pcmin2: endpoint {
+				};
+			};
+
+			i2s_port2: port@2 {
+				i2s_line: endpoint {
+					dai-format = "i2s";
+					remote-endpoint = <&evea_line>;
+				};
+			};
+
+			i2s_port3: port@3 {
+				i2s_hpcmout1: endpoint {
+				};
+			};
+
+			i2s_port4: port@4 {
+				i2s_hp: endpoint {
+					dai-format = "i2s";
+					remote-endpoint = <&evea_hp>;
+				};
+			};
+
+			spdif_port0: port@5 {
+				spdif_hiecout1: endpoint {
+				};
+			};
+
+			src_port0: port@6 {
+				i2s_epcmout2: endpoint {
+				};
+			};
+
+			src_port1: port@7 {
+				i2s_epcmout3: endpoint {
+				};
+			};
+
+			comp_spdif_port0: port@8 {
+				comp_spdif_hiecout1: endpoint {
+				};
+			};
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
+
+			evea_line_port: port@0 {
+				evea_line: endpoint {
+					remote-endpoint = <&i2s_line>;
+				};
+			};
+
+			evea_hp_port: port@1 {
+				evea_hp: endpoint {
+					remote-endpoint = <&i2s_hp>;
+				};
+			};
+		};
+
 		adamv@57920000 {
 			compatible = "socionext,uniphier-ld20-adamv",
 				     "simple-mfd", "syscon";
@@ -528,3 +612,15 @@
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
2.15.1
