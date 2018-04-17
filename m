Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeDQO3Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:29:24 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38790 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751865AbeDQO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:29:21 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 7/9] pinctrl: madera: Add DT bindings for Cirrus Logic Madera codecs
Date: Tue, 17 Apr 2018 15:29:13 +0100
Message-ID: <20180417142915.15772-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417142915.15772-1-rf@opensource.cirrus.com>
References: <20180417142915.15772-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804170130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the binding description of the pinctrl driver for Cirrus Logic
Madera codecs. The binding uses the generic pinctrl binding so  the main
purpose here is to describe the device-specific names for groups and
functions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
new file mode 100644
index 000000000000..b0e36cf0d289
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
@@ -0,0 +1,99 @@
+Cirrus Logic Madera class audio codecs pinctrl driver
+
+The Cirrus Logic Madera codecs provide a number of GPIO functions for
+interfacing to external hardware and to provide logic outputs to other devices.
+Certain groups of GPIO pins also have an alternate function, normally as an
+audio interface.
+
+The set of available GPIOs, functions and alternate function groups differs
+between codecs so refer to the datasheet for the codec for further information
+on what is supported on that device.
+
+The properties for this driver exist within the parent MFD driver node.
+
+See also
+  the core bindings for the parent MFD driver:
+    Documentation/devicetree/bindings/mfd/madera.txt
+
+  the generic pinmix bindings:
+    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Required properties of parent mfd node:
+  - pinctrl-names : must be "default"
+  - pinctrl-0 : a phandle to the node containing the subnodes containing default
+      configurations
+
+Required subnodes:
+  One subnode is required to contain the default settings. It contains an
+  arbitrary number of configuration subnodes, one for each group or pin
+  configuration you want to apply as a default.
+
+Required properties of configuration subnodes:
+  - groups : name of one pin group to configure. One of:
+	aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1, pdmspk2,
+	dmic4, dmic5, dmic6,
+	gpio1, gpio2, ..., gpio40
+    The gpioN groups select the single pin of this name for configuration
+
+Optional properties of configuration subnodes:
+  Any configuration option not explicitly listed in the dts will be left at
+  chip default setting.
+
+  - function : name of function to assign to this group. One of:
+	aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1, pdmspk2,
+	dmic3, dmic4, dmic5, dmic6,
+	io, dsp-gpio, irq1, irq2,
+	fll1-clk, fll1-lock, fll2-clk, fll2-lock, fll3-clk, fll3-lock,
+	fllao-clk, fllao-lock,
+	opclk, opclk-async, pwm1, pwm2, spdif,
+	asrc1-in1-lock, asrc1-in2-lock, asrc2-in1-lock, asrc2-in2-lock,
+	spkl-short-circuit, spkr-short-circuit, spk-shutdown,
+	spk-overheat-shutdown, spk-overheat-warn,
+	timer1-sts, timer2-sts, timer3-sts, timer4-sts, timer5-sts, timer6-sts,
+	timer7-sts, timer8-sts,
+	log1-fifo-ne, log2-fifo-ne, log3-fifo-ne, log4-fifo-ne, log5-fifo-ne,
+	log6-fifo-ne, log7-fifo-ne, log8-fifo-ne,
+
+  - bias-disable : disable pull-up and pull-down
+  - bias-bus-hold : enable buskeeper
+  - bias-pull-up : output is pulled-up
+  - bias-pull-down : output is pulled-down
+  - drive-push-pull : CMOS output
+  - drive-open-drain : open-drain output
+  - drive-strength : drive strength in mA. Valid values are 4 or 8
+  - input-schmitt-enable : enable schmitt-trigger mode
+  - input-schmitt-disable : disable schmitt-trigger mode
+  - input-debounce : A value of 0 disables debounce, a value !=0 enables
+	debounce
+  - output-low : set the pin to output mode with low level
+  - output-high : set the pin to output mode with high level
+
+Example:
+
+cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cs47l85_defaults>;
+
+	cs47l85_defaults: cs47l85-gpio-defaults {
+		aif1 {
+			groups = "aif1";
+			function = "aif1";
+			bias-bus-hold;
+		};
+
+		aif2 {
+			groups = "aif2";
+			function = "aif2";
+			bias-bus-hold;
+		};
+
+		opclk {
+			groups = "gpio1";
+			function = "opclk";
+			bias-pull-up;
+			drive-strength = <8>;
+		};
+	};
+};
-- 
2.11.0
