Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F6B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAVKhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:37:50 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:58338 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfAVKhq (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 22 Jan 2019 05:37:46 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 22 Jan 2019 11:37:45 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 22 Jan 2019 10:37:19 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, david@redhat.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 2/4] mm, memory_hotplug: provide a more generic restrictions for memory hotplug
Date:   Tue, 22 Jan 2019 11:37:06 +0100
Message-Id: <20190122103708.11043-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190122103708.11043-1-osalvador@suse.de>
References: <20190122103708.11043-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

arch_add_memory, __add_pages take a want_memblock which controls whether
the newly added memory should get the sysfs memblock user API (e.g.
ZONE_DEVICE users do not want/need this interface). Some callers even
want to control where do we allocate the memmap from by configuring
altmap.

Add a more generic hotplug context for arch_add_memory and __add_pages.
struct mhp_restrictions contains flags which contains additional
features to be enabled by the memory hotplug (MHP_MEMBLOCK_API
currently) and altmap for alternative memmap allocator.

Please note that the complete altmap propagation down to vmemmap code
is still not done in this patch. It will be done in the follow up to
reduce the churn here.

This patch shouldn't introduce any functional change.

Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/mm/mmu.c            |  5 ++---
 arch/ia64/mm/init.c            |  5 ++---
 arch/powerpc/mm/mem.c          |  6 +++---
 arch/s390/mm/init.c            |  6 +++---
 arch/sh/mm/init.c              |  6 +++---
 arch/x86/mm/init_32.c          |  6 +++---
 arch/x86/mm/init_64.c          | 10 +++++-----
 include/linux/memory_hotplug.h | 25 +++++++++++++++++++------
 kernel/memremap.c              |  9 ++++++---
 mm/memory_hotplug.c            | 10 ++++++----
 10 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa52ac67..3926969f9187 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1049,8 +1049,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		    bool want_memblock)
+int arch_add_memory(int nid, u64 start, u64 size, struct mhp_restrictions *restrictions)
 {
 	int flags = 0;
 
@@ -1061,6 +1060,6 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
 
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
-			   altmap, want_memblock);
+							restrictions);
 }
 #endif
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 29d841525ca1..f7bacfde1b7c 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -644,14 +644,13 @@ mem_init (void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		bool want_memblock)
+int arch_add_memory(int nid, u64 start, u64 size, struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	ret = __add_pages(nid, start_pfn, nr_pages, restrictions);
 	if (ret)
 		printk("%s: Problem encountered in __add_pages() as ret=%d\n",
 		       __func__,  ret);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 33cc6f676fa6..30a2a9b668d7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -117,8 +117,8 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
 	return -ENODEV;
 }
 
-int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		bool want_memblock)
+int __meminit arch_add_memory(int nid, u64 start, u64 size,
+			struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -135,7 +135,7 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
 	}
 	flush_inval_dcache_range(start, start + size);
 
-	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3e82f66d5c61..9ae71a82e9e1 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -224,8 +224,8 @@ device_initcall(s390_cma_mem_init);
 
 #endif /* CONFIG_CMA */
 
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		bool want_memblock)
+int arch_add_memory(int nid, u64 start, u64 size,
+		struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long size_pages = PFN_DOWN(size);
@@ -235,7 +235,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 	if (rc)
 		return rc;
 
-	rc = __add_pages(nid, start_pfn, size_pages, altmap, want_memblock);
+	rc = __add_pages(nid, start_pfn, size_pages, restrictions);
 	if (rc)
 		vmem_remove_mapping(start, size);
 	return rc;
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a0fa4de03dd5..000232933934 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -410,15 +410,15 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		bool want_memblock)
+int arch_add_memory(int nid, u64 start, u64 size,
+		struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
 	/* We only have ZONE_NORMAL, so this is easy.. */
-	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	ret = __add_pages(nid, start_pfn, nr_pages, restrictions);
 	if (unlikely(ret))
 		printk("%s: Failed, __add_pages() == %d\n", __func__, ret);
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 85c94f9a87f8..755dbed85531 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -850,13 +850,13 @@ void __init mem_init(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		bool want_memblock)
+int arch_add_memory(int nid, u64 start, u64 size,
+			struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index bccff68e3267..db42c11b48fb 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -777,11 +777,11 @@ static void update_end_of_memory_vars(u64 start, u64 size)
 }
 
 int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, bool want_memblock)
+				struct mhp_restrictions *restrictions)
 {
 	int ret;
 
-	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	ret = __add_pages(nid, start_pfn, nr_pages, restrictions);
 	WARN_ON_ONCE(ret);
 
 	/* update max_pfn, max_low_pfn and high_memory */
@@ -791,15 +791,15 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	return ret;
 }
 
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-		bool want_memblock)
+int arch_add_memory(int nid, u64 start, u64 size,
+			struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
 	init_memory_mapping(start, start + size);
 
-	return add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	return add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 
 #define PAGE_INUSE 0xFD
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 1a230dde6027..4e0d75b17715 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -113,20 +113,33 @@ extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages, struct vmem_altmap *altmap);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+/*
+ * Do we want sysfs memblock files created. This will allow userspace to online
+ * and offline memory explicitly. Lack of this bit means that the caller has to
+ * call move_pfn_range_to_zone to finish the initialization.
+ */
+
+#define MHP_MEMBLOCK_API               1<<0
+
+/* Restrictions for the memory hotplug */
+struct mhp_restrictions {
+	unsigned long flags;    /* MHP_ flags */
+	struct vmem_altmap *altmap; /* use this alternative allocator for memmaps */
+};
+
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, bool want_memblock);
+					struct mhp_restrictions *restrictions);
 
 #ifndef CONFIG_ARCH_HAS_ADD_PAGES
 static inline int add_pages(int nid, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap,
-		bool want_memblock)
+		unsigned long nr_pages, struct mhp_restrictions *restrictions)
 {
-	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 #else /* ARCH_HAS_ADD_PAGES */
 int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, bool want_memblock);
+				struct mhp_restrictions *restrictions);
 #endif /* ARCH_HAS_ADD_PAGES */
 
 #ifdef CONFIG_NUMA
@@ -328,7 +341,7 @@ extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
 extern int add_memory_resource(int nid, struct resource *resource);
 extern int arch_add_memory(int nid, u64 start, u64 size,
-		struct vmem_altmap *altmap, bool want_memblock);
+			struct mhp_restrictions *restrictions);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
 extern bool is_memblock_offlined(struct memory_block *mem);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index a856cb5ff192..d42f11673979 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -149,6 +149,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	struct resource *res = &pgmap->res;
 	struct dev_pagemap *conflict_pgmap;
 	pgprot_t pgprot = PAGE_KERNEL;
+	struct mhp_restrictions restrictions = {};
 	int error, nid, is_ram;
 
 	if (!pgmap->ref || !pgmap->kill)
@@ -199,6 +200,9 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (error)
 		goto err_pfn_remap;
 
+	/* We do not want any optional features only our own memmap */
+	restrictions.altmap = altmap;
+
 	mem_hotplug_begin();
 
 	/*
@@ -214,7 +218,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	 */
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		error = add_pages(nid, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, NULL, false);
+				align_size >> PAGE_SHIFT, &restrictions);
 	} else {
 		error = kasan_add_zero_shadow(__va(align_start), align_size);
 		if (error) {
@@ -222,8 +226,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 			goto err_kasan;
 		}
 
-		error = arch_add_memory(nid, align_start, align_size, altmap,
-				false);
+		error = arch_add_memory(nid, align_start, align_size, &restrictions);
 	}
 
 	if (!error) {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6efa44087b37..8313279136ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -271,12 +271,12 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
  * add the new pages.
  */
 int __ref __add_pages(int nid, unsigned long phys_start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap,
-		bool want_memblock)
+		unsigned long nr_pages, struct mhp_restrictions *restrictions)
 {
 	unsigned long i;
 	int err = 0;
 	int start_sec, end_sec;
+	struct vmem_altmap *altmap = restrictions->altmap;
 
 	/* during initialize mem_map, align hot-added range to section */
 	start_sec = pfn_to_section_nr(phys_start_pfn);
@@ -297,7 +297,7 @@ int __ref __add_pages(int nid, unsigned long phys_start_pfn,
 
 	for (i = start_sec; i <= end_sec; i++) {
 		err = __add_section(nid, section_nr_to_pfn(i), altmap,
-				want_memblock);
+				restrictions->flags & MHP_MEMBLOCK_API);
 
 		/*
 		 * EEXIST is finally dealt with by ioresource collision
@@ -1108,6 +1108,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	u64 start, size;
 	bool new_node = false;
 	int ret;
+	struct mhp_restrictions restrictions = {};
 
 	start = res->start;
 	size = resource_size(res);
@@ -1132,7 +1133,8 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	new_node = ret;
 
 	/* call arch's memory hotadd */
-	ret = arch_add_memory(nid, start, size, NULL, true);
+	restrictions.flags = MHP_MEMBLOCK_API;
+	ret = arch_add_memory(nid, start, size, &restrictions);
 	if (ret < 0)
 		goto error;
 
-- 
2.13.7

