Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeCJSdO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:33:14 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45301 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeCJSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:13 -0500
X-Google-Smtp-Source: AG47ELvzbtaIoV7CjFuiddHq6NcbUD1RntixR4/hI433Y7CMYtWZfmXWW1EBRjzGm8IM5Z15tjJymA==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 47/83] Dir: Add initial dentries when initializing a directory inode log.
Date: Sat, 10 Mar 2018 10:18:28 -0800
Message-Id: <1520705944-6723-48-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

For root directory and newly created directory via mkdir(),
we append . and .. dentries to the directory inode log.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/dir.c   | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/nova.h  |  2 ++
 fs/nova/super.c |  5 ++++
 3 files changed, 89 insertions(+)

diff --git a/fs/nova/dir.c b/fs/nova/dir.c
index 5bea57a..377d2da 100644
--- a/fs/nova/dir.c
+++ b/fs/nova/dir.c
@@ -139,3 +139,85 @@ void nova_delete_dir_tree(struct super_block *sb,
 
 	NOVA_END_TIMING(delete_dir_tree_t, delete_time);
 }
+
+/* ========================= Entry operations ============================= */
+
+static unsigned int nova_init_dentry(struct super_block *sb,
+	struct nova_dentry *de_entry, u64 self_ino, u64 parent_ino,
+	u64 epoch_id)
+{
+	void *start = de_entry;
+	struct nova_inode_log_page *curr_page = start;
+	unsigned int length;
+	unsigned short de_len;
+
+	de_len = NOVA_DIR_LOG_REC_LEN(1);
+	memset(de_entry, 0, de_len);
+	de_entry->entry_type = DIR_LOG;
+	de_entry->epoch_id = epoch_id;
+	de_entry->trans_id = 0;
+	de_entry->ino = cpu_to_le64(self_ino);
+	de_entry->name_len = 1;
+	de_entry->de_len = cpu_to_le16(de_len);
+	de_entry->mtime = timespec_trunc(current_kernel_time(),
+					 sb->s_time_gran).tv_sec;
+
+	de_entry->links_count = 1;
+	strncpy(de_entry->name, ".\0", 2);
+	nova_persist_entry(de_entry);
+
+	length = de_len;
+
+	de_entry = (struct nova_dentry *)((char *)de_entry + length);
+	de_len = NOVA_DIR_LOG_REC_LEN(2);
+	memset(de_entry, 0, de_len);
+	de_entry->entry_type = DIR_LOG;
+	de_entry->epoch_id = epoch_id;
+	de_entry->trans_id = 0;
+	de_entry->ino = cpu_to_le64(parent_ino);
+	de_entry->name_len = 2;
+	de_entry->de_len = cpu_to_le16(de_len);
+	de_entry->mtime = timespec_trunc(current_kernel_time(),
+					 sb->s_time_gran).tv_sec;
+
+	de_entry->links_count = 2;
+	strncpy(de_entry->name, "..\0", 3);
+	nova_persist_entry(de_entry);
+	length += de_len;
+
+	nova_set_page_num_entries(sb, curr_page, 2, 1);
+
+	nova_flush_buffer(start, length, 0);
+	return length;
+}
+
+/* Append . and .. entries */
+int nova_append_dir_init_entries(struct super_block *sb,
+	struct nova_inode *pi, u64 self_ino, u64 parent_ino, u64 epoch_id)
+{
+	struct nova_inode_info_header sih;
+	int allocated;
+	u64 new_block;
+	unsigned int length;
+	struct nova_dentry *de_entry;
+
+	sih.ino = self_ino;
+	sih.i_blk_type = NOVA_DEFAULT_BLOCK_TYPE;
+
+	allocated = nova_allocate_inode_log_pages(sb, &sih, 1, &new_block,
+							ANY_CPU, 0);
+	if (allocated != 1) {
+		nova_err(sb, "ERROR: no inode log page available\n");
+		return -ENOMEM;
+	}
+
+	pi->log_tail = pi->log_head = new_block;
+
+	de_entry = (struct nova_dentry *)nova_get_block(sb, new_block);
+
+	length = nova_init_dentry(sb, de_entry, self_ino, parent_ino, epoch_id);
+
+	nova_update_tail(pi, new_block + length);
+
+	return 0;
+}
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 3890479..a94f44d 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -458,6 +458,8 @@ void nova_delete_dir_tree(struct super_block *sb,
 struct nova_dentry *nova_find_dentry(struct super_block *sb,
 	struct nova_inode *pi, struct inode *inode, const char *name,
 	unsigned long name_len);
+int nova_append_dir_init_entries(struct super_block *sb,
+	struct nova_inode *pi, u64 self_ino, u64 parent_ino, u64 epoch_id);
 
 /* rebuild.c */
 int nova_rebuild_inode(struct super_block *sb, struct nova_inode_info *si,
diff --git a/fs/nova/super.c b/fs/nova/super.c
index 216d396..1e67062 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -349,6 +349,7 @@ static struct nova_inode *nova_init(struct super_block *sb,
 	struct nova_inode *root_i, *pi;
 	struct nova_super_block *super;
 	struct nova_sb_info *sbi = NOVA_SB(sb);
+	u64 epoch_id;
 	timing_t init_time;
 
 	NOVA_START_TIMING(new_init_t, init_time);
@@ -415,6 +416,10 @@ static struct nova_inode *nova_init(struct super_block *sb,
 
 	nova_flush_buffer(root_i, sizeof(*root_i), false);
 
+	epoch_id = nova_get_epoch_id(sb);
+	nova_append_dir_init_entries(sb, root_i, NOVA_ROOT_INO,
+					NOVA_ROOT_INO, epoch_id);
+
 	PERSISTENT_MARK();
 	PERSISTENT_BARRIER();
 	nova_info("NOVA initialization finish\n");
-- 
2.7.4
