Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeCJSU4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:20:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37505 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbeCJSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:52 -0500
X-Google-Smtp-Source: AG47ELvEQF4J8Y5FciHr+FRPsbET/HiAOT5W/5Dk0PsIrMqUgt8bhyWCqGjw6VKQ5z+diEgMC/kq7Q==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 29/83] Add write_inode and dirty_inode routines.
Date: Sat, 10 Mar 2018 10:18:10 -0800
Message-Id: <1520705944-6723-30-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.c | 33 +++++++++++++++++++++++++++++++++
 fs/nova/inode.h |  2 ++
 fs/nova/super.c |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index a30b6aa..29d172a 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -489,6 +489,39 @@ int nova_free_inuse_inode(struct super_block *sb, unsigned long ino)
 	return ret;
 }
 
+int nova_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	/* write_inode should never be called because we always keep our inodes
+	 * clean. So let us know if write_inode ever gets called.
+	 */
+//	BUG();
+	return 0;
+}
+
+/*
+ * dirty_inode() is called from mark_inode_dirty_sync()
+ * usually dirty_inode should not be called because NOVA always keeps its inodes
+ * clean. Only exception is touch_atime which calls dirty_inode to update the
+ * i_atime field.
+ */
+void nova_dirty_inode(struct inode *inode, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_inode *pi;
+
+	pi = nova_get_block(sb, sih->pi_addr);
+
+	/* only i_atime should have changed if at all.
+	 * we can do in-place atomic update
+	 */
+	pi->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
+	nova_persist_inode(pi);
+	/* Relax atime persistency */
+	nova_flush_buffer(&pi->i_atime, sizeof(pi->i_atime), 0);
+}
+
 static ssize_t nova_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	/* DAX does not support direct IO */
diff --git a/fs/nova/inode.h b/fs/nova/inode.h
index e00b3b9..f9f5c14 100644
--- a/fs/nova/inode.h
+++ b/fs/nova/inode.h
@@ -229,5 +229,7 @@ int nova_get_inode_address(struct super_block *sb, u64 ino,
 struct inode *nova_iget(struct super_block *sb, unsigned long ino);
 inline int nova_insert_inodetree(struct nova_sb_info *sbi,
 	struct nova_range_node *new_node, int cpu);
+extern int nova_write_inode(struct inode *inode, struct writeback_control *wbc);
+extern void nova_dirty_inode(struct inode *inode, int flags);
 
 #endif
diff --git a/fs/nova/super.c b/fs/nova/super.c
index 69e4afc..c0427fd 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -861,6 +861,8 @@ static void destroy_rangenode_cache(void)
 static struct super_operations nova_sops = {
 	.alloc_inode	= nova_alloc_inode,
 	.destroy_inode	= nova_destroy_inode,
+	.write_inode	= nova_write_inode,
+	.dirty_inode	= nova_dirty_inode,
 	.put_super	= nova_put_super,
 	.statfs		= nova_statfs,
 	.remount_fs	= nova_remount,
-- 
2.7.4
