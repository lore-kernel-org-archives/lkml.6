Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B0C282DB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7AC20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfAaIZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:25:36 -0500
Received: from olimex.com ([184.105.72.32]:51507 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfAaIZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:25:35 -0500
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:25:29 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC
        DEVICE DRIVERS)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 3/5] dt-bindings: leds: Add binding for axp20x-led device driver
Date:   Thu, 31 Jan 2019 10:23:05 +0200
Message-Id: <20190131082308.22522-3-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131082308.22522-1-stefan@olimex.com>
References: <20190131082308.22522-1-stefan@olimex.com>
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
index 000000000000..73fae22ffe29
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
@@ -0,0 +1,74 @@
+Device Tree Bindings for LED support on X-Powers PMIC
+
+Most of the X-Powers PMICs have integrated battery charger with LED indicator.
+The output is open-drain, so the state is either high-Z or output-low. The
+driver is subnode of AXP20X MFD driver, since it uses shared bus with all
+other cells.
+The LED can be controlled either manually or automatic. Then in automatic
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
+Supported common leds properties, see ./common.txt for more information:
+- label : sets LED label. If omitted, dt device node is used
+- linux,default-trigger : See
+- default-state:
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
+		axp20x-led {
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
+		axp20x-led {
+			compatible = "x-powers,axp20x-led";
+			status = "okay";
+
+			label = "axp20x:yellow:chgled";
+			x-powers,charger-mode = "mode-b";
+		};
+	};
-- 
2.17.1

