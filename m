Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id g70PACzQGlsaEgAAmS7hNA
	; Fri, 08 Jun 2018 18:51:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3C09607E4; Fri,  8 Jun 2018 18:51:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 60DF36074D;
	Fri,  8 Jun 2018 18:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60DF36074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeFHSuz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:50:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53834 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbeFHSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSp-0006NN-Ep; Fri, 08 Jun 2018 18:50:19 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Packard <keithp@keithp.com>
Subject: [PATCH 01/13] drm_mode_create_lease_ioctl(): switch to filp_clone_open()
Date: Fri,  8 Jun 2018 19:50:07 +0100
Message-Id: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608184842.GD30522@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

It had been open-coding that and, AFAICS, getting the error case wrong.

Cc: Keith Packard <keithp@keithp.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/drm_lease.c | 16 +---------------
 fs/internal.h               |  1 -
 include/linux/fs.h          |  1 +
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index d345563fdff3..ce281d651ae8 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -553,24 +553,13 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 
 	/* Clone the lessor file to create a new file for us */
 	DRM_DEBUG_LEASE("Allocating lease file\n");
-	path_get(&lessor_file->f_path);
-	lessee_file = alloc_file(&lessor_file->f_path,
-				 lessor_file->f_mode,
-				 fops_get(lessor_file->f_inode->i_fop));
-
+	lessee_file = filp_clone_open(lessor_file);
 	if (IS_ERR(lessee_file)) {
 		ret = PTR_ERR(lessee_file);
 		goto out_lessee;
 	}
 
-	/* Initialize the new file for DRM */
-	DRM_DEBUG_LEASE("Initializing the file with %p\n", lessee_file->f_op->open);
-	ret = lessee_file->f_op->open(lessee_file->f_inode, lessee_file);
-	if (ret)
-		goto out_lessee_file;
-
 	lessee_priv = lessee_file->private_data;
-
 	/* Change the file to a master one */
 	drm_master_put(&lessee_priv->master);
 	lessee_priv->master = lessee;
@@ -588,9 +577,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
 	return 0;
 
-out_lessee_file:
-	fput(lessee_file);
-
 out_lessee:
 	drm_master_put(&lessee);
 
diff --git a/fs/internal.h b/fs/internal.h
index 980d005b21b4..5645b4ebf494 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -127,7 +127,6 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 
 extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *, const struct cred *);
-extern struct file *filp_clone_open(struct file *);
 
 /*
  * inode.c
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..81fe0292a7ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2401,6 +2401,7 @@ extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file *filp_clone_open(struct file *);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
-- 
2.11.0
