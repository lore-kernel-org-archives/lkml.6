Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeCJSe6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:34:58 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43697 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeCJSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:05 -0500
X-Google-Smtp-Source: AG47ELvAy2lcCaO2DHvNTYDJ+5/nt8gC6ASxAepRV00iNxxIlQmkPmuNy52O0Z4edDB0U7mcO9YiSQ==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 40/83] Log operation: file write entry append.
Date: Sat, 10 Mar 2018 10:18:21 -0800
Message-Id: <1520705944-6723-41-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA performs writes by appending file write entries to the log.
A file write entry is the metadata of a write operation, and
contains pointers to the data blocks. A single write operation
may append multiple file write entries to the log, if the
allocator cannot provide enough contiguous data blocks.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/log.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/log.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/fs/nova/log.c b/fs/nova/log.c
index 13f9597..437db26 100644
--- a/fs/nova/log.c
+++ b/fs/nova/log.c
@@ -20,6 +20,18 @@
 #include "inode.h"
 #include "log.h"
 
+static int nova_update_write_entry(struct super_block *sb,
+	struct nova_file_write_entry *entry,
+	struct nova_log_entry_info *entry_info)
+{
+	entry->epoch_id = cpu_to_le64(entry_info->epoch_id);
+	entry->trans_id = cpu_to_le64(entry_info->trans_id);
+	entry->mtime = cpu_to_le32(entry_info->time);
+	entry->size = cpu_to_le64(entry_info->file_size);
+	nova_persist_entry(entry);
+	return 0;
+}
+
 static int nova_update_old_dentry(struct super_block *sb,
 	struct inode *dir, struct nova_dentry *dentry,
 	struct nova_log_entry_info *entry_info)
@@ -91,6 +103,11 @@ static int nova_update_log_entry(struct super_block *sb, struct inode *inode,
 
 	switch (type) {
 	case FILE_WRITE:
+		if (entry_info->inplace)
+			nova_update_write_entry(sb, entry, entry_info);
+		else
+			memcpy_to_pmem_nocache(entry, entry_info->data,
+				sizeof(struct nova_file_write_entry));
 		break;
 	case DIR_LOG:
 		if (entry_info->inplace)
@@ -149,6 +166,40 @@ static int nova_append_log_entry(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Append a nova_file_write_entry to the current nova_inode_log_page.
+ * blocknr and start_blk are pgoff.
+ * We cannot update pi->log_tail here because a transaction may contain
+ * multiple entries.
+ */
+int nova_append_file_write_entry(struct super_block *sb, struct nova_inode *pi,
+	struct inode *inode, struct nova_file_write_item *item,
+	struct nova_inode_update *update)
+{
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_file_write_entry *data = &item->entry;
+	struct nova_log_entry_info entry_info;
+	timing_t append_time;
+	int ret;
+
+	NOVA_START_TIMING(append_file_entry_t, append_time);
+
+	entry_info.type = FILE_WRITE;
+	entry_info.update = update;
+	entry_info.data = data;
+	entry_info.epoch_id = data->epoch_id;
+	entry_info.trans_id = data->trans_id;
+	entry_info.inplace = 0;
+
+	ret = nova_append_log_entry(sb, pi, inode, sih, &entry_info);
+	if (ret)
+		nova_err(sb, "%s failed\n", __func__);
+
+	NOVA_END_TIMING(append_file_entry_t, append_time);
+	return ret;
+}
+
 int nova_append_dentry(struct super_block *sb, struct nova_inode *pi,
 	struct inode *dir, struct dentry *dentry, u64 ino,
 	unsigned short de_len, struct nova_inode_update *update,
diff --git a/fs/nova/log.h b/fs/nova/log.h
index 305e69b..db7a72e 100644
--- a/fs/nova/log.h
+++ b/fs/nova/log.h
@@ -364,6 +364,9 @@ static inline int is_dir_init_entry(struct super_block *sb,
 }
 
 
+int nova_append_file_write_entry(struct super_block *sb, struct nova_inode *pi,
+	struct inode *inode, struct nova_file_write_item *item,
+	struct nova_inode_update *update);
 int nova_append_dentry(struct super_block *sb, struct nova_inode *pi,
 	struct inode *dir, struct dentry *dentry, u64 ino,
 	unsigned short de_len, struct nova_inode_update *update,
-- 
2.7.4
