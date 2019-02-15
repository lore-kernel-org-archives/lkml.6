Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D51AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9021929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394542AbfBOLu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:50:59 -0500
Received: from olimex.com ([184.105.72.32]:52088 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394523AbfBOLu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:50:58 -0500
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:50:45 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC
        DEVICE DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 3/8] dt-bindings: leds: Add binding for axp20x-led device driver
Date:   Fri, 15 Feb 2019 13:50:08 +0200
Message-Id: <20190215115013.11098-4-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115013.11098-1-stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the devicetree bindings for charge led indicator found
on most of X-Powers AXP20X PMICs.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
new file mode 100644
index 000000000000..5a83ad06796d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
@@ -0,0 +1,74 @@
+Device Tree Bindings for LED support on X-Powers PMIC
+
+Most of the X-Powers PMICs have integrated battery charger with LED indicator.
+The output is open-drain, so the state is either high-Z or output-low. The
+driver is a subnode of AXP20X MFD driver, since it uses shared bus with all
+other cells.
+The LED can be controlled either manually or automatically. Then in automatic
+(controlled by the charger) there are two indication modes:
+
+Mode-A
+======
+- output-low:		Charging
+- high-Z		Not charging
+- 1Hz flashing:		Abnormal alarm
+- 4Hz flashing		Overvoltage alarm
+
+Mode-B
+======
+- output-low:		Battery full
+- high-Z		Not charging
+- 1Hz flashing:		Charging
+- 4Hz flashing		Overvoltage or abnormal alarm
+
+The control and the mode can be changed from sysfs.
+
+For AXP20X MFD bindings see:
+Documentation/devicetree/bindings/mfd/axp20x.txt
+
+Required properties:
+- compatible : Must be "x-powers,axp20x-led"
+
+Supported common LED properties, see ./common.txt for more informationn
+- label : See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
+- default-state: See Documentation/devicetree/bindings/leds/common.txt
+
+Optional properties:
+- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
+			 If omitted, then the control is set to manual mode.
+			 On invalid value, Mode-A is used.
+
+
+Example:
+
+	axp803: pmic@3a3 {
+		compatible = "x-powers,axp803";
+
+		...
+
+		led@0 {
+			compatible = "x-powers,axp20x-led";
+			status = "okay";
+
+			label = "axp20x:yellow:chgled";
+			linux,default-trigger = "timer";
+			default-state = "on";
+		};
+	};
+
+or
+
+	axp803: pmic@3a3 {
+		compatible = "x-powers,axp803";
+
+		...
+
+		led@0 {
+			compatible = "x-powers,axp20x-led";
+			status = "okay";
+
+			label = "axp20x:yellow:chgled";
+			x-powers,charger-mode = <1>;
+		};
+	};
-- 
2.17.1

