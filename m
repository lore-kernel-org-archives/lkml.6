Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeCMNam (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:30:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeCMN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:27:06 -0400
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: [PATCH v9 53/61] btrfs: Convert page cache to XArray
Date: Tue, 13 Mar 2018 06:26:31 -0700
Message-Id: <20180313132639.17387-54-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313132639.17387-1-willy@infradead.org>
References: <20180313132639.17387-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/btrfs/compression.c | 4 +---
 fs/btrfs/extent_io.c   | 8 +++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ad330af89eef..c2286f436571 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -457,9 +457,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (pg_index > end_index)
 			break;
 
-		rcu_read_lock();
-		page = radix_tree_lookup(&mapping->i_pages, pg_index);
-		rcu_read_unlock();
+		page = xa_load(&mapping->i_pages, pg_index);
 		if (page && !xa_is_value(page)) {
 			misses++;
 			if (misses > 4)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bcc24ee5a2c9..edc472b41037 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5170,11 +5170,9 @@ void clear_extent_buffer_dirty(struct extent_buffer *eb)
 
 		clear_page_dirty_for_io(page);
 		xa_lock_irq(&page->mapping->i_pages);
-		if (!PageDirty(page)) {
-			radix_tree_tag_clear(&page->mapping->i_pages,
-						page_index(page),
-						PAGECACHE_TAG_DIRTY);
-		}
+		if (!PageDirty(page))
+			__xa_clear_tag(&page->mapping->i_pages,
+					page_index(page), PAGECACHE_TAG_DIRTY);
 		xa_unlock_irq(&page->mapping->i_pages);
 		ClearPageError(page);
 		unlock_page(page);
-- 
2.16.1
