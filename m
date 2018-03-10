Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCJSaJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:30:09 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34788 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeCJSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:29 -0500
X-Google-Smtp-Source: AG47ELuo7KnQkmL/S0ddhWBtO+O3JLYbIMXl9OqQEt1Btzva4qU155JgVhOHBq7aqPfNWtrwQrw6xg==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 60/83] Add special inode operations.
Date: Sat, 10 Mar 2018 10:18:41 -0800
Message-Id: <1520705944-6723-61-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.c | 2 ++
 fs/nova/namei.c | 5 +++++
 fs/nova/nova.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index 2092a55..0e9ab4b 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -239,6 +239,7 @@ static int nova_read_inode(struct super_block *sb, struct inode *inode,
 	case S_IFLNK:
 		break;
 	default:
+		inode->i_op = &nova_special_inode_operations;
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(pi->dev.rdev));
 		break;
@@ -929,6 +930,7 @@ struct inode *nova_new_vfs_inode(enum nova_new_inode_type type,
 		break;
 	case TYPE_MKNOD:
 		init_special_inode(inode, mode, rdev);
+		inode->i_op = &nova_special_inode_operations;
 		break;
 	case TYPE_SYMLINK:
 		inode->i_mapping->a_ops = &nova_aops_dax;
diff --git a/fs/nova/namei.c b/fs/nova/namei.c
index 1966bff..7a81672 100644
--- a/fs/nova/namei.c
+++ b/fs/nova/namei.c
@@ -771,3 +771,8 @@ const struct inode_operations nova_dir_inode_operations = {
 	.setattr	= nova_notify_change,
 	.get_acl	= NULL,
 };
+
+const struct inode_operations nova_special_inode_operations = {
+	.setattr	= nova_notify_change,
+	.get_acl	= NULL,
+};
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 03ea0bd..85292d3 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -486,6 +486,7 @@ int nova_remove_dentry(struct dentry *dentry, int dec_link,
 
 /* namei.c */
 extern const struct inode_operations nova_dir_inode_operations;
+extern const struct inode_operations nova_special_inode_operations;
 extern struct dentry *nova_get_parent(struct dentry *child);
 
 /* rebuild.c */
-- 
2.7.4
