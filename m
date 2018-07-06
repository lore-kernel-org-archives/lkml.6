Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31072C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFF523FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFF523FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeGFFhJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:37:09 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:37586 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932199AbeGFFgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:36:02 -0400
Received: from localhost.localdomain (pD95EF57F.dip0.t-ipconnect.de [217.94.245.127])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 2A3A728DBF7;
        Fri,  6 Jul 2018 05:35:57 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
Date:   Fri,  6 Jul 2018 07:35:48 +0200
Message-Id: <20180706053552.11438-2-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706053552.11438-1-daniel@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a generic w1 bindings document that describes how w1
slave deviceses are grouped under master nodes. It also augments the
existing w1-gpio.txt document a bit.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
 Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

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
index 000000000000..05f26b27d898
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
+	onewire {
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

