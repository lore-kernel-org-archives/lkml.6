Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965002AbeE2O7V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:59:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40632 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936500AbeE2O7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:59:11 -0400
From: Mark Brown <broonie@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, alsa-devel@alsa-project.org,
        nicolas.ferre@microchip.com, boris.brezillon@bootlin.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org, broonie@kernel.org,
        Cristian.Birsan@microchip.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S controller" to the asoc tree
In-Reply-To: <1527251668-31396-5-git-send-email-codrin.ciubotariu@microchip.com>
Message-Id: <E1fNg5a-0005qO-IW@debutante>
Date: Tue, 29 May 2018 15:59:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S controller

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 969cc0528e0efdfdeaa5bbc0ab707d8a7819a8ec Mon Sep 17 00:00:00 2001
From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Fri, 25 May 2018 15:34:25 +0300
Subject: [PATCH] ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S
 controller

This patch adds DT bindings for the new Atmel I2S controller embedded
inside sama5d2x SoCs.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/atmel-i2s.txt   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
new file mode 100644
index 000000000000..735368b8a73f
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
2.17.0
