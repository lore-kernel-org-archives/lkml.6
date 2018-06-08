Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L8ReBHvQGlsSFAAAmS7hNA
	; Fri, 08 Jun 2018 18:53:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47CC0607DC; Fri,  8 Jun 2018 18:53:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BF8E1601D2;
	Fri,  8 Jun 2018 18:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF8E1601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeFHSxO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:53:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53800 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSp-0006Nn-W2; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] switch all remaining checks for FILE_OPENED to FMODE_OPENED
Date: Fri,  8 Jun 2018 19:50:12 +0100
Message-Id: <20180608185019.24472-6-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2abd00079b26..3034c97df757 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3027,8 +3027,6 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 		 * permission here.
 		 */
 		int acc_mode = op->acc_mode;
-		if (file->f_mode & FMODE_OPENED)
-			*opened |= FILE_OPENED;
 		if (*opened & FILE_CREATED) {
 			WARN_ON(!(open_flag & O_CREAT));
 			fsnotify_create(dir, dentry);
@@ -3363,11 +3361,10 @@ static int do_last(struct nameidata *nd,
 	error = may_open(&nd->path, acc_mode, open_flag);
 	if (error)
 		goto out;
-	BUG_ON(*opened & FILE_OPENED); /* once it's opened, it's opened */
+	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 	error = vfs_open(&nd->path, file, current_cred());
 	if (error)
 		goto out;
-	*opened |= FILE_OPENED;
 opened:
 	error = open_check_o_direct(file);
 	if (!error)
@@ -3449,8 +3446,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	error = finish_open(file, child, NULL);
 	if (error)
 		goto out2;
-	if (file->f_mode & FMODE_OPENED)
-		*opened |= FILE_OPENED;
 	error = open_check_o_direct(file);
 out2:
 	mnt_drop_write(path.mnt);
@@ -3492,8 +3487,6 @@ static struct file *path_openat(struct nameidata *nd,
 
 	if (unlikely(file->f_flags & O_PATH)) {
 		error = do_o_path(nd, flags, file);
-		if (!error)
-			opened |= FILE_OPENED;
 		goto out2;
 	}
 
@@ -3514,12 +3507,12 @@ static struct file *path_openat(struct nameidata *nd,
 	terminate_walk(nd);
 out2:
 	if (likely(!error)) {
-		if (likely(opened & FILE_OPENED))
+		if (likely(file->f_mode & FMODE_OPENED))
 			return file;
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	if (opened & FILE_OPENED)
+	if (file->f_mode & FMODE_OPENED)
 		fput(file);
 	else
 		put_filp(file);
-- 
2.11.0
