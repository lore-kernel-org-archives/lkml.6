Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i3/nCB3QGlstEgAAmS7hNA
	; Fri, 08 Jun 2018 18:51:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8ACD96089E; Fri,  8 Jun 2018 18:51:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0CDD8607DC;
	Fri,  8 Jun 2018 18:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CDD8607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeFHSvs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:51:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53806 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006Nt-1h; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] now we can fold open_check_o_direct() into do_dentry_open()
Date: Fri,  8 Jun 2018 19:50:13 +0100
Message-Id: <20180608185019.24472-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h |  1 -
 fs/namei.c    |  7 +------
 fs/open.c     | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 5645b4ebf494..08ac9cdee1b4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -125,7 +125,6 @@ int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 
-extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *, const struct cred *);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 3034c97df757..ef21c904f147 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3366,9 +3366,7 @@ static int do_last(struct nameidata *nd,
 	if (error)
 		goto out;
 opened:
-	error = open_check_o_direct(file);
-	if (!error)
-		error = ima_file_check(file, op->acc_mode, *opened);
+	error = ima_file_check(file, op->acc_mode, *opened);
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
@@ -3444,9 +3442,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		goto out2;
 	file->f_path.mnt = path.mnt;
 	error = finish_open(file, child, NULL);
-	if (error)
-		goto out2;
-	error = open_check_o_direct(file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/fs/open.c b/fs/open.c
index 83e489d43526..2724aa2e9635 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -724,16 +724,6 @@ SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
 	return ksys_fchown(fd, user, group);
 }
 
-int open_check_o_direct(struct file *f)
-{
-	/* NB: we're sure to have correct a_ops only after f_op->open */
-	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
-			return -EINVAL;
-	}
-	return 0;
-}
-
 static int do_dentry_open(struct file *f,
 			  struct inode *inode,
 			  int (*open)(struct inode *, struct file *),
@@ -810,6 +800,11 @@ static int do_dentry_open(struct file *f,
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
+	/* NB: we're sure to have correct a_ops only after f_op->open */
+	if (f->f_flags & O_DIRECT) {
+		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
+			return -EINVAL;
+	}
 	return 0;
 
 cleanup_all:
@@ -918,15 +913,11 @@ struct file *dentry_open(const struct path *path, int flags,
 	if (!IS_ERR(f)) {
 		f->f_flags = flags;
 		error = vfs_open(path, f, cred);
-		if (!error) {
-			/* from now on we need fput() to dispose of f */
-			error = open_check_o_direct(f);
-			if (error) {
+		if (error) {
+			if (f->f_mode & FMODE_OPENED)
 				fput(f);
-				f = ERR_PTR(error);
-			}
-		} else { 
-			put_filp(f);
+			else
+				put_filp(f);
 			f = ERR_PTR(error);
 		}
 	}
-- 
2.11.0
