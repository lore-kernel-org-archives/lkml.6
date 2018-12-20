Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C111C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A642176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JsgWejxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbeLTGDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:03:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34669 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbeLTGDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:03:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so626606qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 22:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S7AD+kJd4p6mzjBi7n4tn/iYN+nLwvL9i58SOdg/oDc=;
        b=JsgWejxyHgBrhqzY4bMcbAjH/y5tAtKO/rs663eWum05p8zTzyYEZsP5ctOG2IJvsj
         5QRerEmDNiYWAby3P71NsacY5wGZAXcgGmmWlKJJ1I7z8DxlrbPr2sFIo1G96HKDoitu
         Ikr4fdknv0ubvoSHCfbu/IuwVrRn/F8bSob7B/hlHQRSTgdf8dbzD7plidG4YXTTZxK5
         r600u1KYp9uUhiXbg5Wv2kArPzqWsDBfnmWZgFAdAY78VqVzP9l8Tkv+4w0dOoeMeAip
         KnRYs612+dd+A7x4RrRVho1TYpjiGy0n2peS8smPeB3cZHpVISKXnhoILQrfs/ny2SX9
         CN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S7AD+kJd4p6mzjBi7n4tn/iYN+nLwvL9i58SOdg/oDc=;
        b=ltW+YP1P68lo/1BTJVPh0vpnO6ntMVNrE0N/MrV+JvG3s4gD16pBjSL4LDhh4ylmOO
         l7HvXpAvUnqFy9W+qiLbBiBTqxPQymliEB0P6h1mBSzO/FOLIlQc2KUzACikPpJcabz3
         MT/Hkpj0QQMR34eoCQI1e/TIA9Q84qFj15xI0Gf/HqxBYcMsSxjM3YHNjYfXQ3vZuKF3
         FMEVOaWtUP2NJqnGlc8dH4gnYPLbM8uaniyp8HwsyaXagdJl1VFnsqhV2BHvvIiRkote
         o6C3wi0UYqZw/bkKCmrqmLvkzo9sKfoFL74UEDcewToIABKoMu+MyYSZxl3fTHkaQcf/
         Zvmw==
X-Gm-Message-State: AA+aEWZ6z78fO5O8PE86D7avJZG37dQwhGeTCBuQAaDxrnm2PlDTdz+0
        ZdLfaCsiYMcmulCZRMZBqyN9wQ==
X-Google-Smtp-Source: AFSGD/UdYVEIHmmvJHfNT+GHy4ampoc55G4GQy85Br9rm0g+5+7k8ZHeeNTIcTSUQFjcu1k2vsMV1w==
X-Received: by 2002:aed:3f71:: with SMTP id q46mr25113030qtf.347.1545285794934;
        Wed, 19 Dec 2018 22:03:14 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l33sm3580494qta.57.2018.12.19.22.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 22:03:14 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     Pavel.Tatashin@microsoft.com, mingo@kernel.org, mhocko@suse.com,
        hpa@zytor.com, mgorman@techsingularity.net, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_owner: fix for deferred struct page init
Date:   Thu, 20 Dec 2018 01:03:03 -0500
Message-Id: <20181220060303.38686-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <cbfacb4b-dbfd-f68f-3d1e-05e137feca18@lca.pw>
References: <cbfacb4b-dbfd-f68f-3d1e-05e137feca18@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a system with "page_owner=on",

start_kernel
  page_ext_init
    invoke_init_callbacks
      init_section_page_ext
        init_page_owner
          init_early_allocated_pages
            init_zones_in_node
              init_pages_in_zone
                lookup_page_ext
                  page_to_nid

The issue here is that page_to_nid() will not work since some page
flags have no node information until later in page_alloc_init_late() due
to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
access with an invalid nid.

[    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
[    8.672603] index 7 is out of range for type 'zone [5]'

Also, kernel will panic since flags were poisoned earlier with,

CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_NODE_NOT_IN_PAGE_FLAGS=n

start_kernel
  setup_arch
    pagetable_init
      paging_init
        sparse_init
          sparse_init_nid
            memblock_alloc_try_nid_raw

Although later it tries to set page flags for pages in reserved bootmem
regions,

mm_init
  mem_init
    memblock_free_all
      free_low_memory_core_early
        reserve_bootmem_region

there could still have some freed pages from the page allocator but yet
to be initialized due to DEFERRED_STRUCT_PAGE_INIT. It have already been
dealt with a bit in page_ext_init().

* Take into account DEFERRED_STRUCT_PAGE_INIT.
*/
if (early_pfn_to_nid(pfn) != nid)
	continue;

However it did not handle it well in init_pages_in_zone() which end up
calling page_to_nid().

[   11.917212] page:ffffea0004200000 is uninitialized and poisoned
[   11.917220] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[   11.921745] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[   11.924523] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
[   11.926498] page_owner info is not active (free page?)
[   12.329560] kernel BUG at include/linux/mm.h:990!
[   12.337632] RIP: 0010:init_page_owner+0x486/0x520

Since init_pages_in_zone() has already had the node information, there
is no need to call page_to_nid() at all during the page ext lookup, and
also replace calls that could incorrectly checked for poisoned page
structs.

It ends up wasting some memory to allocate page ext for those already
freed pages, but there is no sane ways to tell those freed pages apart
from uninitialized valid pages due to DEFERRED_STRUCT_PAGE_INIT. It
looks quite reasonable on an arm64 server though.

allocated 83230720 bytes of page_ext
Node 0, zone    DMA32: page owner found early allocated 0 pages
Node 0, zone   Normal: page owner found early allocated 2048214 pages
Node 1, zone   Normal: page owner found early allocated 2080641 pages

Used more memory on a x86_64 server.

allocated 334233600 bytes of page_ext
Node 0, zone      DMA: page owner found early allocated 2 pages
Node 0, zone    DMA32: page owner found early allocated 24303 pages
Node 0, zone   Normal: page owner found early allocated 7545357 pages
Node 1, zone   Normal: page owner found early allocated 8331279 pages

Finally, rename get_entry() to get_ext_entry(), so it can be exported
without a naming collision.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/page_ext.h |  6 ++++++
 mm/page_ext.c            |  8 ++++----
 mm/page_owner.c          | 39 ++++++++++++++++++++++++++++++++-------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index f84f167ec04c..e95cb6198014 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -51,6 +51,7 @@ static inline void page_ext_init(void)
 #endif
 
 struct page_ext *lookup_page_ext(const struct page *page);
+struct page_ext *get_ext_entry(void *base, unsigned long index);
 
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
@@ -64,6 +65,11 @@ static inline struct page_ext *lookup_page_ext(const struct page *page)
 	return NULL;
 }
 
+static inline struct page_ext *get_ext_entry(void *base, unsigned long index)
+{
+	return NULL;
+}
+
 static inline void page_ext_init(void)
 {
 }
diff --git a/mm/page_ext.c b/mm/page_ext.c
index ae44f7adbe07..3cd8f0c13057 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -107,7 +107,7 @@ static unsigned long get_entry_size(void)
 	return sizeof(struct page_ext) + extra_mem;
 }
 
-static inline struct page_ext *get_entry(void *base, unsigned long index)
+struct page_ext *get_ext_entry(void *base, unsigned long index)
 {
 	return base + get_entry_size() * index;
 }
@@ -137,7 +137,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
 		return NULL;
 	index = pfn - round_down(node_start_pfn(page_to_nid(page)),
 					MAX_ORDER_NR_PAGES);
-	return get_entry(base, index);
+	return get_ext_entry(base, index);
 }
 
 static int __init alloc_node_page_ext(int nid)
@@ -207,7 +207,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
 	 */
 	if (!section->page_ext)
 		return NULL;
-	return get_entry(section->page_ext, pfn);
+	return get_ext_entry(section->page_ext, pfn);
 }
 
 static void *__meminit alloc_page_ext(size_t size, int nid)
@@ -285,7 +285,7 @@ static void __free_page_ext(unsigned long pfn)
 	ms = __pfn_to_section(pfn);
 	if (!ms || !ms->page_ext)
 		return;
-	base = get_entry(ms->page_ext, pfn);
+	base = get_ext_entry(ms->page_ext, pfn);
 	free_page_ext(base);
 	ms->page_ext = NULL;
 }
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 87bc0dfdb52b..c27712c9a764 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -531,6 +531,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 	unsigned long pfn = zone->zone_start_pfn;
 	unsigned long end_pfn = zone_end_pfn(zone);
 	unsigned long count = 0;
+	struct page_ext *base;
 
 	/*
 	 * Walk the zone in pageblock_nr_pages steps. If a page block spans
@@ -555,11 +556,11 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 			if (!pfn_valid_within(pfn))
 				continue;
 
-			page = pfn_to_page(pfn);
-
-			if (page_zone(page) != zone)
+			if (pfn < zone->zone_start_pfn || pfn >= end_pfn)
 				continue;
 
+			page = pfn_to_page(pfn);
+
 			/*
 			 * To avoid having to grab zone->lock, be a little
 			 * careful when reading buddy page order. The only
@@ -575,13 +576,37 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 				continue;
 			}
 
-			if (PageReserved(page))
+#ifdef CONFIG_SPARSEMEM
+			base = __pfn_to_section(pfn)->page_ext;
+#else
+			base = pgdat->node_page_ext;
+#endif
+			/*
+			 * The sanity checks the page allocator does upon
+			 * freeing a page can reach here before the page_ext
+			 * arrays are allocated when feeding a range of pages to
+			 * the allocator for the first time during bootup or
+			 * memory hotplug.
+			 */
+			if (unlikely(!base))
 				continue;
 
-			page_ext = lookup_page_ext(page);
-			if (unlikely(!page_ext))
+			/*
+			 * Those pages reached here might had already been freed
+			 * due to the deferred struct page init.
+			 */
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+			if (pfn < pgdat->first_deferred_pfn)
+#endif
+			if (PageReserved(page))
 				continue;
-
+#ifdef CONFIG_SPARSEMEM
+			page_ext = get_ext_entry(base, pfn);
+#else
+			page_ext = get_ext_entry(base, pfn -
+						 round_down(pgdat->node_start_pfn,
+							    MAX_ORDER_NR_PAGES));
+#endif
 			/* Maybe overlapping zone */
 			if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
 				continue;
-- 
2.17.2 (Apple Git-113)

