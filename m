Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672AEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27583208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27583208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389543AbeKPUYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:24:55 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:34624 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389280AbeKPUYy (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 15:24:54 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 16 Nov 2018 11:13:11 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Fri, 16 Nov 2018 10:12:51 +0000
From:   Oscar Salvador <osalvador@suse.com>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, david@redhat.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arunks@codeaurora.org, bhe@redhat.com,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 2/4] mm, memory_hotplug: provide a more generic restrictions for memory hotplug
Date:   Fri, 16 Nov 2018 11:12:20 +0100
Message-Id: <20181116101222.16581-3-osalvador@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181116101222.16581-1-osalvador@suse.com>
References: <20181116101222.16581-1-osalvador@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

arch_add_memory, __add_pages take a want_memblock which controls whether
the newly added memory should get the sysfs memblock user API (e.g.
ZONE_DEVICE users do not want/need this interface). Some callers even
want to control where do we allocate the memmap from by configuring
altmap. This is currently done quite ugly by searching for altmap down
in memory hotplug (to_vmem_altmap). It should be the caller to provide
the altmap down the call chain.

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
 arch/ia64/mm/init.c            |  5 ++---
 arch/powerpc/mm/mem.c          |  6 +++---
 arch/s390/mm/init.c            |  6 +++---
 arch/sh/mm/init.c              |  6 +++---
 arch/x86/mm/init_32.c          |  6 +++---
 arch/x86/mm/init_64.c          | 10 +++++-----
 include/linux/memory_hotplug.h | 27 ++++++++++++++++++++-------
 kernel/memremap.c              |  6 +++++-
 mm/memory_hotplug.c            | 10 ++++++----
 9 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index d5e12ff1d73c..c0c6da053db8 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -645,14 +645,13 @@ mem_init (void)
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
index 0a64fffabee1..2535471daad7 100644
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
index 76d0708438e9..4139affd6157 100644
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
index c8c13c777162..f0b489d6f73b 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -418,15 +418,15 @@ void free_initrd_mem(unsigned long start, unsigned long end)
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
index 49ecf5ecf6d3..c47b33019dbc 100644
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
index 5fab264948c2..fd06bcbd9535 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -783,11 +783,11 @@ static void update_end_of_memory_vars(u64 start, u64 size)
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
@@ -797,15 +797,15 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
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
index 1cb7054cdc03..7249dab00ac9 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -96,7 +96,7 @@ extern void __online_page_set_limits(struct page *page);
 extern void __online_page_increment_counters(struct page *page);
 extern void __online_page_free(struct page *page);
 
-extern int try_online_node(int nid);
+	extern int try_online_node(int nid);
 
 extern bool memhp_auto_online;
 /* If movable_node boot option specified */
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
+	struct vmem_altmap *altmap; /* use this alternative allocatro for memmaps */
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
 extern int add_memory_resource(int nid, struct resource *resource, bool online);
 extern int arch_add_memory(int nid, u64 start, u64 size,
-		struct vmem_altmap *altmap, bool want_memblock);
+				struct mhp_restrictions *restrictions);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 9eced2cc9f94..248082bfea5c 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -143,6 +143,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	struct resource *res = &pgmap->res;
 	struct dev_pagemap *conflict_pgmap;
 	pgprot_t pgprot = PAGE_KERNEL;
+	struct mhp_restrictions restrictions = {};
 	int error, nid, is_ram;
 
 	align_start = res->start & ~(SECTION_SIZE - 1);
@@ -195,6 +196,9 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (error)
 		goto err_pfn_remap;
 
+	/* We do not want any optional features only our own memmap */
+	restrictions.altmap = altmap;
+
 	mem_hotplug_begin();
 	error = kasan_add_zero_shadow(__va(align_start), align_size);
 	if (error) {
@@ -202,7 +206,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_kasan;
 	}
 
-	error = arch_add_memory(nid, align_start, align_size, altmap, false);
+	error = arch_add_memory(nid, align_start, align_size, &restrictions);
 	if (!error)
 		move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
 					align_start >> PAGE_SHIFT,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d19e5f33e33b..8a97bda770c1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -270,12 +270,12 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
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
@@ -296,7 +296,7 @@ int __ref __add_pages(int nid, unsigned long phys_start_pfn,
 
 	for (i = start_sec; i <= end_sec; i++) {
 		err = __add_section(nid, section_nr_to_pfn(i), altmap,
-				want_memblock);
+				restrictions->flags & MHP_MEMBLOCK_API);
 
 		/*
 		 * EEXIST is finally dealt with by ioresource collision
@@ -1100,6 +1100,7 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	u64 start, size;
 	bool new_node = false;
 	int ret;
+	struct mhp_restrictions restrictions = {};
 
 	start = res->start;
 	size = resource_size(res);
@@ -1124,7 +1125,8 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	new_node = ret;
 
 	/* call arch's memory hotadd */
-	ret = arch_add_memory(nid, start, size, NULL, true);
+	restrictions.flags = MHP_MEMBLOCK_API;
+	ret = arch_add_memory(nid, start, size, &restrictions);
 	if (ret < 0)
 		goto error;
 
-- 
2.13.6

