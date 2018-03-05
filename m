Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeCEC5n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:57:43 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42547 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932403AbeCEC5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:57:39 -0500
X-Google-Smtp-Source: AG47ELsTUEOahiqlFmxqZeh3/pUCVUHciNtR5eXI06ZK8UwhwNg2f2kxbmjMV0HUDdlKy39pteRNxQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org,
        andy.shevchenko@gmail.com
Subject: [PATCH v3 1/3] dt-bindings: gpio: Add Spreadtrum EIC controller documentation
Date: Mon,  5 Mar 2018 10:56:50 +0800
Message-Id: <787c9f115db06390549bfee366b7f70faf312286.1520218279.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the Spreadtrum EIC
controller. The EIC can be seen as a special type of GPIO, which
can only be used as input mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v2:
 - Add reviewed tag from Rob.

Changes since v1:
 - Fix some typos and grammar issues.
 - Add more explanation to make things clear.
 - List all device nodes as examples.
---
 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |   97 ++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
new file mode 100644
index 0000000..93d98d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
@@ -0,0 +1,97 @@
+Spreadtrum EIC controller bindings
+
+The EIC is the abbreviation of external interrupt controller, which can
+be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
+one is in digital chip, and another one is in PMIC. The digital chip EIC
+controller contains 4 sub-modules: EIC-debounce, EIC-latch, EIC-async and
+EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
+module.
+
+The EIC-debounce sub-module provides up to 8 source input signal
+connections. A debounce mechanism is used to capture the input signals'
+stable status (millisecond resolution) and a single-trigger mechanism
+is introduced into this sub-module to enhance the input event detection
+reliability. In addition, this sub-module's clock can be shut off
+automatically to reduce power dissipation. Moreover the debounce range
+is from 1ms to 4s with a step size of 1ms. The input signal will be
+ignored if it is asserted for less than 1 ms.
+
+The EIC-latch sub-module is used to latch some special power down signals
+and generate interrupts, since the EIC-latch does not depend on the APB
+clock to capture signals.
+
+The EIC-async sub-module uses a 32kHz clock to capture the short signals
+(microsecond resolution) to generate interrupts by level or edge trigger.
+
+The EIC-sync is similar with GPIO's input function, which is a synchronized
+signal input register. It can generate interrupts by level or edge trigger
+when detecting input signals.
+
+Required properties:
+- compatible: Should be one of the following:
+  "sprd,sc9860-eic-debounce",
+  "sprd,sc9860-eic-latch",
+  "sprd,sc9860-eic-async",
+  "sprd,sc9860-eic-sync",
+  "sprd,sc27xx-eic".
+- reg: Define the base and range of the I/O address space containing
+  the GPIO controller registers.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be <2>. The first cell is the gpio number and
+  the second cell is used to specify optional parameters.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be <2>. Specifies the number of cells needed
+  to encode interrupt source.
+- interrupts: Should be the port interrupt shared by all the gpios.
+
+Example:
+	eic_debounce: gpio@40210000 {
+		compatible = "sprd,sc9860-eic-debounce";
+		reg = <0 0x40210000 0 0x80>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	eic_latch: gpio@40210080 {
+		compatible = "sprd,sc9860-eic-latch";
+		reg = <0 0x40210080 0 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	eic_async: gpio@402100a0 {
+		compatible = "sprd,sc9860-eic-async";
+		reg = <0 0x402100a0 0 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	eic_sync: gpio@402100c0 {
+		compatible = "sprd,sc9860-eic-sync";
+		reg = <0 0x402100c0 0 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmic_eic: gpio@300 {
+		compatible = "sprd,sc27xx-eic";
+		reg = <0x300>;
+		interrupt-parent = <&sc2731_pmic>;
+		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
-- 
1.7.9.5
