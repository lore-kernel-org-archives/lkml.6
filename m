Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D6CECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D68213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D68213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJRHxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:53:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:62545 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbeJRHxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:53:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 16:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="100366649"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2018 16:54:37 -0700
Subject: [mm PATCH v4 6/6] mm: Use common iterator for deferred_init_pages
 and deferred_free_pages
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, alexander.h.duyck@linux.intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Wed, 17 Oct 2018 16:54:36 -0700
Message-ID: <20181017235436.17213.15091.stgit@localhost.localdomain>
In-Reply-To: <20181017235043.17213.92459.stgit@localhost.localdomain>
References: <20181017235043.17213.92459.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a common iterator to be used by both deferred_init_pages
and deferred_free_pages. By doing this we can cut down a bit on code
overhead as they will likely both be inlined into the same function anyway.

This new approach allows deferred_init_pages to make use of
__init_pageblock. By doing this we can cut down on the code size by sharing
code between both the hotplug and deferred memory init code paths.

An additional benefit to this approach is that we improve in cache locality
of the memory init as we can focus on the memory areas related to
identifying if a given PFN is valid and keep that warm in the cache until
we transition to a region of a different type. So we will stream through a
chunk of valid blocks before we turn to initializing page structs.

On my x86_64 test system with 384GB of memory per node I saw a reduction in
initialization time from 1.38s to 1.06s as a result of this patch.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/page_alloc.c |  134 +++++++++++++++++++++++++++----------------------------
 1 file changed, 65 insertions(+), 69 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e7fee7a5f8a3..f47d02e42cf7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1484,32 +1484,6 @@ void clear_zone_contiguous(struct zone *zone)
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static void __init deferred_free_range(unsigned long pfn,
-				       unsigned long nr_pages)
-{
-	struct page *page;
-	unsigned long i;
-
-	if (!nr_pages)
-		return;
-
-	page = pfn_to_page(pfn);
-
-	/* Free a large naturally-aligned chunk if possible */
-	if (nr_pages == pageblock_nr_pages &&
-	    (pfn & (pageblock_nr_pages - 1)) == 0) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, pageblock_order);
-		return;
-	}
-
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if ((pfn & (pageblock_nr_pages - 1)) == 0)
-			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, 0);
-	}
-}
-
 /* Completion tracking for deferred_init_memmap() threads */
 static atomic_t pgdat_init_n_undone __initdata;
 static __initdata DECLARE_COMPLETION(pgdat_init_all_done_comp);
@@ -1521,48 +1495,77 @@ static inline void __init pgdat_init_report_one_done(void)
 }
 
 /*
- * Returns true if page needs to be initialized or freed to buddy allocator.
+ * Returns count if page range needs to be initialized or freed
  *
- * First we check if pfn is valid on architectures where it is possible to have
- * holes within pageblock_nr_pages. On systems where it is not possible, this
- * function is optimized out.
+ * First, we check if a current large page is valid by only checking the
+ * validity of the head pfn.
  *
- * Then, we check if a current large page is valid by only checking the validity
- * of the head pfn.
+ * Then we check if the contiguous pfns are valid on architectures where it
+ * is possible to have holes within pageblock_nr_pages. On systems where it
+ * is not possible, this function is optimized out.
  */
-static inline bool __init deferred_pfn_valid(unsigned long pfn)
+static unsigned long __next_pfn_valid_range(unsigned long *i,
+					    unsigned long end_pfn)
 {
-	if (!pfn_valid_within(pfn))
-		return false;
-	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
-		return false;
-	return true;
+	unsigned long pfn = *i;
+	unsigned long count;
+
+	while (pfn < end_pfn) {
+		unsigned long t = ALIGN(pfn + 1, pageblock_nr_pages);
+		unsigned long pageblock_pfn = min(t, end_pfn);
+
+#ifndef CONFIG_HOLES_IN_ZONE
+		count = pageblock_pfn - pfn;
+		pfn = pageblock_pfn;
+		if (!pfn_valid(pfn))
+			continue;
+#else
+		for (count = 0; pfn < pageblock_pfn; pfn++) {
+			if (pfn_valid_within(pfn)) {
+				count++;
+				continue;
+			}
+
+			if (count)
+				break;
+		}
+
+		if (!count)
+			continue;
+#endif
+		*i = pfn;
+		return count;
+	}
+
+	return 0;
 }
 
+#define for_each_deferred_pfn_valid_range(i, start_pfn, end_pfn, pfn, count) \
+	for (i = (start_pfn),						     \
+	     count = __next_pfn_valid_range(&i, (end_pfn));		     \
+	     count && ({ pfn = i - count; 1; });			     \
+	     count = __next_pfn_valid_range(&i, (end_pfn)))
 /*
  * Free pages to buddy allocator. Try to free aligned pages in
  * pageblock_nr_pages sizes.
  */
-static void __init deferred_free_pages(unsigned long pfn,
+static void __init deferred_free_pages(unsigned long start_pfn,
 				       unsigned long end_pfn)
 {
-	unsigned long nr_pgmask = pageblock_nr_pages - 1;
-	unsigned long nr_free = 0;
-
-	for (; pfn < end_pfn; pfn++) {
-		if (!deferred_pfn_valid(pfn)) {
-			deferred_free_range(pfn - nr_free, nr_free);
-			nr_free = 0;
-		} else if (!(pfn & nr_pgmask)) {
-			deferred_free_range(pfn - nr_free, nr_free);
-			nr_free = 1;
-			touch_nmi_watchdog();
+	unsigned long i, pfn, count;
+
+	for_each_deferred_pfn_valid_range(i, start_pfn, end_pfn, pfn, count) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (count == pageblock_nr_pages) {
+			__free_pages_core(page, pageblock_order);
 		} else {
-			nr_free++;
+			while (count--)
+				__free_pages_core(page++, 0);
 		}
+
+		touch_nmi_watchdog();
 	}
-	/* Free the last block of pages to allocator */
-	deferred_free_range(pfn - nr_free, nr_free);
 }
 
 /*
@@ -1571,29 +1574,22 @@ static void __init deferred_free_pages(unsigned long pfn,
  * Return number of pages initialized.
  */
 static unsigned long  __init deferred_init_pages(struct zone *zone,
-						 unsigned long pfn,
+						 unsigned long start_pfn,
 						 unsigned long end_pfn)
 {
-	unsigned long nr_pgmask = pageblock_nr_pages - 1;
+	unsigned long i, pfn, count;
 	int nid = zone_to_nid(zone);
 	unsigned long nr_pages = 0;
 	int zid = zone_idx(zone);
-	struct page *page = NULL;
 
-	for (; pfn < end_pfn; pfn++) {
-		if (!deferred_pfn_valid(pfn)) {
-			page = NULL;
-			continue;
-		} else if (!page || !(pfn & nr_pgmask)) {
-			page = pfn_to_page(pfn);
-			touch_nmi_watchdog();
-		} else {
-			page++;
-		}
-		__init_single_page(page, pfn, zid, nid);
-		nr_pages++;
+	for_each_deferred_pfn_valid_range(i, start_pfn, end_pfn, pfn, count) {
+		nr_pages += count;
+		__init_pageblock(pfn, count, zid, nid, NULL, false);
+
+		touch_nmi_watchdog();
 	}
-	return (nr_pages);
+
+	return nr_pages;
 }
 
 /*

