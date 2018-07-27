Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB107208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB107208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeG0SRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:17:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731568AbeG0SRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:17:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99E037DAC3;
        Fri, 27 Jul 2018 16:55:02 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A30A111E418;
        Fri, 27 Jul 2018 16:54:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@techadventures.net>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v1] mm: inititalize struct pages when adding a section
Date:   Fri, 27 Jul 2018 18:54:54 +0200
Message-Id: <20180727165454.27292-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 16:55:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 16:55:02 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, struct pages are inititalized when memory is onlined, not
when it is added (since commit d0dc12e86b31 ("mm/memory_hotplug: optimize
memory hotplug")).

remove_memory() will call arch_remove_memory(). Here, we usually access
the struct page to get the zone of the pages.

So effectively, we access stale struct pages in case we remove memory that
was never onlined. So let's simply inititalize them earlier, when the
memory is added. We only have to take care of updating the zone once we
know it. We can use a dummy zone for that purpose.

So effectively, all pages will already be initialized and set to
reserved after memory was added but before it was onlined (and even the
memblock is added). We only inititalize pages once, to not degrade
performance.

This will also mean that user space dump tools will always see sane
struct pages once a memblock pops up.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@techadventures.net>
Cc: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c    |  1 -
 include/linux/memory.h |  1 -
 include/linux/mm.h     | 10 ++++++++++
 mm/memory_hotplug.c    | 27 +++++++++++++++++++--------
 mm/page_alloc.c        | 23 +++++++++++------------
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a5e821d09656..3ec78f80afe2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -408,7 +408,6 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
 	if (!mem_blk)
 		return -EFAULT;
 
-	mem_blk->nid = nid;
 	if (!node_online(nid))
 		return 0;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index a6ddefc60517..8a0864a65a98 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -33,7 +33,6 @@ struct memory_block {
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct device dev;
-	int nid;			/* NID for this memory block */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d3a3842316b8..e6bf3527b7a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1162,7 +1162,15 @@ static inline void set_page_address(struct page *page, void *address)
 {
 	page->virtual = address;
 }
+static void set_page_virtual(struct page *page, and enum zone_type zone)
+{
+	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
+	if (!is_highmem_idx(zone))
+		set_page_address(page, __va(pfn << PAGE_SHIFT));
+}
 #define page_address_init()  do { } while(0)
+#else
+#define set_page_virtual(page, zone)  do { } while(0)
 #endif
 
 #if defined(HASHED_PAGE_VIRTUAL)
@@ -2116,6 +2124,8 @@ extern unsigned long find_min_pfn_with_active_regions(void);
 extern void free_bootmem_with_active_regions(int nid,
 						unsigned long max_low_pfn);
 extern void sparse_memory_present_with_active_regions(int nid);
+extern void __meminit init_single_page(struct page *page, unsigned long pfn,
+				       unsigned long zone, int nid);
 
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7deb49f69e27..3f28ca3c3a33 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -250,6 +250,7 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 		struct vmem_altmap *altmap, bool want_memblock)
 {
 	int ret;
+	int i;
 
 	if (pfn_valid(phys_start_pfn))
 		return -EEXIST;
@@ -258,6 +259,23 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Initialize all pages in the section before fully exposing them to the
+	 * system so nobody will stumble over a half inititalized state.
+	 */
+	for (i = 0; i < PAGES_PER_SECTION; i++) {
+		unsigned long pfn = phys_start_pfn + i;
+		struct page *page;
+
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+
+		/* dummy zone, the actual one will be set when onlining pages */
+		init_single_page(page, pfn, ZONE_NORMAL, nid);
+		SetPageReserved(page);
+	}
+
 	if (!want_memblock)
 		return 0;
 
@@ -891,15 +909,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	int nid;
 	int ret;
 	struct memory_notify arg;
-	struct memory_block *mem;
-
-	/*
-	 * We can't use pfn_to_nid() because nid might be stored in struct page
-	 * which is not yet initialized. Instead, we find nid from memory block.
-	 */
-	mem = find_memory_block(__pfn_to_section(pfn));
-	nid = mem->nid;
 
+	nid = pfn_to_nid(pfn);
 	/* associate pfn range with the zone */
 	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a790ef4be74e..8d81df4c40ab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1168,7 +1168,7 @@ static void free_one_page(struct zone *zone,
 	spin_unlock(&zone->lock);
 }
 
-static void __meminit __init_single_page(struct page *page, unsigned long pfn,
+void __meminit init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
 	mm_zero_struct_page(page);
@@ -1178,11 +1178,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_cpupid_reset_last(page);
 
 	INIT_LIST_HEAD(&page->lru);
-#ifdef WANT_PAGE_VIRTUAL
-	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-	if (!is_highmem_idx(zone))
-		set_page_address(page, __va(pfn << PAGE_SHIFT));
-#endif
+	set_page_virtual(page, zone);
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1203,7 +1199,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
 			break;
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -1520,7 +1516,7 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid);
+		init_single_page(page, pfn, zid, nid);
 		nr_pages++;
 	}
 	return (nr_pages);
@@ -5519,9 +5515,12 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 
 not_early:
 		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid);
-		if (context == MEMMAP_HOTPLUG)
-			SetPageReserved(page);
+		if (context == MEMMAP_HOTPLUG) {
+			/* everything but the zone was inititalized */
+			set_page_zone(page, zone);
+			set_page_virtual(page, zone);
+		} else
+			init_single_page(page, pfn, zone, nid);
 
 		/*
 		 * Mark the block movable so that blocks are reserved for
@@ -6386,7 +6385,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 #if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
  * Only struct pages that are backed by physical memory are zeroed and
- * initialized by going through __init_single_page(). But, there are some
+ * initialized by going through init_single_page(). But, there are some
  * struct pages which are reserved in memblock allocator and their fields
  * may be accessed (for example page_to_pfn() on some configuration accesses
  * flags). We must explicitly zero those struct pages.
-- 
2.17.1

