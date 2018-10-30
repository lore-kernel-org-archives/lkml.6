Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E7FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6827420823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6827420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJ3TiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:38:00 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:38508 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726692AbeJ3TiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:38:00 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 30 Oct 2018 19:45:01 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 95F1F95E51;
        Tue, 30 Oct 2018 19:45:01 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,444,1534777200"; 
   d="scan'208";a="296394853"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 30 Oct 2018 19:44:58 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1 gpio irq mux binding
Date:   Tue, 30 Oct 2018 10:44:37 +0000
Message-Id: <20181030104438.27827-2-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030104438.27827-1-phil.edworthy@renesas.com>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
multiplexer.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - Use interrupt-map to allow the GPIO controller info to be specified
   as part of the irq.
 - Don't show status in binding examples.
 - Don't show the soc/board split in binding doc.
---
 .../interrupt-controller/renesas,rzn1-mux.txt | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
new file mode 100644
index 000000000000..0b4ba27c00ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
@@ -0,0 +1,92 @@
+* Renesas RZ/N1 GPIO Interrupt Multiplexer
+
+On Renesas RZ/N1 devices, there are several GPIO Controllers each with a number
+of interrupt outputs. All of the interrupts from the GPIO Controllers are passed
+to the GPIO Interrupt Multiplexer, which selects a sub-set of the interrupts to
+pass onto the system interrupt controller.
+
+A single node in the device tree is used to describe the GPIO IRQ Muxer.
+
+Required properties:
+- compatible: SoC-specific compatible string "renesas,<soc-specific>-gpioirqmux"
+  followed by "renesas,rzn1-gpioirqmux" as fallback. The SoC-specific compatible
+  strings must be one of:
+	"renesas,r9a06g032-gpioirqmux" for RZ/N1D
+	"renesas,r9a06g033-gpioirqmux" for RZ/N1S
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: should be <1>. The meaning of the cells is the input
+   interrupt index, 0 to 95.
+- reg: Base address and size of GPIO IRQ Muxer registers.
+- interrupts: This is a list of interrupt specifiers. Each interrupt consists of
+   three numbers that represent:
+     - (a) the index of the GPIO Interrupt Multiplexer output interrupt (0..7)
+     - (b) the index of the GPIO Controller input interrupt (0..2)
+     - (c) the interrupt index of the GPIO Controller input interrupt (0..31).
+- interrupt-parent: A phandle for a local node that specifies an interrupt-map.
+   The interrupt-map node must specify #interrupt-cells = <3>, and an
+   interrupt-map property. The interrupt-map is used to translate the interrupt
+   specifier to the output interrupts. It is used in conjunction with an
+   interrupt-map-mask property to mask (b) and (c) from the interrupt specifier
+   so that essentially there is a direct map from (a) to the output interrupt.
+   Therefore (b) and (c) can be used to determine the interrupt source and
+   configure the hardware accordingly. For information on interrupts,
+   see Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	The following is an example for the RZ/N1D SoC.
+
+	gpioirqmux: gpioirqmux@51000480 {
+		compatible = "renesas,r9a06g032-gpioirqmux",
+				"renesas,rzn1-gpioirqmux";
+		reg = <0x51000480 0x20>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&gpioirqmux_map>;
+		interrupts =
+			<0 1 17>,	/* gpio1a 17 */
+			<1 1 24>,	/* gpio1a 24 */
+			<2 1 26>;	/* gpio1a 26 */
+
+		gpioirqmux_map: gpioirqmux-map {
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-map-mask = <7 0 0>;
+			interrupt-map =
+				<0 0 0 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				<1 0 0 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				<2 0 0 &gic GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				<3 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<4 0 0 &gic GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				<5 0 0 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				<6 0 0 &gic GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<7 0 0 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	gpio1: gpio@5000c000 {
+		compatible = "snps,dw-apb-gpio";
+		reg = <0x5000c000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "bus";
+		clocks = <&sysctrl R9A06G032_HCLK_GPIO1>;
+
+		gpio1a: gpio-controller@0 {
+			compatible = "snps,dw-apb-gpio-port";
+			bank-name = "gpio1a";
+			gpio-controller;
+			#gpio-cells = <2>;
+			snps,nr-gpios = <32>;
+			reg = <0>;
+
+			interrupt-controller;
+			interrupt-parent = <&gpioirqmux>;
+			interrupts =   < 0  1  2  3  4  5  6  7
+					 8  9 10 11 12 13 14 15
+					16 17 18 19 20 21 22 23
+					24 25 26 27 28 29 30 31 >;
+			#interrupt-cells = <2>;
+		};
+	};
-- 
2.17.1

