Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeCJSVT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:19 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46194 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932632AbeCJSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:14 -0500
X-Google-Smtp-Source: AG47ELuWTgubcgt8uWXrFzih1YuRqWtmuRH/fjIfVjCk0ySjUULGsJLL/Flu2xtAiBcU9AfSWVNwlg==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 48/83] Dir: Readdir operation.
Date: Sat, 10 Mar 2018 10:18:29 -0800
Message-Id: <1520705944-6723-49-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA reads the directory by traversing the log and reports
the valid dentries. Valid dentris have inode number greater than zero,
meaning it's a create dentry.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/dir.c   | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/inode.c |   2 +
 fs/nova/nova.h  |   1 +
 3 files changed, 156 insertions(+)

diff --git a/fs/nova/dir.c b/fs/nova/dir.c
index 377d2da..35a66f9 100644
--- a/fs/nova/dir.c
+++ b/fs/nova/dir.c
@@ -221,3 +221,156 @@ int nova_append_dir_init_entries(struct super_block *sb,
 
 	return 0;
 }
+
+static u64 nova_find_next_dentry_addr(struct super_block *sb,
+	struct nova_inode_info_header *sih, u64 pos)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct nova_file_write_entry *entry = NULL;
+	struct nova_file_write_entry *entries[1];
+	int nr_entries;
+	u64 addr = 0;
+
+	nr_entries = radix_tree_gang_lookup(&sih->tree,
+					(void **)entries, pos, 1);
+	if (nr_entries == 1) {
+		entry = entries[0];
+		addr = nova_get_addr_off(sbi, entry);
+	}
+
+	return addr;
+}
+
+static int nova_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct nova_inode *pidir;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_inode *child_pi;
+	struct nova_inode *prev_child_pi = NULL;
+	struct nova_dentry *entry = NULL;
+	struct nova_dentry *prev_entry = NULL;
+	unsigned short de_len;
+	u64 pi_addr;
+	unsigned long pos = 0;
+	ino_t ino;
+	void *addr;
+	u64 curr_p;
+	u8 type;
+	int ret = 0;
+	timing_t readdir_time;
+
+	NOVA_START_TIMING(readdir_t, readdir_time);
+	pidir = nova_get_inode(sb, inode);
+	nova_dbgv("%s: ino %llu, size %llu, pos 0x%llx\n",
+			__func__, (u64)inode->i_ino,
+			pidir->i_size, ctx->pos);
+
+	if (sih->log_head == 0) {
+		nova_err(sb, "Dir %lu log is NULL!\n", inode->i_ino);
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	pos = ctx->pos;
+
+	if (pos == 0)
+		curr_p = sih->log_head;
+	else if (pos == READDIR_END)
+		goto out;
+	else {
+		curr_p = nova_find_next_dentry_addr(sb, sih, pos);
+		if (curr_p == 0)
+			goto out;
+	}
+
+	while (curr_p != sih->log_tail) {
+		if (goto_next_page(sb, curr_p))
+			curr_p = next_log_page(sb, curr_p);
+
+
+		if (curr_p == 0) {
+			nova_err(sb, "Dir %lu log is NULL!\n", inode->i_ino);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = (void *)nova_get_block(sb, curr_p);
+		type = nova_get_entry_type(addr);
+		switch (type) {
+		case SET_ATTR:
+			curr_p += sizeof(struct nova_setattr_logentry);
+			continue;
+		case LINK_CHANGE:
+			curr_p += sizeof(struct nova_link_change_entry);
+			continue;
+		case DIR_LOG:
+			break;
+		default:
+			nova_err(sb, "%s: unknown type %d, 0x%llx\n",
+				 __func__, type, curr_p);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		entry = (struct nova_dentry *)nova_get_block(sb, curr_p);
+		nova_dbgv("curr_p: 0x%llx, type %d, ino %llu, name %s, namelen %u, rec len %u\n",
+			  curr_p, entry->entry_type, le64_to_cpu(entry->ino),
+			  entry->name, entry->name_len,
+			  le16_to_cpu(entry->de_len));
+
+		de_len = le16_to_cpu(entry->de_len);
+		if (entry->ino > 0 && entry->invalid == 0
+					&& entry->reassigned == 0) {
+			ino = __le64_to_cpu(entry->ino);
+			pos = BKDRHash(entry->name, entry->name_len);
+
+			ret = nova_get_inode_address(sb, ino,
+						     &pi_addr, 0);
+			if (ret) {
+				nova_dbg("%s: get child inode %lu address failed %d\n",
+					 __func__, ino, ret);
+				ctx->pos = READDIR_END;
+				goto out;
+			}
+
+			child_pi = nova_get_block(sb, pi_addr);
+			nova_dbgv("ctx: ino %llu, name %s, name_len %u, de_len %u\n",
+				(u64)ino, entry->name, entry->name_len,
+				entry->de_len);
+			if (prev_entry && !dir_emit(ctx, prev_entry->name,
+				prev_entry->name_len, ino,
+				IF2DT(le16_to_cpu(prev_child_pi->i_mode)))) {
+				nova_dbgv("Here: pos %llu\n", ctx->pos);
+				ret = 0;
+				goto out;
+			}
+			prev_entry = entry;
+
+			prev_child_pi = child_pi;
+		}
+		ctx->pos = pos;
+		curr_p += de_len;
+	}
+
+	if (prev_entry && !dir_emit(ctx, prev_entry->name,
+			prev_entry->name_len, ino,
+			IF2DT(le16_to_cpu(prev_child_pi->i_mode))))
+		return 0;
+
+	ctx->pos = READDIR_END;
+	ret = 0;
+out:
+	NOVA_END_TIMING(readdir_t, readdir_time);
+	nova_dbgv("%s return\n", __func__);
+	return ret;
+}
+
+const struct file_operations nova_dir_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate	= nova_readdir,
+	.fsync		= noop_fsync,
+};
diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index 15517cc..41417e3 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -181,6 +181,7 @@ static int nova_read_inode(struct super_block *sb, struct inode *inode,
 	case S_IFREG:
 		break;
 	case S_IFDIR:
+		inode->i_fop = &nova_dir_operations;
 		break;
 	case S_IFLNK:
 		break;
@@ -625,6 +626,7 @@ struct inode *nova_new_vfs_inode(enum nova_new_inode_type type,
 		inode->i_mapping->a_ops = &nova_aops_dax;
 		break;
 	case TYPE_MKDIR:
+		inode->i_fop = &nova_dir_operations;
 		inode->i_mapping->a_ops = &nova_aops_dax;
 		set_nlink(inode, 2);
 		break;
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index a94f44d..ed269fe 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -447,6 +447,7 @@ nova_get_blocknr(struct super_block *sb, u64 block, unsigned short btype)
 /* ====================================================== */
 
 /* dir.c */
+extern const struct file_operations nova_dir_operations;
 int nova_insert_dir_radix_tree(struct super_block *sb,
 	struct nova_inode_info_header *sih, const char *name,
 	int namelen, struct nova_dentry *direntry);
-- 
2.7.4
