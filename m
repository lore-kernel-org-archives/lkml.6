Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEACCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E16920894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E16920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390068AbeHARMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:12:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389690AbeHARMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:12:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4C4887A70;
        Wed,  1 Aug 2018 15:26:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204B01C65F;
        Wed,  1 Aug 2018 15:26:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/33] ipc: Convert mqueue fs to fs_context [ver #11]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 16:26:08 +0100
Message-ID: <153313716865.13253.15735862568991586241.stgit@warthog.procyon.org.uk>
In-Reply-To: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 01 Aug 2018 15:26:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 01 Aug 2018 15:26:09 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mqueue filesystem to use the filesystem context stuff.

Notes:

 (1) The relevant ipc namespace is selected in when the context is
     initialised (and it defaults to the current task's ipc namespace).
     The caller can override this before calling vfs_get_tree().

 (2) Rather than simply calling kern_mount_data(), mq_init_ns() and
     mq_internal_mount() create a context, adjust it and then do the rest
     of the mount procedure.

 (3) The lazy mqueue mounting on creation of a new namespace is retained
     from a previous patch, but the avoidance of sget() if no superblock
     yet exists is reverted and the superblock is again keyed on the
     namespace pointer.

     Yes, there was a performance gain in not searching the superblock
     hash, but it's only paid once per ipc namespace - and only if someone
     uses mqueue within that namespace, so I'm not sure it's worth it,
     especially as calling sget() allows avoidance of recursion.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 ipc/mqueue.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 22 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4671d215cb84..0f102210f89e 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -18,6 +18,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/sysctl.h>
 #include <linux/poll.h>
@@ -42,6 +43,10 @@
 #include <net/sock.h>
 #include "util.h"
 
+struct mqueue_fs_context {
+	struct ipc_namespace	*ipc_ns;
+};
+
 #define MQUEUE_MAGIC	0x19800202
 #define DIRENT_SIZE	20
 #define FILENT_SIZE	80
@@ -87,9 +92,11 @@ struct mqueue_inode_info {
 	unsigned long qsize; /* size of queue in memory (sum of all msgs) */
 };
 
+static struct file_system_type mqueue_fs_type;
 static const struct inode_operations mqueue_dir_inode_operations;
 static const struct file_operations mqueue_file_operations;
 static const struct super_operations mqueue_super_ops;
+static const struct fs_context_operations mqueue_fs_context_ops;
 static void remove_notification(struct mqueue_inode_info *info);
 
 static struct kmem_cache *mqueue_inode_cachep;
@@ -322,7 +329,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
-static int mqueue_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
+static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
 	struct ipc_namespace *ns = sb->s_fs_info;
@@ -343,19 +350,84 @@ static int mqueue_fill_super(struct super_block *sb, void *data, size_t data_siz
 	return 0;
 }
 
-static struct dentry *mqueue_mount(struct file_system_type *fs_type,
-			 int flags, const char *dev_name,
-			 void *data, size_t data_size)
+static int mqueue_get_tree(struct fs_context *fc)
 {
-	struct ipc_namespace *ns;
-	if (flags & SB_KERNMOUNT) {
-		ns = data;
-		data = NULL;
-	} else {
-		ns = current->nsproxy->ipc_ns;
+	struct mqueue_fs_context *ctx = fc->fs_private;
+
+	/* As a shortcut, if the namespace already has a superblock created,
+	 * use the root from that directly rather than invoking sget() again.
+	 */
+	spin_lock(&mq_lock);
+	if (ctx->ipc_ns->mq_mnt) {
+		fc->root = dget(ctx->ipc_ns->mq_mnt->mnt_sb->s_root);
+		atomic_inc(&fc->root->d_sb->s_active);
 	}
-	return mount_ns(fs_type, flags, data, data_size, ns, ns->user_ns,
-			mqueue_fill_super);
+	spin_unlock(&mq_lock);
+	if (fc->root) {
+		down_write(&fc->root->d_sb->s_umount);
+		return 0;
+	}
+
+	fc->s_fs_info = ctx->ipc_ns;
+	return vfs_get_super(fc, vfs_get_keyed_super, mqueue_fill_super);
+}
+
+static void mqueue_fs_context_free(struct fs_context *fc)
+{
+	struct mqueue_fs_context *ctx = fc->fs_private;
+
+	if (ctx->ipc_ns)
+		put_ipc_ns(ctx->ipc_ns);
+	kfree(ctx);
+}
+
+static int mqueue_init_fs_context(struct fs_context *fc,
+				  struct dentry *reference)
+{
+	struct mqueue_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct mqueue_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
+	fc->fs_private = ctx;
+	fc->ops = &mqueue_fs_context_ops;
+	return 0;
+}
+
+static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
+{
+	struct mqueue_fs_context *ctx;
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+	int ret;
+
+	fc = vfs_new_fs_context(&mqueue_fs_type, NULL, 0,
+				FS_CONTEXT_FOR_KERNEL_MOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ctx = fc->fs_private;
+	put_ipc_ns(ctx->ipc_ns);
+	ctx->ipc_ns = get_ipc_ns(ns);
+
+	ret = vfs_get_tree(fc);
+	if (ret < 0)
+		goto err_fc;
+
+	mnt = vfs_create_mount(fc, 0);
+	if (IS_ERR(mnt)) {
+		ret = PTR_ERR(mnt);
+		goto err_fc;
+	}
+
+	put_fs_context(fc);
+	return mnt;
+
+err_fc:
+	put_fs_context(fc);
+	return ERR_PTR(ret);
 }
 
 static void init_once(void *foo)
@@ -1523,15 +1595,22 @@ static const struct super_operations mqueue_super_ops = {
 	.statfs = simple_statfs,
 };
 
+static const struct fs_context_operations mqueue_fs_context_ops = {
+	.free		= mqueue_fs_context_free,
+	.get_tree	= mqueue_get_tree,
+};
+
 static struct file_system_type mqueue_fs_type = {
-	.name = "mqueue",
-	.mount = mqueue_mount,
-	.kill_sb = kill_litter_super,
-	.fs_flags = FS_USERNS_MOUNT,
+	.name			= "mqueue",
+	.init_fs_context	= mqueue_init_fs_context,
+	.kill_sb		= kill_litter_super,
+	.fs_flags		= FS_USERNS_MOUNT,
 };
 
 int mq_init_ns(struct ipc_namespace *ns)
 {
+	struct vfsmount *m;
+
 	ns->mq_queues_count  = 0;
 	ns->mq_queues_max    = DFLT_QUEUESMAX;
 	ns->mq_msg_max       = DFLT_MSGMAX;
@@ -1539,12 +1618,10 @@ int mq_init_ns(struct ipc_namespace *ns)
 	ns->mq_msg_default   = DFLT_MSG;
 	ns->mq_msgsize_default  = DFLT_MSGSIZE;
 
-	ns->mq_mnt = kern_mount_data(&mqueue_fs_type, ns, 0);
-	if (IS_ERR(ns->mq_mnt)) {
-		int err = PTR_ERR(ns->mq_mnt);
-		ns->mq_mnt = NULL;
-		return err;
-	}
+	m = mq_create_mount(&init_ipc_ns);
+	if (IS_ERR(m))
+		return PTR_ERR(m);
+	ns->mq_mnt = m;
 	return 0;
 }
 

