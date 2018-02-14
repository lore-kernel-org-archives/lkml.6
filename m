Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032491AbeBNQXB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:23:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032462AbeBNQW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:22:59 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak21 4/4] audit: add parent of refused symlink to audit_names
Date: Wed, 14 Feb 2018 11:18:24 -0500
Message-Id: <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit link denied events for symlinks were missing the parent PATH
record.  Add it.  Since the full pathname may not be available,
reconstruct it from the path in the nameidata supplied.

See: https://github.com/linux-audit/audit-kernel/issues/21
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 0edf133..bf1c046b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -923,6 +923,7 @@ static inline int may_follow_link(struct nameidata *nd)
 	const struct inode *inode;
 	const struct inode *parent;
 	kuid_t puid;
+	char *pathname;
 
 	if (!sysctl_protected_symlinks)
 		return 0;
@@ -945,6 +946,14 @@ static inline int may_follow_link(struct nameidata *nd)
 	if (nd->flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	pathname = kmalloc(PATH_MAX + 1, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+	audit_inode(getname_kernel(d_absolute_path(&nd->stack[0].link, pathname,
+						   PATH_MAX + 1)),
+		    nd->stack[0].link.dentry, 0);
+	audit_inode(nd->name, nd->stack[0].link.dentry->d_parent, LOOKUP_PARENT);
+
 	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
 	audit_log_link_denied("follow_link", &nd->stack[0].link);
 	return -EACCES;
-- 
1.8.3.1
