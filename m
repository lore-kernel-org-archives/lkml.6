Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D7AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3995B2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3995B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeIFOPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:15:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:11897 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeIFOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:15:20 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Sep 2018 18:40:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D90EC600AA;
        Thu,  6 Sep 2018 18:40:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 6 Sep 2018 18:40:41 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2EA5C1A03A2;
        Thu,  6 Sep 2018 18:40:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: add UniPhier PCIe host controller description
Date:   Thu,  6 Sep 2018 18:40:31 +0900
Message-Id: <1536226832-5089-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536226832-5089-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1536226832-5089-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for PCIe controller implemented in UniPhier SoCs when
configured in Root Complex (host) mode. This controller is based on
the DesignWare PCIe core.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
new file mode 100644
index 0000000..a34e167
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -0,0 +1,78 @@
+Socionext UniPhier PCIe host controller bindings
+
+This describes the devicetree bindings for PCIe host controller implemented
+on Socionext UniPhier SoCs.
+
+UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
+It shares common functions with the PCIe DesignWare core driver and inherits
+common properties defined in
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+Required properties:
+- compatible: Should be "socionext,uniphier-pcie".
+- reg: Specifies offset and length of the register set for the device.
+	According to the reg-names, appropriate register sets are required.
+- reg-names: Must include the following entries:
+    "dbi"    - controller configuration registers
+    "link"   - SoC-specific glue layer registers
+    "config" - PCIe configuration space
+- clocks: A phandle to the clock gate for PCIe glue layer including
+	the host controller.
+- resets: A phandle to the reset line for PCIe glue layer including
+	the host controller.
+- interrupts: A list of interrupt specifiers. According to the
+	interrupt-names, appropriate interrupts are required.
+- interrupt-names: Must include the following entries:
+    "dma"    - DMA interrupt
+    "msi"    - MSI interrupt
+    "intx"   - Legacy INTA/B/C/D interrupt
+
+Optional properties:
+- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
+	phys are required.
+- phy-names: Must be "pcie-phy".
+
+Required sub-node:
+- interrupt-controller: Specifies interrupt controller for legacy PCI
+	interrupts. The node name isn't important.
+
+Required properties for interrupt-controller:
+- interrupt-controller: identifies the node as an interrupt controller.
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+
+Example:
+
+	pcie: pcie@66000000 {
+		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+		status = "disabled";
+		reg-names = "dbi", "link", "config";
+		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
+		      <0x2fff0000 0x10000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clocks = <&sys_clk 24>;
+		resets = <&sys_rst 24>;
+		num-lanes = <1>;
+		num-viewport = <1>;
+		bus-range = <0x0 0xff>;
+		device_type = "pci";
+		ranges =
+		/* downstream I/O */
+			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
+		/* non-prefetchable memory */
+			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
+		#interrupt-cells = <1>;
+		interrupt-names = "dma", "msi", "intx";
+		interrupts = <0 224 4>, <0 225 4>, <0 226 4>;
+		interrupt-map-mask = <0 0 0  7>;
+		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
+				<0 0 0  2  &pcie_intc 1>,	/* INTB */
+				<0 0 0  3  &pcie_intc 2>,	/* INTC */
+				<0 0 0  4  &pcie_intc 3>;	/* INTD */
+
+		pcie_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+	};
-- 
2.7.4

