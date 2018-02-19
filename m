Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeBSTsL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:48:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932065AbeBSTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:46:33 -0500
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 61/61] page cache: Finish XArray conversion
Date: Mon, 19 Feb 2018 11:45:56 -0800
Message-Id: <20180219194556.6575-62-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219194556.6575-1-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

With no more radix tree API users left, we can drop the GFP flags
and use xa_init() instead of INIT_RADIX_TREE().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/inode.c         | 2 +-
 include/linux/fs.h | 2 +-
 mm/swap_state.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 07e26909e24d..c1e8d61c9925 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(inc_nlink);
 void address_space_init_once(struct address_space *mapping)
 {
 	memset(mapping, 0, sizeof(*mapping));
-	INIT_RADIX_TREE(&mapping->pages, GFP_ATOMIC | __GFP_ACCOUNT);
+	xa_init_flags(&mapping->pages, XA_FLAGS_LOCK_IRQ);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->private_list);
 	spin_lock_init(&mapping->private_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b134f80ca498..518167152254 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -410,7 +410,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  */
 struct address_space {
 	struct inode		*host;
-	struct radix_tree_root	pages;
+	struct xarray		pages;
 	gfp_t			gfp_mask;
 	atomic_t		i_mmap_writable;
 	struct rb_root_cached	i_mmap;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 219e3b4f09e6..25f027d0bb00 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -573,7 +573,7 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
 		space = spaces + i;
-		INIT_RADIX_TREE(&space->pages, GFP_ATOMIC|__GFP_NOWARN);
+		xa_init_flags(&space->pages, XA_FLAGS_LOCK_IRQ);
 		atomic_set(&space->i_mmap_writable, 0);
 		space->a_ops = &swap_aops;
 		/* swap cache doesn't use writeback related tags */
-- 
2.16.1
