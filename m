Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbeEYMfE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:35:04 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:14730 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932994AbeEYMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:35:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="15314122"
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <nicolas.ferre@microchip.com>,
        <boris.brezillon@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>
CC: <Cristian.Birsan@microchip.com>
Subject: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
Date: Fri, 25 May 2018 15:34:22 +0300
Message-ID: <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S mux clock can be used to select the I2S input clock. The
available parents are the peripheral and the generated clocks.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../devicetree/bindings/clock/at91-clock.txt       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 51c259a..1c46b3c 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -90,6 +90,8 @@ Required properties:
 	"atmel,sama5d2-clk-audio-pll-pmc"
 		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
 		and can be used by peripheral clock or generic clock
+	"atmel,sama5d2-clk-i2s-mux":
+		at91 I2S clock source selection
 
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
@@ -507,3 +509,35 @@ For example:
 			atmel,clk-output-range = <0 83000000>;
 		};
 	};
+
+Required properties for I2S mux clocks:
+- #size-cells : shall be 0 (reg is used to encode I2S bus id).
+- #address-cells : shall be 1 (reg is used to encode I2S bus id).
+- name: device tree node describing a specific mux clock.
+	* #clock-cells : from common clock binding; shall be set to 0.
+	* clocks : shall be the mux clock parent phandles; shall be 2 phandles:
+	  peripheral and generated clock; the first phandle shall belong to the
+	  peripheral clock and the second one shall belong to the generated
+	  clock; "clock-indices" property can be user to specify
+	  the correct order.
+	* reg: I2S bus id of the corresponding mux clock.
+	  e.g. reg = <0>; for i2s0, reg = <1>; for i2s1
+
+For example:
+	i2s_clkmux {
+		compatible = "atmel,sama5d2-clk-i2s-mux";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2s0muxck: i2s0_muxclk {
+			clocks = <&i2s0_clk>, <&i2s0_gclk>;
+			#clock-cells = <0>;
+			reg = <0>;
+		};
+
+		i2s1muxck: i2s1_muxclk {
+			clocks = <&i2s1_clk>, <&i2s1_gclk>;
+			#clock-cells = <0>;
+			reg = <1>;
+		};
+	};
-- 
2.7.4
