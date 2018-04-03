Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx4+OFJANss4Pdj0plqRsTbN6nWNYlXmUP27wsPB+kY6r1FrjvF+A5gdvePlSqwUQT+wja7t9
ARC-Seal: i=1; a=rsa-sha256; t=1522779434; cv=none;
        d=google.com; s=arc-20160816;
        b=PDuBA+dxZGif/trvp97y3CXZNlmAExh4o+kYwocUTGP9mld+ymQzkVJmL7465jMXp9
         liVoCyhZiznuG8Ee0sH0T4qDa7rolQZSHEEW2LsiZFphabpcQPRAypjJVgqeLlwW455s
         ni+WhV7iO3syui7B2n/Ar69Mjwan+R34tr1YKWqKmxbwrsf0INr3LCV+US/apr0Auemm
         ZppJzf7GwyyfU25ZC+nkY3vsHPt+9hgGT1XJ+gRDSNgiuQdMotE7ko4ZfO28DRm5nIZe
         pN7sCFkXEFT6jR7xYPvcBgQCVQXXf1GzZfZuQwX2R3u0ba2Yw65BN1n9Pn2ELVcXcvvG
         T2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=36pCJ8UFH42OuIyRC4/UIoOiwqjJxPy8z9WlyzDoftM=;
        b=AEc3CnE+eWn4m39/Q0Iv3/bhqH4WQxvYS7PAQ0DDM97P1c2J5d0EilNxpMd+DlvBNH
         HTNuAoVva9s1tQ70Vs9vJVgE4j+qyDf/iLhmaa7ZPykJV1u7gj+citxucH1mf3b7pr+i
         dDltCvxS2myC1YO475WDA6rpPjo+iVCuOk04JtoGecvqXx9Yps6g8sEWiD58icBSYBiz
         vbghFb5R6gC1eVKWlrGdnNZ5c3XX0XbbLuIalFCdeaM1HPWe6akXPrBOrtdg9j7Q5ha8
         qovDnwazCnsm2NUShO4P888lNVyj+FB0wH1issjAKF7VERt2M/xlsyWrJbXTBwcPs0Ap
         7o1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aligkRug;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aligkRug;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com, alexander.levin@microsoft.com
Subject: [v6 6/6] mm/memory_hotplug: optimize memory hotplug
Date: Tue,  3 Apr 2018 14:16:43 -0400
Message-Id: <20180403181643.28127-7-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180403181643.28127-1-pasha.tatashin@oracle.com>
References: <20180403181643.28127-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=63 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030185
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596749968192490420?=
X-GMAIL-MSGID: =?utf-8?q?1596749968192490420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

During memory hotplugging we traverse struct pages three times:

1. memset(0) in sparse_add_one_section()
2. loop in __add_section() to set do: set_page_node(page, nid); and
   SetPageReserved(page);
3. loop in memmap_init_zone() to call __init_single_pfn()

This patch removes the first two loops, and leaves only loop 3. All struct
pages are initialized in one place, the same as it is done during boot.

The benefits:
- We improve memory hotplug performance because we are not evicting the
  cache several times and also reduce loop branching overhead.

- Remove condition from hotpath in __init_single_pfn(), that was added in
  order to fix the problem that was reported by Bharata in the above email
  thread, thus also improve performance during normal boot.

- Make memory hotplug more similar to the boot memory initialization path
  because we zero and initialize struct pages only in one function.

- Simplifies memory hotplug struct page initialization code, and thus
  enables future improvements, such as multi-threading the initialization
  of struct pages in order to improve hotplug performance even further on
  larger machines.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/base/node.c    |  2 ++
 include/linux/memory.h |  1 +
 mm/memory_hotplug.c    | 27 ++++++++-------------------
 mm/page_alloc.c        | 28 ++++++++++------------------
 mm/sparse.c            |  8 +++++++-
 5 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index d7cfc8d8a5c5..51de4af290ac 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -405,6 +405,8 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
 
 	if (!mem_blk)
 		return -EFAULT;
+
+	mem_blk->nid = nid;
 	if (!node_online(nid))
 		return 0;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 9f8cd856ca1e..31ca3e28b0eb 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -33,6 +33,7 @@ struct memory_block {
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct device dev;
+	int nid;			/* NID for this memory block */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 477e183a4ac7..6a9ba14e18ed 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -250,7 +250,6 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 		struct vmem_altmap *altmap, bool want_memblock)
 {
 	int ret;
-	int i;
 
 	if (pfn_valid(phys_start_pfn))
 		return -EEXIST;
@@ -259,23 +258,6 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Make all the pages reserved so that nobody will stumble over half
-	 * initialized state.
-	 * FIXME: We also have to associate it with a node because page_to_nid
-	 * relies on having page with the proper node.
-	 */
-	for (i = 0; i < PAGES_PER_SECTION; i++) {
-		unsigned long pfn = phys_start_pfn + i;
-		struct page *page;
-		if (!pfn_valid(pfn))
-			continue;
-
-		page = pfn_to_page(pfn);
-		set_page_node(page, nid);
-		SetPageReserved(page);
-	}
-
 	if (!want_memblock)
 		return 0;
 
@@ -908,8 +890,15 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	int nid;
 	int ret;
 	struct memory_notify arg;
+	struct memory_block *mem;
+
+	/*
+	 * We can't use pfn_to_nid() because nid might be stored in struct page
+	 * which is not yet initialized. Instead, we find nid from memory block.
+	 */
+	mem = find_memory_block(__pfn_to_section(pfn));
+	nid = mem->nid;
 
-	nid = pfn_to_nid(pfn);
 	/* associate pfn range with the zone */
 	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4ea018263210..1edbfa00bd73 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1181,10 +1181,9 @@ static void free_one_page(struct zone *zone,
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid, bool zero)
+				unsigned long zone, int nid)
 {
-	if (zero)
-		mm_zero_struct_page(page);
+	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
@@ -1198,12 +1197,6 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 #endif
 }
 
-static void __meminit __init_single_pfn(unsigned long pfn, unsigned long zone,
-					int nid, bool zero)
-{
-	return __init_single_page(pfn_to_page(pfn), pfn, zone, nid, zero);
-}
-
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static void __meminit init_reserved_page(unsigned long pfn)
 {
@@ -1222,7 +1215,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
 			break;
 	}
-	__init_single_pfn(pfn, zid, nid, true);
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -1539,7 +1532,7 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid, true);
+		__init_single_page(page, pfn, zid, nid);
 		nr_pages++;
 	}
 	return (nr_pages);
@@ -5334,6 +5327,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long pfn;
 	unsigned long nr_initialised = 0;
+	struct page *page;
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	struct memblock_region *r = NULL, *tmp;
 #endif
@@ -5386,6 +5380,11 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 #endif
 
 not_early:
+		page = pfn_to_page(pfn);
+		__init_single_page(page, pfn, zone, nid);
+		if (context == MEMMAP_HOTPLUG)
+			SetPageReserved(page);
+
 		/*
 		 * Mark the block movable so that blocks are reserved for
 		 * movable at startup. This will force kernel allocations
@@ -5402,15 +5401,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * because this is done early in sparse_add_one_section
 		 */
 		if (!(pfn & (pageblock_nr_pages - 1))) {
-			struct page *page = pfn_to_page(pfn);
-
-			__init_single_page(page, pfn, zone, nid,
-					context != MEMMAP_HOTPLUG);
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
-		} else {
-			__init_single_pfn(pfn, zone, nid,
-					context != MEMMAP_HOTPLUG);
 		}
 	}
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 58cab483e81b..62eef264a7bd 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -779,7 +779,13 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-	memset(memmap, 0, sizeof(struct page) * PAGES_PER_SECTION);
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * Poison uninitialized struct pages in order to catch invalid flags
+	 * combinations.
+	 */
+	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
+#endif
 
 	section_mark_present(ms);
 
-- 
2.16.3
