Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 99f6A97PGluqEAAAmS7hNA
	; Fri, 08 Jun 2018 18:50:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2FD5607DC; Fri,  8 Jun 2018 18:50:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 84B60601D2;
	Fri,  8 Jun 2018 18:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84B60601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeFHSuX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:50:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53786 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeFHSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSp-0006NQ-JK; Fri, 08 Jun 2018 18:50:19 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] rename filp_clone_open() to file_clone_open()
Date: Fri,  8 Jun 2018 19:50:08 +0100
Message-Id: <20180608185019.24472-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

'filp' naming convention is bogus; sure, it's "file pointer", but
we generally don't do that kind of Hungarian notation.  Some of
the instances have too many callers to touch, but this one has
only two, so let's sanitize it while we can...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/drm_lease.c | 2 +-
 fs/binfmt_misc.c            | 2 +-
 fs/open.c                   | 4 ++--
 include/linux/fs.h          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index ce281d651ae8..bb5f817baf0b 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -553,7 +553,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 
 	/* Clone the lessor file to create a new file for us */
 	DRM_DEBUG_LEASE("Allocating lease file\n");
-	lessee_file = filp_clone_open(lessor_file);
+	lessee_file = file_clone_open(lessor_file);
 	if (IS_ERR(lessee_file)) {
 		ret = PTR_ERR(lessee_file);
 		goto out_lessee;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a41b48f82a70..86ebd9dc9469 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -205,7 +205,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		goto error;
 
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
-		interp_file = filp_clone_open(fmt->interp_file);
+		interp_file = file_clone_open(fmt->interp_file);
 		if (!IS_ERR(interp_file))
 			deny_write_access(interp_file);
 	} else {
diff --git a/fs/open.c b/fs/open.c
index d0e955b558ad..96ab60d52303 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1063,7 +1063,7 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(file_open_root);
 
-struct file *filp_clone_open(struct file *oldfile)
+struct file *file_clone_open(struct file *oldfile)
 {
 	struct file *file;
 	int retval;
@@ -1081,7 +1081,7 @@ struct file *filp_clone_open(struct file *oldfile)
 
 	return file;
 }
-EXPORT_SYMBOL(filp_clone_open);
+EXPORT_SYMBOL(file_clone_open);
 
 long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 81fe0292a7ac..8f0b4667ebf1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2401,7 +2401,7 @@ extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
-extern struct file *filp_clone_open(struct file *);
+extern struct file *file_clone_open(struct file *);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
-- 
2.11.0
