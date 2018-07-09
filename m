Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCF52089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCF52089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932597AbeGIE72 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:59:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38074 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbeGIEyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBm-0003es-D7; Mon, 09 Jul 2018 04:54:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 08/27] switch all remaining checks for FILE_OPENED to FMODE_OPENED
Date:   Mon,  9 Jul 2018 05:53:58 +0100
Message-Id: <20180709045417.13988-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and don't bother with setting FILE_OPENED at all.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 36c2fa804e26..b324f59f8209 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3061,8 +3061,6 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 		 * permission here.
 		 */
 		int acc_mode = op->acc_mode;
-		if (file->f_mode & FMODE_OPENED)
-			*opened |= FILE_OPENED;
 		if (*opened & FILE_CREATED) {
 			WARN_ON(!(open_flag & O_CREAT));
 			fsnotify_create(dir, dentry);
@@ -3397,11 +3395,10 @@ static int do_last(struct nameidata *nd,
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
@@ -3483,8 +3480,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	error = finish_open(file, child, NULL);
 	if (error)
 		goto out2;
-	if (file->f_mode & FMODE_OPENED)
-		*opened |= FILE_OPENED;
 	error = open_check_o_direct(file);
 out2:
 	mnt_drop_write(path.mnt);
@@ -3526,8 +3521,6 @@ static struct file *path_openat(struct nameidata *nd,
 
 	if (unlikely(file->f_flags & O_PATH)) {
 		error = do_o_path(nd, flags, file);
-		if (!error)
-			opened |= FILE_OPENED;
 		goto out2;
 	}
 
@@ -3548,12 +3541,12 @@ static struct file *path_openat(struct nameidata *nd,
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

