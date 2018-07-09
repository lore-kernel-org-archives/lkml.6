Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA083C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F42089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830F42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeGIEyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:54:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38150 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGIEyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBo-0003gw-Pv; Mon, 09 Jul 2018 04:54:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 27/27] turn filp_clone_open() into inline wrapper for dentry_open()
Date:   Mon,  9 Jul 2018 05:54:17 +0100
Message-Id: <20180709045417.13988-27-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's exactly the same thing as
	dentry_open(&file->f_path, file->f_flags, file->f_cred)

... and rename it to file_clone_open(), while we are at it.
'filp' naming convention is bogus; sure, it's "file pointer",
but we generally don't do that kind of Hungarian notation.
Some of the instances have too many callers to touch, but this
one has only two, so let's sanitize it while we can...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/drm_lease.c |  2 +-
 fs/binfmt_misc.c            |  2 +-
 fs/open.c                   | 20 --------------------
 include/linux/fs.h          |  5 ++++-
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index d638c0fb3418..b54fb78a283c 100644
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
index 4b5fff31ef27..aa4a7a23ff99 100644
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
index 0836c86fd0ce..39dcbf13031c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1053,26 +1053,6 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(file_open_root);
 
-struct file *filp_clone_open(struct file *oldfile)
-{
-	struct file *file;
-	int retval;
-
-	file = get_empty_filp();
-	if (IS_ERR(file))
-		return file;
-
-	file->f_flags = oldfile->f_flags;
-	retval = vfs_open(&oldfile->f_path, file, oldfile->f_cred);
-	if (retval) {
-		put_filp(file);
-		return ERR_PTR(retval);
-	}
-
-	return file;
-}
-EXPORT_SYMBOL(filp_clone_open);
-
 long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b3240025ce1a..b3aeb2098fc6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2426,7 +2426,10 @@ extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
-extern struct file *filp_clone_open(struct file *);
+static inline struct file *file_clone_open(struct file *file)
+{
+	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
+}
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
-- 
2.11.0

