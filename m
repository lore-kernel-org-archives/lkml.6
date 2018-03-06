Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbeCFN5U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:57:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35020 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753517AbeCFN5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:57:15 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 6/7] arm: dts: sun8i: a33: Add the DSI-related nodes
Date: Tue,  6 Mar 2018 14:56:03 +0100
Message-Id: <fbb4d14a83ed80e9740c042cd9df58b8132b4c91.1520344489.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The A33 has a MIPI-DSI block, along with its D-PHY. Let's add it in order
to use it in the relevant boards.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 44 +++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 50eb84fa246a..94cfa7b1bbfa 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -236,6 +236,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi0: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi0_in_tcon0>;
+					};
 				};
 			};
 		};
@@ -280,6 +285,45 @@
 			#io-channel-cells = <0>;
 		};
 
+		dsi0: dsi@1ca0000 {
+			compatible = "allwinner,sun6i-a31-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_SCLK>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy0>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					dsi0_in_tcon0: endpoint {
+						remote-endpoint = <&tcon0_out_dsi0>;
+					};
+				};
+			};
+		};
+
+		dphy0: d-phy@1ca1000 {
+			compatible = "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01ca1000 0x1000>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_DPHY>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		fe0: display-frontend@1e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
-- 
git-series 0.9.1
