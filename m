Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeCJSeS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:34:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40638 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbeCJSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:08 -0500
X-Google-Smtp-Source: AG47ELtcH8mMf5a0krSJSyq7KUVYYLwFu7Fxa5FoPsbpbrB6j71YYPP+7HeCGwFvabSKPYkJxoCzuw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 43/83] Log operation: in-place update log entry
Date: Sat, 10 Mar 2018 10:18:24 -0800
Message-Id: <1520705944-6723-44-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

To in-place update a log entry, NOVA starts a lite transaction
to journal the log entry, then performs update and commits the transaction.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.h |  12 ++++
 fs/nova/log.c   | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/log.h   |   9 +++
 3 files changed, 204 insertions(+)

diff --git a/fs/nova/inode.h b/fs/nova/inode.h
index 943f77f..6970872 100644
--- a/fs/nova/inode.h
+++ b/fs/nova/inode.h
@@ -5,6 +5,7 @@ struct nova_inode_info_header;
 struct nova_inode;
 
 #include "super.h"
+#include "log.h"
 
 enum nova_new_inode_type {
 	TYPE_CREATE = 0,
@@ -143,6 +144,17 @@ static inline void nova_update_tail(struct nova_inode *pi, u64 new_tail)
 	NOVA_END_TIMING(update_tail_t, update_time);
 }
 
+static inline void nova_update_inode(struct super_block *sb,
+	struct inode *inode, struct nova_inode *pi,
+	struct nova_inode_update *update)
+{
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+
+	sih->log_tail = update->tail;
+	nova_update_tail(pi, update->tail);
+}
+
 static inline
 struct inode_table *nova_get_inode_table(struct super_block *sb, int cpu)
 {
diff --git a/fs/nova/log.c b/fs/nova/log.c
index 4638ccf..c8b7d2e 100644
--- a/fs/nova/log.c
+++ b/fs/nova/log.c
@@ -218,6 +218,35 @@ static int nova_append_log_entry(struct super_block *sb,
 	return 0;
 }
 
+/* Perform lite transaction to atomically in-place update log entry */
+static int nova_inplace_update_log_entry(struct super_block *sb,
+	struct inode *inode, void *entry,
+	struct nova_log_entry_info *entry_info)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	enum nova_entry_type type = entry_info->type;
+	u64 journal_tail;
+	size_t size;
+	int cpu;
+	timing_t update_time;
+
+	NOVA_START_TIMING(update_entry_t, update_time);
+	size = nova_get_log_entry_size(sb, type);
+
+	cpu = smp_processor_id();
+	spin_lock(&sbi->journal_locks[cpu]);
+	journal_tail = nova_create_logentry_transaction(sb, entry, type, cpu);
+	nova_update_log_entry(sb, inode, entry, entry_info);
+
+	PERSISTENT_BARRIER();
+
+	nova_commit_lite_transaction(sb, journal_tail, cpu);
+	spin_unlock(&sbi->journal_locks[cpu]);
+
+	NOVA_END_TIMING(update_entry_t, update_time);
+	return 0;
+}
+
 /* Returns new tail after append */
 static int nova_append_setattr_entry(struct super_block *sb,
 	struct nova_inode *pi, struct inode *inode, struct iattr *attr,
@@ -250,6 +279,125 @@ static int nova_append_setattr_entry(struct super_block *sb,
 	return ret;
 }
 
+static int nova_can_inplace_update_setattr(struct super_block *sb,
+	struct nova_inode_info_header *sih, u64 epoch_id)
+{
+	u64 last_log = 0;
+	struct nova_setattr_logentry *entry = NULL;
+
+	last_log = sih->last_setattr;
+	if (last_log) {
+		entry = (struct nova_setattr_logentry *)nova_get_block(sb,
+								last_log);
+		/* Do not overwrite setsize entry */
+		if (entry->attr & ATTR_SIZE)
+			return 0;
+		if (entry->epoch_id == epoch_id)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int nova_inplace_update_setattr_entry(struct super_block *sb,
+	struct inode *inode, struct nova_inode_info_header *sih,
+	struct iattr *attr, u64 epoch_id)
+{
+	struct nova_setattr_logentry *entry = NULL;
+	struct nova_log_entry_info entry_info;
+	u64 last_log = 0;
+
+	nova_dbgv("%s : Modifying last log entry for inode %lu\n",
+				__func__, inode->i_ino);
+	last_log = sih->last_setattr;
+	entry = (struct nova_setattr_logentry *)nova_get_block(sb,
+							last_log);
+
+	entry_info.type = SET_ATTR;
+	entry_info.attr = attr;
+	entry_info.epoch_id = epoch_id;
+	entry_info.trans_id = sih->trans_id;
+
+	return nova_inplace_update_log_entry(sb, inode, entry,
+					&entry_info);
+}
+
+int nova_handle_setattr_operation(struct super_block *sb, struct inode *inode,
+	struct nova_inode *pi, unsigned int ia_valid, struct iattr *attr,
+	u64 epoch_id)
+{
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_inode_update update;
+	u64 last_setattr = 0;
+	int ret;
+
+	if (ia_valid & ATTR_MODE)
+		sih->i_mode = inode->i_mode;
+
+	/*
+	 * Let's try to do inplace update.
+	 */
+	if (!(ia_valid & ATTR_SIZE) &&
+			nova_can_inplace_update_setattr(sb, sih, epoch_id)) {
+		nova_inplace_update_setattr_entry(sb, inode, sih,
+						attr, epoch_id);
+	} else {
+		/* We are holding inode lock so OK to append the log */
+		nova_dbgv("%s : Appending last log entry for inode ino = %lu\n",
+				__func__, inode->i_ino);
+		update.tail = 0;
+		ret = nova_append_setattr_entry(sb, pi, inode, attr, &update,
+						&last_setattr, epoch_id);
+		if (ret) {
+			nova_dbg("%s: append setattr entry failure\n",
+								__func__);
+			return ret;
+		}
+
+		nova_update_inode(sb, inode, pi, &update);
+	}
+
+	return 0;
+}
+
+static int nova_can_inplace_update_lcentry(struct super_block *sb,
+	struct nova_inode_info_header *sih, u64 epoch_id)
+{
+	u64 last_log = 0;
+	struct nova_link_change_entry *entry = NULL;
+
+	last_log = sih->last_link_change;
+	if (last_log) {
+		entry = (struct nova_link_change_entry *)nova_get_block(sb,
+								last_log);
+		if (entry->epoch_id == epoch_id)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int nova_inplace_update_lcentry(struct super_block *sb,
+	struct inode *inode, struct nova_inode_info_header *sih,
+	u64 epoch_id)
+{
+	struct nova_link_change_entry *entry = NULL;
+	struct nova_log_entry_info entry_info;
+	u64 last_log = 0;
+
+	last_log = sih->last_link_change;
+	entry = (struct nova_link_change_entry *)nova_get_block(sb,
+							last_log);
+
+	entry_info.type = LINK_CHANGE;
+	entry_info.epoch_id = epoch_id;
+	entry_info.trans_id = sih->trans_id;
+
+	return nova_inplace_update_log_entry(sb, inode, entry,
+					&entry_info);
+}
+
 /* Returns new tail after append */
 int nova_append_link_change_entry(struct super_block *sb,
 	struct nova_inode *pi, struct inode *inode,
@@ -263,6 +411,15 @@ int nova_append_link_change_entry(struct super_block *sb,
 
 	NOVA_START_TIMING(append_link_change_t, append_time);
 
+	if (nova_can_inplace_update_lcentry(sb, sih, epoch_id)) {
+		nova_inplace_update_lcentry(sb, inode, sih, epoch_id);
+		update->tail = sih->log_tail;
+
+		*old_linkc = 0;
+		sih->trans_id++;
+		goto out;
+	}
+
 	entry_info.type = LINK_CHANGE;
 	entry_info.update = update;
 	entry_info.epoch_id = epoch_id;
@@ -282,6 +439,14 @@ int nova_append_link_change_entry(struct super_block *sb,
 	return ret;
 }
 
+int nova_inplace_update_write_entry(struct super_block *sb,
+	struct inode *inode, struct nova_file_write_entry *entry,
+	struct nova_log_entry_info *entry_info)
+{
+	return nova_inplace_update_log_entry(sb, inode, entry,
+					entry_info);
+}
+
 /*
  * Append a nova_file_write_entry to the current nova_inode_log_page.
  * blocknr and start_blk are pgoff.
@@ -316,6 +481,24 @@ int nova_append_file_write_entry(struct super_block *sb, struct nova_inode *pi,
 	return ret;
 }
 
+int nova_inplace_update_dentry(struct super_block *sb,
+	struct inode *dir, struct nova_dentry *dentry, int link_change,
+	u64 epoch_id)
+{
+	struct nova_inode_info *si = NOVA_I(dir);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_log_entry_info entry_info;
+
+	entry_info.type = DIR_LOG;
+	entry_info.link_change = link_change;
+	entry_info.epoch_id = epoch_id;
+	entry_info.trans_id = sih->trans_id;
+	entry_info.inplace = 1;
+
+	return nova_inplace_update_log_entry(sb, dir, dentry,
+					&entry_info);
+}
+
 int nova_append_dentry(struct super_block *sb, struct nova_inode *pi,
 	struct inode *dir, struct dentry *dentry, u64 ino,
 	unsigned short de_len, struct nova_inode_update *update,
diff --git a/fs/nova/log.h b/fs/nova/log.h
index f36f4a3..74891b3 100644
--- a/fs/nova/log.h
+++ b/fs/nova/log.h
@@ -364,12 +364,21 @@ static inline int is_dir_init_entry(struct super_block *sb,
 }
 
 
+int nova_handle_setattr_operation(struct super_block *sb, struct inode *inode,
+	struct nova_inode *pi, unsigned int ia_valid, struct iattr *attr,
+	u64 epoch_id);
 int nova_append_link_change_entry(struct super_block *sb,
 	struct nova_inode *pi, struct inode *inode,
 	struct nova_inode_update *update, u64 *old_linkc, u64 epoch_id);
+int nova_inplace_update_write_entry(struct super_block *sb,
+	struct inode *inode, struct nova_file_write_entry *entry,
+	struct nova_log_entry_info *entry_info);
 int nova_append_file_write_entry(struct super_block *sb, struct nova_inode *pi,
 	struct inode *inode, struct nova_file_write_item *item,
 	struct nova_inode_update *update);
+int nova_inplace_update_dentry(struct super_block *sb,
+	struct inode *dir, struct nova_dentry *dentry, int link_change,
+	u64 epoch_id);
 int nova_append_dentry(struct super_block *sb, struct nova_inode *pi,
 	struct inode *dir, struct dentry *dentry, u64 ino,
 	unsigned short de_len, struct nova_inode_update *update,
-- 
2.7.4
