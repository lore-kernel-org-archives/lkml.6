Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F3B2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbeLUOk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:40:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbeLUOk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:40:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BECC3ACA8;
        Fri, 21 Dec 2018 14:40:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] mm: Refactor readahead defines in mm.h
Date:   Fri, 21 Dec 2018 16:40:53 +0200
Message-Id: <20181221144053.24318-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of VM_MAX_READAHEAD actually convert it to kbytes and then to
pages. Define the macro explicitly as (SZ_128K / PAGE_SIZE). This
simplifies the expression in every filesystem. Also rename the macro to
VM_READAHEAD_PAGES to properly convey its meaning. Finally remove unused
VM_MIN_READAHEAD

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 block/blk-core.c   | 3 +--
 fs/9p/vfs_super.c  | 2 +-
 fs/afs/super.c     | 2 +-
 fs/btrfs/disk-io.c | 2 +-
 fs/fuse/inode.c    | 2 +-
 include/linux/mm.h | 4 ++--
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index deb56932f8c4..d25c8564a117 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1031,8 +1031,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	if (!q->stats)
 		goto fail_stats;
 
-	q->backing_dev_info->ra_pages =
-			(VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
+	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->backing_dev_info->name = "block";
 	q->node = node_id;
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 48ce50484e80..10d3bd3f534b 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -92,7 +92,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		return ret;
 
 	if (v9ses->cache)
-		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
+		sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 
 	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
 	if (!v9ses->cache)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index dcd07fe99871..e684f6769b15 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -399,7 +399,7 @@ static int afs_fill_super(struct super_block *sb,
 	ret = super_setup_bdi(sb);
 	if (ret)
 		return ret;
-	sb->s_bdi->ra_pages	= VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
+	sb->s_bdi->ra_pages	= VM_READAHEAD_PAGES;
 
 	/* allocate the root inode and dentry */
 	if (as->dyn_root) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6d776717d8b3..ee47d8b5b50c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2900,7 +2900,7 @@ int open_ctree(struct super_block *sb,
 	sb->s_bdi->congested_fn = btrfs_congested_fn;
 	sb->s_bdi->congested_data = fs_info;
 	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
-	sb->s_bdi->ra_pages = VM_MAX_READAHEAD * SZ_1K / PAGE_SIZE;
+	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 568abed20eb2..d3eab53a29b7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1009,7 +1009,7 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	if (err)
 		return err;
 
-	sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
+	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	/* fuse does it's own writeback accounting */
 	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..1579082af177 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -26,6 +26,7 @@
 #include <linux/page_ref.h>
 #include <linux/memremap.h>
 #include <linux/overflow.h>
+#include <linux/sizes.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2396,8 +2397,7 @@ int __must_check write_one_page(struct page *page);
 void task_dirty_inc(struct task_struct *tsk);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
-#define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
+#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
 
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			pgoff_t offset, unsigned long nr_to_read);
-- 
2.17.1

