Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6558E22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6558E22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeKNIoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:44:23 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:38758 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbeKNIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:44:22 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993032AbeKMWmaKhUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:42:30 +0100
Date:   Tue, 13 Nov 2018 22:42:30 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] MIPS: SiByte: Set 32-bit bus mask for BCM1250 PCI
In-Reply-To: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1811132035050.9637@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom SiByte BCM1250, BCM1125H and BCM1125 SOCs have an onchip 
32-bit PCI host bridge, and the two former SOCs also have an onchip HT 
host bridge.  The HT host bridge, where present, appears in the PCI 
configuration space as if it was a device on the 32-bit PCI bus behind 
the PCI host bridge, however at the hardware level its signals are 
routed separately, so these two devices are actually peer host bridges.

As documented[1] and observed in reality the 32-bit PCI host bridge does 
not support 64-bit addressing as it does not support the Dual Address 
Cycle (DAC) PCI command, and naturally, being 32-bit only, it has no 
means to carry the high 32 address bits otherwise.  However the DRAM 
controller also included in the SOC supports memory amounts of up to 
16GiB, and due to how the address decoder has been wired in the SOC any 
memory beyond 1GiB is actually mapped starting from 4GiB physical up, 
that is beyond the 32-bit addressable limit.  Consequently if the 
maximum amount of memory has been installed, then it will span up to 
19GiB.

Contrariwise, the HT host bridge does support full 40-bit addressing 
defined by the HyperTransport (formerly LDT) specification the bridge 
adheres to, depending on the peripherals revision of the SOC[2] either 
revision 0.17[3] or revision 1.03[4].  This allows addressing any and 
all memory installed, and well beyond.

Set the bus mask then to limit DMA addressing to 32 bits for all the 
devices down the 32-bit PCI host bridge, excluding however any devices 
that are down the HT host bridge.

References:

[1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R, 
    Broadcom Corporation, 21 Oct 2002, Section 8: "PCI Bus and 
    HyperTransport Fabric", "Introduction", p. 190

[2] same, Table 140: "HyperTransport Configuration Header (Type 1)", p. 
    245

[3] "Lightning Data Transport IO Specification", Revision 0.17, Advanced 
    Micro Devices, 21 Jan 2000, Section 3.2.1.2 "Command Packet", p. 8

[4] "HyperTransport I/O Link Specification", Revision 1.03, 
    HyperTransport Technology Consortium, 10 Oct 2001, Section 3.2.1.2 
    "Request Packet", pp. 27-28

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
No changes from v2.

Changes from v1:

- conditions restructured in `sb1250_bus_dma_mask' for clarity, no 
  functional change.
---
 arch/mips/pci/fixup-sb1250.c |   53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

linux-mips-sibyte-sb1250-bus-dma-mask.diff
Index: linux-20181104-swarm64-eb/arch/mips/pci/fixup-sb1250.c
===================================================================
--- linux-20181104-swarm64-eb.orig/arch/mips/pci/fixup-sb1250.c
+++ linux-20181104-swarm64-eb/arch/mips/pci/fixup-sb1250.c
@@ -1,6 +1,7 @@
 /*
  *	Copyright (C) 2004, 2006  MIPS Technologies, Inc.  All rights reserved.
  *	    Author:	Maciej W. Rozycki <macro@mips.com>
+ *	Copyright (C) 2018  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -8,6 +9,7 @@
  *	2 of the License, or (at your option) any later version.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/pci.h>
 
 /*
@@ -22,6 +24,57 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SI
 			quirk_sb1250_pci);
 
 /*
+ * The BCM1250, etc. PCI host bridge does not support DAC on its 32-bit
+ * bus, so we set the bus's DMA mask accordingly.  However the HT link
+ * down the artificial PCI-HT bridge supports 40-bit addressing and the
+ * SP1011 HT-PCI bridge downstream supports both DAC and a 64-bit bus
+ * width, so we record the PCI-HT bridge's secondary and subordinate bus
+ * numbers and do not set the mask for devices present in the inclusive
+ * range of those.
+ */
+struct sb1250_bus_dma_mask_exclude {
+	bool set;
+	unsigned char start;
+	unsigned char end;
+};
+
+static int sb1250_bus_dma_mask(struct pci_dev *dev, void *data)
+{
+	struct sb1250_bus_dma_mask_exclude *exclude = data;
+	bool exclude_this;
+	bool ht_bridge;
+
+	exclude_this = exclude->set && (dev->bus->number >= exclude->start &&
+					dev->bus->number <= exclude->end);
+	ht_bridge = !exclude->set && (dev->vendor == PCI_VENDOR_ID_SIBYTE &&
+				      dev->device == PCI_DEVICE_ID_BCM1250_HT);
+
+	if (exclude_this) {
+		dev_dbg(&dev->dev, "not disabling DAC for device");
+	} else if (ht_bridge) {
+		exclude->start = dev->subordinate->number;
+		exclude->end = pci_bus_max_busnr(dev->subordinate);
+		exclude->set = true;
+		dev_dbg(&dev->dev, "not disabling DAC for [bus %02x-%02x]",
+			exclude->start, exclude->end);
+	} else {
+		dev_dbg(&dev->dev, "disabling DAC for device");
+		dev->dev.bus_dma_mask = DMA_BIT_MASK(32);
+	}
+
+	return 0;
+}
+
+static void quirk_sb1250_pci_dac(struct pci_dev *dev)
+{
+	struct sb1250_bus_dma_mask_exclude exclude = { .set = false };
+
+	pci_walk_bus(dev->bus, sb1250_bus_dma_mask, &exclude);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_PCI,
+			quirk_sb1250_pci_dac);
+
+/*
  * The BCM1250, etc. PCI/HT bridge reports as a host bridge.
  */
 static void quirk_sb1250_ht(struct pci_dev *dev)
