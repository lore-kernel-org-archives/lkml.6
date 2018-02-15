Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x227Mv2gHIe/+u0vS5oVeBbndfCUYNmDX/M/VtylqfihqcRhjTkdoaCX9vJtzHS74WOhXtQNS
ARC-Seal: i=1; a=rsa-sha256; t=1518714290; cv=none;
        d=google.com; s=arc-20160816;
        b=ExZGVbnwWaLH7xppD4fSG6oiYeN42Rfk0EyeLsgfWzfA0o6O7NyKbDC1jpR/dpnpGt
         wz93KwUhrPTrgzbsEyxnii1+Rv2DvGbm6TkYPFIMtgIdKcUNCGAYae68xvj3PzFXLuCW
         UNLqr3WGxuyVmyGSSCuS5G5aI0zKnsAZ0SQJKXRD/5lSGbSIgLCi3GbbXyVN+nDTPNjt
         aMxs0MtAeeb/XS+Ozn48Z9pI9IlSjuK4x0IxLbzga8XeHkPObZVmX2ydaDQBDxXkIcTD
         s0hN/391sTVveXvIZnyi0ZnZ4Zr/dF22AYe7Fncggh+JUdhq97BHJ2IyH6GDNhEPXiqo
         Br2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=wghLUkqCKB8S7m0/ikTzSApaHc4xHSdKp72UxbX9JjE=;
        b=DekZdzM4lwmLXtO4KZc6oPpZMWWfw42esdpGcuuQnMmmNV9ph8EvNwcEMum+elNB4c
         BB8RbDn4buu3zlNFpCKcvxbla/lLasoKO5cPfFwRu2Sae6GLvbpF9WzvpR5bQmEU7Vx/
         Vrp1LAjehH5hIMxTeqU9PM7MNEUAD006pSbzn4elM8i78/cMqzvGlg4uTsFK/L1HUExv
         B+ZMwN75R3fF3UPtPFVVJ4DUTI1U1JVxPMlKTe8mjQ49xOtdB0dMjvnbkAExccxKrypN
         yln25VhxqoM+evNjZ9aF6FR7q3LbHUHtGoVp/RObYnvf7v4oeZ7fUmi9zdZ9JDnr1/bz
         jOOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=VrkAfKY6;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=VrkAfKY6;
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
Subject: [v4 6/6] mm/memory_hotplug: optimize memory hotplug
Date: Thu, 15 Feb 2018 11:59:20 -0500
Message-Id: <20180215165920.8570-7-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215165920.8570-1-pasha.tatashin@oracle.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=475
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446931456044?=
X-GMAIL-MSGID: =?utf-8?q?1592487355125223738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

During memory hotplugging we traverse struct pages three times:

1. memset(0) in sparse_add_one_section()
2. loop in __add_section() to set do: set_page_node(page, nid); and
   SetPageReserved(page);
3. loop in memmap_init_zone() to call __init_single_pfn()

This patch remove the first two loops, and leaves only loop 3. All struct
pages are initialized in one place, the same as it is done during boot.

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
 mm/memory_hotplug.c | 21 ++++++---------------
 mm/page_alloc.c     | 28 ++++++++++------------------
 mm/sparse.c         |  9 ++++++++-
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 565048f496f7..ee04dae21f0c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -250,7 +250,7 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 		struct vmem_altmap *altmap, bool want_memblock)
 {
 	int ret;
-	int i;
+	struct page *page;
 
 	if (pfn_valid(phys_start_pfn))
 		return -EEXIST;
@@ -260,21 +260,12 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 		return ret;
 
 	/*
-	 * Make all the pages reserved so that nobody will stumble over half
-	 * initialized state.
-	 * FIXME: We also have to associate it with a node because page_to_nid
-	 * relies on having page with the proper node.
+	 * The first page in every section holds node id, this is because we
+	 * will need it in online_pages().
 	 */
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
+	page = pfn_to_page(phys_start_pfn);
+	mm_zero_struct_page(page);
+	set_page_node(page, nid);
 
 	if (!want_memblock)
 		return 0;
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
index 7af5e7a92528..eb72de54089c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -816,7 +816,14 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
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
 
-- 
2.16.1
