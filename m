Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8618DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0812151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tO/EtYpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0812151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHUUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:03:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52560 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeHUUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:03:36 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/8] dt-bindings: pinctrl: Update pinctrl-ingenic for JZ4725B and GPIO merge
Date:   Tue, 21 Aug 2018 18:42:29 +0200
Message-Id: <20180821164236.21101-2-paul@crapouillou.net>
In-Reply-To: <20180821164236.21101-1-paul@crapouillou.net>
References: <20180821164236.21101-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534869763; bh=R4u/11f/9d4XWlScLfQ1IJFrnf4IibTLB+2bLfQzv0o=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tO/EtYpdDurILHUVUE4NBwmqTTOUr0ic027st51pvNjtsVFDlj5u/47v6gY4v4Fj1mHP6dpOiSMZZIMWHGjL1yUnvZSfWSFtlSQA5zY/Seo4X5fvJ0CpA4gtO+SZ5bTLFpAWJVzX5RW8Sp1Tsz9KLmGkm1g08r0w2sJBos51hXk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl-ingenic driver now supports the JZ4725B SoC.

Furthermore, the gpio-ingenic driver was dropped and the pinctrl-ingenic
driver is now responsible for providing the GPIO functionality.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 .../devicetree/bindings/gpio/ingenic,gpio.txt      | 46 ----------------------
 .../bindings/pinctrl/ingenic,pinctrl.txt           | 39 ++++++++++++++++--
 2 files changed, 35 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
deleted file mode 100644
index 7988aeb725f4..000000000000
--- a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Ingenic jz47xx GPIO controller
-
-That the Ingenic GPIO driver node must be a sub-node of the Ingenic pinctrl
-driver node.
-
-Required properties:
---------------------
-
- - compatible: Must contain one of:
-    - "ingenic,jz4740-gpio"
-    - "ingenic,jz4770-gpio"
-    - "ingenic,jz4780-gpio"
- - reg: The GPIO bank number.
- - interrupt-controller: Marks the device node as an interrupt controller.
- - interrupts: Interrupt specifier for the controllers interrupt.
- - #interrupt-cells: Should be 2. Refer to
-   ../interrupt-controller/interrupts.txt for more details.
- - gpio-controller: Marks the device node as a GPIO controller.
- - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
-    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
-    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
- - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
-   'gpio.txt' in this directory for more details.
-
-Example:
---------
-
-&pinctrl {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	gpa: gpio@0 {
-		compatible = "ingenic,jz4740-gpio";
-		reg = <0>;
-
-		gpio-controller;
-		gpio-ranges = <&pinctrl 0 0 32>;
-		#gpio-cells = <2>;
-
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		interrupt-parent = <&intc>;
-		interrupts = <28>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
index ca313a7aeaff..af20b0ec715c 100644
--- a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
@@ -20,16 +20,30 @@ Required properties:
 
  - compatible: One of:
     - "ingenic,jz4740-pinctrl"
+    - "ingenic,jz4725b-pinctrl"
     - "ingenic,jz4770-pinctrl"
     - "ingenic,jz4780-pinctrl"
  - reg: Address range of the pinctrl registers.
 
 
-GPIO sub-nodes
---------------
+Required properties for sub-nodes (GPIO chips):
+-----------------------------------------------
 
-The pinctrl node can have optional sub-nodes for the Ingenic GPIO driver;
-please refer to ../gpio/ingenic,gpio.txt.
+ - compatible: Must contain one of:
+    - "ingenic,jz4740-gpio"
+    - "ingenic,jz4770-gpio"
+    - "ingenic,jz4780-gpio"
+ - reg: The GPIO bank number.
+ - interrupt-controller: Marks the device node as an interrupt controller.
+ - interrupts: Interrupt specifier for the controllers interrupt.
+ - #interrupt-cells: Should be 2. Refer to
+   ../interrupt-controller/interrupts.txt for more details.
+ - gpio-controller: Marks the device node as a GPIO controller.
+ - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
+    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
+    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
+ - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
+   ../gpio/gpio.txt for more details.
 
 
 Example:
@@ -38,4 +52,21 @@ Example:
 pinctrl: pin-controller@10010000 {
 	compatible = "ingenic,jz4740-pinctrl";
 	reg = <0x10010000 0x400>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gpa: gpio@0 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+	};
 };
-- 
2.11.0

