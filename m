Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeFDNSl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:18:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46454 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeFDNSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:18:39 -0400
X-Google-Smtp-Source: ADUXVKKre4o0xVuE9g5WidxiYG93Atm2oh9nSeIQXONGAwIcPtfiLeMu5GHPVwOLrbvCQ5N2dCXf8A==
Date: Mon, 4 Jun 2018 16:18:30 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v5 2/4] mfd: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Message-ID: <6509bbe0238c20c16930c9f23d63656b1d5f4af2.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC MFD.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
new file mode 100644
index 000000000000..ac2b66181f17
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -0,0 +1,76 @@
+* ROHM BD71837 Power Management Integrated Circuit bindings
+
+BD71837MWV is a programmable Power Management IC for powering single-core,
+dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
+low BOM cost and compact solution footprint. It integrates 8 Buck
+egulators and 7 LDO’s to provide all the power rails required by the SoC and
+the commonly used peripherals.
+
+Required properties:
+ - compatible		: Should be "rohm,bd71837".
+ - reg			: I2C slave address.
+ - interrupt-parent	: Phandle to the parent interrupt controller.
+ - interrupts		: The interrupt line the device is connected to.
+ - regulators:		: List of child nodes that specify the regulators
+			  Please see ../regulator/rohm,bd71837-regulator.txt
+ - clock:		: Please see ../clock/rohm,bd71837-clock.txt
+
+Optional properties:
+ - interrupt-controller	: Marks the device node as an interrupt controller.
+			  BD71837MWV can report different power state change
+			  events to other drivers. Different events can be seen
+			  as separate BD71837 domain interrupts.
+			  The BD71837 driver only provides the infrastructure
+			  for the IRQs. The users should write own driver to
+			  convert the IRQ into the event they wish. The IRQ can
+			  be used with the standard
+			  request_irq/enable_irq/disable_irq API inside the
+			  kernel.
+ - #interrupt-cells	: The number of cells to describe an IRQ should be 1.
+			    The value in cell is the IRQ number.
+			    Meaningfull numbers are:
+			      0 => PMIC_STBY_REQ level change
+			      1 => PMIC_ON_REQ level change
+			      2 => WDOG_B level change
+			      3 => Power Button level change
+			      4 => Power Button Long Push
+			      5 => Power Button Short Push
+			      6 => SWRESET register is written 1
+
+Example:
+
+	pmic: pmic@4b {
+		compatible = "rohm,bd71837";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x4b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 GPIO_ACTIVE_LOW>;
+		interrupt-names = "irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <1250>;
+			};
+			/* ... */
+		};
+	};
+
+	/* driver consuming PMIC interrupts */
+
+	my-power-button: power-button {
+		compatible = "foo";
+		interrupt-parent = <&pmic>;
+		interrupts = <3>, <4>, <5>;
+		interrupt-names = "pwrb", "pwrb-l", "pwrb-s";
+		/* ... */
+	};
+
-- 
2.14.3
