Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeCWTvI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:51:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCWTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:51:07 -0400
Date: Fri, 23 Mar 2018 12:50:39 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-51c7eeba7975c1d2a02eefd00ece6de25176f5f3@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, mulix@mulix.org,
        hpa@zytor.com, tglx@linutronix.de, dwmw2@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org, peterz@infradead.org,
        jdmason@kudzu.us, hch@lst.de, joro@8bytes.org, thomas.lendacky@amd.com
Reply-To: mingo@kernel.org, dwmw2@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, mulix@mulix.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, thomas.lendacky@amd.com, hch@lst.de,
        joro@8bytes.org, peterz@infradead.org, jdmason@kudzu.us,
        torvalds@linux-foundation.org
In-Reply-To: <20180319103826.12853-7-hch@lst.de>
References: <20180319103826.12853-7-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] x86/dma/amd_gart: Use dma_direct_{alloc,free}()
Git-Commit-ID: 51c7eeba7975c1d2a02eefd00ece6de25176f5f3
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

Commit-ID:  51c7eeba7975c1d2a02eefd00ece6de25176f5f3
Gitweb:     https://git.kernel.org/tip/51c7eeba7975c1d2a02eefd00ece6de25176f5f3
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:57 +0100

x86/dma/amd_gart: Use dma_direct_{alloc,free}()

This gains support for CMA allocations for the force_iommu case, and
cleans up the code a bit.

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
Link: http://lkml.kernel.org/r/20180319103826.12853-7-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/amd_gart_64.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 79ac6caaaabb..f299d8a479bb 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -480,29 +480,21 @@ static void *
 gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		    gfp_t flag, unsigned long attrs)
 {
-	dma_addr_t paddr;
-	unsigned long align_mask;
-	struct page *page;
-
-	if (force_iommu && dev->coherent_dma_mask > DMA_BIT_MASK(24)) {
-		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
-		if (!page)
-			return NULL;
-
-		align_mask = (1UL << get_order(size)) - 1;
-		paddr = dma_map_area(dev, page_to_phys(page), size,
-				     DMA_BIDIRECTIONAL, align_mask);
-
-		flush_gart();
-		if (paddr != bad_dma_addr) {
-			*dma_addr = paddr;
-			return page_address(page);
-		}
-		__free_pages(page, get_order(size));
-	} else
-		return dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	void *vaddr;
+
+	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	if (!vaddr ||
+	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
+		return vaddr;
 
+	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
+			DMA_BIDIRECTIONAL, (1UL << get_order(size)) - 1);
+	flush_gart();
+	if (unlikely(*dma_addr == bad_dma_addr))
+		goto out_free;
+	return vaddr;
+out_free:
+	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
 	return NULL;
 }
 
