Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58AC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355712083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355712083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757397AbeFSV17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:27:59 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:50638 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757188AbeFSV1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:27:53 -0400
Received: from localhost.localdomain (pD95EF733.dip0.t-ipconnect.de [217.94.247.51])
        by mail.bugwerft.de (Postfix) with ESMTPSA id F3C2E28A28E;
        Tue, 19 Jun 2018 21:24:47 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH RFC 1/4] dt-bindings: w1: document sub-node bindings for DS2760
Date:   Tue, 19 Jun 2018 23:27:41 +0200
Message-Id: <20180619212744.794-2-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619212744.794-1-daniel@zonque.org>
References: <20180619212744.794-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a generic w1 bindings document that merely describes how
slave deviceses are grouped under master nodes. It also adds a specific
binding for the ds2760 battery monitor.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/w1/w1-ds2760.txt        |  9 +++++++++
 .../devicetree/bindings/w1/w1-gpio.txt          |  6 ++++++
 Documentation/devicetree/bindings/w1/w1.txt     | 17 +++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

diff --git a/Documentation/devicetree/bindings/w1/w1-ds2760.txt b/Documentation/devicetree/bindings/w1/w1-ds2760.txt
new file mode 100644
index 000000000000..86a0f4c573eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1-ds2760.txt
@@ -0,0 +1,9 @@
+Devicetree bindings for Maxim DS2760
+====================================
+
+The ds2760 is a w1 slave device and must hence have its sub-node in DT
+under a w1 bus master node.
+
+Required properties:
+- compatible: must be "maxim,ds2760-w1"
+
diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
index 6e09c35d9f1a..a3e0e964b260 100644
--- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
+++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
@@ -13,10 +13,16 @@ Optional properties:
  - linux,open-drain: if specified, the data pin is considered in
 		     open-drain mode.
 
+Also refer to the generic w1.txt document.
+
 Examples:
 
 	onewire@0 {
 		compatible = "w1-gpio";
 		gpios = <&gpio 126 0>, <&gpio 105 0>;
+
+		slave@0 {
+			compatible = "maxim,w1-ds2760";
+		};
 	};
 
diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
new file mode 100644
index 000000000000..504adf7c7352
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1.txt
@@ -0,0 +1,17 @@
+Generic devicetree bindings for onewire (w1) busses
+===================================================
+
+Onewire busses are described through nodes of their master bus controller.
+Slave devices are listed as sub-nodes of such master devices.
+
+Example:
+
+	onewire {
+		compatible = "w1-gpio";
+		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+
+		w1_slave: slave@0 {
+			compatible = "maxim,w1-ds2760";
+		};
+	};
+
-- 
2.17.1

