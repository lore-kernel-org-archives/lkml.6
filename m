Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5173C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F5A20856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F5A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJDJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:20:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:62286 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJDJUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:20:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 19:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="96302448"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2018 19:27:22 -0700
Subject: [PATCH v2 3/3] mm: Maintain randomization of page free lists
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Wed, 03 Oct 2018 19:15:34 -0700
Message-ID: <153861933441.2863953.2686611248399177664.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 include/linux/mmzone.h |    2 ++
 mm/page_alloc.c        |   27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index adf9b3a7440d..4a095432843d 100644
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b4a1598fcab5..e659119351ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -43,6 +43,7 @@
 #include <linux/mempolicy.h>
 #include <linux/memremap.h>
 #include <linux/stop_machine.h>
+#include <linux/random.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
 #include <linux/backing-dev.h>
@@ -746,6 +747,22 @@ static inline int page_is_buddy(struct page *page, struct page *buddy,
 	return 0;
 }
 
+static void add_to_free_area_random(struct page *page, struct free_area *area,
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
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -851,7 +868,8 @@ static inline void __free_one_page(struct page *page,
 	 * so it's less likely to be used soon and more likely to be merged
 	 * as a higher order page
 	 */
-	if ((order < MAX_ORDER-2) && pfn_valid_within(buddy_pfn)) {
+	if ((order < MAX_ORDER-2) && pfn_valid_within(buddy_pfn)
+			&& order < shuffle_page_order) {
 		struct page *higher_page, *higher_buddy;
 		combined_pfn = buddy_pfn & pfn;
 		higher_page = page + (combined_pfn - pfn);
@@ -865,7 +883,12 @@ static inline void __free_one_page(struct page *page,
 		}
 	}
 
-	add_to_free_area(page, &zone->free_area[order], migratetype);
+	if (order < shuffle_page_order)
+		add_to_free_area(page, &zone->free_area[order], migratetype);
+	else
+		add_to_free_area_random(page, &zone->free_area[order],
+				migratetype);
+
 }
 
 /*

