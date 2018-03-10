Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCJS3o (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:29:44 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34790 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932741AbeCJSVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:30 -0500
X-Google-Smtp-Source: AG47ELtwkMKN3MjkCwqH0yskJRR+NyRC1uUlgMZgPQFBIIfgR+/gw3Q6FbrE5Fgs+70JJ68m0ScLlg==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 61/83] Super: Add nova_export_ops.
Date: Sat, 10 Mar 2018 10:18:42 -0800
Message-Id: <1520705944-6723-62-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/nova/super.c b/fs/nova/super.c
index daf3270..0847e57 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -51,6 +51,7 @@ module_param(nova_dbgmask, int, 0444);
 MODULE_PARM_DESC(nova_dbgmask, "Control debugging output");
 
 static struct super_operations nova_sops;
+static const struct export_operations nova_export_ops;
 
 static struct kmem_cache *nova_inode_cachep;
 static struct kmem_cache *nova_range_node_cachep;
@@ -631,6 +632,7 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &nova_sops;
 	sb->s_maxbytes = nova_max_size(sb->s_blocksize_bits);
 	sb->s_time_gran = 1000000000; // 1 second.
+	sb->s_export_op = &nova_export_ops;
 	sb->s_xattr = NULL;
 	sb->s_flags |= MS_NOSEC;
 
@@ -904,6 +906,52 @@ static struct file_system_type nova_fs_type = {
 	.kill_sb	= kill_block_super,
 };
 
+static struct inode *nova_nfs_get_inode(struct super_block *sb,
+					 u64 ino, u32 generation)
+{
+	struct inode *inode;
+
+	if (ino < NOVA_ROOT_INO)
+		return ERR_PTR(-ESTALE);
+
+	if (ino > LONG_MAX)
+		return ERR_PTR(-ESTALE);
+
+	inode = nova_iget(sb, ino);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	if (generation && inode->i_generation != generation) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+
+	return inode;
+}
+
+static struct dentry *nova_fh_to_dentry(struct super_block *sb,
+					 struct fid *fid, int fh_len,
+					 int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    nova_nfs_get_inode);
+}
+
+static struct dentry *nova_fh_to_parent(struct super_block *sb,
+					 struct fid *fid, int fh_len,
+					 int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    nova_nfs_get_inode);
+}
+
+static const struct export_operations nova_export_ops = {
+	.fh_to_dentry	= nova_fh_to_dentry,
+	.fh_to_parent	= nova_fh_to_parent,
+	.get_parent	= nova_get_parent,
+};
+
 static int __init init_nova_fs(void)
 {
 	int rc = 0;
-- 
2.7.4
