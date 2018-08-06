Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5ECC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A160219C5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A160219C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeHFFLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:11:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbeHFFLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:11:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 566C8C91B940E;
        Mon,  6 Aug 2018 11:04:41 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Mon, 6 Aug 2018 11:04:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs/btrfs: remove the unneeded variable "err" and change the function to be void function
Date:   Mon, 6 Aug 2018 10:52:58 +0800
Message-ID: <1533523978-50321-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The err is not modified after initalization, So just remove it and make
the function to be void function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
 - Merge v1 series into a patch to void same changelog.
 - Fix v1 issue that forget to return after remove the variable "err".

 fs/btrfs/disk-io.c     | 13 +++++--------
 fs/btrfs/extent-tree.c |  6 ++----
 fs/btrfs/tree-log.c    |  5 +----
 fs/btrfs/tree-log.h    |  2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 468365d..bad6cc6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -53,8 +53,8 @@
 static const struct extent_io_ops btree_extent_io_ops;
 static void end_workqueue_fn(struct btrfs_work *work);
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info);
+static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+				       struct btrfs_fs_info *fs_info);
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
 static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 					struct extent_io_tree *dirty_pages,
@@ -4179,13 +4179,12 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->ordered_root_lock);
 }
 
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info)
+static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+				       struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4193,7 +4192,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_info(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return;
 	}
 
 	while ((node = rb_first(&delayed_refs->href_root)) != NULL) {
@@ -4247,8 +4246,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	}
 
 	spin_unlock(&delayed_refs->lock);
-
-	return ret;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b1f2f64..ed02305 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6464,11 +6464,10 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
  * reserve set to 0 in order to clear the reservation.
  */
 
-static int btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
-				     u64 num_bytes, int delalloc)
+static void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
+				      u64 num_bytes, int delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
-	int ret = 0;
 
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
@@ -6481,7 +6480,6 @@ static int btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
-	return ret;
 }
 void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1650dc4..4ed7379 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -205,14 +205,11 @@ static int join_running_log_trans(struct btrfs_root *root)
  * until you call btrfs_end_log_trans() or it makes any future
  * log transactions wait until you call btrfs_end_log_trans()
  */
-int btrfs_pin_log_trans(struct btrfs_root *root)
+void btrfs_pin_log_trans(struct btrfs_root *root)
 {
-	int ret = -ENOENT;
-
 	mutex_lock(&root->log_mutex);
 	atomic_inc(&root->log_writers);
 	mutex_unlock(&root->log_mutex);
-	return ret;
 }
 
 /*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 122e68b..8977678 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -65,7 +65,7 @@ int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 			       const char *name, int name_len,
 			       struct btrfs_inode *inode, u64 dirid);
 void btrfs_end_log_trans(struct btrfs_root *root);
-int btrfs_pin_log_trans(struct btrfs_root *root);
+void btrfs_pin_log_trans(struct btrfs_root *root);
 void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_inode *dir, struct btrfs_inode *inode,
 			     int for_rename);
-- 
1.7.12.4

