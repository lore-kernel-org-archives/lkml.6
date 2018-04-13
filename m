Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeDMJRS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:17:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeDMJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:17:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 962666076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH] mm: vmalloc: Remove double execution of vunmap_page_range
Date: Fri, 13 Apr 2018 14:46:59 +0530
Message-Id: <1523611019-17679-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmap legs do call vunmap_page_range() irrespective of
debug_pagealloc_enabled() is enabled or not. So, remove
redundant check and optional vunmap_page_range() routines.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 mm/vmalloc.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebff729..920378a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -603,26 +603,6 @@ static void unmap_vmap_area(struct vmap_area *va)
 	vunmap_page_range(va->va_start, va->va_end);
 }
 
-static void vmap_debug_free_range(unsigned long start, unsigned long end)
-{
-	/*
-	 * Unmap page tables and force a TLB flush immediately if pagealloc
-	 * debugging is enabled.  This catches use after free bugs similarly to
-	 * those in linear kernel virtual address space after a page has been
-	 * freed.
-	 *
-	 * All the lazy freeing logic is still retained, in order to minimise
-	 * intrusiveness of this debugging feature.
-	 *
-	 * This is going to be *slow* (linear kernel virtual address debugging
-	 * doesn't do a broadcast TLB flush so it is a lot faster).
-	 */
-	if (debug_pagealloc_enabled()) {
-		vunmap_page_range(start, end);
-		flush_tlb_kernel_range(start, end);
-	}
-}
-
 /*
  * lazy_max_pages is the maximum amount of virtual address space we gather up
  * before attempting to purge with a TLB flush.
@@ -756,6 +736,7 @@ static void free_unmap_vmap_area(struct vmap_area *va)
 {
 	flush_cache_vunmap(va->va_start, va->va_end);
 	unmap_vmap_area(va);
+	flush_tlb_kernel_range(va->va_start, va->va_end);
 	free_vmap_area_noflush(va);
 }
 
@@ -1142,7 +1123,6 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	BUG_ON(!PAGE_ALIGNED(addr));
 
 	debug_check_no_locks_freed(mem, size);
-	vmap_debug_free_range(addr, addr+size);
 
 	if (likely(count <= VMAP_MAX_ALLOC)) {
 		vb_free(mem, size);
@@ -1499,7 +1479,6 @@ struct vm_struct *remove_vm_area(const void *addr)
 		va->flags |= VM_LAZY_FREE;
 		spin_unlock(&vmap_area_lock);
 
-		vmap_debug_free_range(va->va_start, va->va_end);
 		kasan_free_shadow(vm);
 		free_unmap_vmap_area(va);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
