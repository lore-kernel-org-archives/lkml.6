Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937372AbeE1K3l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937282AbeE1K3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:29:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 073/329] mm: pin address_space before dereferencing it while isolating an LRU page
Date: Mon, 28 May 2018 12:00:02 +0200
Message-Id: <20180528100248.911936585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@techsingularity.net>

[ Upstream commit 69d763fc6d3aee787a3e8c8c35092b4f4960fa5d ]

Minchan Kim asked the following question -- what locks protects
address_space destroying when race happens between inode trauncation and
__isolate_lru_page? Jan Kara clarified by describing the race as follows

CPU1                                            CPU2

truncate(inode)                                 __isolate_lru_page()
  ...
  truncate_inode_page(mapping, page);
    delete_from_page_cache(page)
      spin_lock_irqsave(&mapping->tree_lock, flags);
        __delete_from_page_cache(page, NULL)
          page_cache_tree_delete(..)
            ...                                   mapping = page_mapping(page);
            page->mapping = NULL;
            ...
      spin_unlock_irqrestore(&mapping->tree_lock, flags);
      page_cache_free_page(mapping, page)
        put_page(page)
          if (put_page_testzero(page)) -> false
- inode now has no pages and can be freed including embedded address_space

                                                  if (mapping && !mapping->a_ops->migratepage)
- we've dereferenced mapping which is potentially already free.

The race is theoretically possible but unlikely.  Before the
delete_from_page_cache, truncate_cleanup_page is called so the page is
likely to be !PageDirty or PageWriteback which gets skipped by the only
caller that checks the mappping in __isolate_lru_page.  Even if the race
occurs, a substantial amount of work has to happen during a tiny window
with no preemption but it could potentially be done using a virtual
machine to artifically slow one CPU or halt it during the critical
window.

This patch should eliminate the race with truncation by try-locking the
page before derefencing mapping and aborting if the lock was not
acquired.  There was a suggestion from Huang Ying to use RCU as a
side-effect to prevent mapping being freed.  However, I do not like the
solution as it's an unconventional means of preserving a mapping and
it's not a context where rcu_read_lock is obviously protecting rcu data.

Link: http://lkml.kernel.org/r/20180104102512.2qos3h5vqzeisrek@techsingularity.net
Fixes: c82449352854 ("mm: compaction: make isolate_lru_page() filter-aware again")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1374,6 +1374,7 @@ int __isolate_lru_page(struct page *page
 
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
 
 			/* ISOLATE_CLEAN means only clean pages */
 			if (mode & ISOLATE_CLEAN)
@@ -1382,10 +1383,19 @@ int __isolate_lru_page(struct page *page
 			/*
 			 * Only pages without mappings or that have a
 			 * ->migratepage callback are possible to migrate
-			 * without blocking
+			 * without blocking. However, we can be racing with
+			 * truncation so it's necessary to lock the page
+			 * to stabilise the mapping as truncation holds
+			 * the page lock until after the page is removed
+			 * from the page cache.
 			 */
+			if (!trylock_page(page))
+				return ret;
+
 			mapping = page_mapping(page);
-			if (mapping && !mapping->a_ops->migratepage)
+			migrate_dirty = mapping && mapping->a_ops->migratepage;
+			unlock_page(page);
+			if (!migrate_dirty)
 				return ret;
 		}
 	}
