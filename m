Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeBLIMn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:12:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:29057 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeBLIMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:12:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="29306666"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>, Jan Kara <jack@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: Fix races between address_space dereference and free in page_evicatable
Date: Mon, 12 Feb 2018 16:12:27 +0800
Message-Id: <20180212081227.1940-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

When page_mapping() is called and the mapping is dereferenced in
page_evicatable() through shrink_active_list(), it is possible for the
inode to be truncated and the embedded address space to be freed at
the same time.  This may lead to the following race.

CPU1                                                CPU2

truncate(inode)                                     shrink_active_list()
  ...                                                 page_evictable(page)
  truncate_inode_page(mapping, page);
    delete_from_page_cache(page)
      spin_lock_irqsave(&mapping->tree_lock, flags);
        __delete_from_page_cache(page, NULL)
          page_cache_tree_delete(..)
            ...                                         mapping = page_mapping(page);
            page->mapping = NULL;
            ...
      spin_unlock_irqrestore(&mapping->tree_lock, flags);
      page_cache_free_page(mapping, page)
        put_page(page)
          if (put_page_testzero(page)) -> false
- inode now has no pages and can be freed including embedded address_space

                                                        mapping_unevictable(mapping)
							  test_bit(AS_UNEVICTABLE, &mapping->flags);
- we've dereferenced mapping which is potentially already free.

Similar race exists between swap cache freeing and page_evicatable() too.

The address_space in inode and swap cache will be freed after a RCU
grace period.  So the races are fixed via enclosing the page_mapping()
and address_space usage in rcu_read_lock/unlock().  Some comments are
added in code to make it clear what is protected by the RCU read lock.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d1c1e00b08bb..10a0f32a3f90 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3886,7 +3886,13 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
  */
 int page_evictable(struct page *page)
 {
-	return !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
+	int ret;
+
+	/* Prevent address_space of inode and swap cache from being freed */
+	rcu_read_lock();
+	ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
+	rcu_read_unlock();
+	return ret;
 }
 
 #ifdef CONFIG_SHMEM
-- 
2.15.1
