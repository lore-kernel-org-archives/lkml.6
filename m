Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E370C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A00217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeLREgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:36:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:45556 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeLREgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:36:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 20:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="110266003"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2018 20:36:30 -0800
Subject: [PATCH v6 6/6] mm: Maintain randomization of page free lists
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.de
Date:   Mon, 17 Dec 2018 20:23:55 -0800
Message-ID: <154510703541.1941238.6053320635908576300.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeing a page with an order >= shuffle_page_order randomly select
the front or back of the list for insertion.

While the mm tries to defragment physical pages into huge pages this can
tend to make the page allocator more predictable over time. Inject the
front-back randomness to preserve the initial randomness established by
shuffle_free_memory() when the kernel was booted.

The overhead of this manipulation is constrained by only being applied
for MAX_ORDER sized pages by default.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mmzone.h  |   10 ++++++++++
 include/linux/shuffle.h |   12 ++++++++++++
 mm/page_alloc.c         |   11 +++++++++--
 mm/shuffle.c            |   16 ++++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 35cc33af87f2..338929647eea 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -98,6 +98,8 @@ extern int page_group_by_mobility_disabled;
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
+	u64			rand;
+	u8			rand_bits;
 };
 
 /* Used for pages not on another list */
@@ -116,6 +118,14 @@ static inline void add_to_free_area_tail(struct page *page, struct free_area *ar
 	area->nr_free++;
 }
 
+#ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
+/* Used to preserve page allocation order entropy */
+void add_to_free_area_random(struct page *page, struct free_area *area,
+		int migratetype);
+#else
+#define add_to_free_area_random add_to_free_area
+#endif
+
 /* Used for pages which are on another list */
 static inline void move_to_free_area(struct page *page, struct free_area *area,
 			     int migratetype)
diff --git a/include/linux/shuffle.h b/include/linux/shuffle.h
index a8a168919cb5..8b3941a87c2c 100644
--- a/include/linux/shuffle.h
+++ b/include/linux/shuffle.h
@@ -29,6 +29,13 @@ static inline void shuffle_zone(struct zone *z, unsigned long start_pfn,
 		return;
 	__shuffle_zone(z, start_pfn, end_pfn);
 }
+
+static inline bool is_shuffle_order(int order)
+{
+	if (!static_branch_unlikely(&page_alloc_shuffle_key))
+                return false;
+	return order >= CONFIG_SHUFFLE_PAGE_ORDER;
+}
 #else
 static inline void shuffle_free_memory(pg_data_t *pgdat, unsigned long start_pfn,
 		unsigned long end_pfn)
@@ -43,5 +50,10 @@ static inline void shuffle_zone(struct zone *z, unsigned long start_pfn,
 static inline void page_alloc_shuffle(void)
 {
 }
+
+static inline bool is_shuffle_order(int order)
+{
+	return false;
+}
 #endif
 #endif /* _MM_SHUFFLE_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index de8b5eb78d13..3a932ba23daf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -42,6 +42,7 @@
 #include <linux/mempolicy.h>
 #include <linux/memremap.h>
 #include <linux/stop_machine.h>
+#include <linux/random.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
 #include <linux/backing-dev.h>
@@ -851,7 +852,8 @@ static inline void __free_one_page(struct page *page,
 	 * so it's less likely to be used soon and more likely to be merged
 	 * as a higher order page
 	 */
-	if ((order < MAX_ORDER-2) && pfn_valid_within(buddy_pfn)) {
+	if ((order < MAX_ORDER-2) && pfn_valid_within(buddy_pfn)
+			&& !is_shuffle_order(order)) {
 		struct page *higher_page, *higher_buddy;
 		combined_pfn = buddy_pfn & pfn;
 		higher_page = page + (combined_pfn - pfn);
@@ -865,7 +867,12 @@ static inline void __free_one_page(struct page *page,
 		}
 	}
 
-	add_to_free_area(page, &zone->free_area[order], migratetype);
+	if (is_shuffle_order(order))
+		add_to_free_area_random(page, &zone->free_area[order],
+				migratetype);
+	else
+		add_to_free_area(page, &zone->free_area[order], migratetype);
+
 }
 
 /*
diff --git a/mm/shuffle.c b/mm/shuffle.c
index 07961ff41a03..4cadf51c9b40 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -213,3 +213,19 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat, unsigned long start_pfn,
 	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
 		shuffle_zone(z, start_pfn, end_pfn);
 }
+
+void add_to_free_area_random(struct page *page, struct free_area *area,
+		int migratetype)
+{
+	if (area->rand_bits == 0) {
+		area->rand_bits = 64;
+		area->rand = get_random_u64();
+	}
+
+	if (area->rand & 1)
+		add_to_free_area(page, area, migratetype);
+	else
+		add_to_free_area_tail(page, area, migratetype);
+	area->rand_bits--;
+	area->rand >>= 1;
+}

