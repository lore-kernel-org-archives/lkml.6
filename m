Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbeCJSVq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:46 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41911 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeCJSVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:44 -0500
X-Google-Smtp-Source: AG47ELsBzexsaRxgZLjintVXIGm6K5ye/pFVkkF8TU/CZWgUJ/0A3eqgSZD/RYuE/fXa6keLrQN/JQ==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 72/83] File operation: fallocate.
Date: Sat, 10 Mar 2018 10:18:53 -0800
Message-Id: <1520705944-6723-73-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Fallocate works similar as writes, allocating zeroed blocked
for the holes in the request region.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/file.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/nova.h |   5 ++
 2 files changed, 153 insertions(+)

diff --git a/fs/nova/file.c b/fs/nova/file.c
index b94a9a3..a6b5bd3 100644
--- a/fs/nova/file.c
+++ b/fs/nova/file.c
@@ -113,6 +113,153 @@ static int nova_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static long nova_fallocate(struct file *file, int mode, loff_t offset,
+	loff_t len)
+{
+	struct inode *inode = file->f_path.dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_inode *pi;
+	struct nova_file_write_entry *entry;
+	struct nova_file_write_item *entry_item;
+	struct list_head item_head;
+	struct nova_inode_update update;
+	unsigned long start_blk, num_blocks, ent_blks = 0;
+	unsigned long total_blocks = 0;
+	unsigned long blocknr = 0;
+	unsigned long blockoff;
+	loff_t new_size;
+	long ret = 0;
+	int inplace = 0;
+	int blocksize_mask;
+	int allocated = 0;
+	timing_t fallocate_time;
+	u64 epoch_id;
+	u32 time;
+
+	/*
+	 * Fallocate does not make much sence for CoW,
+	 * but we still support it for DAX-mmap purpose.
+	 */
+
+	/* We only support the FALLOC_FL_KEEP_SIZE mode */
+	if (mode & ~FALLOC_FL_KEEP_SIZE)
+		return -EOPNOTSUPP;
+
+	if (S_ISDIR(inode->i_mode))
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&item_head);
+	new_size = len + offset;
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && new_size > inode->i_size) {
+		ret = inode_newsize_ok(inode, new_size);
+		if (ret)
+			return ret;
+	} else {
+		new_size = inode->i_size;
+	}
+
+	nova_dbgv("%s: inode %lu, offset %lld, count %lld, mode 0x%x\n",
+			__func__, inode->i_ino,	offset, len, mode);
+
+	NOVA_START_TIMING(fallocate_t, fallocate_time);
+	inode_lock(inode);
+	sih_lock(sih);
+
+	pi = nova_get_inode(sb, inode);
+	if (!pi) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	inode->i_mtime = inode->i_ctime = current_time(inode);
+	time = current_time(inode).tv_sec;
+
+	blocksize_mask = sb->s_blocksize - 1;
+	start_blk = offset >> sb->s_blocksize_bits;
+	blockoff = offset & blocksize_mask;
+	num_blocks = (blockoff + len + blocksize_mask) >> sb->s_blocksize_bits;
+
+	epoch_id = nova_get_epoch_id(sb);
+	update.tail = sih->log_tail;
+	while (num_blocks > 0) {
+		ent_blks = nova_check_existing_entry(sb, inode, num_blocks,
+						start_blk, &entry,
+						1, epoch_id, &inplace);
+
+		if (entry && inplace) {
+			if (entry->size < new_size) {
+				/* Update existing entry */
+				entry->size = new_size;
+				nova_persist_entry(entry);
+			}
+			allocated = ent_blks;
+			goto next;
+		}
+
+		/* Allocate zeroed blocks to fill hole */
+		allocated = nova_new_data_blocks(sb, sih, &blocknr, start_blk,
+				 ent_blks, ALLOC_INIT_ZERO, ANY_CPU,
+				 ALLOC_FROM_HEAD);
+		nova_dbgv("%s: alloc %d blocks @ %lu\n", __func__,
+						allocated, blocknr);
+
+		if (allocated <= 0) {
+			nova_dbg("%s alloc %lu blocks failed!, %d\n",
+						__func__, ent_blks, allocated);
+			ret = allocated;
+			goto out;
+		}
+
+		entry_item = nova_alloc_file_write_item(sb);
+		if (!entry_item) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Handle hole fill write */
+		nova_init_file_write_item(sb, sih, entry_item, epoch_id,
+					start_blk, allocated, blocknr,
+					time, new_size);
+
+		list_add_tail(&entry_item->list, &item_head);
+
+		total_blocks += allocated;
+next:
+		num_blocks -= allocated;
+		start_blk += allocated;
+	}
+
+	ret = nova_commit_writes_to_log(sb, pi, inode,
+					&item_head, total_blocks, 1);
+	if (ret < 0) {
+		nova_err(sb, "commit to log failed\n");
+		goto out;
+	}
+
+	if (ret || (mode & FALLOC_FL_KEEP_SIZE)) {
+		pi->i_flags |= cpu_to_le32(NOVA_EOFBLOCKS_FL);
+		sih->i_flags |= cpu_to_le32(NOVA_EOFBLOCKS_FL);
+	}
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && new_size > inode->i_size) {
+		inode->i_size = new_size;
+		sih->i_size = new_size;
+	}
+
+	nova_persist_inode(pi);
+
+out:
+	if (ret < 0)
+		nova_cleanup_incomplete_write(sb, sih, &item_head, 1);
+
+	sih_unlock(sih);
+	inode_unlock(inode);
+	NOVA_END_TIMING(fallocate_t, fallocate_time);
+	return ret;
+}
+
 static ssize_t
 do_dax_mapping_read(struct file *filp, char __user *buf,
 	size_t len, loff_t *ppos)
@@ -477,6 +624,7 @@ const struct file_operations nova_dax_file_operations = {
 	.open		= nova_open,
 	.fsync		= nova_fsync,
 	.flush		= nova_flush,
+	.fallocate	= nova_fallocate,
 };
 
 const struct inode_operations nova_file_inode_operations = {
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 6392bb3..ab9e8f3 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -477,6 +477,11 @@ void nova_init_file_write_item(struct super_block *sb,
 	struct nova_inode_info_header *sih, struct nova_file_write_item *item,
 	u64 epoch_id, u64 pgoff, int num_pages, u64 blocknr, u32 time,
 	u64 file_size);
+unsigned long nova_check_existing_entry(struct super_block *sb,
+	struct inode *inode, unsigned long num_blocks, unsigned long start_blk,
+	struct nova_file_write_entry **ret_entry,
+	int check_next, u64 epoch_id,
+	int *inplace);
 ssize_t nova_inplace_file_write(struct file *filp, const char __user *buf,
 	size_t len, loff_t *ppos);
 ssize_t do_nova_inplace_file_write(struct file *filp, const char __user *buf,
-- 
2.7.4
