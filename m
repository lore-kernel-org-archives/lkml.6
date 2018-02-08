Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbeBHICN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:02:13 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41616 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeBHICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:02:11 -0500
X-Google-Smtp-Source: AH8x227q+Q3T6cWP0lXQhhvf+YR7jbFmA2CA0o/f0Z2Sd5/4OKCVKKTcUAQ8MGQCgce40olzCYgvLw==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org,
        andy.shevchenko@gmail.com
Subject: [PATCH 1/2] dt-bindings: gpio: Add Spreadtrum EIC controller documentation
Date: Thu,  8 Feb 2018 16:01:42 +0800
Message-Id: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the Spreadtrum EIC
controller. The EIC can be recognized as one special type of GPIO,
which can only be used as input.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |   51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
new file mode 100644
index 0000000..34f194f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
@@ -0,0 +1,51 @@
+Spreadtrum EIC controller bindings
+
+The EIC is the abbreviation of external interrupt controller, which
+is only can be used as input mode. The EIC controller includes 4
+sub-modules: EIC-Debounce, EIC-Latch, EIC-Async, EIC-Sync.
+
+The EIC-debounce sub-module provides up to 8 source input signal
+connection. A debounce machanism is used to capture input signal's
+stable status (ms grade) and a single-trigger mechanism is introduced
+into this sub-module to enhance the input event detection reliability.
+In addition, this sub-module's clock can be shut-off automatically to
+reduce power dissipation. The debounce range is from 1ms to 4s with
+the step of 1ms. If the input signal is shorter than 1ms, it will be
+omitted as this sub-module.
+
+The EIC-latch sub-module is used to latch some special input signal
+and send interrupts to MCU core, and it can provide up to 8 latch
+source input signal connection.
+
+The EIC-async sub-module uses 32k clock to capture short signal (us
+grade) to generate interrupt to MCU by level or edge trigger.
+
+The EIC-sync is similar with GPIO's input function.
+
+Required properties:
+- compatible: Should be one of the following:
+  "sprd,sc9860-eic-debounce",
+  "sprd,sc9860-eic-latch",
+  "sprd,sc9860-eic-async",
+  "sprd,sc9860-eic-sync",
+  "sprd,sc27xx-eic-debounce".
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
+	eic_debounce: eic@40210000 {
+		compatible = "sprd,sc9860-eic-debounce";
+		reg = <0 0x40210000 0 0x80>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.7.9.5
