Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8408FECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245312089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245312089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeGMQXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:23:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38367 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbeGMQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:23:21 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.ubuntu-ci)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fe0bx-0006pX-27; Fri, 13 Jul 2018 16:08:01 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [PATCH net-next v2 1/7] kernfs: allow creating kernfs objects with arbitrary uid/gid
Date:   Fri, 13 Jul 2018 16:05:43 +0000
Message-Id: <1531497949-1766-2-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This change allows creating kernfs files and directories with arbitrary
uid/gid instead of always using GLOBAL_ROOT_UID/GID by extending
kernfs_create_dir_ns() and kernfs_create_file_ns() with uid/gid arguments.
The "simple" kernfs_create_file() and kernfs_create_dir() are left alone
and always create objects belonging to the global root.

When creating symlinks ownership (uid/gid) is taken from the target kernfs
object.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/kernfs/dir.c             | 29 ++++++++++++++++++++++++++---
 fs/kernfs/file.c            |  8 ++++++--
 fs/kernfs/inode.c           |  2 +-
 fs/kernfs/kernfs-internal.h |  2 ++
 fs/kernfs/symlink.c         | 11 ++++++++++-
 fs/sysfs/dir.c              |  4 +++-
 fs/sysfs/file.c             |  5 +++--
 include/linux/kernfs.h      | 28 +++++++++++++++++++---------
 kernel/cgroup/cgroup.c      |  4 +++-
 9 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d66cc0777303..4ca0b5c18192 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -619,6 +619,7 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 
 static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     const char *name, umode_t mode,
+					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
 {
 	struct kernfs_node *kn;
@@ -661,8 +662,22 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->mode = mode;
 	kn->flags = flags;
 
+	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
+		struct iattr iattr = {
+			.ia_valid = ATTR_UID | ATTR_GID,
+			.ia_uid = uid,
+			.ia_gid = gid,
+		};
+
+		ret = __kernfs_setattr(kn, &iattr);
+		if (ret < 0)
+			goto err_out3;
+	}
+
 	return kn;
 
+ err_out3:
+	idr_remove(&root->ino_idr, kn->id.ino);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -672,11 +687,13 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
+				    kuid_t uid, kgid_t gid,
 				    unsigned flags)
 {
 	struct kernfs_node *kn;
 
-	kn = __kernfs_new_node(kernfs_root(parent), name, mode, flags);
+	kn = __kernfs_new_node(kernfs_root(parent),
+			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
 		kn->parent = parent;
@@ -946,6 +963,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	root->next_generation = 1;
 
 	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
+			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
 		idr_destroy(&root->ino_idr);
@@ -984,6 +1002,8 @@ void kernfs_destroy_root(struct kernfs_root *root)
  * @parent: parent in which to create a new directory
  * @name: name of the new directory
  * @mode: mode of the new directory
+ * @uid: uid of the new directory
+ * @gid: gid of the new directory
  * @priv: opaque data associated with the new directory
  * @ns: optional namespace tag of the directory
  *
@@ -991,13 +1011,15 @@ void kernfs_destroy_root(struct kernfs_root *root)
  */
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 kuid_t uid, kgid_t gid,
 					 void *priv, const void *ns)
 {
 	struct kernfs_node *kn;
 	int rc;
 
 	/* allocate */
-	kn = kernfs_new_node(parent, name, mode | S_IFDIR, KERNFS_DIR);
+	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
+			     uid, gid, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
@@ -1028,7 +1050,8 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 	int rc;
 
 	/* allocate */
-	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR, KERNFS_DIR);
+	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR,
+			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 2015d8c45e4a..dbf5bc250bfd 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -965,6 +965,8 @@ const struct file_operations kernfs_file_fops = {
  * @parent: directory to create the file in
  * @name: name of the file
  * @mode: mode of the file
+ * @uid: uid of the file
+ * @gid: gid of the file
  * @size: size of the file
  * @ops: kernfs operations for the file
  * @priv: private data for the file
@@ -975,7 +977,8 @@ const struct file_operations kernfs_file_fops = {
  */
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name,
-					 umode_t mode, loff_t size,
+					 umode_t mode, kuid_t uid, kgid_t gid,
+					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
 					 struct lock_class_key *key)
@@ -986,7 +989,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 
 	flags = KERNFS_FILE;
 
-	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG, flags);
+	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
+			     uid, gid, flags);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d73fe9d56e2..80cebcd94c90 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -63,7 +63,7 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 	return ret;
 }
 
-static int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
+int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	struct kernfs_iattrs *attrs;
 	struct iattr *iattrs;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 0f260dcca177..3d83b114bb08 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -90,6 +90,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr);
 int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
+int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 
 /*
  * dir.c
@@ -104,6 +105,7 @@ void kernfs_put_active(struct kernfs_node *kn);
 int kernfs_add_one(struct kernfs_node *kn);
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
+				    kuid_t uid, kgid_t gid,
 				    unsigned flags);
 struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
 						    unsigned int ino);
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 08ccabd7047f..5ffed48f3d0e 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -21,6 +21,7 @@
  * @target: target node for the symlink to point to
  *
  * Returns the created node on success, ERR_PTR() value on error.
+ * Ownership of the link matches ownership of the target.
  */
 struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 				       const char *name,
@@ -28,8 +29,16 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	int error;
+	kuid_t uid = GLOBAL_ROOT_UID;
+	kgid_t gid = GLOBAL_ROOT_GID;
 
-	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO, KERNFS_LINK);
+	if (target->iattr) {
+		uid = target->iattr->ia_iattr.ia_uid;
+		gid = target->iattr->ia_iattr.ia_gid;
+	}
+
+	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO, uid, gid,
+			     KERNFS_LINK);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 58eba92a0e41..e39b884f0867 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -52,7 +52,9 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 		return -ENOENT;
 
 	kn = kernfs_create_dir_ns(parent, kobject_name(kobj),
-				  S_IRWXU | S_IRUGO | S_IXUGO, kobj, ns);
+				  S_IRWXU | S_IRUGO | S_IXUGO,
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  kobj, ns);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, kobject_name(kobj));
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 5c13f29bfcdb..513fa691ecbd 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -302,8 +302,9 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 	if (!attr->ignore_lockdep)
 		key = attr->key ?: (struct lock_class_key *)&attr->skey;
 #endif
-	kn = __kernfs_create_file(parent, attr->name, mode & 0777, size, ops,
-				  (void *)attr, ns, key);
+	kn = __kernfs_create_file(parent, attr->name,
+				  mode & 0777, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  size, ops, (void *)attr, ns, key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index ab25c8b6d9e3..814643f7ee52 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/rbtree.h>
 #include <linux/atomic.h>
+#include <linux/uidgid.h>
 #include <linux/wait.h>
 
 struct file;
@@ -325,12 +326,14 @@ void kernfs_destroy_root(struct kernfs_root *root);
 
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 kuid_t uid, kgid_t gid,
 					 void *priv, const void *ns);
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name);
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
-					 const char *name,
-					 umode_t mode, loff_t size,
+					 const char *name, umode_t mode,
+					 kuid_t uid, kgid_t gid,
+					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
 					 struct lock_class_key *key);
@@ -415,12 +418,14 @@ static inline void kernfs_destroy_root(struct kernfs_root *root) { }
 
 static inline struct kernfs_node *
 kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
-		     umode_t mode, void *priv, const void *ns)
+		     umode_t mode, kuid_t uid, kgid_t gid,
+		     void *priv, const void *ns)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
 __kernfs_create_file(struct kernfs_node *parent, const char *name,
-		     umode_t mode, loff_t size, const struct kernfs_ops *ops,
+		     umode_t mode, kuid_t uid, kgid_t gid,
+		     loff_t size, const struct kernfs_ops *ops,
 		     void *priv, const void *ns, struct lock_class_key *key)
 { return ERR_PTR(-ENOSYS); }
 
@@ -498,12 +503,15 @@ static inline struct kernfs_node *
 kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
 		  void *priv)
 {
-	return kernfs_create_dir_ns(parent, name, mode, priv, NULL);
+	return kernfs_create_dir_ns(parent, name, mode,
+				    GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				    priv, NULL);
 }
 
 static inline struct kernfs_node *
 kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
-		      umode_t mode, loff_t size, const struct kernfs_ops *ops,
+		      umode_t mode, kuid_t uid, kgid_t gid,
+		      loff_t size, const struct kernfs_ops *ops,
 		      void *priv, const void *ns)
 {
 	struct lock_class_key *key = NULL;
@@ -511,15 +519,17 @@ kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = (struct lock_class_key *)&ops->lockdep_key;
 #endif
-	return __kernfs_create_file(parent, name, mode, size, ops, priv, ns,
-				    key);
+	return __kernfs_create_file(parent, name, mode, uid, gid,
+				    size, ops, priv, ns, key);
 }
 
 static inline struct kernfs_node *
 kernfs_create_file(struct kernfs_node *parent, const char *name, umode_t mode,
 		   loff_t size, const struct kernfs_ops *ops, void *priv)
 {
-	return kernfs_create_file_ns(parent, name, mode, size, ops, priv, NULL);
+	return kernfs_create_file_ns(parent, name, mode,
+				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				     size, ops, priv, NULL);
 }
 
 static inline int kernfs_remove_by_name(struct kernfs_node *parent,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 077370bf8964..35cf3d71f8aa 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3557,7 +3557,9 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	key = &cft->lockdep_key;
 #endif
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
-				  cgroup_file_mode(cft), 0, cft->kf_ops, cft,
+				  cgroup_file_mode(cft),
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  0, cft->kf_ops, cft,
 				  NULL, key);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
-- 
2.7.4

