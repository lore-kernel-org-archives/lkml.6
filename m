Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbeEHSGq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54369 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933123AbeEHSGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:39 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 76/76] btrfs: Use fs_view in roots, point inodes to it
Date: Tue,  8 May 2018 11:04:36 -0700
Message-Id: <20180508180436.716-77-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that our per-subvolume anonymous dev_t gets published to userspace,
instead of the global device in struct super_block. We do this by embedding a
struct fs_view in btrfs_root. The anonymous device number is placed in
view->v_dev. Each inode is then pointed to the view embedded in their owning root.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/btrfs/ctree.h     |  7 ++-----
 fs/btrfs/disk-io.c   | 14 ++++++++------
 fs/btrfs/disk-io.h   |  2 +-
 fs/btrfs/inode.c     |  5 +++--
 fs/btrfs/root-tree.c |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a3cca35642e2..cffd3aa51e93 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1216,11 +1216,6 @@ struct btrfs_root {
 	 * protected by inode_lock
 	 */
 	struct radix_tree_root delayed_nodes_tree;
-	/*
-	 * right now this just gets used so that a root has its own devid
-	 * for stat.  It may be used for more later
-	 */
-	dev_t anon_dev;
 
 	spinlock_t root_item_lock;
 	refcount_t refs;
@@ -1262,6 +1257,8 @@ struct btrfs_root {
 
 	/* For qgroup metadata space reserve */
 	atomic64_t qgroup_meta_rsv;
+
+	struct fs_view view; /* fill in and link to inodes for vfs usage */
 };
 
 struct btrfs_file_private {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 334234da997c..c50af14b5856 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1191,7 +1191,8 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	else
 		root->defrag_trans_start = 0;
 	root->root_key.objectid = objectid;
-	root->anon_dev = 0;
+	memset(&root->view, 0, sizeof(struct fs_view));
+	root->view.v_sb = fs_info->sb;
 
 	spin_lock_init(&root->root_item_lock);
 }
@@ -1463,7 +1464,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 	return root;
 }
 
-int btrfs_init_fs_root(struct btrfs_root *root)
+int btrfs_init_fs_root(struct btrfs_root *root, struct super_block *sb)
 {
 	int ret;
 	struct btrfs_subvolume_writers *writers;
@@ -1487,7 +1488,8 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 	spin_lock_init(&root->ino_cache_lock);
 	init_waitqueue_head(&root->ino_cache_wait);
 
-	ret = get_anon_bdev(&root->anon_dev);
+	root->view.v_sb = sb;
+	ret = get_anon_bdev(&root->view.v_dev);
 	if (ret)
 		goto fail;
 
@@ -1587,7 +1589,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 		goto fail;
 	}
 
-	ret = btrfs_init_fs_root(root);
+	ret = btrfs_init_fs_root(root, fs_info->sb);
 	if (ret)
 		goto fail;
 
@@ -3603,8 +3605,8 @@ static void free_fs_root(struct btrfs_root *root)
 	WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
 	btrfs_free_block_rsv(root->fs_info, root->orphan_block_rsv);
 	root->orphan_block_rsv = NULL;
-	if (root->anon_dev)
-		free_anon_bdev(root->anon_dev);
+	if (root->view.v_dev)
+		free_anon_bdev(root->view.v_dev);
 	if (root->subv_writers)
 		btrfs_free_subvolume_writers(root->subv_writers);
 	free_extent_buffer(root->node);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 301151a50ac1..af60e7d76449 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -72,7 +72,7 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 				      struct btrfs_key *location);
-int btrfs_init_fs_root(struct btrfs_root *root);
+int btrfs_init_fs_root(struct btrfs_root *root, struct super_block *sb);
 struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_id);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1d4a28a4763a..17e93fb6d871 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5705,6 +5705,7 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	memcpy(&BTRFS_I(inode)->location, args->location,
 	       sizeof(*args->location));
 	BTRFS_I(inode)->root = args->root;
+	inode->i_view = &args->root->view;
 	return 0;
 }
 
@@ -6346,6 +6347,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	BTRFS_I(inode)->root = root;
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
+	inode->i_view = &root->view;
 
 	/*
 	 * We could have gotten an inode number from somebody who was fsynced
@@ -9528,8 +9530,7 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(inode, stat);
-	stat->dev = BTRFS_I(inode)->root->anon_dev;
-
+	stat->dev = inode->i_view->v_dev;
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
 	spin_unlock(&BTRFS_I(inode)->lock);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index aab0194efe46..1e6f820c0974 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -308,7 +308,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 
-		err = btrfs_init_fs_root(root);
+		err = btrfs_init_fs_root(root, fs_info->sb);
 		if (err) {
 			btrfs_free_fs_root(root);
 			break;
-- 
2.15.1
