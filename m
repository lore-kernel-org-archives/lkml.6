Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbeCJSVb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36896 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeCJSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:21 -0500
X-Google-Smtp-Source: AG47ELuEK4FCTohSroXD45zNjuE086Yg212QxXSq7M/aM4/FUm3xL9fAdCicFgAWsM9Tmun9Gypu2A==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 54/83] Namei: create and mknod.
Date: Sat, 10 Mar 2018 10:18:35 -0800
Message-Id: <1520705944-6723-55-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA allocates and initializes a new inode, and appends a dentry
to the directory's log. Then NOVA creates a transaction to
commit both changes atomically: update the directory log tail
pointer and validate the new inode.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/namei.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/fs/nova/namei.c b/fs/nova/namei.c
index 8076f5b..a07cc4f 100644
--- a/fs/nova/namei.c
+++ b/fs/nova/namei.c
@@ -68,6 +68,145 @@ static struct dentry *nova_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
+static void nova_lite_transaction_for_new_inode(struct super_block *sb,
+	struct nova_inode *pi, struct nova_inode *pidir, struct inode *inode,
+	struct inode *dir, struct nova_inode_update *update)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	int cpu;
+	u64 journal_tail;
+	timing_t trans_time;
+
+	NOVA_START_TIMING(create_trans_t, trans_time);
+
+	cpu = smp_processor_id();
+	spin_lock(&sbi->journal_locks[cpu]);
+
+	// If you change what's required to create a new inode, you need to
+	// update this functions so the changes will be roll back on failure.
+	journal_tail = nova_create_inode_transaction(sb, inode, dir, cpu, 1, 0);
+
+	nova_update_inode(sb, dir, pidir, update);
+
+	pi->valid = 1;
+	nova_persist_inode(pi);
+	PERSISTENT_BARRIER();
+
+	nova_commit_lite_transaction(sb, journal_tail, cpu);
+	spin_unlock(&sbi->journal_locks[cpu]);
+
+	NOVA_END_TIMING(create_trans_t, trans_time);
+}
+
+/* Returns new tail after append */
+/*
+ * By the time this is called, we already have created
+ * the directory cache entry for the new file, but it
+ * is so far negative - it has no inode.
+ *
+ * If the create succeeds, we fill in the inode information
+ * with d_instantiate().
+ */
+static int nova_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+			bool excl)
+{
+	struct inode *inode = NULL;
+	int err = PTR_ERR(inode);
+	struct super_block *sb = dir->i_sb;
+	struct nova_inode *pidir, *pi;
+	struct nova_inode_update update;
+	u64 pi_addr = 0;
+	u64 ino, epoch_id;
+	timing_t create_time;
+
+	NOVA_START_TIMING(create_t, create_time);
+
+	pidir = nova_get_inode(sb, dir);
+	if (!pidir)
+		goto out_err;
+
+	epoch_id = nova_get_epoch_id(sb);
+	ino = nova_new_nova_inode(sb, &pi_addr);
+	if (ino == 0)
+		goto out_err;
+
+	update.tail = 0;
+	err = nova_add_dentry(dentry, ino, 0, &update, epoch_id);
+	if (err)
+		goto out_err;
+
+	nova_dbgv("%s: %s\n", __func__, dentry->d_name.name);
+	nova_dbgv("%s: inode %llu, dir %lu\n", __func__, ino, dir->i_ino);
+	inode = nova_new_vfs_inode(TYPE_CREATE, dir, pi_addr, ino, mode,
+					0, 0, &dentry->d_name, epoch_id);
+	if (IS_ERR(inode))
+		goto out_err;
+
+	d_instantiate(dentry, inode);
+	unlock_new_inode(inode);
+
+	pi = nova_get_block(sb, pi_addr);
+	nova_lite_transaction_for_new_inode(sb, pi, pidir, inode, dir,
+						&update);
+	NOVA_END_TIMING(create_t, create_time);
+	return err;
+out_err:
+	nova_err(sb, "%s return %d\n", __func__, err);
+	NOVA_END_TIMING(create_t, create_time);
+	return err;
+}
+
+static int nova_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
+		       dev_t rdev)
+{
+	struct inode *inode = NULL;
+	int err = PTR_ERR(inode);
+	struct super_block *sb = dir->i_sb;
+	u64 pi_addr = 0;
+	struct nova_inode *pidir, *pi;
+	struct nova_inode_update update;
+	u64 ino;
+	u64 epoch_id;
+	timing_t mknod_time;
+
+	NOVA_START_TIMING(mknod_t, mknod_time);
+
+	pidir = nova_get_inode(sb, dir);
+	if (!pidir)
+		goto out_err;
+
+	epoch_id = nova_get_epoch_id(sb);
+	ino = nova_new_nova_inode(sb, &pi_addr);
+	if (ino == 0)
+		goto out_err;
+
+	nova_dbgv("%s: %s\n", __func__, dentry->d_name.name);
+	nova_dbgv("%s: inode %llu, dir %lu\n", __func__, ino, dir->i_ino);
+
+	update.tail = 0;
+	err = nova_add_dentry(dentry, ino, 0, &update, epoch_id);
+	if (err)
+		goto out_err;
+
+	inode = nova_new_vfs_inode(TYPE_MKNOD, dir, pi_addr, ino, mode,
+					0, rdev, &dentry->d_name, epoch_id);
+	if (IS_ERR(inode))
+		goto out_err;
+
+	d_instantiate(dentry, inode);
+	unlock_new_inode(inode);
+
+	pi = nova_get_block(sb, pi_addr);
+	nova_lite_transaction_for_new_inode(sb, pi, pidir, inode, dir,
+						&update);
+	NOVA_END_TIMING(mknod_t, mknod_time);
+	return err;
+out_err:
+	nova_err(sb, "%s return %d\n", __func__, err);
+	NOVA_END_TIMING(mknod_t, mknod_time);
+	return err;
+}
+
 struct dentry *nova_get_parent(struct dentry *child)
 {
 	struct inode *inode;
@@ -93,5 +232,7 @@ struct dentry *nova_get_parent(struct dentry *child)
 }
 
 const struct inode_operations nova_dir_inode_operations = {
+	.create		= nova_create,
 	.lookup		= nova_lookup,
+	.mknod		= nova_mknod,
 };
-- 
2.7.4
