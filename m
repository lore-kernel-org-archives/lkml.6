Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeCJSZY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:25:24 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43578 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932894AbeCJSVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:45 -0500
X-Google-Smtp-Source: AG47ELt6mQRExAAscSxhwQtjRzXjtc3WX1JvowL/d7MmlBp8YoYuN1Bz2bSOZYvNmzQTSy5meTf0cw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 73/83] Dax: Add iomap operations.
Date: Sat, 10 Mar 2018 10:18:54 -0800
Message-Id: <1520705944-6723-74-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

The key of iomap is dax_get_blocks(). It first takes the read lock
and lookup the block; if the block is missing, it takes write lock,
check again and allocate the new block if needed.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/dax.c  | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/nova.h |   3 +
 2 files changed, 187 insertions(+)

diff --git a/fs/nova/dax.c b/fs/nova/dax.c
index 8624ce4..e639b23 100644
--- a/fs/nova/dax.c
+++ b/fs/nova/dax.c
@@ -731,3 +731,187 @@ ssize_t nova_inplace_file_write(struct file *filp,
 
 	return ret;
 }
+
+/*
+ * return > 0, # of blocks mapped or allocated.
+ * return = 0, if plain lookup failed.
+ * return < 0, error case.
+ */
+static int nova_dax_get_blocks(struct inode *inode, sector_t iblock,
+	unsigned long max_blocks, u32 *bno, bool *new, bool *boundary,
+	int create)
+{
+	struct super_block *sb = inode->i_sb;
+	struct nova_inode *pi;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_file_write_entry *entry = NULL;
+	struct nova_file_write_item entry_item;
+	struct list_head item_head;
+	struct nova_inode_update update;
+	u32 time;
+	unsigned long nvmm = 0;
+	unsigned long blocknr = 0;
+	u64 epoch_id;
+	int num_blocks = 0;
+	int inplace = 0;
+	int allocated = 0;
+	int locked = 0;
+	int check_next;
+	int ret = 0;
+	timing_t get_block_time;
+
+
+	if (max_blocks == 0)
+		return 0;
+
+	NOVA_START_TIMING(dax_get_block_t, get_block_time);
+	INIT_LIST_HEAD(&item_head);
+
+	nova_dbgv("%s: pgoff %lu, num %lu, create %d\n",
+				__func__, iblock, max_blocks, create);
+
+	epoch_id = nova_get_epoch_id(sb);
+
+	check_next = 0;
+	sih_lock_shared(sih);
+
+again:
+	num_blocks = nova_check_existing_entry(sb, inode, max_blocks,
+					iblock, &entry, check_next,
+					epoch_id, &inplace);
+
+	if (entry) {
+		if (create == 0 || inplace) {
+			nvmm = get_nvmm(sb, sih, entry, iblock);
+			nova_dbgv("%s: found pgoff %lu, block %lu\n",
+					__func__, iblock, nvmm);
+			goto out;
+		}
+	}
+
+	if (create == 0) {
+		num_blocks = 0;
+		goto out1;
+	}
+
+	if (locked == 0) {
+		sih_unlock_shared(sih);
+		sih_lock(sih);
+		locked = 1;
+		/* Check again incase someone has done it for us */
+		check_next = 1;
+		goto again;
+	}
+
+	pi = nova_get_inode(sb, inode);
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	time = current_time(inode).tv_sec;
+	update.tail = sih->log_tail;
+
+	/* Return initialized blocks to the user */
+	allocated = nova_new_data_blocks(sb, sih, &blocknr, iblock,
+				 num_blocks, ALLOC_INIT_ZERO, ANY_CPU,
+				 ALLOC_FROM_HEAD);
+	if (allocated <= 0) {
+		nova_dbgv("%s alloc blocks failed %d\n", __func__,
+							allocated);
+		ret = allocated;
+		goto out;
+	}
+
+	num_blocks = allocated;
+	/* FIXME: how to handle file size? */
+	nova_init_file_write_item(sb, sih, &entry_item,
+					epoch_id, iblock, num_blocks,
+					blocknr, time, inode->i_size);
+
+	list_add_tail(&entry_item.list, &item_head);
+
+	nvmm = blocknr;
+
+	ret = nova_commit_writes_to_log(sb, pi, inode,
+					&item_head, num_blocks, 0);
+	if (ret < 0) {
+		nova_err(sb, "commit to log failed\n");
+		goto out;
+	}
+
+	NOVA_STATS_ADD(dax_new_blocks, 1);
+
+	*new = true;
+//	set_buffer_new(bh);
+out:
+	if (ret < 0) {
+		nova_cleanup_incomplete_write(sb, sih, &item_head, 0);
+		num_blocks = ret;
+		goto out1;
+	}
+
+	*bno = nvmm;
+//	if (num_blocks > 1)
+//		bh->b_size = sb->s_blocksize * num_blocks;
+
+out1:
+	if (locked)
+		sih_unlock(sih);
+	else
+		sih_unlock_shared(sih);
+
+	NOVA_END_TIMING(dax_get_block_t, get_block_time);
+	return num_blocks;
+}
+
+static int nova_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap)
+{
+	struct nova_sb_info *sbi = NOVA_SB(inode->i_sb);
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned long first_block = offset >> blkbits;
+	unsigned long max_blocks = (length + (1 << blkbits) - 1) >> blkbits;
+	bool new = false, boundary = false;
+	u32 bno;
+	int ret;
+
+	ret = nova_dax_get_blocks(inode, first_block, max_blocks, &bno, &new,
+				  &boundary, flags & IOMAP_WRITE);
+	if (ret < 0) {
+		nova_dbgv("%s: nova_dax_get_blocks failed %d", __func__, ret);
+		return ret;
+	}
+
+	iomap->flags = 0;
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->dax_dev = sbi->s_dax_dev;
+	iomap->offset = (u64)first_block << blkbits;
+
+	if (ret == 0) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->length = 1 << blkbits;
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = (u64)bno << blkbits;
+		iomap->length = (u64)ret << blkbits;
+		iomap->flags |= IOMAP_F_MERGED;
+	}
+
+	if (new)
+		iomap->flags |= IOMAP_F_NEW;
+	return 0;
+}
+
+static int nova_iomap_end(struct inode *inode, loff_t offset, loff_t length,
+	ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	if (iomap->type == IOMAP_MAPPED &&
+			written < length &&
+			(flags & IOMAP_WRITE))
+		truncate_pagecache(inode, inode->i_size);
+	return 0;
+}
+
+const struct iomap_ops nova_iomap_ops = {
+	.iomap_begin	= nova_iomap_begin,
+	.iomap_end	= nova_iomap_end,
+};
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index ab9e8f3..0d62c47 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -487,6 +487,9 @@ ssize_t nova_inplace_file_write(struct file *filp, const char __user *buf,
 ssize_t do_nova_inplace_file_write(struct file *filp, const char __user *buf,
 	size_t len, loff_t *ppos);
 
+extern const struct iomap_ops nova_iomap_ops;
+
+
 /* dir.c */
 extern const struct file_operations nova_dir_operations;
 int nova_insert_dir_radix_tree(struct super_block *sb,
-- 
2.7.4
