Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2085C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEDB2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEDB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIDJFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:45 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45045 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeIDJFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:44 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id AE85FFFA34;
        Tue,  4 Sep 2018 04:42:19 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
Date:   Tue,  4 Sep 2018 12:40:50 +0800
Message-Id: <20180904044053.15425-9-icenowy@aosc.io>
In-Reply-To: <20180904044053.15425-1-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

Allwinner A64 have a display pipeline with 2 mixers/TCONs, the first
TCON is connected to LCD and the second is to HDMI.

The HDMI controller/PHY pair is similar to the one on H3/H5.

Add all required device tree nodes of the display pipeline, including
the TCON0 LCD one and the TCON1 HDMI one.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
[Icenowy: refactor commit message and add 1st pipeline]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes for v4:
- Misc fixes
- Dropped second PLL from HDMI PHY clock
Changes for v3.1:
- Refactor commit message to make it more clear.
- Added first pipeline (mixer0 -> tcon0)
Changes for v3:
- Squash all pipeline components in one patch
- Add status for mixer1 and tcon1
Changes for v2:
- Change compatibles and other based on previous patch changes

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index b73f9287c3f0..8c7bcae0b8ec 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -121,6 +121,13 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun50i-a64-display-engine";
+		allwinner,pipelines = <&mixer0>,
+				      <&mixer1>;
+		status = "disabled";
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -203,6 +210,52 @@
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 			};
+
+			mixer0: mixer@100000 {
+				compatible = "allwinner,sun50i-a64-de2-mixer-0";
+				reg = <0x100000 0x100000>;
+				clocks = <&display_clocks CLK_BUS_MIXER0>,
+					 <&display_clocks CLK_MIXER0>;
+				clock-names = "bus",
+					      "mod";
+				resets = <&display_clocks RST_MIXER0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					mixer0_out: port@1 {
+						reg = <1>;
+
+						mixer0_out_tcon0: endpoint {
+							remote-endpoint = <&tcon0_in_mixer0>;
+						};
+					};
+				};
+			};
+
+			mixer1: mixer@200000 {
+				compatible = "allwinner,sun50i-a64-de2-mixer-1";
+				reg = <0x200000 0x100000>;
+				clocks = <&display_clocks CLK_BUS_MIXER1>,
+					 <&display_clocks CLK_MIXER1>;
+				clock-names = "bus",
+					      "mod";
+				resets = <&display_clocks RST_MIXER1>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					mixer1_out: port@1 {
+						reg = <1>;
+
+						mixer1_out_tcon1: endpoint {
+							remote-endpoint = <&tcon1_in_mixer1>;
+						};
+					};
+				};
+			};
 		};
 
 		syscon: syscon@1c00000 {
@@ -237,6 +290,75 @@
 			#dma-cells = <1>;
 		};
 
+		tcon0: lcd-controller@1c0c000 {
+			compatible = "allwinner,sun50i-a64-tcon-lcd",
+				     "allwinner,sun8i-a83t-tcon-lcd";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
+			clock-names = "ahb", "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
+			reset-names = "lcd", "lvds";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon0_in_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&mixer0_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
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
@@ -700,6 +826,50 @@
 			status = "disabled";
 		};
 
+		hdmi: hdmi@1ee0000 {
+			compatible = "allwinner,sun50i-a64-dw-hdmi",
+				     "allwinner,sun8i-a83t-dw-hdmi";
+			reg = <0x01ee0000 0x10000>;
+			reg-io-width = <1>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
+				 <&ccu CLK_HDMI>;
+			clock-names = "iahb", "isfr", "tmds";
+			resets = <&ccu RST_BUS_HDMI1>;
+			reset-names = "ctrl";
+			phys = <&hdmi_phy>;
+			phy-names = "hdmi-phy";
+			status = "disabled";
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
+		};
+
+		hdmi_phy: hdmi-phy@1ef0000 {
+			compatible = "allwinner,sun8i-h3-hdmi-phy";
+			reg = <0x01ef0000 0x10000>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
+				 <&ccu 7>;
+			clock-names = "bus", "mod", "pll-0";
+			resets = <&ccu RST_BUS_HDMI0>;
+			reset-names = "phy";
+			#phy-cells = <0>;
+		};
+
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.18.0

