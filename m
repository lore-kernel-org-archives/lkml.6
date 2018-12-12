Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABDC67872
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2902084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2902084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeLLXwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:52:03 -0500
Received: from anholt.net ([50.246.234.109]:59118 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbeLLXv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:51:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B176910A1DB5;
        Wed, 12 Dec 2018 15:51:55 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IVeULlcjD68n; Wed, 12 Dec 2018 15:51:53 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5203F10A1D70;
        Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 27B862FE1FF3; Wed, 12 Dec 2018 15:51:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
Date:   Wed, 12 Dec 2018 15:51:46 -0800
Message-Id: <20181212235150.6491-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
References: <20181212235150.6491-1-eric@anholt.net>
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
Reviewed-by: Rob Herring <robh@kernel.org> (v3)
---

v4: Add the system-power-controller node.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
new file mode 100644
index 000000000000..3b7d32956391
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
@@ -0,0 +1,46 @@
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
+- timeout-sec:		Contains the watchdog timeout in seconds
+- system-power-controller: Whether the watchdog is controlling the
+    system power.  This node follows the power controller bindings[3].
+
+[1] Documentation/devicetree/bindings/reset/reset.txt
+[2] Documentation/devicetree/bindings/power/power_domain.txt
+[3] Documentation/devicetree/bindings/power/power-controller.txt
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
+	system-power-controller;
+};
-- 
2.20.0.rc1

