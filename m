Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967468AbeEYRTm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:19:42 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15060 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967433AbeEYRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:19:40 -0400
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="14357818"
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v4 2/6] dt-bindings: add binding for atmel-usart in SPI mode
Date: Fri, 25 May 2018 20:19:37 +0300
Message-ID: <20180525171941.26766-3-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525171941.26766-1-radu.pirea@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the bindings for serial from serial/atmel-usart.txt to
mfd/atmel-usart.txt and adds bindings for USART in SPI mode.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
similarity index 76%
rename from Documentation/devicetree/bindings/serial/atmel-usart.txt
rename to Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 7c0d6b2f53e4..3b9e18642c3b 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,6 +1,6 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
-Required properties:
+Required properties for USART:
 - compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
   The compatible <chip> indicated will be the first SoC to support an
   additional mode or an USART new feature.
@@ -11,7 +11,13 @@ Required properties:
 	Required elements: "usart"
 - clocks: phandles to input clocks.
 
-Optional properties:
+Required properties for USART in SPI mode:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- cs-gpios: chipselects (internal cs not supported)
+- atmel,usart-mode : Must be <USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
+
+Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
@@ -62,3 +68,18 @@ Example:
 		dma-names = "tx", "rx";
 		atmel,fifo-size = <32>;
 	};
+
+- SPI mode:
+	#include <dt-bindings/mfd/at91-usart.h>
+
+	spi0: spi@f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
+		atmel,usart-mode = <USART_MODE_SPI>;
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
-- 
2.17.0
