Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeEKIBb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:01:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbeEKIB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:01:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] microblaze: remove the consistent_sync and consistent_sync_page
Date: Fri, 11 May 2018 09:59:34 +0200
Message-Id: <20180511075945.16548-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511075945.16548-1-hch@lst.de>
References: <20180511075945.16548-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/pgtable.h |  3 --
 arch/microblaze/mm/consistent.c       | 45 ---------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 8a2e654b709f..7b650ab14fa0 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,9 +553,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-void consistent_sync(void *vaddr, size_t size, int direction);
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction);
 unsigned long consistent_virt_to_pfn(void *vaddr);
 
 void setup_memory(void);
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index b9a9c8c3397b..c9a278ac795a 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -220,48 +220,3 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	flush_tlb_all();
 #endif
 }
-
-/*
- * make an area consistent.
- */
-void consistent_sync(void *vaddr, size_t size, int direction)
-{
-	unsigned long start;
-	unsigned long end;
-
-	start = (unsigned long)vaddr;
-
-	/* Convert start address back down to unshadowed memory region */
-#ifdef CONFIG_XILINX_UNCACHED_SHADOW
-	start &= ~UNCACHED_SHADOW_MASK;
-#endif
-	end = start + size;
-
-	switch (direction) {
-	case PCI_DMA_NONE:
-		BUG();
-	case PCI_DMA_FROMDEVICE:	/* invalidate only */
-		invalidate_dcache_range(start, end);
-		break;
-	case PCI_DMA_TODEVICE:		/* writeback only */
-		flush_dcache_range(start, end);
-		break;
-	case PCI_DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
-		break;
-	}
-}
-EXPORT_SYMBOL(consistent_sync);
-
-/*
- * consistent_sync_page makes memory consistent. identical
- * to consistent_sync, but takes a struct page instead of a
- * virtual address
- */
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
-{
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	consistent_sync((void *)start, size, direction);
-}
-EXPORT_SYMBOL(consistent_sync_page);
-- 
2.17.0
