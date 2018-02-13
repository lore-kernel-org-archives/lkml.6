Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x225cNEJgD2IfvAW5Rjz27aSyaVz1IwagIbbBpJffnaL37h7+a0pmWGquv/nC6SYK+YboKhnQ
ARC-Seal: i=1; a=rsa-sha256; t=1518550345; cv=none;
        d=google.com; s=arc-20160816;
        b=Av0PdmV39N0bz2alALhEui8GZ0NGPa5qbzWdd3W8J2J/2Ap8WxS3Y85+EoaPOcc1au
         Y20fWbofPMvPAJCrTjwke0EnuOcSetSDpagMYezAvnPo7yKoxKxSyJjGXfL9TdJVr2LZ
         qGw6TCXZ/G9/q0k4gGlgVa1dMMl2I7hBpWn4y56Rf4hknqTegLnwYnwsDP7U5kh8x/gg
         MudHCRtPutoMinzqv6SQfAtO5IwrhHfCPb9FUlf5DkNFhkF9pjnMwp8sh8Hht0FPOFbT
         b7bTVBRyPZZjRbbKWSywspMUd9MYN/6+DVpO5lDAybE9FN2ckGhBLIw2KoNXwT9W5P5x
         TUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=nob4q5CQQkOeVE3E2ABEajqSymBTwQekpiMqFYBYXWA=;
        b=l/PVh5P32x5MLagOT8QE5Bd784IGtDcvcsU3hiLknxwCfNt/cSgGK1Od8owZNKNUTD
         UNkggbwd57Xa3ilTTExB9wuNchWyhK3lflVLP0omIAfMZPp7erZ7NzkJ3fEVxgznUnC8
         e30xHcGIDDs7I/2OAW/tA+vqXDbiOo0Ss2QrmhqOPHgheVh2Ul32RnBMRQBFe48AgZC8
         Ebc+9dIv1xAKhXiBC7IfpSEDu+9rpp3j1fq1K1Q3eTS2SQCPTPvef7xp4VGDTshbJl+u
         qIKHazZcIa6NgTrMhZCbmbj0UaJXhbiP9NXLGQQUAYx+NeFFFRxv7BKLO/8wRKABHl3M
         e1/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=d3bTgT/3;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=d3bTgT/3;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [PATCH v3 4/4] mm/memory_hotplug: optimize memory hotplug
Date: Tue, 13 Feb 2018 14:31:59 -0500
Message-Id: <20180213193159.14606-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213193159.14606-1-pasha.tatashin@oracle.com>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=2 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130233
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446931456044?=
X-GMAIL-MSGID: =?utf-8?q?1592315446931456044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch was inspired by the discussion of this problem:
http://lkml.kernel.org/r/20180130083006.GB1245@in.ibm.com

Currently, during memory hotplugging we traverse struct pages several
times:

1. memset(0) in sparse_add_one_section()
2. loop in __add_section() to set do: set_page_node(page, nid); and
   SetPageReserved(page);
3. loop in pages_correctly_reserved() to check that SetPageReserved is set.
4. loop in memmap_init_zone() to call __init_single_pfn()

This patch removes loops 1, 2, and 3 and only leaves the loop 4, where all
struct page fields are initialized in one go, the same as it is now done
during boot.

The benefits:
- We improve the memory hotplug performance because we are not evicting
  cache several times and also reduce loop branching overheads.

- Remove condition from hotpath in __init_single_pfn(), that was added in
  order to fix the problem that was reported by Bharata in the above email
  thread, thus also improve the performance during normal boot.

- Make memory hotplug more similar to boot memory initialization path
  because we zero and initialize struct pages only in one function.

- Simplifies memory hotplug strut page initialization code, and thus
  enables future improvements, such as multi-threading the initialization
  of struct pages in order to improve the hotplug performance even further
  on larger machines.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/memory.c          | 38 +++++++++++++++++++++-----------------
 drivers/base/node.c            | 17 ++++++++++-------
 include/linux/memory_hotplug.h |  2 ++
 include/linux/node.h           |  4 ++--
 mm/memory_hotplug.c            | 21 ++-------------------
 mm/page_alloc.c                | 28 ++++++++++------------------
 mm/sparse.c                    | 29 ++++++++++++++++++++++++++---
 7 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe4b24f05f6a..a14fb0cd424a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -187,13 +187,14 @@ int memory_isolate_notify(unsigned long val, void *v)
 }
 
 /*
- * The probe routines leave the pages reserved, just as the bootmem code does.
- * Make sure they're still that way.
+ * The probe routines leave the pages uninitialized, just as the bootmem code
+ * does. Make sure we do not access them, but instead use only information from
+ * within sections.
  */
-static bool pages_correctly_reserved(unsigned long start_pfn)
+static bool pages_correctly_probed(unsigned long start_pfn)
 {
-	int i, j;
-	struct page *page;
+	unsigned long section_nr = pfn_to_section_nr(start_pfn);
+	unsigned long section_nr_end = section_nr + sections_per_block;
 	unsigned long pfn = start_pfn;
 
 	/*
@@ -201,21 +202,24 @@ static bool pages_correctly_reserved(unsigned long start_pfn)
 	 * SPARSEMEM_VMEMMAP. We lookup the page once per section
 	 * and assume memmap is contiguous within each section
 	 */
-	for (i = 0; i < sections_per_block; i++, pfn += PAGES_PER_SECTION) {
+	for (; section_nr < section_nr_end; section_nr++) {
 		if (WARN_ON_ONCE(!pfn_valid(pfn)))
 			return false;
-		page = pfn_to_page(pfn);
-
-		for (j = 0; j < PAGES_PER_SECTION; j++) {
-			if (PageReserved(page + j))
-				continue;
-
-			printk(KERN_WARNING "section number %ld page number %d "
-				"not reserved, was it already online?\n",
-				pfn_to_section_nr(pfn), j);
 
+		if (!present_section_nr(section_nr)) {
+			pr_warn("section %ld pfn[%lx, %lx) not present",
+				section_nr, pfn, pfn + PAGES_PER_SECTION);
+			return false;
+		} else if (!valid_section_nr(section_nr)) {
+			pr_warn("section %ld pfn[%lx, %lx) no valid memmap",
+				section_nr, pfn, pfn + PAGES_PER_SECTION);
+			return false;
+		} else if (online_section_nr(section_nr)) {
+			pr_warn("section %ld pfn[%lx, %lx) is already online",
+				section_nr, pfn, pfn + PAGES_PER_SECTION);
 			return false;
 		}
+		pfn += PAGES_PER_SECTION;
 	}
 
 	return true;
@@ -237,7 +241,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
 
 	switch (action) {
 	case MEM_ONLINE:
-		if (!pages_correctly_reserved(start_pfn))
+		if (!pages_correctly_probed(start_pfn))
 			return -EBUSY;
 
 		ret = online_pages(start_pfn, nr_pages, online_type);
@@ -727,7 +731,7 @@ int register_new_memory(int nid, struct mem_section *section)
 	}
 
 	if (mem->section_count == sections_per_block)
-		ret = register_mem_sect_under_node(mem, nid);
+		ret = register_mem_sect_under_node(mem, nid, false);
 out:
 	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index ee090ab9171c..f1c0c130ac88 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -397,7 +397,8 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
 }
 
 /* register memory section under specified node if it spans that node */
-int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
+int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
+				 bool check_nid)
 {
 	int ret;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
@@ -423,11 +424,13 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
 			continue;
 		}
 
-		page_nid = get_nid_for_pfn(pfn);
-		if (page_nid < 0)
-			continue;
-		if (page_nid != nid)
-			continue;
+		if (check_nid) {
+			page_nid = get_nid_for_pfn(pfn);
+			if (page_nid < 0)
+				continue;
+			if (page_nid != nid)
+				continue;
+		}
 		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
 					&mem_blk->dev.kobj,
 					kobject_name(&mem_blk->dev.kobj));
@@ -502,7 +505,7 @@ int link_mem_sections(int nid, unsigned long start_pfn, unsigned long nr_pages)
 
 		mem_blk = find_memory_block_hinted(mem_sect, mem_blk);
 
-		ret = register_mem_sect_under_node(mem_blk, nid);
+		ret = register_mem_sect_under_node(mem_blk, nid, true);
 		if (!err)
 			err = ret;
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index aba5f86eb038..0f2c17bef9d6 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -234,6 +234,8 @@ void put_online_mems(void);
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
 
+int get_section_nid(unsigned long section_nr);
+
 extern void set_zone_contiguous(struct zone *zone);
 extern void clear_zone_contiguous(struct zone *zone);
 
diff --git a/include/linux/node.h b/include/linux/node.h
index 4ece0fee0ffc..41f171861dcc 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -67,7 +67,7 @@ extern void unregister_one_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
-						int nid);
+						int nid, bool check_nid);
 extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 					   unsigned long phys_index);
 
@@ -97,7 +97,7 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 	return 0;
 }
 static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
-							int nid)
+							int nid, bool check_nid)
 {
 	return 0;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 565048f496f7..cf1041380ab7 100644
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
 
@@ -909,7 +891,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	int ret;
 	struct memory_notify arg;
 
-	nid = pfn_to_nid(pfn);
+	nid = get_section_nid(pfn_to_section_nr(pfn));
+
 	/* associate pfn range with the zone */
 	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81e18ceef579..2667b35fca41 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1177,10 +1177,9 @@ static void free_one_page(struct zone *zone,
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
@@ -1194,12 +1193,6 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
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
@@ -1218,7 +1211,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
 			break;
 	}
-	__init_single_pfn(pfn, zid, nid, true);
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -1535,7 +1528,7 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid, true);
+		__init_single_page(page, pfn, zid, nid);
 		nr_pages++;
 	}
 	return (nr_pages);
@@ -5328,6 +5321,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long pfn;
 	unsigned long nr_initialised = 0;
+	struct page *page;
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	struct memblock_region *r = NULL, *tmp;
 #endif
@@ -5389,6 +5383,11 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
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
@@ -5405,15 +5404,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
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
index 7af5e7a92528..d7808307023b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -30,11 +30,14 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 #endif
 EXPORT_SYMBOL(mem_section);
 
-#ifdef NODE_NOT_IN_PAGE_FLAGS
+#if defined(NODE_NOT_IN_PAGE_FLAGS) || defined(CONFIG_MEMORY_HOTPLUG)
 /*
  * If we did not store the node number in the page then we have to
  * do a lookup in the section_to_node_table in order to find which
  * node the page belongs to.
+ *
+ * We also use this data in case memory hotplugging is enabled to be
+ * able to determine nid while struct pages are not yet initialized.
  */
 #if MAX_NUMNODES <= 256
 static u8 section_to_node_table[NR_MEM_SECTIONS] __cacheline_aligned;
@@ -42,17 +45,28 @@ static u8 section_to_node_table[NR_MEM_SECTIONS] __cacheline_aligned;
 static u16 section_to_node_table[NR_MEM_SECTIONS] __cacheline_aligned;
 #endif
 
+#ifdef NODE_NOT_IN_PAGE_FLAGS
 int page_to_nid(const struct page *page)
 {
 	return section_to_node_table[page_to_section(page)];
 }
 EXPORT_SYMBOL(page_to_nid);
+#endif /* NODE_NOT_IN_PAGE_FLAGS */
 
 static void set_section_nid(unsigned long section_nr, int nid)
 {
 	section_to_node_table[section_nr] = nid;
 }
-#else /* !NODE_NOT_IN_PAGE_FLAGS */
+
+/* Return NID for given section number */
+int get_section_nid(unsigned long section_nr)
+{
+	if (WARN_ON(section_nr >= NR_MEM_SECTIONS))
+		return 0;
+	return section_to_node_table[section_nr];
+}
+EXPORT_SYMBOL(get_section_nid);
+#else /* ! (NODE_NOT_IN_PAGE_FLAGS || CONFIG_MEMORY_HOTPLUG) */
 static inline void set_section_nid(unsigned long section_nr, int nid)
 {
 }
@@ -816,7 +830,14 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-	memset(memmap, 0, sizeof(struct page) * PAGES_PER_SECTION);
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * poison uninitialized struct pages in order to catch invalid flags
+	 * combinations.
+	 */
+	memset(memmap, PAGE_POISON_PATTERN,
+	       sizeof(struct page) * PAGES_PER_SECTION);
+#endif
 
 	section_mark_present(ms);
 
@@ -827,6 +848,8 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 	if (ret <= 0) {
 		kfree(usemap);
 		__kfree_section_memmap(memmap, altmap);
+	} else {
+		set_section_nid(section_nr, pgdat->node_id);
 	}
 	return ret;
 }
-- 
2.16.1
