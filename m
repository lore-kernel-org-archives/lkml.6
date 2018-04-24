Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934619AbeDXNgb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:36:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46663 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757457AbeDXNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:35:42 -0400
X-Google-Smtp-Source: AIpwx487z+aLlnOmCjMjGrt7UznnSFXpD/lzDudSPWr77U6EsDW3Z/2gvcLPIlD7KPdnyPcWa4KtYg==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [RFC 12/13] arm64: dts: allwinner: a64: Add HDMI pipeline
Date: Tue, 24 Apr 2018 19:04:24 +0530
Message-Id: <20180424133425.24291-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180424133425.24291-1-jagan@amarulasolutions.com>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI pipeline on A64 has similar behavior like A83T where
tcon1 is connected to HDMI. So reuse similar dts nodes for A64.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 79 ++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index aa73f1ce1ab2..56e06e504d5f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -109,7 +109,7 @@
 
 	de: display-engine {
 		compatible = "allwinner,sun50i-a64-display-engine";
-		allwinner,pipelines = <&mixer0>;
+		allwinner,pipelines = <&mixer0>, <&mixer1>;
 		status = "disabled";
 	};
 
@@ -213,6 +213,31 @@
 			};
 		};
 
+		mixer1: mixer@1200000 {
+			compatible = "allwinner,sun50i-a64-de2-mixer-1",
+				     "allwinner,sun8i-a83t-de2-mixer-1";
+			reg = <0x01200000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER1>,
+				 <&display_clocks CLK_MIXER1>;
+			clock-names = "bus",
+				      "mod";
+			resets = <&display_clocks RST_WB>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer1_out: port@1 {
+					reg = <1>;
+
+					mixer1_out_tcon1: endpoint {
+						remote-endpoint = <&tcon1_in_mixer1>;
+					};
+				};
+			};
+		};
+
+
 		syscon: syscon@1c00000 {
 			compatible = "allwinner,sun50i-a64-system-controller",
 				"syscon";
@@ -261,6 +286,41 @@
 			};
 		};
 
+		tcon1: lcd-controller@1c0d000 {
+			compatible = "allwinner,sun50i-a64-tcon-tv",
+				     "allwinner,sun8i-a83t-tcon-tv";
+			reg = <0x01c0d000 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON1>, <&ccu CLK_TCON1>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON1>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon1_in: port@0 {
+					reg = <0>;
+
+					tcon1_in_mixer1: endpoint {
+						remote-endpoint = <&mixer1_out_tcon1>;
+					};
+				};
+
+				tcon1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon1_out_hdmi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in_tcon1>;
+					};
+				};
+			};
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun50i-a64-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -719,6 +779,23 @@
 			phys = <&hdmi_phy>;
 			phy-names = "hdmi-phy";
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port@0 {
+					reg = <0>;
+
+					hdmi_in_tcon1: endpoint {
+						remote-endpoint = <&tcon1_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port@1 {
+					reg = <1>;
+				};
+			};
 		};
 
 		hdmi_phy: hdmi-phy@1ef0000 {
-- 
2.14.3
