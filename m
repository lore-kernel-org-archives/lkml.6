Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0378EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A797F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeHUNO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeHUNOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98DFB40216FA;
        Tue, 21 Aug 2018 09:55:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC4DF2157F49;
        Tue, 21 Aug 2018 09:55:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/6] vfs: Pass path info fsinfo and rename get_fsinfo sb op
 to fsinfo
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:55:24 +0100
Message-ID: <153484532442.1183.7584783993663542714.stgit@warthog.procyon.org.uk>
In-Reply-To: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
References: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 21 Aug 2018 09:55:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 21 Aug 2018 09:55:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the path, not just the dentry, into the superblock get_fsinfo
operation because s->s_root isn't useful on NFS for retrocalculating the
source name, but rather mnt->mnt_root must be used.

Further, rename the ->get_fsinfo() superblock op to ->fsinfo() for
consistency.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c         |    9 +++++----
 fs/hugetlbfs/inode.c   |    7 ++++---
 fs/kernfs/mount.c      |    8 ++++----
 fs/statfs.c            |   15 ++++++++-------
 include/linux/fs.h     |    4 ++--
 include/linux/fsinfo.h |    2 +-
 6 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 15c5eb9412bb..0afff582eb99 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -35,7 +35,7 @@ static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf);
-static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params);
+static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params);
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
 static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference);
@@ -55,7 +55,7 @@ int afs_net_id;
 
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
-	.get_fsinfo	= afs_get_fsinfo,
+	.fsinfo		= afs_fsinfo,
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
@@ -778,12 +778,13 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 /*
  * Get filesystem information.
  */
-static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
 	struct fsinfo_timestamp_info *tsinfo;
 	struct fsinfo_server_address *addr;
 	struct fsinfo_capabilities *caps;
 	struct fsinfo_supports *sup;
+	struct dentry *dentry = path->dentry;
 	struct afs_server_list *slist;
 	struct afs_super_info *as = AFS_FS_S(dentry->d_sb);
 	struct afs_addr_list *alist;
@@ -923,7 +924,7 @@ static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 		}
 
 	default:
-		return generic_fsinfo(dentry, params);
+		return generic_fsinfo(path, params);
 	}
 
 string:
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e2378c8ce7e0..e4f7619e9541 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -949,8 +949,9 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static int hugetlbfs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+static int hugetlbfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
+	struct dentry *dentry = path->dentry;
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
 	struct hugepage_subpool *spool = sbinfo->spool;
 	unsigned long hpage_size = huge_page_size(sbinfo->hstate);
@@ -1008,7 +1009,7 @@ static int hugetlbfs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *pa
 			return -ENODATA;
 		}
 	default:
-		return generic_fsinfo(dentry, params);
+		return generic_fsinfo(path, params);
 	}
 }
 
@@ -1171,7 +1172,7 @@ static const struct super_operations hugetlbfs_ops = {
 	.statfs		= hugetlbfs_statfs,
 	.put_super	= hugetlbfs_put_super,
 	.show_options	= hugetlbfs_show_options,
-	.get_fsinfo	= hugetlbfs_get_fsinfo,
+	.fsinfo		= hugetlbfs_fsinfo,
 };
 
 /*
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index b568e6c5e063..6194ad7a817c 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -56,9 +56,9 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
 	return 0;
 }
 
-static int kernfs_sop_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+static int kernfs_sop_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
-	struct kernfs_root *root = kernfs_root(kernfs_dentry_node(dentry));
+	struct kernfs_root *root = kernfs_root(kernfs_dentry_node(path->dentry));
 	struct kernfs_syscall_ops *scops = root->syscall_ops;
 	int ret;
 
@@ -67,7 +67,7 @@ static int kernfs_sop_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *p
 		if (ret != -EAGAIN)
 			return ret;
 	}
-	return generic_fsinfo(dentry, params);
+	return generic_fsinfo(path, params);
 }
 
 const struct super_operations kernfs_sops = {
@@ -78,7 +78,7 @@ const struct super_operations kernfs_sops = {
 	.reconfigure	= kernfs_sop_reconfigure,
 	.show_options	= kernfs_sop_show_options,
 	.show_path	= kernfs_sop_show_path,
-	.get_fsinfo	= kernfs_sop_get_fsinfo,
+	.fsinfo		= kernfs_sop_fsinfo,
 };
 
 /*
diff --git a/fs/statfs.c b/fs/statfs.c
index 6bb95808ee66..95fdfd9a79d1 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -627,8 +627,9 @@ static int fsinfo_generic_param_enum(struct file_system_type *f,
 /*
  * Implement some queries generically from stuff in the superblock.
  */
-int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
+	struct dentry *dentry = path->dentry;
 	struct file_system_type *f = dentry->d_sb->s_type;
 	
 #define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(dentry, params->buffer)
@@ -659,10 +660,10 @@ EXPORT_SYMBOL(generic_fsinfo);
  * Retrieve the filesystem info.  We make some stuff up if the operation is not
  * supported.
  */
-int vfs_fsinfo(const struct path *path, struct fsinfo_kparams *params)
+int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
 	struct dentry *dentry = path->dentry;
-	int (*get_fsinfo)(struct dentry *, struct fsinfo_kparams *);
+	int (*fsinfo)(struct path *, struct fsinfo_kparams *);
 	int ret;
 
 	if (params->request == FSINFO_ATTR_FSINFO) {
@@ -673,18 +674,18 @@ int vfs_fsinfo(const struct path *path, struct fsinfo_kparams *params)
 		return sizeof(*info);
 	}
 
-	get_fsinfo = dentry->d_sb->s_op->get_fsinfo;
-	if (!get_fsinfo) {
+	fsinfo = dentry->d_sb->s_op->fsinfo;
+	if (!fsinfo) {
 		if (!dentry->d_sb->s_op->statfs)
 			return -EOPNOTSUPP;
-		get_fsinfo = generic_fsinfo;
+		fsinfo = generic_fsinfo;
 	}
 
 	ret = security_sb_statfs(dentry);
 	if (ret)
 		return ret;
 
-	ret = get_fsinfo(dentry, params);
+	ret = fsinfo(path, params);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 053d53861995..b9b5ba36033c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1851,7 +1851,7 @@ struct super_operations {
 	int (*thaw_super) (struct super_block *);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
-	int (*get_fsinfo) (struct dentry *, struct fsinfo_kparams *);
+	int (*fsinfo) (struct path *, struct fsinfo_kparams *);
 	int (*remount_fs) (struct super_block *, int *, char *, size_t);
 	int (*reconfigure) (struct super_block *, struct fs_context *);
 	void (*umount_begin) (struct super_block *);
@@ -2229,7 +2229,7 @@ extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
-extern int vfs_fsinfo(const struct path *, struct fsinfo_kparams *);
+extern int vfs_fsinfo(struct path *, struct fsinfo_kparams *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
 extern bool our_mnt(struct vfsmount *mnt);
diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
index f2d25b898d48..e488701c5c04 100644
--- a/include/linux/fsinfo.h
+++ b/include/linux/fsinfo.h
@@ -24,7 +24,7 @@ struct fsinfo_kparams {
 	size_t			buf_size;	/* Size of the buffer */
 };
 
-extern int generic_fsinfo(struct dentry *, struct fsinfo_kparams *);
+extern int generic_fsinfo(struct path *, struct fsinfo_kparams *);
 
 static inline void fsinfo_set_cap(struct fsinfo_capabilities *c,
 				  enum fsinfo_capability cap)

