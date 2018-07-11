Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C86C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23D020936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23D020936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeGKC2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:28:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45578 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeGKCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003J0-Oy; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 16/42] now we can fold open_check_o_direct() into do_dentry_open()
Date:   Wed, 11 Jul 2018 03:21:40 +0100
Message-Id: <20180711022206.12571-16-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h |  1 -
 fs/namei.c    |  7 +------
 fs/open.c     | 17 +++++------------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index ab84a29f4874..33a28438570e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -125,7 +125,6 @@ int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 
-extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 5a79bd170410..39b5da70d6f5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3401,9 +3401,7 @@ static int do_last(struct nameidata *nd,
 		goto out;
 	*opened |= FILE_OPENED;
 opened:
-	error = open_check_o_direct(file);
-	if (!error)
-		error = ima_file_check(file, op->acc_mode, *opened);
+	error = ima_file_check(file, op->acc_mode, *opened);
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
@@ -3479,9 +3477,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		goto out2;
 	file->f_path.mnt = path.mnt;
 	error = finish_open(file, child, NULL, opened);
-	if (error)
-		goto out2;
-	error = open_check_o_direct(file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/fs/open.c b/fs/open.c
index affdeebe5fd5..2aa3dc03e2fd 100644
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
 			  int (*open)(struct inode *, struct file *))
@@ -809,6 +799,11 @@ static int do_dentry_open(struct file *f,
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
+	/* NB: we're sure to have correct a_ops only after f_op->open */
+	if (f->f_flags & O_DIRECT) {
+		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
+			return -EINVAL;
+	}
 	return 0;
 
 cleanup_all:
@@ -925,8 +920,6 @@ struct file *dentry_open(const struct path *path, int flags,
 	if (!IS_ERR(f)) {
 		f->f_flags = flags;
 		error = vfs_open(path, f);
-		if (!error)
-			error = open_check_o_direct(f);
 		if (error) {
 			fput(f);
 			f = ERR_PTR(error);
-- 
2.11.0

