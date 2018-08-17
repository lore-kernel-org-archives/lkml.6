Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0EBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E611208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E611208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeHQSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:45:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34776 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeHQSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:45:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so1741809wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8JPUTMtIccaJLGbKXytnCKoN8NEp3iYJQnlf3aMwjQ=;
        b=WADy5elUQDVn0vysNlG58VAg6NWNAyxvuA0nRkgiJwfaxx1MmRnhSS5z/gOgqhej0z
         h7tFqZq75kbrdYmwxkWbT5xJRiNiTDeM8ADYaD0jcluF3guwT6NMes7uGRuHP26DzOEj
         9CB4PbZWTi5Pu7xPZEXJXnoMzV3gMUaANJlb8Z4c4mVLyVsqb1fzlFS7rt9Y7qeyY7Xb
         RlmPAXcOfzrPShDOniHWYXEly3g0p7qqNR10/STFC+7SbHPiTrwQjndT8GaU/YEnm9mf
         uxxyqFchoJaKkLzYslTII9RRA0aPW3TT2nExOZSoPbafM0g2k/VrrrayBdmtg77oM9dU
         lQGA==
X-Gm-Message-State: AOUpUlGRkNhrIJnKNMbd2loT4/Jiekztxd2TxJwvpmjzpSfq9+YyD9oc
        Lh11pVSOvhT0QDzXNoOlNCY=
X-Google-Smtp-Source: AA+uWPzPVa2sDUgvpnc2zlx1+zyu36fKRwoso/zOvy8h4BzNqagSFWERUD5vi2UFddA9xhlgmuQGQQ==
X-Received: by 2002:a1c:36aa:: with SMTP id y42-v6mr18376666wmh.159.1534520496845;
        Fri, 17 Aug 2018 08:41:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j6-v6sm3033283wrs.91.2018.08.17.08.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 08:41:35 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 6AE3E124950;
        Fri, 17 Aug 2018 17:41:34 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        david@redhat.com, jonathan.cameron@huawei.com,
        Pavel.Tatashin@microsoft.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC v2 2/2] mm/memory_hotplug: Shrink spanned pages when offlining memory
Date:   Fri, 17 Aug 2018 17:41:27 +0200
Message-Id: <20180817154127.28602-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180817154127.28602-1-osalvador@techadventures.net>
References: <20180817154127.28602-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, we decrement zone/node spanned_pages when we
remove memory and not when we offline it.

This, besides of not being consistent with the current code,
implies that we can access steal pages if we never get to online
that memory.

In order to prevent that, we have to move all zone/pages stuff to
the offlining memory stage.
Removing memory path should only care about memory sections and memory
blocks.

Another thing to notice here is that this is not so easy to be done
as HMM/devm have a particular handling of memory-hotplug.
They do not go through the common path, and so, they do not
call either offline_pages() nor online_pages().

All they care about is to add the sections, move the pages to
ZONE_DEVICE, and in some cases, to create the linear mapping.

In order to do this more smooth, two new functions are created
to deal with these particular cases:

del_device_memory
add_device_memory

add_device_memory is in charge of

a) calling either arch_add_memory() or add_pages(), depending on whether
   we want a linear mapping
b) online the memory sections that correspond to the pfn range
c) calling move_pfn_range_to_zone() being zone ZONE_DEVICE to
   expand zone/pgdat spanned pages and initialize its pages

del_device_memory, on the other hand, is in charge of

a) offline the memory sections that correspond to the pfn range
b) calling shrink_pages(), which shrinks node/zone spanned pages.
c) calling either arch_remove_memory() or __remove_pages(), depending on
   whether we need to tear down the linear mapping or not

These two functions are called from:

add_device_memory:
	- devm_memremap_pages()
	- hmm_devmem_pages_create()

del_device_memory:
	- devm_memremap_pages_release()
	- hmm_devmem_release()

I think that this will get easier as soon as [1] gets merged.

Finally, shrink_pages() is moved to offline_pages(), so now,
all pages/zone handling is being taken care in online/offline_pages stage.

[1] https://lkml.org/lkml/2018/6/19/110

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/ia64/mm/init.c            |   4 +-
 arch/powerpc/mm/mem.c          |  10 +--
 arch/sh/mm/init.c              |   4 +-
 arch/x86/mm/init_32.c          |   4 +-
 arch/x86/mm/init_64.c          |   8 +--
 include/linux/memory_hotplug.h |   9 ++-
 kernel/memremap.c              |  14 ++--
 kernel/resource.c              |  16 +++++
 mm/hmm.c                       |  32 ++++-----
 mm/memory_hotplug.c            | 143 +++++++++++++++++++++++++++--------------
 mm/sparse.c                    |   4 +-
 11 files changed, 145 insertions(+), 103 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index b54d0ee74b53..30ed58e5e86c 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -666,11 +666,9 @@ int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
 	int ret;
 
-	zone = page_zone(pfn_to_page(start_pfn));
-	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	ret = __remove_pages(nid, start_pfn, nr_pages, altmap);
 	if (ret)
 		pr_warn("%s: Problem encountered in __remove_pages() as"
 			" ret=%d\n", __func__,  ret);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9e17d57a9948..f3b47d02b879 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -146,15 +146,7 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altma
 	struct page *page;
 	int ret;
 
-	/*
-	 * If we have an altmap then we need to skip over any reserved PFNs
-	 * when querying the zone.
-	 */
-	page = pfn_to_page(start_pfn);
-	if (altmap)
-		page += vmem_altmap_offset(altmap);
-
-	ret = __remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
+	ret = __remove_pages(nid, start_pfn, nr_pages, altmap);
 	if (ret)
 		return ret;
 
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 5c91bb6abc35..6f6e7d321b1f 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -448,11 +448,9 @@ int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
 	int ret;
 
-	zone = page_zone(pfn_to_page(start_pfn));
-	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	ret = __remove_pages(nid, start_pfn, nr_pages, altmap);
 	if (unlikely(ret))
 		pr_warn("%s: Failed, __remove_pages() == %d\n", __func__,
 			ret);
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 9fa503f2f56c..88909e88c873 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -865,10 +865,8 @@ int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
 
-	zone = page_zone(pfn_to_page(start_pfn));
-	return __remove_pages(zone, start_pfn, nr_pages, altmap);
+	return __remove_pages(nid, start_pfn, nr_pages, altmap);
 }
 #endif
 #endif
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index f90fa077b0c4..d04338ffabec 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1152,15 +1152,9 @@ int __ref arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *a
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct page *page = pfn_to_page(start_pfn);
-	struct zone *zone;
 	int ret;
 
-	/* With altmap the first mapped page is offset from @start */
-	if (altmap)
-		page += vmem_altmap_offset(altmap);
-	zone = page_zone(page);
-	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	ret = __remove_pages(nid, start_pfn, nr_pages, altmap);
 	WARN_ON_ONCE(ret);
 	kernel_physical_mapping_remove(start, start + size);
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index c68b03fd87bd..e1446dbb37dc 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -109,14 +109,19 @@ static inline bool movable_node_is_enabled(void)
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern int arch_remove_memory(int nid, u64 start, u64 size,
 		struct vmem_altmap *altmap);
-extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
+extern int __remove_pages(int nid, unsigned long start_pfn,
 	unsigned long nr_pages, struct vmem_altmap *altmap);
+extern int del_device_memory(int nid, unsigned long start, unsigned long size,
+					struct vmem_altmap *altmap, bool mapping);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, bool want_memblock);
 
+extern int add_device_memory(int nid, unsigned long start, unsigned long size,
+					struct vmem_altmap *altmap, bool mapping);
+
 #ifndef CONFIG_ARCH_HAS_ADD_PAGES
 static inline int add_pages(int nid, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
@@ -333,7 +338,7 @@ extern bool is_memblock_offlined(struct memory_block *mem);
 extern void remove_memory(int nid, u64 start, u64 size);
 extern int sparse_add_one_section(struct pglist_data *pgdat,
 		unsigned long start_pfn, struct vmem_altmap *altmap);
-extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
+extern void sparse_remove_one_section(int nid, struct mem_section *ms,
 		unsigned long map_offset, struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 7a832b844f24..95df37686196 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -119,6 +119,8 @@ static void devm_memremap_pages_release(void *data)
 	struct dev_pagemap *pgmap = data;
 	struct device *dev = pgmap->dev;
 	struct resource *res = &pgmap->res;
+	struct vmem_altmap *altmap = pgmap->altmap_valid ?
+					&pgmap->altmap : NULL;
 	resource_size_t align_start, align_size;
 	unsigned long pfn;
 	int nid;
@@ -138,8 +140,7 @@ static void devm_memremap_pages_release(void *data)
 	nid = dev_to_node(dev);
 
 	mem_hotplug_begin();
-	arch_remove_memory(nid, align_start, align_size, pgmap->altmap_valid ?
-			&pgmap->altmap : NULL);
+	del_device_memory(nid, align_start, align_size, altmap, true);
 	kasan_remove_zero_shadow(__va(align_start), align_size);
 	mem_hotplug_done();
 
@@ -175,7 +176,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 {
 	resource_size_t align_start, align_size, align_end;
 	struct vmem_altmap *altmap = pgmap->altmap_valid ?
-			&pgmap->altmap : NULL;
+					&pgmap->altmap : NULL;
 	struct resource *res = &pgmap->res;
 	unsigned long pfn, pgoff, order;
 	pgprot_t pgprot = PAGE_KERNEL;
@@ -249,11 +250,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_kasan;
 	}
 
-	error = arch_add_memory(nid, align_start, align_size, altmap, false);
-	if (!error)
-		move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-					align_start >> PAGE_SHIFT,
-					align_size >> PAGE_SHIFT, altmap);
+	error = add_device_memory(nid, align_start, align_size, altmap, true);
+
 	mem_hotplug_done();
 	if (error)
 		goto err_add_memory;
diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..8e68b5ca67ca 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1262,6 +1262,22 @@ int release_mem_region_adjustable(struct resource *parent,
 			continue;
 		}
 
+		/*
+		 * All memory regions added from memory-hotplug path
+		 * have the flag IORESOURCE_SYSTEM_RAM.
+		 * IORESOURCE_SYSTEM_RAM = (IORESOURCE_MEM|IORESOURCE_SYSRAM)
+		 * If the resource does not have this flag, we know that
+		 * we are dealing with a resource coming from HMM/devm.
+		 * HMM/devm use another mechanism to add/release a resource.
+		 * This goes via devm_request_mem_region/devm_release_mem_region.
+		 * HMM/devm take care to release their resources when they want, so
+		 * if we are dealing with them, let us just back off nicely
+		 */
+		if (!(res->flags & IORESOURCE_SYSRAM)) {
+			ret = 0;
+			break;
+		}
+
 		if (!(res->flags & IORESOURCE_MEM))
 			break;
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 21787e480b4a..23ce7fbdb651 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -996,6 +996,7 @@ static void hmm_devmem_release(struct device *dev, void *data)
 	struct zone *zone;
 	struct page *page;
 	int nid;
+	bool mapping;
 
 	if (percpu_ref_tryget_live(&devmem->ref)) {
 		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
@@ -1012,12 +1013,14 @@ static void hmm_devmem_release(struct device *dev, void *data)
 
 	mem_hotplug_begin();
 	if (resource->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
-		__remove_pages(zone, start_pfn, npages, NULL);
+		mapping = false;
 	else
-		arch_remove_memory(nid, start_pfn << PAGE_SHIFT,
-				   npages << PAGE_SHIFT, NULL);
-	mem_hotplug_done();
+		mapping = true;
 
+	del_device_memory(nid, start_pfn << PAGE_SHIFT, npages << PAGE_SHIFT,
+									NULL,
+									mapping);
+	mem_hotplug_done();
 	hmm_devmem_radix_release(resource);
 }
 
@@ -1027,6 +1030,7 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	struct device *device = devmem->device;
 	int ret, nid, is_ram;
 	unsigned long pfn;
+	bool mapping;
 
 	align_start = devmem->resource->start & ~(PA_SECTION_SIZE - 1);
 	align_size = ALIGN(devmem->resource->start +
@@ -1085,7 +1089,6 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	if (nid < 0)
 		nid = numa_mem_id();
 
-	mem_hotplug_begin();
 	/*
 	 * For device private memory we call add_pages() as we only need to
 	 * allocate and initialize struct page for the device memory. More-
@@ -1096,21 +1099,18 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	 * For device public memory, which is accesible by the CPU, we do
 	 * want the linear mapping and thus use arch_add_memory().
 	 */
+	mem_hotplug_begin();
 	if (devmem->pagemap.type == MEMORY_DEVICE_PUBLIC)
-		ret = arch_add_memory(nid, align_start, align_size, NULL,
-				false);
+		mapping = true;
 	else
-		ret = add_pages(nid, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, NULL, false);
-	if (ret) {
-		mem_hotplug_done();
-		goto error_add_memory;
-	}
-	move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-				align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, NULL);
+		mapping = false;
+
+	ret = add_device_memory(nid, align_start, align_size, NULL, mapping);
 	mem_hotplug_done();
 
+	if (ret)
+		goto error_add_memory;
+
 	for (pfn = devmem->pfn_first; pfn < devmem->pfn_last; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9bd629944c91..60b67f09956e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -320,12 +320,10 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 				     unsigned long start_pfn,
 				     unsigned long end_pfn)
 {
-	struct mem_section *ms;
-
 	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(start_pfn);
+		struct mem_section *ms = __pfn_to_section(start_pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!online_section(ms)))
 			continue;
 
 		if (unlikely(pfn_to_nid(start_pfn) != nid))
@@ -345,15 +343,14 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 				    unsigned long start_pfn,
 				    unsigned long end_pfn)
 {
-	struct mem_section *ms;
 	unsigned long pfn;
 
 	/* pfn is the end pfn of a memory section. */
 	pfn = end_pfn - 1;
 	for (; pfn >= start_pfn; pfn -= PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
+		struct mem_section *ms = __pfn_to_section(pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!online_section(ms)))
 			continue;
 
 		if (unlikely(pfn_to_nid(pfn) != nid))
@@ -415,7 +412,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
 		ms = __pfn_to_section(pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!online_section(ms)))
 			continue;
 
 		if (page_zone(pfn_to_page(pfn)) != zone)
@@ -502,23 +499,33 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 	pgdat->node_spanned_pages = 0;
 }
 
-static void __remove_zone(struct zone *zone, unsigned long start_pfn)
+static void shrink_pages(struct zone *zone, unsigned long start_pfn,
+						unsigned long end_pfn,
+						unsigned long offlined_pages)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
 	unsigned long flags;
+	unsigned long pfn;
 
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
-	shrink_pgdat_span(pgdat, start_pfn, start_pfn + nr_pages);
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+	zone->present_pages -= offlined_pages;
+
+	clear_zone_contiguous(zone);
+	pgdat_resize_lock(pgdat, &flags);
+
+	for(pfn = start_pfn; pfn < end_pfn; pfn += nr_pages) {
+		shrink_zone_span(zone, pfn, pfn + nr_pages);
+		shrink_pgdat_span(pgdat, pfn, pfn + nr_pages);
+	}
+	pgdat->node_present_pages -= offlined_pages;
+
+	pgdat_resize_unlock(pgdat, &flags);
+	set_zone_contiguous(zone);
 }
 
-static int __remove_section(struct zone *zone, struct mem_section *ms,
+static int __remove_section(int nid, struct mem_section *ms,
 		unsigned long map_offset, struct vmem_altmap *altmap)
 {
-	unsigned long start_pfn;
-	int scn_nr;
 	int ret = -EINVAL;
 
 	if (!valid_section(ms))
@@ -528,17 +535,13 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
 	if (ret)
 		return ret;
 
-	scn_nr = __section_nr(ms);
-	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
-	__remove_zone(zone, start_pfn);
-
-	sparse_remove_one_section(zone, ms, map_offset, altmap);
+	sparse_remove_one_section(nid, ms, map_offset, altmap);
 	return 0;
 }
 
 /**
  * __remove_pages() - remove sections of pages from a zone
- * @zone: zone from which pages need to be removed
+ * @nid: nid from which pages belong to
  * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
  * @nr_pages: number of pages to remove (must be multiple of section size)
  * @altmap: alternative device page map or %NULL if default memmap is used
@@ -548,35 +551,27 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
  * sure that pages are marked reserved and zones are adjust properly by
  * calling offline_pages().
  */
-int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
+int __remove_pages(int nid, unsigned long phys_start_pfn,
 		 unsigned long nr_pages, struct vmem_altmap *altmap)
 {
 	unsigned long i;
 	unsigned long map_offset = 0;
 	int sections_to_remove, ret = 0;
+	resource_size_t start, size;
 
-	/* In the ZONE_DEVICE case device driver owns the memory region */
-	if (is_dev_zone(zone)) {
-		if (altmap)
-			map_offset = vmem_altmap_offset(altmap);
-	} else {
-		resource_size_t start, size;
-
-		start = phys_start_pfn << PAGE_SHIFT;
-		size = nr_pages * PAGE_SIZE;
+	start = phys_start_pfn << PAGE_SHIFT;
+	size = nr_pages * PAGE_SIZE;
 
-		ret = release_mem_region_adjustable(&iomem_resource, start,
-					size);
-		if (ret) {
-			resource_size_t endres = start + size - 1;
+	if (altmap)
+		map_offset = vmem_altmap_offset(altmap);
 
-			pr_warn("Unable to release resource <%pa-%pa> (%d)\n",
-					&start, &endres, ret);
-		}
+	ret = release_mem_region_adjustable(&iomem_resource, start, size);
+	if (ret) {
+		resource_size_t endres = start + size - 1;
+		pr_warn("Unable to release resource <%pa-%pa> (%d)\n",
+						&start, &endres, ret);
 	}
 
-	clear_zone_contiguous(zone);
-
 	/*
 	 * We can only remove entire sections
 	 */
@@ -587,15 +582,13 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 	for (i = 0; i < sections_to_remove; i++) {
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
 
-		ret = __remove_section(zone, __pfn_to_section(pfn), map_offset,
-				altmap);
+		ret = __remove_section(nid, __pfn_to_section(pfn), map_offset,
+									altmap);
 		map_offset = 0;
 		if (ret)
 			break;
 	}
 
-	set_zone_contiguous(zone);
-
 	return ret;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
@@ -1595,7 +1588,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	unsigned long pfn, nr_pages;
 	long offlined_pages;
 	int ret, node;
-	unsigned long flags;
 	unsigned long valid_start, valid_end;
 	struct zone *zone;
 	struct memory_notify arg;
@@ -1665,11 +1657,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
-	zone->present_pages -= offlined_pages;
 
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	zone->zone_pgdat->node_present_pages -= offlined_pages;
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+	/* Here we will shrink zone/node's spanned/present_pages */
+	shrink_pages(zone, valid_start, valid_end, offlined_pages);
 
 	init_per_zone_wmark_min();
 
@@ -1902,4 +1892,57 @@ void __ref remove_memory(int nid, u64 start, u64 size)
 	mem_hotplug_done();
 }
 EXPORT_SYMBOL_GPL(remove_memory);
+
+static int __del_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool mapping)
+{
+	int ret;
+	unsigned long start_pfn = PHYS_PFN(start);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+
+	offline_mem_sections(start_pfn, start_pfn + nr_pages);
+	shrink_pages(zone, start_pfn, start_pfn + nr_pages, 0);
+
+	if (mapping)
+		ret = arch_remove_memory(nid, start, size, altmap);
+	else
+		ret = __remove_pages(nid, start_pfn, nr_pages, altmap);
+
+	return ret;
+}
+
+int del_device_memory(int nid, unsigned long start, unsigned long size,
+			struct vmem_altmap *altmap, bool mapping)
+{
+	return __del_device_memory(nid, start, size, altmap, mapping);
+}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
+
+static int __add_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool mapping)
+{
+	int ret;
+        unsigned long start_pfn = PHYS_PFN(start);
+        unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	if (mapping)
+		ret = arch_add_memory(nid, start, size, altmap, false);
+        else
+		ret = add_pages(nid, start_pfn, nr_pages, altmap, false);
+
+	if (!ret) {
+		struct zone *zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+
+		online_mem_sections(start_pfn, start_pfn + nr_pages);
+		move_pfn_range_to_zone(zone, start_pfn, nr_pages, altmap);
+	}
+
+	return ret;
+}
+
+int add_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool mapping)
+{
+	return __add_device_memory(nid, start, size, altmap, mapping);
+}
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..016020bd20b5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -766,12 +766,12 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
 		free_map_bootmem(memmap);
 }
 
-void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
+void sparse_remove_one_section(int nid, struct mem_section *ms,
 		unsigned long map_offset, struct vmem_altmap *altmap)
 {
 	struct page *memmap = NULL;
 	unsigned long *usemap = NULL, flags;
-	struct pglist_data *pgdat = zone->zone_pgdat;
+	struct pglist_data *pgdat = NODE_DATA(nid);
 
 	pgdat_resize_lock(pgdat, &flags);
 	if (ms->section_mem_map) {
-- 
2.13.6

