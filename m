Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeEVKHQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:07:16 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:60503 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751060AbeEVKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:07:12 -0400
X-IronPort-AV: E=Sophos;i="5.49,429,1520866800";
   d="scan'208";a="280253499"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 3/6] dt-bindings: clock: renesas,rzn1-clocks: document RZ/N1 clock driver
Date: Tue, 22 May 2018 11:01:23 +0100
Message-Id: <1526983321-41949-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
to provide the SoC clock infrastructure for Linux.

This documents the driver bindings.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/clock/renesas,rzn1-clocks.txt         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
new file mode 100644
index 0000000..0c41137
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
@@ -0,0 +1,44 @@
+* Renesas RZ/N1 Clock Driver
+
+This driver provides the clock infrastructure used by all the other drivers.
+
+One of the 'special' feature of this infrastructure is that Linux doesn't
+necessary 'own' all the clocks on the SoC, some other OS runs on
+the Cortex-M3 core and that OS can access and claim it's own clocks.
+
+Required Properties:
+
+  - compatible: Must be
+    - "renesas,r9a06g032-clocks" for the RZ/N1D
+    and "renesas,rzn1-clocks" as a fallback.
+  - reg: Base address and length of the memory resource used by the driver
+  - #clock-cells: Must be 1
+
+Examples
+--------
+
+  - Clock driver device node:
+
+	clock: clocks@4000c000 {
+		compatible = "renesas,r9a06g032-clocks",
+				"renesas,rzn1-clocks";
+		reg = <0x4000c000 0x1000>;
+		status = "okay";
+		#clock-cells = <1>;
+	};
+
+
+  - Other drivers can use the clocks as in:
+
+	uart0: serial@40060000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x40060000 0x400>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&clock RZN1_CLK_UART0>;
+		clock-names = "baudclk";
+	};
+    Note the use of RZN1_CLK_UART0 -- these constants are declared in
+    the rzn1-clocks.h header file. These are not hardware based constants
+    and are Linux specific.
-- 
2.7.4
