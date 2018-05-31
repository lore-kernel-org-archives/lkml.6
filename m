Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeEaDX3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:23:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37629 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeEaDX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:23:26 -0400
X-Google-Smtp-Source: ADUXVKLYRqxhFOF656fpHd/hirsrswOTDTl4mB3StiLOjxVgnHsFl0ndZNYcu2VcthuVm5mQmLD1lA==
Date: Wed, 30 May 2018 20:23:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Andrew Morton <akpm@linux-foundation.org>
cc: Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: fix the NULL mapping case in __isolate_lru_page()
Message-ID: <alpine.LSU.2.11.1805302014001.12558@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

George Boole would have noticed a slight error in 4.16 commit 69d763fc6d3a
("mm: pin address_space before dereferencing it while isolating an LRU page").
Fix it, to match both the comment above it, and the original behaviour.

Although anonymous pages are not marked PageDirty at first, we have an
old habit of calling SetPageDirty when a page is removed from swap cache:
so there's a category of ex-swap pages that are easily migratable, but
were inadvertently excluded from compaction's async migration in 4.16.

Fixes: 69d763fc6d3a ("mm: pin address_space before dereferencing it while isolating an LRU page")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 4.17-rc7/mm/vmscan.c	2018-04-26 10:48:36.027288294 -0700
+++ linux/mm/vmscan.c	2018-05-30 20:08:39.184634029 -0700
@@ -1418,7 +1418,7 @@ int __isolate_lru_page(struct page *page
 				return ret;
 
 			mapping = page_mapping(page);
-			migrate_dirty = mapping && mapping->a_ops->migratepage;
+			migrate_dirty = !mapping || mapping->a_ops->migratepage;
 			unlock_page(page);
 			if (!migrate_dirty)
 				return ret;
