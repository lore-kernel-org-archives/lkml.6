Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDRPuQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:50:16 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37262 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752162AbeDRPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:50:14 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/9] mfd: madera: Add DT bindings for Cirrus Logic Madera codecs
Date: Tue, 17 Apr 2018 15:29:08 +0100
Message-ID: <20180417142915.15772-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417142915.15772-1-rf@opensource.cirrus.com>
References: <20180417142915.15772-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804180142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specification of the bindings for the parent MFD driver component
of the Cirrus Logic Madera codec drivers.

Note that although the interrupt controller and GPIO are child
drivers their required bindings are trivial, mandatory, and exist
within the parent MFD node so are documented here.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/madera.txt | 102 +++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt

diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
new file mode 100644
index 000000000000..db3266088386
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/madera.txt
@@ -0,0 +1,102 @@
+Cirrus Logic Madera class audio codecs Multi-Functional Device
+
+These devices are audio SoCs with extensive digital capabilities and a range
+of analogue I/O.
+
+See also the child driver bindings in:
+bindings/pinctrl/cirrus,madera-pinctrl.txt
+bindings/regulator/arizona-regulator.txt
+bindings/sound/madera.txt
+
+Required properties:
+
+  - compatible : One of the following chip-specific strings:
+        "cirrus,cs47l35"
+        "cirrus,cs47l85"
+        "cirrus,cs47l90"
+        "cirrus,cs47l91"
+        "cirrus,wm1840"
+
+  - reg : I2C slave address when connected using I2C, chip select number when
+    using SPI.
+
+  - DCVDD-supply : Power supply for the device as defined in
+    bindings/regulator/regulator.txt
+    Mandatory on CS47L35, CS47L90, CS47L91
+    Optional on CS47L85, WM1840
+
+  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, CPVDD1-supply, CPVDD2-supply :
+    Power supplies for the device
+
+  - DBVDD3-supply, DBVDD4-supply : Power supplies for the device
+    (CS47L85, CS47L90, CS47L91, WM1840)
+
+  - SPKVDDL-supply, SPKVDDR-supply : Power supplies for the device
+    (CS47L85, WM1840)
+
+  - SPKVDD-supply : Power supply for the device
+    (CS47L35)
+
+  - interrupt-controller : Indicates that this device is an interrupt controller
+
+  - #interrupt-cells: the number of cells to describe an IRQ, must be 2.
+    The first cell is the IRQ number.
+    The second cell is the flags, encoded as the trigger masks from
+    bindings/interrupt-controller/interrupts.txt
+
+  - gpio-controller : Indicates this device is a GPIO controller.
+
+  - #gpio-cells : Must be 2. The first cell is the pin number. The second cell
+    is reserved for future use and must be zero
+
+  - interrupt-parent : The parent interrupt controller.
+
+  - interrupts : The interrupt line the /IRQ signal for the device is
+    connected to.
+
+Optional properties:
+
+  - MICVDD-supply : Power supply, only need to be specified if
+    powered externally
+
+  - reset-gpios : One entry specifying the GPIO controlling /RESET.
+    As defined in bindings/gpio.txt.
+    Although optional, it is strongly recommended to use a hardware reset
+
+  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+    One for each MICBIAS generator (MICBIAS1, MICBIAS2, ...)
+    (all codecs)
+
+    One for each output pin (MICBIAS1A, MIBCIAS1B, MICBIAS2A, ...)
+    (all except CS47L85, WM1840)
+
+    The following following additional property is supported for the generator
+    nodes:
+      - cirrus,ext-cap : Set to 1 if the MICBIAS has external decoupling
+        capacitors attached.
+
+Optional child nodes:
+    micvdd : Node containing initialization data for the micvdd regulator
+    See bindings/regulator/arizona-regulator.txt
+
+    ldo1 : Node containing initialization data for the LDO1 regulator
+    See bindings/regulator/arizona-regulator.txt
+    (cs47l85, wm1840)
+
+Example:
+
+cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+	reg = <0>;
+
+	reset-gpios = <&gpio 0>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	interrupts = <&host_irq1>;
+	interrupt-parent = <&gic>;
+
+	gpio-controller;
+	#gpio-cells = <2>;
+};
-- 
2.11.0
