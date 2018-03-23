Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeCWTwa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:52:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeCWTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:52:28 -0400
Date: Fri, 23 Mar 2018 12:52:00 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-178c5682447ac0e315f0f3e27664fd4e0d2721cc@git.kernel.org>
Cc: hch@lst.de, mingo@kernel.org, mulix@mulix.org, hpa@zytor.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, dwmw2@infradead.org,
        konrad.wilk@oracle.com, torvalds@linux-foundation.org,
        jdmason@kudzu.us, joro@8bytes.org
Reply-To: peterz@infradead.org, dwmw2@infradead.org, tglx@linutronix.de,
        joro@8bytes.org, torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        jdmason@kudzu.us, mingo@kernel.org, hpa@zytor.com, mulix@mulix.org,
        hch@lst.de, linux-kernel@vger.kernel.org, thomas.lendacky@amd.com
In-Reply-To: <20180319103826.12853-10-hch@lst.de>
References: <20180319103826.12853-10-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] x86/dma: Remove dma_alloc_coherent_gfp_flags()
Git-Commit-ID: 178c5682447ac0e315f0f3e27664fd4e0d2721cc
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

Commit-ID:  178c5682447ac0e315f0f3e27664fd4e0d2721cc
Gitweb:     https://git.kernel.org/tip/178c5682447ac0e315f0f3e27664fd4e0d2721cc
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:58 +0100

x86/dma: Remove dma_alloc_coherent_gfp_flags()

All dma_ops implementations used on x86 now take care of setting their own
required GFP_ masks for the allocation.  And given that the common code
now clears harmful flags itself that means we can stop the flags in all
the IOMMU implementations as well.

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
Link: http://lkml.kernel.org/r/20180319103826.12853-10-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/dma-mapping.h | 11 -----------
 arch/x86/kernel/pci-calgary_64.c   |  2 --
 arch/x86/kernel/pci-dma.c          |  2 --
 arch/x86/mm/mem_encrypt.c          |  7 -------
 4 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index df9816b385eb..89ce4bfd241f 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -36,15 +36,4 @@ int arch_dma_supported(struct device *dev, u64 mask);
 bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
 #define arch_dma_alloc_attrs arch_dma_alloc_attrs
 
-static inline gfp_t dma_alloc_coherent_gfp_flags(struct device *dev, gfp_t gfp)
-{
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
-		gfp |= GFP_DMA;
-#ifdef CONFIG_X86_64
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
-		gfp |= GFP_DMA32;
-#endif
-       return gfp;
-}
-
 #endif
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 5647853053bd..bbfc8b1e9104 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -446,8 +446,6 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 	npages = size >> PAGE_SHIFT;
 	order = get_order(size);
 
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-
 	/* alloc enough pages (and possibly more) */
 	ret = (void *)__get_free_pages(flag, order);
 	if (!ret)
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index db0b88ea8d1b..14437116ffea 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -82,8 +82,6 @@ bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp)
 	if (!*dev)
 		*dev = &x86_dma_fallback_dev;
 
-	*gfp = dma_alloc_coherent_gfp_flags(*dev, *gfp);
-
 	if (!is_device_dma_capable(*dev))
 		return false;
 	return true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index f6cd84beb610..1217a4fab915 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -203,13 +203,6 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	void *vaddr = NULL;
 
 	order = get_order(size);
-
-	/*
-	 * Memory will be memset to zero after marking decrypted, so don't
-	 * bother clearing it before.
-	 */
-	gfp &= ~__GFP_ZERO;
-
 	page = alloc_pages_node(dev_to_node(dev), gfp, order);
 	if (page) {
 		dma_addr_t addr;
