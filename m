Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1ACECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63C32089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63C32089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbeGMQX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:23:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38376 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbeGMQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:23:26 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.ubuntu-ci)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fe0c1-0006pX-Ey; Fri, 13 Jul 2018 16:08:05 +0000
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
Subject: [PATCH net-next v2 2/7] sysfs, kobject: allow creating kobject belonging to arbitrary users
Date:   Fri, 13 Jul 2018 16:05:44 +0000
Message-Id: <1531497949-1766-3-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Normally kobjects and their sysfs representation belong to global root,
however it is not necessarily the case for objects in separate namespaces.
For example, objects in separate network namespace logically belong to the
container's root and not global root.

This change lays groundwork for allowing network namespace objects
ownership to be transferred to container's root user by defining
get_ownership() callback in ktype structure and using it in sysfs code to
retrieve desired uid/gid when creating sysfs objects for given kobject.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/sysfs/dir.c          |  7 +++++--
 fs/sysfs/file.c         | 32 ++++++++++++++++++++------------
 fs/sysfs/group.c        | 23 +++++++++++++++++------
 fs/sysfs/sysfs.h        |  3 ++-
 include/linux/kobject.h |  4 ++++
 lib/kobject.c           | 19 +++++++++++++++++++
 6 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index e39b884f0867..feeae8081c22 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -40,6 +40,8 @@ void sysfs_warn_dup(struct kernfs_node *parent, const char *name)
 int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 {
 	struct kernfs_node *parent, *kn;
+	kuid_t uid;
+	kgid_t gid;
 
 	BUG_ON(!kobj);
 
@@ -51,9 +53,10 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 	if (!parent)
 		return -ENOENT;
 
+	kobject_get_ownership(kobj, &uid, &gid);
+
 	kn = kernfs_create_dir_ns(parent, kobject_name(kobj),
-				  S_IRWXU | S_IRUGO | S_IXUGO,
-				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  S_IRWXU | S_IRUGO | S_IXUGO, uid, gid,
 				  kobj, ns);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 513fa691ecbd..fa46216523cf 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -245,7 +245,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			   const struct attribute *attr, bool is_bin,
-			   umode_t mode, const void *ns)
+			   umode_t mode, kuid_t uid, kgid_t gid, const void *ns)
 {
 	struct lock_class_key *key = NULL;
 	const struct kernfs_ops *ops;
@@ -302,8 +302,8 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 	if (!attr->ignore_lockdep)
 		key = attr->key ?: (struct lock_class_key *)&attr->skey;
 #endif
-	kn = __kernfs_create_file(parent, attr->name,
-				  mode & 0777, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+
+	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
 				  size, ops, (void *)attr, ns, key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
@@ -313,12 +313,6 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 	return 0;
 }
 
-int sysfs_add_file(struct kernfs_node *parent, const struct attribute *attr,
-		   bool is_bin)
-{
-	return sysfs_add_file_mode_ns(parent, attr, is_bin, attr->mode, NULL);
-}
-
 /**
  * sysfs_create_file_ns - create an attribute file for an object with custom ns
  * @kobj: object we're creating for
@@ -328,9 +322,14 @@ int sysfs_add_file(struct kernfs_node *parent, const struct attribute *attr,
 int sysfs_create_file_ns(struct kobject *kobj, const struct attribute *attr,
 			 const void *ns)
 {
+	kuid_t uid;
+	kgid_t gid;
+
 	BUG_ON(!kobj || !kobj->sd || !attr);
 
-	return sysfs_add_file_mode_ns(kobj->sd, attr, false, attr->mode, ns);
+	kobject_get_ownership(kobj, &uid, &gid);
+	return sysfs_add_file_mode_ns(kobj->sd, attr, false, attr->mode,
+				      uid, gid, ns);
 
 }
 EXPORT_SYMBOL_GPL(sysfs_create_file_ns);
@@ -359,6 +358,8 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 		const struct attribute *attr, const char *group)
 {
 	struct kernfs_node *parent;
+	kuid_t uid;
+	kgid_t gid;
 	int error;
 
 	if (group) {
@@ -371,7 +372,9 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 	if (!parent)
 		return -ENOENT;
 
-	error = sysfs_add_file(parent, attr, false);
+	kobject_get_ownership(kobj, &uid, &gid);
+	error = sysfs_add_file_mode_ns(kobj->sd, attr, false,
+				       attr->mode, uid, gid, NULL);
 	kernfs_put(parent);
 
 	return error;
@@ -487,9 +490,14 @@ EXPORT_SYMBOL_GPL(sysfs_remove_file_from_group);
 int sysfs_create_bin_file(struct kobject *kobj,
 			  const struct bin_attribute *attr)
 {
+	kuid_t uid;
+	kgid_t gid;
+
 	BUG_ON(!kobj || !kobj->sd || !attr);
 
-	return sysfs_add_file(kobj->sd, &attr->attr, true);
+	kobject_get_ownership(kobj, &uid, &gid);
+	return sysfs_add_file_mode_ns(kobj->sd, &attr->attr, true,
+				      attr->attr.mode, uid, gid, NULL);
 }
 EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
 
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4802ec0e1e3a..c7a716c4acc9 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -31,6 +31,7 @@ static void remove_files(struct kernfs_node *parent,
 }
 
 static int create_files(struct kernfs_node *parent, struct kobject *kobj,
+			kuid_t uid, kgid_t gid,
 			const struct attribute_group *grp, int update)
 {
 	struct attribute *const *attr;
@@ -60,7 +61,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 
 			mode &= SYSFS_PREALLOC | 0664;
 			error = sysfs_add_file_mode_ns(parent, *attr, false,
-						       mode, NULL);
+						       mode, uid, gid, NULL);
 			if (unlikely(error))
 				break;
 		}
@@ -90,7 +91,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			mode &= SYSFS_PREALLOC | 0664;
 			error = sysfs_add_file_mode_ns(parent,
 					&(*bin_attr)->attr, true,
-					mode, NULL);
+					mode,
+					uid, gid, NULL);
 			if (error)
 				break;
 		}
@@ -106,6 +108,8 @@ static int internal_create_group(struct kobject *kobj, int update,
 				 const struct attribute_group *grp)
 {
 	struct kernfs_node *kn;
+	kuid_t uid;
+	kgid_t gid;
 	int error;
 
 	BUG_ON(!kobj || (!update && !kobj->sd));
@@ -118,9 +122,11 @@ static int internal_create_group(struct kobject *kobj, int update,
 			kobj->name, grp->name ?: "");
 		return -EINVAL;
 	}
+	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
-		kn = kernfs_create_dir(kobj->sd, grp->name,
-				       S_IRWXU | S_IRUGO | S_IXUGO, kobj);
+		kn = kernfs_create_dir_ns(kobj->sd, grp->name,
+					  S_IRWXU | S_IRUGO | S_IXUGO,
+					  uid, gid, kobj, NULL);
 		if (IS_ERR(kn)) {
 			if (PTR_ERR(kn) == -EEXIST)
 				sysfs_warn_dup(kobj->sd, grp->name);
@@ -129,7 +135,7 @@ static int internal_create_group(struct kobject *kobj, int update,
 	} else
 		kn = kobj->sd;
 	kernfs_get(kn);
-	error = create_files(kn, kobj, grp, update);
+	error = create_files(kn, kobj, uid, gid, grp, update);
 	if (error) {
 		if (grp->name)
 			kernfs_remove(kn);
@@ -281,6 +287,8 @@ int sysfs_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp)
 {
 	struct kernfs_node *parent;
+	kuid_t uid;
+	kgid_t gid;
 	int error = 0;
 	struct attribute *const *attr;
 	int i;
@@ -289,8 +297,11 @@ int sysfs_merge_group(struct kobject *kobj,
 	if (!parent)
 		return -ENOENT;
 
+	kobject_get_ownership(kobj, &uid, &gid);
+
 	for ((i = 0, attr = grp->attrs); *attr && !error; (++i, ++attr))
-		error = sysfs_add_file(parent, *attr, false);
+		error = sysfs_add_file_mode_ns(parent, *attr, false,
+					       (*attr)->mode, uid, gid, NULL);
 	if (error) {
 		while (--i >= 0)
 			kernfs_remove_by_name(parent, (*--attr)->name);
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index d098e015fcc9..911abe55720d 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -31,7 +31,8 @@ int sysfs_add_file(struct kernfs_node *parent,
 		   const struct attribute *attr, bool is_bin);
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			   const struct attribute *attr, bool is_bin,
-			   umode_t amode, const void *ns);
+			   umode_t amode, kuid_t uid, kgid_t gid,
+			   const void *ns);
 
 /*
  * symlink.c
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f6f93c3df9c..b49ff230beba 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -26,6 +26,7 @@
 #include <linux/wait.h>
 #include <linux/atomic.h>
 #include <linux/workqueue.h>
+#include <linux/uidgid.h>
 
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			32	/* number of env pointers */
@@ -114,6 +115,8 @@ extern struct kobject * __must_check kobject_get_unless_zero(
 extern void kobject_put(struct kobject *kobj);
 
 extern const void *kobject_namespace(struct kobject *kobj);
+extern void kobject_get_ownership(struct kobject *kobj,
+				  kuid_t *uid, kgid_t *gid);
 extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
@@ -122,6 +125,7 @@ struct kobj_type {
 	struct attribute **default_attrs;
 	const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);
 	const void *(*namespace)(struct kobject *kobj);
+	void (*get_ownership)(struct kobject *kobj, kuid_t *uid, kgid_t *gid);
 };
 
 struct kobj_uevent_env {
diff --git a/lib/kobject.c b/lib/kobject.c
index 18989b5b3b56..f2dc1f756007 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -35,6 +35,25 @@ const void *kobject_namespace(struct kobject *kobj)
 	return kobj->ktype->namespace(kobj);
 }
 
+/**
+ * kobject_get_ownership - get sysfs ownership data for @kobj
+ * @kobj: kobject in question
+ * @uid: kernel user ID for sysfs objects
+ * @gid: kernel group ID for sysfs objects
+ *
+ * Returns initial uid/gid pair that should be used when creating sysfs
+ * representation of given kobject. Normally used to adjust ownership of
+ * objects in a container.
+ */
+void kobject_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+{
+	*uid = GLOBAL_ROOT_UID;
+	*gid = GLOBAL_ROOT_GID;
+
+	if (kobj->ktype->get_ownership)
+		kobj->ktype->get_ownership(kobj, uid, gid);
+}
+
 /*
  * populate_dir - populate directory with attributes.
  * @kobj: object we're working on.
-- 
2.7.4

