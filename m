Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E24C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179020870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1179020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbeGJSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:43:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51798 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389000AbeGJSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99AB01682;
        Tue, 10 Jul 2018 10:17:30 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F4313F589;
        Tue, 10 Jul 2018 10:17:27 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
Subject: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
Date:   Tue, 10 Jul 2018 18:17:16 +0100
Message-Id: <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1.dirty
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst the notion of an upstream DMA restriction is most commonly seen
via PCI host bridges saddled with a 32-bit native interface, a more
general version of the same issue can exist on complex SoCs where a bus
or point-to-point interconnect link carries fewer address bits between a
device and a downstream component (often an IOMMU) than both blocks
nominally support. In order to properly deal with this, first grow the
dma_32bit_limit flag into an arbitrary mask.

To minimise the impact on existing code, we'll only consider this new
mask valid if set. That makes sense anyway, since cases where DMA is not
wired up at all would be better handled by not giving the device valid
ops in the first place.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/x86/kernel/pci-dma.c | 2 +-
 include/linux/device.h    | 6 +++---
 kernel/dma/direct.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..0b60f2a9dace 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -175,7 +175,7 @@ rootfs_initcall(pci_iommu_init);
 
 static int via_no_dac_cb(struct pci_dev *pdev, void *data)
 {
-	pdev->dev.dma_32bit_limit = true;
+	pdev->dev_dma_mask = DMA_BIT_MASK(32);
 	return 0;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..6d3b000be57e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -886,6 +886,8 @@ struct dev_links_info {
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
  * 		hardware supports 64-bit addresses for consistent allocations
  * 		such descriptors.
+ * @bus_dma_mask: Mask of an upstream bridge or bus which imposes a smaller DMA
+ *		limit than the device itself supports.
  * @dma_pfn_offset: offset of DMA memory range relatively of RAM
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
@@ -912,8 +914,6 @@ struct dev_links_info {
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
  *              device.
- * @dma_32bit_limit: bridge limited to 32bit DMA even if the device itself
- *		indicates support for a higher limit in the dma_mask field.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -967,6 +967,7 @@ struct device {
 					     not all hardware supports
 					     64 bit addresses for consistent
 					     allocations such descriptors. */
+	u64		bus_dma_mask;	/* upstream dma_mask constraint */
 	unsigned long	dma_pfn_offset;
 
 	struct device_dma_parameters *dma_parms;
@@ -1002,7 +1003,6 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
-	bool			dma_32bit_limit:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8be8106270c2..95e185347e34 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
 	 * if the device itself might support it.
 	 */
-	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
+	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
 		return 0;
 	return 1;
 }
-- 
2.17.1.dirty

