Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeCFN5M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:57:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34963 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbeCFN5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:57:10 -0500
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
Subject: [PATCH v3 2/7] dt-bindings: display: Add Allwinner MIPI-DSI bindings
Date: Tue,  6 Mar 2018 14:55:59 +0100
Message-Id: <5f183ae295c0190369ec576ecfb10c1d78f41eb3.1520344489.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The Allwinner SoCs usually come with a DSI encoder. Add a binding for it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 93 +++++++-
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
new file mode 100644
index 000000000000..6a6cf5de08b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -0,0 +1,93 @@
+Allwinner A31 DSI Encoder
+=========================
+
+The DSI pipeline consists of two separate blocks: the DSI controller
+itself, and its associated D-PHY.
+
+DSI Encoder
+-----------
+
+The DSI Encoder generates the DSI signal from the TCON's.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun6i-a31-mipi-dsi
+  - reg: base address and size of memory-mapped region
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the DSI encoder
+    * bus: the DSI interface clock
+    * mod: the DSI module clock
+  - clock-names: the clock names mentioned above
+  - phys: phandle to the D-PHY
+  - phy-names: must be "dphy"
+  - resets: phandle to the reset controller driving the encoder
+
+  - ports: A ports node with endpoint definitions as defined in
+    Documentation/devicetree/bindings/media/video-interfaces.txt. The
+    first port should be the input endpoint, usually coming from the
+    associated TCON.
+
+Any MIPI-DSI device attached to this should be described according to
+the bindings defined in ../mipi-dsi-bus.txt
+
+D-PHY
+-----
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun6i-a31-mipi-dphy
+  - reg: base address and size of memory-mapped region
+  - clocks: phandles to the clocks feeding the DSI encoder
+    * bus: the DSI interface clock
+    * mod: the DSI module clock
+  - clock-names: the clock names mentioned above
+  - resets: phandle to the reset controller driving the encoder
+
+Example:
+
+dsi0: dsi@1ca0000 {
+	compatible = "allwinner,sun6i-a31-mipi-dsi";
+	reg = <0x01ca0000 0x1000>;
+	interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_MIPI_DSI>,
+		 <&ccu CLK_DSI_SCLK>;
+	clock-names = "bus", "mod";
+	resets = <&ccu RST_BUS_MIPI_DSI>;
+	phys = <&dphy0>;
+	phy-names = "dphy";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+		reg = <0>;
+		power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+		backlight = <&pwm_bl>;
+	};
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			dsi0_in_tcon0: endpoint {
+				remote-endpoint = <&tcon0_out_dsi0>;
+			};
+		};
+	};
+};
+
+dphy0: d-phy@1ca1000 {
+	compatible = "allwinner,sun6i-a31-mipi-dphy";
+	reg = <0x01ca1000 0x1000>;
+	clocks = <&ccu CLK_BUS_MIPI_DSI>,
+		 <&ccu CLK_DSI_DPHY>;
+	clock-names = "bus", "mod";
+	resets = <&ccu RST_BUS_MIPI_DSI>;
+	#phy-cells = <0>;
+};
-- 
git-series 0.9.1
