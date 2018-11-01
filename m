Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298BA20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298BA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeKBGx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:53:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58269 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeKBGx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:53:59 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIKpz-0008KE-VP
        for linux-kernel@vger.kernel.org; Thu, 01 Nov 2018 21:49:12 +0000
Received: by mail-it1-f198.google.com with SMTP id a17so463684itk.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yczXKaqAEGqNQkY5lhKY0Xn53759KFuVu2oBmKdF/AE=;
        b=AcMdJ7LFiL4N01NNsluQk9Kd9e0Fo4aVlyajJGRvr0HNoyREovFsM0h5gA5kKJzxa0
         9mVis8fuM/0EAW5HpDJ/ejrwgbVVrQkQtwJddHea0MmX0F9SZnqhi+zpyQZl3aKcf6hc
         URuMW21nxX0eZd42Jwk+MYNqx9b0VTR3iK6WvgotxjKrYSRQCbfKv9vMSeGkL9vGGqoI
         cos6i0Y3x3U0DACTvZxGAiPSAF0Ay+f1dOSBiimWEWjzEx+N6QUG3UBHxDxYUZSlu7hs
         6ojMwJCSfHN7bsSo3MHSydvsYshHH3nRu+e2/e/UnFmmKRhStY6v0APQ8meSmmzxNF2a
         r2+g==
X-Gm-Message-State: AGRZ1gLjMXPJNyqX9I/Uhxr8zpUxjhA8s7aWyEcGuyx0jkYwF4I412J5
        5nuMjFmvjiRZVGjycgrWUcfoyjA5lPg4kZVxjm4Vc2ubB331ErBlbLlHmJ7toxEkbFAxdfI9GBx
        Jx+jul1cLjLU13MOlDo2VXrev7JswJU7Sgq9XDJQjHA==
X-Received: by 2002:a24:ef05:: with SMTP id i5-v6mr7685210ith.125.1541108950699;
        Thu, 01 Nov 2018 14:49:10 -0700 (PDT)
X-Google-Smtp-Source: AJdET5e9/x089BHZSYmlcs9moJieKePTQTxwdIXB4C83vdvkGx7MUAoGGTmvMw/ctAgR8d0N/Dn8FQ==
X-Received: by 2002:a24:ef05:: with SMTP id i5-v6mr7685177ith.125.1541108950203;
        Thu, 01 Nov 2018 14:49:10 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id 10-v6sm16562581itl.32.2018.11.01.14.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:49:09 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [RFC PATCH 5/6] shiftfs: add support for posix acls
Date:   Thu,  1 Nov 2018 16:48:55 -0500
Message-Id: <20181101214856.4563-6-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101214856.4563-1-seth.forshee@canonical.com>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/Kconfig   |  10 +++
 fs/shiftfs.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 392c5a41a9f9..691f3c4fc7eb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -121,6 +121,16 @@ config SHIFT_FS
 	  unprivileged containers can use this to mount root volumes
 	  using this technique.
 
+config SHIFT_FS_POSIX_ACL
+	bool "shiftfs POSIX Access Control Lists"
+	depends on SHIFT_FS
+	select FS_POSIX_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  If you don't know what Access Control Lists are, say N.
+
 menu "Caches"
 
 source "fs/fscache/Kconfig"
diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index 226c03d8588b..b19af7b2fe75 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -13,6 +13,8 @@
 #include <linux/user_namespace.h>
 #include <linux/uidgid.h>
 #include <linux/xattr.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 
 struct shiftfs_super_info {
 	struct vfsmount *mnt;
@@ -631,6 +633,183 @@ static int shiftfs_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
+#ifdef CONFIG_SHIFT_FS_POSIX_ACL
+
+static int
+shift_acl_ids(struct user_namespace *from, struct user_namespace *to,
+	      struct posix_acl *acl)
+{
+	int i;
+
+	for (i = 0; i < acl->a_count; i++) {
+		struct posix_acl_entry *e = &acl->a_entries[i];
+		switch(e->e_tag) {
+		case ACL_USER:
+			e->e_uid = shift_kuid(from, to, e->e_uid);
+			if (!uid_valid(e->e_uid))
+				return -EOVERFLOW;
+			break;
+		case ACL_GROUP:
+			e->e_gid = shift_kgid(from, to, e->e_gid);
+			if (!gid_valid(e->e_gid))
+				return -EOVERFLOW;
+			break;
+		}
+	}
+	return 0;
+}
+
+static void
+shift_acl_xattr_ids(struct user_namespace *from, struct user_namespace *to,
+		    void *value, size_t size)
+{
+	struct posix_acl_xattr_header *header = value;
+	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
+	int count;
+	kuid_t kuid;
+	kgid_t kgid;
+
+	if (!value)
+		return;
+	if (size < sizeof(struct posix_acl_xattr_header))
+		return;
+	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
+		return;
+
+	count = posix_acl_xattr_count(size);
+	if (count < 0)
+		return;
+	if (count == 0)
+		return;
+
+	for (end = entry + count; entry != end; entry++) {
+		switch(le16_to_cpu(entry->e_tag)) {
+		case ACL_USER:
+			kuid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
+			kuid = shift_kuid(from, to, kuid);
+			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns, kuid));
+			break;
+		case ACL_GROUP:
+			kgid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
+			kgid = shift_kgid(from, to, kgid);
+			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns, kgid));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static struct posix_acl *shiftfs_get_acl(struct inode *inode, int type)
+{
+	struct inode *reali = inode->i_private;
+	const struct cred *oldcred, *newcred;
+	struct posix_acl *real_acl, *acl = NULL;
+	struct user_namespace *from_ns = reali->i_sb->s_user_ns;
+	struct user_namespace *to_ns = inode->i_sb->s_user_ns;
+	int size;
+	int err;
+
+	if (!IS_POSIXACL(reali))
+		return NULL;
+
+	oldcred = shiftfs_new_creds(&newcred, inode->i_sb);
+	real_acl = get_acl(reali, type);
+	shiftfs_old_creds(oldcred, &newcred);
+
+	if (real_acl && !IS_ERR(acl)) {
+		/* XXX: export posix_acl_clone? */
+		size = sizeof(struct posix_acl) +
+			   real_acl->a_count * sizeof(struct posix_acl_entry);
+		acl = kmemdup(acl, size, GFP_KERNEL);
+		posix_acl_release(real_acl);
+
+		if (!acl)
+			return ERR_PTR(-ENOMEM);
+
+		refcount_set(&acl->a_refcount, 1);
+
+		err = shift_acl_ids(from_ns, to_ns, acl);
+		if (err) {
+			kfree(acl);
+			return ERR_PTR(err);
+		}
+	}
+
+	return acl;
+}
+
+static int
+shiftfs_posix_acl_xattr_get(const struct xattr_handler *handler,
+			   struct dentry *dentry, struct inode *inode,
+			   const char *name, void *buffer, size_t size)
+{
+	struct inode *reali = inode->i_private;
+	int ret;
+
+	ret = shiftfs_xattr_get(NULL, dentry, inode, handler->name,
+				buffer, size);
+	if (ret < 0)
+		return ret;
+
+	shift_acl_xattr_ids(reali->i_sb->s_user_ns, inode->i_sb->s_user_ns,
+			    buffer, size);
+	return ret;
+}
+
+static int
+shiftfs_posix_acl_xattr_set(const struct xattr_handler *handler,
+			    struct dentry *dentry, struct inode *inode,
+			    const char *name, const void *value,
+			    size_t size, int flags)
+{
+	struct inode *reali = inode->i_private;
+	int err;
+
+	if (!IS_POSIXACL(reali) || !reali->i_op->set_acl)
+		return -EOPNOTSUPP;
+	if (handler->flags == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
+		return value ? -EACCES : 0;
+	if (!inode_owner_or_capable(inode))
+		return -EPERM;
+
+	if (value) {
+		shift_acl_xattr_ids(inode->i_sb->s_user_ns,
+				    reali->i_sb->s_user_ns,
+				    (void *)value, size);
+		err = shiftfs_setxattr(dentry, inode, handler->name, value,
+				       size, flags);
+	} else {
+		err = shiftfs_removexattr(dentry, handler->name);
+	}
+
+	if (!err)
+		shiftfs_copyattr(reali, inode);
+	return err;
+}
+
+static const struct xattr_handler
+shiftfs_posix_acl_access_xattr_handler = {
+	.name = XATTR_NAME_POSIX_ACL_ACCESS,
+	.flags = ACL_TYPE_ACCESS,
+	.get = shiftfs_posix_acl_xattr_get,
+	.set = shiftfs_posix_acl_xattr_set,
+};
+
+static const struct xattr_handler
+shiftfs_posix_acl_default_xattr_handler = {
+	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
+	.flags = ACL_TYPE_DEFAULT,
+	.get = shiftfs_posix_acl_xattr_get,
+	.set = shiftfs_posix_acl_xattr_set,
+};
+
+#else /* !CONFIG_SHIFT_FS_POSIX_ACL */
+
+#define shiftfs_get_acl NULL
+
+#endif /* CONFIG_SHIFT_FS_POSIX_ACL */
+
 static const struct inode_operations shiftfs_inode_ops = {
 	.lookup		= shiftfs_lookup,
 	.getattr	= shiftfs_getattr,
@@ -647,6 +826,7 @@ static const struct inode_operations shiftfs_inode_ops = {
 	.create		= shiftfs_create,
 	.mknod		= NULL,	/* no special files currently */
 	.listxattr	= shiftfs_listxattr,
+	.get_acl	= shiftfs_get_acl,
 };
 
 static struct inode *shiftfs_new_inode(struct super_block *sb, umode_t mode,
@@ -725,6 +905,10 @@ static const struct xattr_handler shiftfs_xattr_handler = {
 };
 
 const struct xattr_handler *shiftfs_xattr_handlers[] = {
+#ifdef CONFIG_SHIFT_FS_POSIX_ACL
+	&shiftfs_posix_acl_access_xattr_handler,
+	&shiftfs_posix_acl_default_xattr_handler,
+#endif
 	&shiftfs_xattr_handler,
 	NULL
 };
@@ -819,6 +1003,7 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
 	sb->s_op = &shiftfs_super_ops;
 	sb->s_xattr = shiftfs_xattr_handlers;
 	sb->s_d_op = &shiftfs_dentry_ops;
+	sb->s_flags |= SB_POSIXACL;
 	sb->s_root = d_make_root(shiftfs_new_inode(sb, S_IFDIR, dentry));
 	sb->s_root->d_fsdata = dentry;
 
-- 
2.19.1

