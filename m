Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A513FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226312650A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226312650A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755090AbeF0AKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:10:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:45125 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeF0AKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:10:41 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qi022979;
        Tue, 26 Jun 2018 18:27:23 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/14] dt-bindings: fsi: Document binding for the fsi-master-ast-cf "device"
Date:   Wed, 27 Jun 2018 09:26:02 +1000
Message-Id: <20180626232605.13420-12-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't per-se a real device, it's a pseudo-device that
represents the use of the Aspeed built-in ColdFire to
implement the FSI protocol by bitbanging the GPIOs instead
of doing it from the ARM core.

Thus it's a drop-in replacement for the existing
fsi-master-gpio pseudo-device for use on systems for which
a corresponding firmware file exists. It has most of the
same properties, plus some more needed to operate the
coprocessor.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
new file mode 100644
index 000000000000..50913ae685cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
@@ -0,0 +1,36 @@
+Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
+------------------------------------------------------------------------
+
+Required properties:
+ - compatible =
+   	      "fsi-master-ast-2400-cf" for an AST2400 based system
+	    or
+	      "fsi-master-ast-2500-cf" for an AST2500 based system
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
+ - sram = <phandle>;			: Reference to the SRAM node.
+ - cvic = <phandle>;			: Reference to the CVIC node.
+ - fw-name = <string>;			: The name used to construct the firmware
+   	     				  file name (cf-fsi-<name>.bin)
+ - fw-platform-sig = <value>;		: A signature value that must match the one
+   		     			  contained in the firmware image. Known
+					  values are listed in the firmware interface
+					  file cf-fsi-fw.h
+Examples:
+
+    fsi-master {
+        compatible = "fsi-master-gpio", "fsi-master";
+        clock-gpios = <&gpio 0>;
+        data-gpios = <&gpio 1>;
+        enable-gpios = <&gpio 2>;
+        trans-gpios = <&gpio 3>;
+        mux-gpios = <&gpio 4>;
+    }
-- 
2.17.1

