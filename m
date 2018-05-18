Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeERMfq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbeERMe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:26 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 09/11] btrfs: have sync_fs op report writeback errors when passed a since pointer
Date: Fri, 18 May 2018 08:34:13 -0400
Message-Id: <20180518123415.28181-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/btrfs/super.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4b3e6676be9d..eac785459f10 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1231,12 +1231,13 @@ int btrfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root = fs_info->tree_root;
+	int ret = 0;
 
 	trace_btrfs_sync_fs(fs_info, wait);
 
 	if (!wait) {
 		filemap_flush(fs_info->btree_inode->i_mapping);
-		return 0;
+		goto out;
 	}
 
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
@@ -1250,7 +1251,7 @@ int btrfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 			 * that need to go through commit
 			 */
 			if (fs_info->pending_changes == 0)
-				return 0;
+				goto out;
 			/*
 			 * A non-blocking test if the fs is frozen. We must not
 			 * start a new transaction here otherwise a deadlock
@@ -1260,13 +1261,22 @@ int btrfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 			if (sb_start_write_trylock(sb))
 				sb_end_write(sb);
 			else
-				return 0;
+				goto out;
 			trans = btrfs_start_transaction(root, 0);
 		}
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			goto out;
+		}
 	}
-	return btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+out:
+	if (since) {
+		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
+		if (ret == 0)
+			ret = ret2;
+	}
+	return ret;
 }
 
 static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
-- 
2.17.0
