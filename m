Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDQJ5U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:57:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56639 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeDQJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:57:18 -0400
Date: Tue, 17 Apr 2018 02:55:55 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-ef97837db916075af54554552628bcb0840df62f@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        hch@lst.de, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        hch@lst.de, tglx@linutronix.de
In-Reply-To: <20180416124442.13831-1-hch@lst.de>
References: <20180416124442.13831-1-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Remove pci-nommu.c
Git-Commit-ID: ef97837db916075af54554552628bcb0840df62f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ef97837db916075af54554552628bcb0840df62f
Gitweb:     https://git.kernel.org/tip/ef97837db916075af54554552628bcb0840df62f
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 16 Apr 2018 14:44:42 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 11:48:06 +0200

x86: Remove pci-nommu.c

The commit that switched x86 to dma_direct_ops stopped using and building
this file, but accidentally left it in the tree.  Remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.infradead.org
Link: https://lkml.kernel.org/r/20180416124442.13831-1-hch@lst.de

---
 arch/x86/kernel/pci-nommu.c | 90 ---------------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
deleted file mode 100644
index ac7ea3a8242f..000000000000
--- a/arch/x86/kernel/pci-nommu.c
+++ /dev/null
@@ -1,90 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Fallback functions when the main IOMMU code is not compiled in. This
-   code is roughly equivalent to i386. */
-#include <linux/dma-direct.h>
-#include <linux/scatterlist.h>
-#include <linux/string.h>
-#include <linux/gfp.h>
-#include <linux/pci.h>
-#include <linux/mm.h>
-
-#include <asm/processor.h>
-#include <asm/iommu.h>
-#include <asm/dma.h>
-
-#define NOMMU_MAPPING_ERROR		0
-
-static int
-check_addr(char *name, struct device *hwdev, dma_addr_t bus, size_t size)
-{
-	if (hwdev && !dma_capable(hwdev, bus, size)) {
-		if (*hwdev->dma_mask >= DMA_BIT_MASK(32))
-			printk(KERN_ERR
-			    "nommu_%s: overflow %Lx+%zu of device mask %Lx\n",
-				name, (long long)bus, size,
-				(long long)*hwdev->dma_mask);
-		return 0;
-	}
-	return 1;
-}
-
-static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	dma_addr_t bus = phys_to_dma(dev, page_to_phys(page)) + offset;
-	WARN_ON(size == 0);
-	if (!check_addr("map_single", dev, bus, size))
-		return NOMMU_MAPPING_ERROR;
-	return bus;
-}
-
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scatter-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	WARN_ON(nents == 0 || sg[0].length == 0);
-
-	for_each_sg(sg, s, nents, i) {
-		BUG_ON(!sg_page(s));
-		s->dma_address = sg_phys(s);
-		if (!check_addr("map_sg", hwdev, s->dma_address, s->length))
-			return 0;
-		s->dma_length = s->length;
-	}
-	return nents;
-}
-
-static int nommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == NOMMU_MAPPING_ERROR;
-}
-
-const struct dma_map_ops nommu_dma_ops = {
-	.alloc			= dma_generic_alloc_coherent,
-	.free			= dma_generic_free_coherent,
-	.map_sg			= nommu_map_sg,
-	.map_page		= nommu_map_page,
-	.is_phys		= 1,
-	.mapping_error		= nommu_mapping_error,
-	.dma_supported		= x86_dma_supported,
-};
