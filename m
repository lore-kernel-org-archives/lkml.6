Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA92C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376FE2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376FE2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbeKMXMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:12:39 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:37381 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732728AbeKMXMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:12:39 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 18:12:38 EST
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie5.idc.renesas.com with ESMTP; 13 Nov 2018 22:09:29 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 86026B6BC7;
        Tue, 13 Nov 2018 22:09:29 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,499,1534777200"; 
   d="scan'208";a="297422162"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 13 Nov 2018 22:09:26 +0900
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
Subject: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1 gpio irq mux binding
Date:   Tue, 13 Nov 2018 13:09:09 +0000
Message-Id: <20181113130910.22130-2-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113130910.22130-1-phil.edworthy@renesas.com>
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
multiplexer.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
 - Use 'interrupt-map' DT property correctly.
v2:
 - Use interrupt-map to allow the GPIO controller info to be specified
   as part of the irq.
 - Don't show status in binding examples.
 - Don't show the soc/board split in binding doc.
---
 .../interrupt-controller/renesas,rzn1-mux.txt | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
new file mode 100644
index 000000000000..6515880e25cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
@@ -0,0 +1,73 @@
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
+- reg: Base address and size of GPIO IRQ Muxer registers.
+- interrupts: List of output interrupts.
+- #interrupt-cells: Numder of cells in the input interrupt specifier, must be 1.
+- #address-cells: Must be 0.
+- interrupt-map-mask: must be 127.
+- interrupt-map: Standard property detailing the maps between input irqs and the
+  corresponding output irq. This consist of a list of:
+	<input-irq-spec phandle-to-interrupt-controller output-irq-spec>
+  The input-irq-spec is from 0 to 95, corresponding to the outputs of the GPIO
+  Controllers.
+
+Example:
+
+	The following is an example for the RZ/N1D SoC.
+
+	gpioirqmux: gpioirqmux@51000480 {
+		compatible = "renesas,r9a06g032-gpioirqmux",
+				"renesas,rzn1-gpioirqmux";
+		reg = <0x51000480 0x20>;
+		interrupts =
+			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		interrupt-map-mask = <127>;
+		interrupt-map =
+			/* gpio2a 24, pin 146: ETH Port 1 IRQ */
+			<88 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+			/* gpio2a 26, pin 148: TouchSCRN_IRQ */
+			<90 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpio2: gpio@5000d000 {
+		compatible = "snps,dw-apb-gpio";
+		reg = <0x5000d000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "bus";
+		clocks = <&sysctrl R9A06G032_HCLK_GPIO2>;
+
+		gpio2a: gpio-controller@0 {
+			compatible = "snps,dw-apb-gpio-port";
+			bank-name = "gpio2a";
+			gpio-controller;
+			#gpio-cells = <2>;
+			snps,nr-gpios = <32>;
+			reg = <0>;
+
+			interrupt-controller;
+			interrupt-parent = <&gpioirqmux>;
+			interrupts =  < 64 65 66 67 68 69 70 71
+					72 73 74 75 76 77 78 79
+					80 81 82 83 84 85 86 87
+					88 89 90 91 92 93 94 95 >;
+			#interrupt-cells = <2>;
+		};
+	};
-- 
2.17.1

