Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC80C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CDE2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CDE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbeKQDra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:47:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeKQDr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:47:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F6BA3082B22;
        Fri, 16 Nov 2018 17:34:12 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDD3F60E1C;
        Fri, 16 Nov 2018 17:34:09 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak100 V1 1/2] audit: avoid fcaps on MNT_FORCE
Date:   Fri, 16 Nov 2018 12:33:13 -0500
Message-Id: <218e806e61cd5ae2fd38f9d546f953f86c763b58.1542149969.git.rgb@redhat.com>
In-Reply-To: <cover.1542149969.git.rgb@redhat.com>
References: <cover.1542149969.git.rgb@redhat.com>
In-Reply-To: <cover.1542149969.git.rgb@redhat.com>
References: <cover.1542149969.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 16 Nov 2018 17:34:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't fetch fcaps when umount2 is called with MNT_FORCE to avoid a
process hang while it waits for the missing resource to (possibly never)
re-appear.

Note the comment above user_path_mountpoint_at():
 * A umount is a special case for path walking. We're not actually interested
 * in the inode in this situation, and ESTALE errors can be a problem.  We
 * simply want track down the dentry and vfsmount attached at the mountpoint
 * and avoid revalidating the last component.

This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.

Please see the github issue tracker
https://github.com/linux-audit/audit-kernel/issues/100

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c            | 2 +-
 fs/namespace.c        | 3 +++
 include/linux/audit.h | 8 ++++++--
 kernel/audit.c        | 5 +++--
 kernel/audit.h        | 2 +-
 kernel/auditsc.c      | 6 +++---
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0cab6494978c..5ac8410b704c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2720,7 +2720,7 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 	if (unlikely(error == -ESTALE))
 		error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
 	if (likely(!error))
-		audit_inode(name, path->dentry, 0);
+		audit_inode(name, path->dentry, flags & LOOKUP_NO_REVAL);
 	restore_nameidata();
 	putname(name);
 	return error;
diff --git a/fs/namespace.c b/fs/namespace.c
index 99186556f8d3..5bae5bbd4e1f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1636,6 +1636,9 @@ int ksys_umount(char __user *name, int flags)
 	if (!(flags & UMOUNT_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 
+	if (!(flags & MNT_FORCE))
+		lookup_flags |= LOOKUP_NO_REVAL;
+
 	retval = user_path_mountpoint_at(AT_FDCWD, name, lookup_flags, &path);
 	if (retval)
 		goto out;
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 9334fbef7bae..503f1710c9d0 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -25,6 +25,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
+#include <linux/namei.h>  /* LOOKUP_* */
 #include <uapi/linux/audit.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
@@ -229,6 +230,7 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 
 #define AUDIT_INODE_PARENT	1	/* dentry represents the parent */
 #define AUDIT_INODE_HIDDEN	2	/* audit record should be hidden */
+#define AUDIT_INODE_NOREVAL	4	/* audit record incomplete */
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
 				unsigned int flags);
 extern void __audit_file(const struct file *);
@@ -289,11 +291,13 @@ static inline void audit_getname(struct filename *name)
 }
 static inline void audit_inode(struct filename *name,
 				const struct dentry *dentry,
-				unsigned int parent) {
+				unsigned int lflags) {
 	if (unlikely(!audit_dummy_context())) {
 		unsigned int flags = 0;
-		if (parent)
+		if (lflags & LOOKUP_PARENT)
 			flags |= AUDIT_INODE_PARENT;
+		if (lflags & LOOKUP_NO_REVAL)
+			flags |= AUDIT_INODE_NOREVAL;
 		__audit_inode(name, dentry, flags);
 	}
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 2a8058764aa6..45ca6d15ce89 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2097,7 +2097,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 
 /* Copy inode data into an audit_names. */
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
-		      struct inode *inode)
+		      struct inode *inode, unsigned int flags)
 {
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
@@ -2106,7 +2106,8 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
 	security_inode_getsecid(inode, &name->osid);
-	audit_copy_fcaps(name, dentry);
+	if (!(flags & AUDIT_INODE_NOREVAL))
+		audit_copy_fcaps(name, dentry);
 }
 
 /**
diff --git a/kernel/audit.h b/kernel/audit.h
index 214e14948370..7db09151c2d0 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -212,7 +212,7 @@ struct audit_context {
 
 extern void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
-			     struct inode *inode);
+			     struct inode *inode, unsigned int flags);
 extern void audit_log_cap(struct audit_buffer *ab, char *prefix,
 			  kernel_cap_t *cap);
 extern void audit_log_name(struct audit_context *context,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b2d1f043f17f..d39a7fbaf944 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1846,7 +1846,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		n->type = AUDIT_TYPE_NORMAL;
 	}
 	handle_path(dentry);
-	audit_copy_inode(n, dentry, inode);
+	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOREVAL);
 }
 
 void __audit_file(const struct file *file)
@@ -1947,7 +1947,7 @@ void __audit_inode_child(struct inode *parent,
 		n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
 		if (!n)
 			return;
-		audit_copy_inode(n, NULL, parent);
+		audit_copy_inode(n, NULL, parent, 0);
 	}
 
 	if (!found_child) {
@@ -1966,7 +1966,7 @@ void __audit_inode_child(struct inode *parent,
 	}
 
 	if (inode)
-		audit_copy_inode(found_child, dentry, inode);
+		audit_copy_inode(found_child, dentry, inode, 0);
 	else
 		found_child->ino = AUDIT_INO_UNSET;
 }
-- 
1.8.3.1

