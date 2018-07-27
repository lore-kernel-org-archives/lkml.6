Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BFEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597EA20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597EA20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbeG0LIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbeG0LIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:19 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9567A898;
        Fri, 27 Jul 2018 09:47:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Fabio Coatti <fabio.coatti@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4.17 02/66] Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()"
Date:   Fri, 27 Jul 2018 11:44:55 +0200
Message-Id: <20180727093809.307234145@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 7ec916f82c48dcfc115eee2e3e0e6d400e310fc5 upstream.

This commit may cause a less than required dma mask to be used for
some allocations, which apparently leads to module load failures for
iwlwifi sometimes.

This reverts commit d657c5c73ca987214a6f9436e435b34fc60f332a.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Fabio Coatti <fabio.coatti@gmail.com>
Tested-by: Fabio Coatti <fabio.coatti@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/Kconfig       |    1 
 drivers/iommu/intel-iommu.c |   64 ++++++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 18 deletions(-)

--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -142,7 +142,6 @@ config DMAR_TABLE
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
-	select DMA_DIRECT_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
 	select DMAR_TABLE
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -31,7 +31,6 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-direct.h>
 #include <linux/mempool.h>
 #include <linux/memory.h>
 #include <linux/cpu.h>
@@ -3709,30 +3708,61 @@ static void *intel_alloc_coherent(struct
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  unsigned long attrs)
 {
-	void *vaddr;
+	struct page *page = NULL;
+	int order;
 
-	vaddr = dma_direct_alloc(dev, size, dma_handle, flags, attrs);
-	if (iommu_no_mapping(dev) || !vaddr)
-		return vaddr;
-
-	*dma_handle = __intel_map_single(dev, virt_to_phys(vaddr),
-			PAGE_ALIGN(size), DMA_BIDIRECTIONAL,
-			dev->coherent_dma_mask);
-	if (!*dma_handle)
-		goto out_free_pages;
-	return vaddr;
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	if (!iommu_no_mapping(dev))
+		flags &= ~(GFP_DMA | GFP_DMA32);
+	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
+			flags |= GFP_DMA;
+		else
+			flags |= GFP_DMA32;
+	}
+
+	if (gfpflags_allow_blocking(flags)) {
+		unsigned int count = size >> PAGE_SHIFT;
+
+		page = dma_alloc_from_contiguous(dev, count, order, flags);
+		if (page && iommu_no_mapping(dev) &&
+		    page_to_phys(page) + size > dev->coherent_dma_mask) {
+			dma_release_from_contiguous(dev, page, count);
+			page = NULL;
+		}
+	}
+
+	if (!page)
+		page = alloc_pages(flags, order);
+	if (!page)
+		return NULL;
+	memset(page_address(page), 0, size);
+
+	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
+					 DMA_BIDIRECTIONAL,
+					 dev->coherent_dma_mask);
+	if (*dma_handle)
+		return page_address(page);
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, order);
 
-out_free_pages:
-	dma_direct_free(dev, size, vaddr, *dma_handle, attrs);
 	return NULL;
 }
 
 static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 				dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (!iommu_no_mapping(dev))
-		intel_unmap(dev, dma_handle, PAGE_ALIGN(size));
-	dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+	int order;
+	struct page *page = virt_to_page(vaddr);
+
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	intel_unmap(dev, dma_handle, size);
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, order);
 }
 
 static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,


