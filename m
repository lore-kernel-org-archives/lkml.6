Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2347DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C882F2469C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C882F2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933094AbeGDEoX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:44:23 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:40996 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932311AbeGDEoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:44:20 -0400
Received: from localhost.localdomain (pD95EF712.dip0.t-ipconnect.de [217.94.247.18])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 89E2328D3FF;
        Wed,  4 Jul 2018 04:40:58 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 1/4] dt-bindings: w1: document generic onewire and DS2760 bindings
Date:   Wed,  4 Jul 2018 06:44:08 +0200
Message-Id: <20180704044411.2693-2-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704044411.2693-1-daniel@zonque.org>
References: <20180704044411.2693-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a generic w1 bindings document that merely describes how
slave deviceses are grouped under master nodes. It also adds a specific
binding for the ds2760 battery monitor.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/power/supply/maxim,ds2760.txt    | 29 +++++++++++++++++++
 .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++--
 Documentation/devicetree/bindings/w1/w1.txt   | 25 ++++++++++++++++
 3 files changed, 62 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
new file mode 100644
index 000000000000..a39d1ada48f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
@@ -0,0 +1,29 @@
+Devicetree bindings for Maxim DS2760
+====================================
+
+The ds2760 is a w1 slave device and must hence have its sub-node in DT
+under a w1 bus master node.
+
+The device exposes a power supply, so the details described in
+Documentation/devicetree/bindings/power/supply/power_supply.txt apply.
+
+Required properties:
+- compatible: must be "maxim,ds2760"
+
+Optional properties:
+- power-supplies:	Refers to one or more power supplies connected to
+			this battery.
+- maxim,pmod-enabled:	This boolean property enables the DS2760 to enter
+			sleep mode when the DQ line goes low for greater
+			than 2 seconds and leave sleep Mode when the DQ
+			line goes high.
+- maxim,cache-time:	Time im milliseconds to cache the data for. When
+			this time expires, the values are read again from
+			the hardware. Defaults to 1000.
+- maxim,rated-capacity:	The rated capacity of the battery, in mAh.
+			If not specified, the value stored in the
+			non-volatile chip memory is used.
+- maxim,current-accumulator:
+			The current accumulator value in mAh.
+			If not specified, the value stored in the
+			non-volatile chip memory is used.
diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
index 6e09c35d9f1a..3d6554eac240 100644
--- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
+++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
@@ -13,10 +13,15 @@ Optional properties:
  - linux,open-drain: if specified, the data pin is considered in
 		     open-drain mode.
 
+Also refer to the generic w1.txt document.
+
 Examples:
 
-	onewire@0 {
+	onewire {
 		compatible = "w1-gpio";
-		gpios = <&gpio 126 0>, <&gpio 105 0>;
-	};
+		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 
+		battery {
+			// ...
+		};
+	};
diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
new file mode 100644
index 000000000000..bee18f7070ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1.txt
@@ -0,0 +1,25 @@
+Generic devicetree bindings for onewire (w1) busses
+===================================================
+
+Onewire busses are described through nodes of their master bus controller.
+Slave devices are listed as sub-nodes of such master devices. For now, only
+one slave is allowed per bus master.
+
+
+Example:
+
+	charger: charger {
+		compatible = "gpio-charger";
+		charger-type = "mains";
+		gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	};
+
+	onewire@0 {
+		compatible = "w1-gpio";
+		gpios = <&gpio 100 0>, <&gpio 101 0>;
+
+		battery {
+			compatible = "maxim,ds2760";
+			power-supplies = <&charger>;
+		};
+	};
-- 
2.17.1

