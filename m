Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9938214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9938214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeKUIIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:20 -0500
Received: from anholt.net ([50.246.234.109]:52684 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKUIIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9513010A15EC;
        Tue, 20 Nov 2018 13:37:05 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BpShjXYjTbtN; Tue, 20 Nov 2018 13:37:03 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 82C9D10A0AE6;
        Tue, 20 Nov 2018 13:37:03 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8064F2FE1FE5; Tue, 20 Nov 2018 13:37:02 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/5] dt-bindings: soc: Add a new binding for the BCM2835 PM node.
Date:   Tue, 20 Nov 2018 13:36:58 -0800
Message-Id: <20181120213702.27958-2-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120213702.27958-1-eric@anholt.net>
References: <20181120213702.27958-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding supersedes the bcm2835-pm-wdt binding which only covered
enough to provide a watchdog, but the HW block is actually mostly
about power domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
new file mode 100644
index 000000000000..7818d33a158f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
@@ -0,0 +1,42 @@
+BCM2835 PM (Power domains, watchdog)
+
+The PM block controls power domains and some reset lines, and includes
+a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
+binding which covered some of PM's register range and functionality.
+
+Required properties:
+
+- compatible:		Should be "brcm,bcm2835-pm"
+- reg:			Specifies base physical address and size of the two
+			  register ranges ("PM" and "ASYNC_BRIDGE" in that
+			  order)
+- clocks:		a) v3d: The V3D clock from CPRMAN
+			b) peri_image: The PERI_IMAGE clock from CPRMAN
+			c) h264: The H264 clock from CPRMAN
+			d) isp: The ISP clock from CPRMAN
+- #reset-cells: 	Should be 1.  This property follows the reset controller
+			  bindings[1].
+- #power-domain-cells:	Should be 1.  This property follows the power domain
+			  bindings[2].
+
+Optional properties:
+
+- timeout-sec:	Contains the watchdog timeout in seconds
+
+[1] Documentation/devicetree/bindings/reset/reset.txt
+[2] Documentation/devicetree/bindings/power/power_domain.txt
+
+Example:
+
+pm {
+	compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+	#power-domain-cells = <1>;
+	#reset-cells = <1>;
+	reg = <0x7e100000 0x114>,
+	      <0x7e00a000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_V3D>,
+		 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+		 <&clocks BCM2835_CLOCK_H264>,
+		 <&clocks BCM2835_CLOCK_ISP>;
+	clock-names = "v3d", "peri_image", "h264", "isp";
+};
-- 
2.19.1

