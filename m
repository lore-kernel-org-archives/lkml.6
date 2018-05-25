Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935215AbeEYMf2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:35:28 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23091 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934249AbeEYMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:35:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="15314127"
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <nicolas.ferre@microchip.com>,
        <boris.brezillon@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>
CC: <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v4 4/7] ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S controller
Date: Fri, 25 May 2018 15:34:25 +0300
Message-ID: <1527251668-31396-5-git-send-email-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds DT bindings for the new Atmel I2S controller embedded
inside sama5d2x SoCs.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v4:
	- more specific description for dmas, dma-names, clocks, clock-names
	  properties;
	- removed SoC and internal details of the block IP;
	- added description for the new clock mux phandle;

 .../devicetree/bindings/sound/atmel-i2s.txt        | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
new file mode 100644
index 0000000..735368b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
@@ -0,0 +1,47 @@
+* Atmel I2S controller
+
+Required properties:
+- compatible:     Should be "atmel,sama5d2-i2s".
+- reg:            Should be the physical base address of the controller and the
+                  length of memory mapped region.
+- interrupts:     Should contain the interrupt for the controller.
+- dmas:           Should be one per channel name listed in the dma-names property,
+                  as described in atmel-dma.txt and dma.txt files.
+- dma-names:      Two dmas have to be defined, "tx" and "rx".
+                  This IP also supports one shared channel for both rx and tx;
+                  if this mode is used, one "rx-tx" name must be used.
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    Should be one of each entry matching the clocks phandles list:
+                  - "pclk" (peripheral clock) Required.
+                  - "gclk" (generated clock) Optional (1).
+                  - "aclk" (Audio PLL clock) Optional (1).
+                  - "muxclk" (I2S mux clock) Optional (1).
+
+Optional properties:
+- pinctrl-0:      Should specify pin control groups used for this controller.
+- princtrl-names: Should contain only one value - "default".
+
+
+(1) : Only the peripheral clock is required. The generated clock, the Audio
+      PLL clock adn the I2S mux clock are optional and should only be set
+      together, when Master Mode is required.
+
+Example:
+
+	i2s@f8050000 {
+		compatible = "atmel,sama5d2-i2s";
+		reg = <0xf8050000 0x300>;
+		interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(31))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(32))>;
+		dma-names = "tx", "rx";
+		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
+		clock-names = "pclk", "gclk", "aclk", "muxclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s0_default>;
+	};
-- 
2.7.4
