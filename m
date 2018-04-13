Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx48nVddD40cZuWkYOCDLNFMPixXikGdz9nFU0H6pTtHIlVN6hbNW97GfmlvqojE/m6SDnfH+
ARC-Seal: i=1; a=rsa-sha256; t=1523625405; cv=none;
        d=google.com; s=arc-20160816;
        b=w5EAkEswOwfvoZd61aut9htnJN6kmRnWFPjRt7+QKjh6a06/txgqsc8Wai2pM6C5Pd
         hM00dJJPtnlaLyjcjLsm4Sil6Dfips0t5/2sGTLumQv17u5Kq62NNZ7yfkOZwtvaOmSX
         orEvBEOBPZlg0aJ5m879PbL0JVbhs414KBQcOvjbeGEfLSVeIMEdBkCBEohFCDUMDCbR
         V7kObogZQjKPBE6Vt3p8GyVSuiO+EcTlrPmLwJbr7zRhWa4t24JTT4AqhPkrpBFC2bVo
         xAYlYQzRpeL/+JZwrjamYi4Izcj5RAiBcMRkBo7kJvzztqd7pxVh01vU7qPSbrqJLmnM
         LUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=n42Yk6PHqHjzap+xA3JX3C04+jr6LlM3LQvMw06iuQw=;
        b=Bjn0l/EIgPlQyFpTiTrcZi8eiRV8BJ+wiEIHa/BvcsLe4KuAsuaKRe1qi1YwlwqkyV
         vqKD1Zrov+ARG5Eh9RTEbyZXpNKeN0l0cOtFT1jMxr8ENeiak2dtRwgmMgH1vv72rkSm
         zIdQeRA3hHhGAyw4/bG/0H2MEzf4NxsbTRxGp2qBH8y3N4LjEymz2Rnbl+lN9w3XC3bn
         HavpFCgI+hEAF3WStsxirIxpMfyFQlVDaKY/PIOqT/t2skl4cQ3SWaecHxOYJhbUjATu
         Pch/01jgPiJB9SnFJdXkT0p/FxQOdIWlRDZQbTfr6rByxljz+ZDSpKl8GcQZ+hPjDIuq
         rO6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Reza Arbab <arbab@linux.vnet.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 1/8] mm/memory_hotplug: Revert "mm/memory_hotplug: optimize memory hotplug"
Date: Fri, 13 Apr 2018 15:16:25 +0200
Message-Id: <20180413131632.1413-2-david@redhat.com>
In-Reply-To: <20180413131632.1413-1-david@redhat.com>
References: <20180413131632.1413-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637033562508385?=
X-GMAIL-MSGID: =?utf-8?q?1597637033562508385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Conflicts with the possibility to online sub-section chunks. Revert it
for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c    |  2 --
 include/linux/memory.h |  1 -
 mm/memory_hotplug.c    | 27 +++++++++++++++++++--------
 mm/page_alloc.c        | 28 ++++++++++++++++++----------
 mm/sparse.c            |  8 +-------
 5 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 7a3a580821e0..92b00a7e6a02 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -407,8 +407,6 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
 
 	if (!mem_blk)
 		return -EFAULT;
-
-	mem_blk->nid = nid;
 	if (!node_online(nid))
 		return 0;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 31ca3e28b0eb..9f8cd856ca1e 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -33,7 +33,6 @@ struct memory_block {
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct device dev;
-	int nid;			/* NID for this memory block */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f74826cdceea..d4474781c799 100644
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
+	 * Make all the pages reserved so that nobody will stumble over half
+	 * initialized state.
+	 * FIXME: We also have to associate it with a node because page_to_nid
+	 * relies on having page with the proper node.
+	 */
+	for (i = 0; i < PAGES_PER_SECTION; i++) {
+		unsigned long pfn = phys_start_pfn + i;
+		struct page *page;
+		if (!pfn_valid(pfn))
+			continue;
+
+		page = pfn_to_page(pfn);
+		set_page_node(page, nid);
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
index 905db9d7962f..647c8c6dd4d1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1172,9 +1172,10 @@ static void free_one_page(struct zone *zone,
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid)
+				unsigned long zone, int nid, bool zero)
 {
-	mm_zero_struct_page(page);
+	if (zero)
+		mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
@@ -1188,6 +1189,12 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 #endif
 }
 
+static void __meminit __init_single_pfn(unsigned long pfn, unsigned long zone,
+					int nid, bool zero)
+{
+	return __init_single_page(pfn_to_page(pfn), pfn, zone, nid, zero);
+}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static void __meminit init_reserved_page(unsigned long pfn)
 {
@@ -1206,7 +1213,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
 			break;
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	__init_single_pfn(pfn, zid, nid, true);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -1523,7 +1530,7 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid);
+		__init_single_page(page, pfn, zid, nid, true);
 		nr_pages++;
 	}
 	return (nr_pages);
@@ -5460,7 +5467,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long pfn;
 	unsigned long nr_initialised = 0;
-	struct page *page;
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	struct memblock_region *r = NULL, *tmp;
 #endif
@@ -5513,11 +5519,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 #endif
 
 not_early:
-		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid);
-		if (context == MEMMAP_HOTPLUG)
-			SetPageReserved(page);
-
 		/*
 		 * Mark the block movable so that blocks are reserved for
 		 * movable at startup. This will force kernel allocations
@@ -5534,8 +5535,15 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * because this is done early in sparse_add_one_section
 		 */
 		if (!(pfn & (pageblock_nr_pages - 1))) {
+			struct page *page = pfn_to_page(pfn);
+
+			__init_single_page(page, pfn, zone, nid,
+					context != MEMMAP_HOTPLUG);
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
+		} else {
+			__init_single_pfn(pfn, zone, nid,
+					context != MEMMAP_HOTPLUG);
 		}
 	}
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 62eef264a7bd..58cab483e81b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -779,13 +779,7 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-#ifdef CONFIG_DEBUG_VM
-	/*
-	 * Poison uninitialized struct pages in order to catch invalid flags
-	 * combinations.
-	 */
-	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
-#endif
+	memset(memmap, 0, sizeof(struct page) * PAGES_PER_SECTION);
 
 	section_mark_present(ms);
 
-- 
2.14.3
