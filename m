Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967522AbeE2V7N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:59:13 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35448 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966679AbeE2V7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:59:04 -0400
X-Google-Smtp-Source: ADUXVKLk2yirpYLOmwAK7waM6jzBjZJXh6AGaXkWLtXo9xVQb8ojSz+f7idgcIk420aa8z3Fh/WP3g==
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
Date: Tue, 29 May 2018 14:58:45 -0700
Message-Id: <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the iProc PCIe binding document for better modeling of the legacy
interrupt (INTx) support

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index b8e48b4..7ea24dc 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -13,9 +13,6 @@ controller, used in Stingray
   PAXB-based root complex is used for external endpoint devices. PAXC-based
 root complex is connected to emulated endpoint devices internal to the ASIC
 - reg: base address and length of the PCIe controller I/O register space
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map, standard PCI properties to define the
-  mapping of the PCIe interface to interrupt numbers
 - linux,pci-domain: PCI domain ID. Should be unique for each host controller
 - bus-range: PCI bus numbers covered
 - #address-cells: set to <3>
@@ -41,6 +38,16 @@ Required:
 - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
 address used by the iProc PCIe core (not the PCIe address)
 
+Legacy interrupt (INTx) support (optional):
+
+Note INTx is for PAXB only.
+
+- interrupt-controller: claims itself as an interrupt controller for INTx
+- #interrupt-cells: set to <1>
+- interrupt-map-mask and interrupt-map, standard PCI properties to define
+the mapping of the PCIe interface to interrupt numbers
+- interrupts: interrupt line wired to the generic GIC for INTx support
+
 MSI support (optional):
 
 For older platforms without MSI integrated in the GIC, iProc PCIe core provides
@@ -77,9 +84,14 @@ Example:
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18012000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0 1>,
+				<0 0 0 2 &pcie0 2>,
+				<0 0 0 3 &pcie0 3>,
+				<0 0 0 4 &pcie0 4>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <0>;
 
@@ -115,9 +127,14 @@ Example:
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18013000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1 1>,
+				<0 0 0 2 &pcie1 2>,
+				<0 0 0 3 &pcie1 3>,
+				<0 0 0 4 &pcie1 4>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <1>;
 
-- 
2.1.4
