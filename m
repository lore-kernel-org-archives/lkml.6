Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08581ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00CC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeGWN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:33 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A412BDB;
        Mon, 23 Jul 2018 12:28:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.17 61/63] drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
Date:   Mon, 23 Jul 2018 14:25:07 +0200
Message-Id: <20180723122448.660042034@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit b4e7a7a88b5d060650094b8d3454bc521d669f6a upstream.

Failure of ->open() should *not* be followed by fput().  Fixed by
using filp_clone_open(), which gets the cleanups right.

Cc: stable@vger.kernel.org
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_lease.c |   16 +---------------
 fs/internal.h               |    1 -
 include/linux/fs.h          |    1 +
 3 files changed, 2 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -553,24 +553,13 @@ int drm_mode_create_lease_ioctl(struct d
 
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
@@ -588,9 +577,6 @@ int drm_mode_create_lease_ioctl(struct d
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
 	return 0;
 
-out_lessee_file:
-	fput(lessee_file);
-
 out_lessee:
 	drm_master_put(&lessee);
 
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -127,7 +127,6 @@ int do_fchownat(int dfd, const char __us
 
 extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *, const struct cred *);
-extern struct file *filp_clone_open(struct file *);
 
 /*
  * inode.c
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2401,6 +2401,7 @@ extern struct file *filp_open(const char
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file *filp_clone_open(struct file *);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);


