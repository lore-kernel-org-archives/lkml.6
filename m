Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99257C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B44421479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B44421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJQAdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:33:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51383 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeJQAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:33:39 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gCSQE-00060Q-NI; Tue, 16 Oct 2018 18:42:18 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 1/2] dt-bindings: irq: add binding for Freescale IRQSTEER multiplexer
Date:   Tue, 16 Oct 2018 18:42:17 +0200
Message-Id: <20181016164218.3736-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT binding for the Freescale IRQSTEER interrupt
multiplexer found in the i.MX8 familiy SoCs.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../interrupt-controller/fsl,irqsteer.txt     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
new file mode 100644
index 000000000000..ed2b18165591
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
@@ -0,0 +1,39 @@
+Freescale IRQSTEER Interrupt multiplexer
+
+Required properties:
+
+- compatible: should be:
+	- "fsl,imx8m-irqsteer"
+	- "fsl,imx-irqsteer"
+- reg: Physical base address and size of registers.
+- interrupts: Should contain the parent interrupt line used to multiplex the
+  input interrupts.
+- clocks: Should contain one clock for entry in clock-names
+  see Documentation/devicetree/bindings/clock/clock-bindings.txt
+- clock-names:
+   - "ipg": main logic clock
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value must be 2.
+
+Optional properties:
+- fsl,channel: Number of channels managed by this controller. Each channel
+  contains up to 32 interrupt sources. If absent defaults to 1.
+- fsl,endian:
+  0: controller registers are little endian
+  1: controller registers are big endian
+  If absent defaults to 0.
+
+Example:
+
+	interrupt-controller@32e2d000 {
+		compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x32e2d000 0x1000>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+		clock-names = "ipg";
+		fsl,channel = <2>;
+		fsl,endian = <1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
-- 
2.19.0

