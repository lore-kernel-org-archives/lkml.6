Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014EFC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B307E2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B307E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeKJLTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:19:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:50506 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbeKJLTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:19:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 17:36:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,485,1534834800"; 
   d="scan'208";a="105025660"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2018 17:36:27 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, willy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 1/4] vmalloc: Add __vmalloc_node_try_addr function
Date:   Fri,  9 Nov 2018 17:38:04 -0800
Message-Id: <20181110013807.24903-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181110013807.24903-1-rick.p.edgecombe@intel.com>
References: <20181110013807.24903-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create __vmalloc_node_try_addr function that tries to allocate at a specific
address without triggering any lazy purging and retry. For the randomized
allocator that uses this function, failing to allocate at a specific address is
a lot more common. This function will not try to do any lazy purge and retry,
to try to fail faster when an allocation won't fit at a specific address. This
function is used for a case where lazy free areas are unlikely and so the purge
and retry is just extra work done every time. For the randomized module
loader, the performance for an average allocation in ns for different numbers
of modules was:

Modules Vmalloc optimization    No Vmalloc Optimization
1000    1433                    1993
2000    2295                    3681
3000    4424                    7450
4000    7746                    13824
5000    12721                   21852
6000    19724                   33926
7000    27638                   47427
8000    37745                   64443

In order to support this behavior a try_addr argument was plugged into several
of the static helpers.

This also changes logic in __get_vm_area_node to be faster in cases where
allocations fail due to no space, which is a lot more common when trying
specific addresses.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/vmalloc.h |   3 +
 mm/vmalloc.c            | 128 +++++++++++++++++++++++++++++-----------
 2 files changed, 95 insertions(+), 36 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 398e9c95cd61..6eaa89612372 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -82,6 +82,9 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller);
+extern void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
+			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
+			int node, const void *caller);
 #ifndef CONFIG_MMU
 extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
 static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 97d4b25d0373..b8b34d319c85 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -326,6 +326,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define VM_LAZY_FREE	0x02
 #define VM_VM_AREA	0x04
 
+#define VMAP_MAY_PURGE	0x2
+#define VMAP_NO_PURGE	0x1
+
 static DEFINE_SPINLOCK(vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
@@ -402,12 +405,12 @@ static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
-				int node, gfp_t gfp_mask)
+				int node, gfp_t gfp_mask, int try_purge)
 {
 	struct vmap_area *va;
 	struct rb_node *n;
 	unsigned long addr;
-	int purged = 0;
+	int purged = try_purge & VMAP_NO_PURGE;
 	struct vmap_area *first;
 
 	BUG_ON(!size);
@@ -860,7 +863,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
-					node, gfp_mask);
+					node, gfp_mask, VMAP_MAY_PURGE);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -1170,8 +1173,9 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 		addr = (unsigned long)mem;
 	} else {
 		struct vmap_area *va;
-		va = alloc_vmap_area(size, PAGE_SIZE,
-				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
+		va = alloc_vmap_area(size, PAGE_SIZE, VMALLOC_START,
+					VMALLOC_END, node, GFP_KERNEL,
+					VMAP_MAY_PURGE);
 		if (IS_ERR(va))
 			return NULL;
 
@@ -1372,7 +1376,8 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 
 static struct vm_struct *__get_vm_area_node(unsigned long size,
 		unsigned long align, unsigned long flags, unsigned long start,
-		unsigned long end, int node, gfp_t gfp_mask, const void *caller)
+		unsigned long end, int node, gfp_t gfp_mask, int try_purge,
+		const void *caller)
 {
 	struct vmap_area *va;
 	struct vm_struct *area;
@@ -1386,16 +1391,17 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 		align = 1ul << clamp_t(int, get_count_order_long(size),
 				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
 
-	area = kzalloc_node(sizeof(*area), gfp_mask & GFP_RECLAIM_MASK, node);
-	if (unlikely(!area))
-		return NULL;
-
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
-	if (IS_ERR(va)) {
-		kfree(area);
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask,
+				try_purge);
+	if (IS_ERR(va))
+		return NULL;
+
+	area = kzalloc_node(sizeof(*area), gfp_mask & GFP_RECLAIM_MASK, node);
+	if (unlikely(!area)) {
+		free_vmap_area(va);
 		return NULL;
 	}
 
@@ -1408,7 +1414,8 @@ struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 				unsigned long start, unsigned long end)
 {
 	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
-				  GFP_KERNEL, __builtin_return_address(0));
+				  GFP_KERNEL, VMAP_MAY_PURGE,
+				  __builtin_return_address(0));
 }
 EXPORT_SYMBOL_GPL(__get_vm_area);
 
@@ -1417,7 +1424,7 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
 				       const void *caller)
 {
 	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
-				  GFP_KERNEL, caller);
+				  GFP_KERNEL, VMAP_MAY_PURGE, caller);
 }
 
 /**
@@ -1432,7 +1439,7 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
 struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 {
 	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
-				  NUMA_NO_NODE, GFP_KERNEL,
+				  NUMA_NO_NODE, GFP_KERNEL, VMAP_MAY_PURGE,
 				  __builtin_return_address(0));
 }
 
@@ -1440,7 +1447,8 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				const void *caller)
 {
 	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
-				  NUMA_NO_NODE, GFP_KERNEL, caller);
+				  NUMA_NO_NODE, GFP_KERNEL, VMAP_MAY_PURGE,
+				  caller);
 }
 
 /**
@@ -1713,26 +1721,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
-/**
- *	__vmalloc_node_range  -  allocate virtually contiguous memory
- *	@size:		allocation size
- *	@align:		desired alignment
- *	@start:		vm area range start
- *	@end:		vm area range end
- *	@gfp_mask:	flags for the page level allocator
- *	@prot:		protection mask for the allocated pages
- *	@vm_flags:	additional vm area flags (e.g. %VM_NO_GUARD)
- *	@node:		node to use for allocation or NUMA_NO_NODE
- *	@caller:	caller's return address
- *
- *	Allocate enough pages to cover @size from the page level
- *	allocator with @gfp_mask flags.  Map them into contiguous
- *	kernel virtual space, using a pagetable protection of @prot.
- */
-void *__vmalloc_node_range(unsigned long size, unsigned long align,
+static void *__vmalloc_node_range_opts(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
-			const void *caller)
+			int try_purge, const void *caller)
 {
 	struct vm_struct *area;
 	void *addr;
@@ -1743,7 +1735,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		goto fail;
 
 	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
-				vm_flags, start, end, node, gfp_mask, caller);
+				vm_flags, start, end, node, gfp_mask,
+				try_purge, caller);
 	if (!area)
 		goto fail;
 
@@ -1768,6 +1761,69 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return NULL;
 }
 
+/**
+ *	__vmalloc_node_range  -  allocate virtually contiguous memory
+ *	@size:		allocation size
+ *	@align:		desired alignment
+ *	@start:		vm area range start
+ *	@end:		vm area range end
+ *	@gfp_mask:	flags for the page level allocator
+ *	@prot:		protection mask for the allocated pages
+ *	@vm_flags:	additional vm area flags (e.g. %VM_NO_GUARD)
+ *	@node:		node to use for allocation or NUMA_NO_NODE
+ *	@caller:	caller's return address
+ *
+ *	Allocate enough pages to cover @size from the page level
+ *	allocator with @gfp_mask flags.  Map them into contiguous
+ *	kernel virtual space, using a pagetable protection of @prot.
+ */
+void *__vmalloc_node_range(unsigned long size, unsigned long align,
+			unsigned long start, unsigned long end, gfp_t gfp_mask,
+			pgprot_t prot, unsigned long vm_flags, int node,
+			const void *caller)
+{
+	return __vmalloc_node_range_opts(size, align, start, end, gfp_mask,
+					prot, vm_flags, node, VMAP_MAY_PURGE,
+					caller);
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
+ *	@caller:	caller's return address
+ *
+ *	Try to allocate at the specific address. If it succeeds the address is
+ *	returned. If it fails NULL is returned.  It will not try to purge lazy
+ *	free vmap areas in order to fit.
+ */
+void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
+			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
+			int node, const void *caller)
+{
+	unsigned long addr_end;
+	unsigned long vsize = PAGE_ALIGN(size);
+
+	if (!vsize || (vsize >> PAGE_SHIFT) > totalram_pages)
+		return NULL;
+
+	if (!(vm_flags & VM_NO_GUARD))
+		vsize += PAGE_SIZE;
+
+	addr_end = addr + vsize;
+
+	if (addr > addr_end)
+		return NULL;
+
+	return __vmalloc_node_range_opts(size, 1, addr, addr_end,
+				gfp_mask | __GFP_NOWARN, prot, vm_flags, node,
+				VMAP_NO_PURGE, caller);
+}
+
 /**
  *	__vmalloc_node  -  allocate virtually contiguous memory
  *	@size:		allocation size
-- 
2.17.1

