Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeCWTyv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:54:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeCWTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:54:49 -0400
Date: Fri, 23 Mar 2018 12:54:19 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-16e73adbca76fd18733278cb688b0ddb4cad162c@git.kernel.org>
Cc: mingo@kernel.org, hch@lst.de, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, jdmason@kudzu.us, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org, mulix@mulix.org,
        tglx@linutronix.de, joro@8bytes.org
Reply-To: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, konrad.wilk@oracle.com, jdmason@kudzu.us,
        hpa@zytor.com, mingo@kernel.org, hch@lst.de,
        torvalds@linux-foundation.org, peterz@infradead.org, mulix@mulix.org,
        tglx@linutronix.de, joro@8bytes.org
In-Reply-To: <20180319103826.12853-15-hch@lst.de>
References: <20180319103826.12853-15-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()
Git-Commit-ID: 16e73adbca76fd18733278cb688b0ddb4cad162c
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

Commit-ID:  16e73adbca76fd18733278cb688b0ddb4cad162c
Gitweb:     https://git.kernel.org/tip/16e73adbca76fd18733278cb688b0ddb4cad162c
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:26 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:59 +0100

dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()

Unused now that everyone uses swiotlb_{alloc,free}().

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-15-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/swiotlb.h |  8 --------
 lib/swiotlb.c           | 38 --------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5b1f2a00491c..965be92c33b5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,14 +72,6 @@ void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 void swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs);
 
-extern void
-*swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			dma_addr_t *dma_handle, gfp_t flags);
-
-extern void
-swiotlb_free_coherent(struct device *hwdev, size_t size,
-		      void *vaddr, dma_addr_t dma_handle);
-
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 8b06b4485e65..15954b86f09e 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -157,13 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-/* Note that this doesn't work with highmem page */
-static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
-				      volatile void *address)
-{
-	return phys_to_dma(hwdev, virt_to_phys(address));
-}
-
 static bool no_iotlb_memory;
 
 void swiotlb_print_info(void)
@@ -752,28 +745,6 @@ out_warn:
 	return NULL;
 }
 
-void *
-swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-		       dma_addr_t *dma_handle, gfp_t flags)
-{
-	int order = get_order(size);
-	unsigned long attrs = (flags & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0;
-	void *ret;
-
-	ret = (void *)__get_free_pages(flags, order);
-	if (ret) {
-		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
-		if (dma_coherent_ok(hwdev, *dma_handle, size)) {
-			memset(ret, 0, size);
-			return ret;
-		}
-		free_pages((unsigned long)ret, order);
-	}
-
-	return swiotlb_alloc_buffer(hwdev, size, dma_handle, attrs);
-}
-EXPORT_SYMBOL(swiotlb_alloc_coherent);
-
 static bool swiotlb_free_buffer(struct device *dev, size_t size,
 		dma_addr_t dma_addr)
 {
@@ -793,15 +764,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 	return true;
 }
 
-void
-swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-		      dma_addr_t dev_addr)
-{
-	if (!swiotlb_free_buffer(hwdev, size, dev_addr))
-		free_pages((unsigned long)vaddr, get_order(size));
-}
-EXPORT_SYMBOL(swiotlb_free_coherent);
-
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
 	     int do_panic)
