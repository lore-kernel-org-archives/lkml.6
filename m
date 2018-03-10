Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeCJSko (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:40:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34503 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932337AbeCJSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:37 -0500
X-Google-Smtp-Source: AG47ELuzQ9TQDIevIFiH2Si+vheU2Gttoh+C11W5X4xRBeVtYEJdOcaMMLwGnhz5tKYN9tl2Jd9CEQ==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 17/83] Add statfs support.
Date: Sat, 10 Mar 2018 10:17:58 -0800
Message-Id: <1520705944-6723-18-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/balloc.c | 18 ++++++++++++++++++
 fs/nova/balloc.h |  1 +
 fs/nova/super.c  | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/fs/nova/balloc.c b/fs/nova/balloc.c
index cb627db..0742fe0 100644
--- a/fs/nova/balloc.c
+++ b/fs/nova/balloc.c
@@ -217,3 +217,21 @@ inline int nova_insert_blocktree(struct nova_sb_info *sbi,
 
 	return ret;
 }
+
+/* We do not take locks so it's inaccurate */
+unsigned long nova_count_free_blocks(struct super_block *sb)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct free_list *free_list;
+	unsigned long num_free_blocks = 0;
+	int i;
+
+	for (i = 0; i < sbi->cpus; i++) {
+		free_list = nova_get_free_list(sb, i);
+		num_free_blocks += free_list->num_free_blocks;
+	}
+
+	return num_free_blocks;
+}
+
+
diff --git a/fs/nova/balloc.h b/fs/nova/balloc.h
index 57a93e4..537532e 100644
--- a/fs/nova/balloc.h
+++ b/fs/nova/balloc.h
@@ -66,6 +66,7 @@ inline struct nova_range_node *nova_alloc_blocknode(struct super_block *sb);
 inline void nova_free_blocknode(struct super_block *sb,
 	struct nova_range_node *bnode);
 extern void nova_init_blockmap(struct super_block *sb, int recovery);
+extern unsigned long nova_count_free_blocks(struct super_block *sb);
 inline int nova_insert_blocktree(struct nova_sb_info *sbi,
 	struct rb_root *tree, struct nova_range_node *new_node);
 
diff --git a/fs/nova/super.c b/fs/nova/super.c
index 9762f26..3500d19 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -629,6 +629,24 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 	return retval;
 }
 
+static int nova_statfs(struct dentry *d, struct kstatfs *buf)
+{
+	struct super_block *sb = d->d_sb;
+	struct nova_sb_info *sbi = (struct nova_sb_info *)sb->s_fs_info;
+
+	buf->f_type = NOVA_SUPER_MAGIC;
+	buf->f_bsize = sb->s_blocksize;
+
+	buf->f_blocks = sbi->num_blocks;
+	buf->f_bfree = buf->f_bavail = nova_count_free_blocks(sb);
+	buf->f_files = LONG_MAX;
+	buf->f_ffree = LONG_MAX - sbi->s_inodes_used_count;
+	buf->f_namelen = NOVA_NAME_LEN;
+	nova_dbg_verbose("nova_stats: total 4k free blocks 0x%llx\n",
+		buf->f_bfree);
+	return 0;
+}
+
 static int nova_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct nova_sb_info *sbi = NOVA_SB(root->d_sb);
@@ -794,6 +812,7 @@ static struct super_operations nova_sops = {
 	.alloc_inode	= nova_alloc_inode,
 	.destroy_inode	= nova_destroy_inode,
 	.put_super	= nova_put_super,
+	.statfs		= nova_statfs,
 	.remount_fs	= nova_remount,
 	.show_options	= nova_show_options,
 };
-- 
2.7.4
