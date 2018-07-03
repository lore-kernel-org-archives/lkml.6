Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4023C2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4023C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbeGCJrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:47:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33447 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754560AbeGCJrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:47:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EFC8F2079F; Tue,  3 Jul 2018 11:47:37 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id AC9E8207D4;
        Tue,  3 Jul 2018 11:47:27 +0200 (CEST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v6 2/2] dt-bindings: input: Add documentation for cyttsp5
Date:   Tue,  3 Jul 2018 11:43:09 +0200
Message-Id: <20180703094309.18514-3-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180703094309.18514-1-mylene.josserand@bootlin.com>
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
documentation. It can use I2C or SPI bus.
This touchscreen can handle some defined zone that are designed and
sent as button. To be able to customize the keycode sent, the
"linux,keycodes" property can be used.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 .../bindings/input/touchscreen/cypress,cyttsp5.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt b/Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
new file mode 100644
index 000000000000..1e0e90e322c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
@@ -0,0 +1,39 @@
+* Cypress cyttsp touchscreen controller, generation 5
+
+Required properties:
+ - compatible		: must be "cypress,cyttsp5"
+ - reg			: Device I2C address or SPI chip select number
+ - interrupt-parent	: the phandle for the gpio controller
+			  (see interrupt binding[0]).
+ - interrupts		: (gpio) interrupt to which the chip is connected
+			  (see interrupt binding[0]).
+
+Optional properties:
+ - reset-gpios		: the reset gpio the chip is connected to
+			  (see GPIO binding[1] for more details).
+Some other touchscreen optional properties can be defined such as
+"touchscreen-size-x". See ./touchscreen.txt[2] for more details.
+
+This touchscreen can handle some buttons that are touchscreen's defined zones.
+Each button's event can be customized using a property:
+	- linux,keycodes: List of keycode to emit.
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[1]: Documentation/devicetree/bindings/gpio/gpio.txt
+[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+
+Example:
+&i2c0 {
+	[...]
+
+	touchscreen@24 {
+		compatible = "cypress,cyttsp5";
+		reg = <0x24>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
+		touchscreen-swapped-x-y;
+		linux,keycodes = <KEY_HOMEPAGE>, <KEY_MENU>, <KEY_BACK>;
+	};
+};
-- 
2.11.0

