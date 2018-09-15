Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B8FECE564
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975BE2147E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975BE2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIOVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 17:54:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:20642 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbeIOVyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 17:54:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 09:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,377,1531810800"; 
   d="scan'208";a="83785006"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2018 09:35:00 -0700
Subject: [PATCH 3/3] mm: Maintain randomization of page free lists
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Sep 2018 09:23:18 -0700
Message-ID: <153702859851.1603922.5390659652135091505.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index 175f2e5f9e50..33a6b40ae463 100644
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

