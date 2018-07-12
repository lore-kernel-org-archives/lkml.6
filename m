Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25193C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D783920C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D783920C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeGLE4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:56:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:36090 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbeGLE4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:56:55 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6C3mnNT020207;
        Wed, 11 Jul 2018 22:48:54 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-aspeed@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 1/5] dt-bindings: fsi: Document binding for the fsi-master-ast-cf "device"
Date:   Thu, 12 Jul 2018 13:48:43 +1000
Message-Id: <20180712034847.12878-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712034847.12878-1-benh@kernel.crashing.org>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't per-se a real device, it's a pseudo-device that
represents the use of the Aspeed built-in ColdFire to
implement the FSI protocol by bitbanging the GPIOs instead
of doing it from the ARM core.

Thus it's a drop-in replacement for the existing
fsi-master-gpio pseudo-device for use on systems based
on the Aspeed chips. It has most of the same properties,
plus some more needed to operate the coprocessor.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
new file mode 100644
index 000000000000..431bf8a423ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
@@ -0,0 +1,36 @@
+Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
+------------------------------------------------------------------------
+
+Required properties:
+ - compatible =
+	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
+   or
+	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
+
+ - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
+ - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
+ - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
+ - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
+ - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
+                                          functions (eg, external FSI masters)
+ - memory-region = <phandle>;		: Reference to the reserved memory for
+                                          the ColdFire. Must be 2M aligned on
+					  AST2400 and 1M aligned on AST2500
+ - aspeed,sram = <phandle>;		: Reference to the SRAM node.
+ - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
+
+Examples:
+
+    fsi-master {
+        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
+
+	clock-gpios = <&gpio 0>;
+        data-gpios = <&gpio 1>;
+        enable-gpios = <&gpio 2>;
+        trans-gpios = <&gpio 3>;
+        mux-gpios = <&gpio 4>;
+
+	memory-region = <&coldfire_memory>;
+	sram = <&sram>;
+	cvic = <&cvic>;
+    }
-- 
2.17.1

