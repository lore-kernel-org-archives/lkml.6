Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC9C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26DA20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfAIMUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:20:38 -0500
Received: from relay.sw.ru ([185.231.240.75]:42302 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfAIMUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:20:36 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ghCqO-0004gt-O2; Wed, 09 Jan 2019 15:20:24 +0300
Subject: [PATCH 1/3] mm: Uncharge and keep page in pagecache on memcg reclaim
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        ktkhai@virtuozzo.com, darrick.wong@oracle.com, mhocko@suse.com,
        aryabinin@virtuozzo.com, guro@fb.com, mgorman@techsingularity.net,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 15:20:24 +0300
Message-ID: <154703642447.32690.5604527676583713589.stgit@localhost.localdomain>
In-Reply-To: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes __remove_mapping() not remove a page from
pagecache on memcg reclaim. After all mappings are removed
and refcounter is freezed, we uncharge page memcg. Further
putback_lru_page() places page into root_mem_cgroup, so it
remains in pagecache till global reclaim. This gives memcg
tasks extra possibility to obtain page from pagecache
instead of launching IO.

Next patch makes pagecache_get_page() to recharge a page
in case of its memcg is NULL (i.e., on first access after
uncharging). It looks to be the only function, which is
used by filesystems to obtain a pagecache page. Here we
introduce AS_KEEP_MEMCG_RECLAIM flag to mark the filesystems,
which are reviewed, that they really follow this way. It
has a sense to keep pages in __remove_mapping() only for
them. Later, we remove this flags after all filesystems are
reviewed.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/pagemap.h |    1 +
 mm/vmscan.c             |   22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1020e6f40880..1b880da85868 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -29,6 +29,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
+	AS_KEEP_MEMCG_RECLAIM = 6,
 };
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f800e9..7237603c8973 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -887,7 +887,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping,
  * gets returned with a refcount of 0.
  */
 static int __remove_mapping(struct address_space *mapping, struct page *page,
-			    bool reclaimed)
+			    bool reclaimed, bool memcg_reclaim)
 {
 	unsigned long flags;
 	int refcount;
@@ -963,7 +963,20 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		if (reclaimed && page_is_file_cache(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
 			shadow = workingset_eviction(mapping, page);
-		__delete_from_page_cache(page, shadow);
+#ifdef CONFIG_MEMCG
+		if (memcg_reclaim &&
+		    test_bit(AS_KEEP_MEMCG_RECLAIM, &mapping->flags)) {
+			/*
+			 * Page is not dirty/writeback/mapped, so we may avoid
+			 * taking mem_cgroup::move_lock for changing its memcg.
+			 * See mem_cgroup_move_account() for details.
+			 */
+			mem_cgroup_uncharge(page);
+			page_ref_unfreeze(page, refcount);
+			goto cannot_free;
+		} else
+#endif
+			__delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
 		if (freepage != NULL)
@@ -985,7 +998,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
  */
 int remove_mapping(struct address_space *mapping, struct page *page)
 {
-	if (__remove_mapping(mapping, page, false)) {
+	if (__remove_mapping(mapping, page, false, false)) {
 		/*
 		 * Unfreezing the refcount with 1 rather than 2 effectively
 		 * drops the pagecache ref for us without requiring another
@@ -1458,7 +1471,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 			count_vm_event(PGLAZYFREED);
 			count_memcg_page_event(page, PGLAZYFREED);
-		} else if (!mapping || !__remove_mapping(mapping, page, true))
+		} else if (!mapping || !__remove_mapping(mapping, page, true,
+							!global_reclaim(sc)))
 			goto keep_locked;
 
 		unlock_page(page);

