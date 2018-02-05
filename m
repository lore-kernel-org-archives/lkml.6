Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeBEBcz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:32:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:43456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752793AbeBEB3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:23 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 52/64] arch/openrisc: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:42 +0100
Message-Id: <20180205012754.23615-53-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This becomes quite straightforward with the mmrange in place.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/openrisc/kernel/dma.c |  6 ++++--
 arch/openrisc/mm/fault.c   | 10 +++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index a945f00011b4..9fee5388f647 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -87,6 +87,7 @@ or1k_dma_alloc(struct device *dev, size_t size,
 {
 	unsigned long va;
 	void *page;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct mm_walk walk = {
 		.pte_entry = page_set_nocache,
 		.mm = &init_mm
@@ -106,7 +107,7 @@ or1k_dma_alloc(struct device *dev, size_t size,
 		 * We need to iterate through the pages, clearing the dcache for
 		 * them and setting the cache-inhibit bit.
 		 */
-		if (walk_page_range(va, va + size, &walk)) {
+		if (walk_page_range(va, va + size, &walk, &mmrange)) {
 			free_pages_exact(page, size);
 			return NULL;
 		}
@@ -120,6 +121,7 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	      dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long va = (unsigned long)vaddr;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct mm_walk walk = {
 		.pte_entry = page_clear_nocache,
 		.mm = &init_mm
@@ -127,7 +129,7 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 
 	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
 		/* walk_page_range shouldn't be able to fail here */
-		WARN_ON(walk_page_range(va, va + size, &walk));
+		WARN_ON(walk_page_range(va, va + size, &walk, &mmrange));
 	}
 
 	free_pages_exact(vaddr, size);
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 75ddb1e8e7e7..81f6d509bf64 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -109,7 +109,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		goto no_context;
 
 retry:
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	vma = find_vma(mm, address);
 
 	if (!vma)
@@ -198,7 +198,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return;
 
 	/*
@@ -207,7 +207,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 bad_area_nosemaphore:
 
@@ -270,14 +270,14 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	__asm__ __volatile__("l.nop 42");
 	__asm__ __volatile__("l.nop 1");
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
-- 
2.13.6
