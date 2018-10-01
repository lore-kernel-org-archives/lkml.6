Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9D62089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9D62089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJBESY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:18:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:11191 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeJBESX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:18:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 14:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="84916735"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2018 14:38:03 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, willy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v7 1/4] vmalloc: Add __vmalloc_node_try_addr function
Date:   Mon,  1 Oct 2018 14:38:44 -0700
Message-Id: <1538429927-17834-2-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538429927-17834-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1538429927-17834-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create __vmalloc_node_try_addr function that tries to allocate at a specific
address and supports caller specified behavior for whether any lazy purging
happens if there is a collision.

This new function draws from the __vmalloc_node_range implementation. Attempts
to merge the two into a single allocator resulted in logic that was difficult
to follow, so they are left separate.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/vmalloc.h |   3 +
 mm/vmalloc.c            | 177 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 398e9c9..c7712c8 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -82,6 +82,9 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller);
+extern void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
+			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
+			int node, int try_purge, const void *caller);
 #ifndef CONFIG_MMU
 extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
 static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a728fc4..1954458 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1709,6 +1709,181 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
+static bool pvm_find_next_prev(unsigned long end,
+			       struct vmap_area **pnext,
+			       struct vmap_area **pprev);
+
+/* Try to allocate a region of KVA of the specified address and size. */
+static struct vmap_area *try_alloc_vmap_area(unsigned long addr,
+				unsigned long size, int node, gfp_t gfp_mask,
+				int try_purge)
+{
+	struct vmap_area *va;
+	struct vmap_area *cur_va = NULL;
+	struct vmap_area *first_before = NULL;
+	int need_purge = 0;
+	int blocked = 0;
+	int purged = 0;
+	unsigned long addr_end;
+
+	WARN_ON(!size);
+	WARN_ON(offset_in_page(size));
+
+	addr_end = addr + size;
+	if (addr > addr_end)
+		return ERR_PTR(-EOVERFLOW);
+
+	might_sleep();
+
+	va = kmalloc_node(sizeof(struct vmap_area),
+			gfp_mask & GFP_RECLAIM_MASK, node);
+	if (unlikely(!va))
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Only scan the relevant parts containing pointers to other objects
+	 * to avoid false negatives.
+	 */
+	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
+
+retry:
+	spin_lock(&vmap_area_lock);
+
+	pvm_find_next_prev(addr, &cur_va, &first_before);
+
+	if (!cur_va)
+		goto found;
+
+	/*
+	 * If there is no VA that starts before the target address, start the
+	 * check from the closest VA in order to cover the case where the
+	 * allocation overlaps at the end.
+	 */
+	if (first_before && addr < first_before->va_end)
+		cur_va = first_before;
+
+	/* Linearly search through to make sure there is a hole */
+	while (cur_va->va_start < addr_end) {
+		if (cur_va->va_end > addr) {
+			if (cur_va->flags & VM_LAZY_FREE) {
+				need_purge = 1;
+			} else {
+				blocked = 1;
+				break;
+			}
+		}
+
+		if (list_is_last(&cur_va->list, &vmap_area_list))
+			break;
+
+		cur_va = list_next_entry(cur_va, list);
+	}
+
+	/*
+	 * If a non-lazy free va blocks the allocation, or
+	 * we are not supposed to purge, but we need to, the
+	 * allocation fails.
+	 */
+	if (blocked || (need_purge && !try_purge))
+		goto fail;
+
+	if (try_purge && need_purge) {
+		/* if purged once before, give up */
+		if (purged)
+			goto fail;
+
+		/*
+		 * If the va blocking the allocation is set to
+		 * be purged then purge all vmap_areas that are
+		 * set to purged since this will flush the TLBs
+		 * anyway.
+		 */
+		spin_unlock(&vmap_area_lock);
+		purge_vmap_area_lazy();
+		need_purge = 0;
+		purged = 1;
+		goto retry;
+	}
+
+found:
+	va->va_start = addr;
+	va->va_end = addr_end;
+	va->flags = 0;
+	__insert_vmap_area(va);
+	spin_unlock(&vmap_area_lock);
+
+	return va;
+fail:
+	spin_unlock(&vmap_area_lock);
+	kfree(va);
+	if (need_purge && !blocked)
+		return ERR_PTR(-EUCLEAN);
+	return ERR_PTR(-EBUSY);
+}
+
+/**
+ *	__vmalloc_try_addr  -  try to alloc at a specific address
+ *	@addr:		address to try
+ *	@size:		size to try
+ *	@gfp_mask:	flags for the page level allocator
+ *	@prot:		protection mask for the allocated pages
+ *	@vm_flags:	additional vm area flags (e.g. %VM_NO_GUARD)
+ *	@node:		node to use for allocation or NUMA_NO_NODE
+ *	@try_purge:	try to purge if needed to fulfill and allocation
+ *	@caller:	caller's return address
+ *
+ *	Try to allocate at the specific address. If it succeeds the address is
+ *	returned. If it fails an EBUSY ERR_PTR is returned. If try_purge is
+ *	zero, it will return an EUCLEAN ERR_PTR if it could have allocated if it
+ *	was allowed to purge. It may trigger TLB flushes if a purge is needed,
+ *	and try_purge is set.
+ */
+void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
+			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
+			int node, int try_purge, const void *caller)
+{
+	struct vmap_area *va;
+	struct vm_struct *area;
+	void *alloc_addr;
+	unsigned long real_size = size;
+
+	size = PAGE_ALIGN(size);
+	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
+		return NULL;
+
+	WARN_ON(in_interrupt());
+
+	if (!(vm_flags & VM_NO_GUARD))
+		size += PAGE_SIZE;
+
+	va = try_alloc_vmap_area(addr, size, node, gfp_mask, try_purge);
+	if (IS_ERR(va))
+		goto fail;
+
+	area = kzalloc_node(sizeof(*area), gfp_mask & GFP_RECLAIM_MASK, node);
+	if (unlikely(!area)) {
+		warn_alloc(gfp_mask, NULL, "kmalloc: allocation failure");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	setup_vmalloc_vm(area, va, vm_flags, caller);
+
+	alloc_addr = __vmalloc_area_node(area, gfp_mask, prot, node);
+	if (!alloc_addr) {
+		warn_alloc(gfp_mask, NULL,
+			"vmalloc: allocation failure: %lu bytes", real_size);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clear_vm_uninitialized_flag(area);
+
+	kmemleak_vmalloc(area, real_size, gfp_mask);
+
+	return alloc_addr;
+fail:
+	return va;
+}
+
 /**
  *	__vmalloc_node_range  -  allocate virtually contiguous memory
  *	@size:		allocation size
@@ -2355,7 +2530,6 @@ void free_vm_area(struct vm_struct *area)
 }
 EXPORT_SYMBOL_GPL(free_vm_area);
 
-#ifdef CONFIG_SMP
 static struct vmap_area *node_to_va(struct rb_node *n)
 {
 	return rb_entry_safe(n, struct vmap_area, rb_node);
@@ -2403,6 +2577,7 @@ static bool pvm_find_next_prev(unsigned long end,
 	return true;
 }
 
+#ifdef CONFIG_SMP
 /**
  * pvm_determine_end - find the highest aligned address between two vmap_areas
  * @pnext: in/out arg for the next vmap_area
-- 
2.7.4

