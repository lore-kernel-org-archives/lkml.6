Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeCNF1D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:27:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:50588 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbeCNF1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:27:02 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ARM: dts: uniphier: add sound node for UniPhier PXs2
Date: Wed, 14 Mar 2018 14:26:58 +0900
Message-Id: <20180314052658.6244-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio controller, external codec and simple card node
of UniPhier AIO sound system for PXs2 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 24 +++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 37 ++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 54 ++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index d09acb8e59a1..782962749bbf 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -34,6 +34,12 @@
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "UniPhier PXs2";
+		dais = <&i2s_port2>;
+	};
 };
 
 &serial2 {
@@ -52,6 +58,19 @@
 
 &i2c2 {
 	status = "okay";
+
+	wm8960@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			wm_speaker: endpoint {
+				dai-format = "i2s";
+				remote-endpoint = <&i2s_aux>;
+			};
+		};
+	};
 };
 
 &eth {
@@ -64,3 +83,8 @@
 		reg = <1>;
 	};
 };
+
+&i2s_aux {
+	dai-format = "i2s";
+	remote-endpoint = <&wm_speaker>;
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 6f13a25b935f..33bcd98c8653 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -32,6 +32,35 @@
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "UniPhier PXs2";
+		dais = <&spdif_port0
+			&comp_spdif_port0>;
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
+
+	comp-spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			comp_spdif_tx: endpoint {
+				remote-endpoint = <&comp_spdif_hiecout1>;
+			};
+		};
+	};
 };
 
 &serial2 {
@@ -52,3 +81,11 @@
 		reg = <1>;
 	};
 };
+
+&spdif_hiecout1 {
+	remote-endpoint = <&spdif_tx>;
+};
+
+&comp_spdif_hiecout1 {
+	remote-endpoint = <&comp_spdif_tx>;
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 18f336e64036..d64ca9d0aef1 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -227,6 +227,60 @@
 						     <21 217 3>;
 		};
 
+		audio@56000000 {
+			compatible = "socionext,uniphier-pxs2-aio";
+			reg = <0x56000000 0x80000>;
+			interrupts = <0 144 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ain1>,
+				    <&pinctrl_ain2>,
+				    <&pinctrl_ainiec1>,
+				    <&pinctrl_aout2>,
+				    <&pinctrl_aout3>,
+				    <&pinctrl_aoutiec1>,
+				    <&pinctrl_aoutiec2>;
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
+				i2s_line: endpoint {
+				};
+			};
+
+			i2s_port2: port@2 {
+				i2s_aux: endpoint {
+				};
+			};
+
+			spdif_port0: port@3 {
+				spdif_hiecout1: endpoint {
+				};
+			};
+
+			spdif_port1: port@4 {
+				spdif_iecout1: endpoint {
+				};
+			};
+
+			comp_spdif_port0: port@5 {
+				comp_spdif_hiecout1: endpoint {
+				};
+			};
+
+			comp_spdif_port1: port@6 {
+				comp_spdif_iecout1: endpoint {
+				};
+			};
+		};
+
 		i2c0: i2c@58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
-- 
2.16.1
