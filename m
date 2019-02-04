Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5339C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1C02087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfBDMBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:01:18 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:42905 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729283AbfBDMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:01:15 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id CFA1598BEC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Feb 2019 12:01:12 +0000 (UTC)
Received: (qmail 3119 invoked from network); 4 Feb 2019 12:01:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Feb 2019 12:01:12 -0000
Date:   Mon, 4 Feb 2019 12:01:11 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm, compaction: Use free lists to quickly locate a migration
 source -fix
Message-ID: <20190204120111.GL9565@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-12-mgorman@techsingularity.net>
 <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
 <20190201145139.GI9565@techsingularity.net>
 <cb0bae2e-8628-1378-68a1-9da02a94652e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <cb0bae2e-8628-1378-68a1-9da02a94652e@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil correctly pointed out that when a fast search fails and cc->migrate_pfn
is reinitialised to the lowest PFN found that the caller does not use the updated
PFN.

He also pointed out that there is an inconsistency between
move_freelist_head and move_freelist_tail. This patch adds a new helper
and uses it in move_freelist_tail so that list manipulations are avoided
if the first list item traversed is a suitable migration source. The
end result will be that the helpers should be symmetrical and it's been
confirmed that the scan rates are slightly improved as a result of the
fix but not enough to rewrite the changelogs.

This is a fix for the mmotm patch
mm-compaction-use-free-lists-to-quickly-locate-a-migration-source.patch . It's
been provided as a combined patch as the first patch is not picked up at the
time of writing and a rolled up patch is less likely to fall through the cracks.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/gpu/drm/i915/i915_utils.h |  6 ------
 include/linux/list.h              | 11 +++++++++++
 mm/compaction.c                   | 10 ++++++----
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 9726df37c4c4..540e20eb032c 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -123,12 +123,6 @@ static inline u64 ptr_to_u64(const void *ptr)
 
 #include <linux/list.h>
 
-static inline int list_is_first(const struct list_head *list,
-				const struct list_head *head)
-{
-	return head->next == list;
-}
-
 static inline void __list_del_many(struct list_head *head,
 				   struct list_head *first)
 {
diff --git a/include/linux/list.h b/include/linux/list.h
index edb7628e46ed..79626b5ab36c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -206,6 +206,17 @@ static inline void list_bulk_move_tail(struct list_head *head,
 	head->prev = last;
 }
 
+/**
+ * list_is_first -- tests whether @ list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list,
+					const struct list_head *head)
+{
+	return list->prev == head;
+}
+
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test
diff --git a/mm/compaction.c b/mm/compaction.c
index 92d10eb3d1c7..55f7ab142af2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1062,7 +1062,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
 {
 	LIST_HEAD(sublist);
 
-	if (!list_is_last(freelist, &freepage->lru)) {
+	if (!list_is_first(freelist, &freepage->lru)) {
 		list_cut_position(&sublist, freelist, &freepage->lru);
 		if (!list_empty(&sublist))
 			list_splice_tail(&sublist, freelist);
@@ -1238,14 +1238,16 @@ update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
 	cc->fast_start_pfn = min(cc->fast_start_pfn, pfn);
 }
 
-static inline void
+static inline unsigned long
 reinit_migrate_pfn(struct compact_control *cc)
 {
 	if (!cc->fast_start_pfn || cc->fast_start_pfn == ULONG_MAX)
-		return;
+		return cc->migrate_pfn;
 
 	cc->migrate_pfn = cc->fast_start_pfn;
 	cc->fast_start_pfn = ULONG_MAX;
+
+	return cc->migrate_pfn;
 }
 
 /*
@@ -1361,7 +1363,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 	 * that had free pages as the basis for starting a linear scan.
 	 */
 	if (pfn == cc->migrate_pfn)
-		reinit_migrate_pfn(cc);
+		pfn = reinit_migrate_pfn(cc);
 
 	return pfn;
 }
