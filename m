Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDFC10F18
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADB62086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfBVRn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:43:29 -0500
Received: from relay.sw.ru ([185.231.240.75]:59692 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfBVRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:43:28 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gxEr3-00010r-5K; Fri, 22 Feb 2019 20:43:21 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/5] mm/workingset: remove unused @mapping argument in workingset_eviction()
Date:   Fri, 22 Feb 2019 20:43:33 +0300
Message-Id: <20190222174337.26390-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

workingset_eviction() doesn't use and never did use the @mapping argument.
Remove it.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/swap.h | 2 +-
 mm/vmscan.c          | 2 +-
 mm/workingset.c      | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 649529be91f2..fc50e21b3b88 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -307,7 +307,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
-void *workingset_eviction(struct address_space *mapping, struct page *page);
+void *workingset_eviction(struct page *page);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac4806f0f332..a9852ed7b97f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -952,7 +952,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 */
 		if (reclaimed && page_is_file_cache(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
-			shadow = workingset_eviction(mapping, page);
+			shadow = workingset_eviction(page);
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
diff --git a/mm/workingset.c b/mm/workingset.c
index dcb994f2acc2..0906137760c5 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -215,13 +215,12 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 
 /**
  * workingset_eviction - note the eviction of a page from memory
- * @mapping: address space the page was backing
  * @page: the page being evicted
  *
  * Returns a shadow entry to be stored in @mapping->i_pages in place
  * of the evicted @page so that a later refault can be detected.
  */
-void *workingset_eviction(struct address_space *mapping, struct page *page)
+void *workingset_eviction(struct page *page)
 {
 	struct pglist_data *pgdat = page_pgdat(page);
 	struct mem_cgroup *memcg = page_memcg(page);
-- 
2.19.2

