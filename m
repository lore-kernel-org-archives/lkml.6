Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAFAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC7A20936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC7A20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbeGKC0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:26:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45638 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbeGKCYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lc-0003KB-VX; Wed, 11 Jul 2018 02:22:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 26/42] switch atomic_open() and lookup_open() to returning 0 in all success cases
Date:   Wed, 11 Jul 2018 03:21:50 +0100
Message-Id: <20180711022206.12571-26-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

caller can tell "opened" from "open it yourself" by looking at ->f_mode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8b1e5cb85f58..ca3f4dec8cda 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3027,9 +3027,9 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
  * Returns 0 if successful.  The file will have been created and attached to
  * @file by the filesystem calling finish_open().
  *
- * Returns 1 if the file was looked up only or didn't need creating.  The
- * caller will need to perform the open themselves.  @path will have been
- * updated to point to the new dentry.  This may be negative.
+ * If the file was looked up only or didn't need creating, FMODE_OPENED won't
+ * be set.  The caller will need to perform the open themselves.  @path will
+ * have been updated to point to the new dentry.  This may be negative.
  *
  * Returns an error code otherwise.
  */
@@ -3082,7 +3082,7 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 			} else {
 				path->dentry = dentry;
 				path->mnt = nd->path.mnt;
-				return 1;
+				return 0;
 			}
 		}
 	}
@@ -3093,17 +3093,17 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 /*
  * Look up and maybe create and open the last component.
  *
- * Must be called with i_mutex held on parent.
- *
- * Returns 0 if the file was successfully atomically created (if necessary) and
- * opened.  In this case the file will be returned attached to @file.
+ * Must be called with parent locked (exclusive in O_CREAT case).
  *
- * Returns 1 if the file was not completely opened at this time, though lookups
- * and creations will have been performed and the dentry returned in @path will
- * be positive upon return if O_CREAT was specified.  If O_CREAT wasn't
- * specified then a negative dentry may be returned.
+ * Returns 0 on success, that is, if
+ *  the file was successfully atomically created (if necessary) and opened, or
+ *  the file was not completely opened at this time, though lookups and
+ *  creations were performed.
+ * These case are distinguished by presence of FMODE_OPENED on file->f_mode.
+ * In the latter case dentry returned in @path might be negative if O_CREAT
+ * hadn't been specified.
  *
- * An error code is returned otherwise.
+ * An error code is returned on failure.
  */
 static int lookup_open(struct nameidata *nd, struct path *path,
 			struct file *file,
@@ -3225,7 +3225,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 out_no_open:
 	path->dentry = dentry;
 	path->mnt = nd->path.mnt;
-	return 1;
+	return 0;
 
 out_dput:
 	dput(dentry);
@@ -3308,10 +3308,10 @@ static int do_last(struct nameidata *nd,
 	else
 		inode_unlock_shared(dir->d_inode);
 
-	if (error <= 0) {
-		if (error)
-			goto out;
+	if (error)
+		goto out;
 
+	if (file->f_mode & FMODE_OPENED) {
 		if ((file->f_mode & FMODE_CREATED) ||
 		    !S_ISREG(file_inode(file)->i_mode))
 			will_truncate = false;
-- 
2.11.0

