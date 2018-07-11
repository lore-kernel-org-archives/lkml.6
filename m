Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60982C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C14208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C14208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbeGKC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:27:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45522 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbeGKCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003I9-18; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 09/42] pass creds to get_empty_filp(), make sure dentry_open() passes the right creds
Date:   Wed, 11 Jul 2018 03:21:33 +0100
Message-Id: <20180711022206.12571-9-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and rename get_empty_filp() to alloc_empty_file().

dentry_open() gets creds as argument, but the only thing that sees those is
security_file_open() - file->f_cred still ends up with current_cred().  For
almost all callers it's the same thing, but there are several broken cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c | 5 ++---
 fs/internal.h   | 2 +-
 fs/namei.c      | 2 +-
 fs/open.c       | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eee7cf629e52..d7a03a47b702 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -101,9 +101,8 @@ int proc_nr_files(struct ctl_table *table, int write,
  * done, you will imbalance int the mount's writer count
  * and a warning at __fput() time.
  */
-struct file *get_empty_filp(void)
+struct file *alloc_empty_file(const struct cred *cred)
 {
-	const struct cred *cred = current_cred();
 	static long old_max;
 	struct file *f;
 	int error;
@@ -161,7 +160,7 @@ struct file *alloc_file(const struct path *path, fmode_t mode,
 {
 	struct file *file;
 
-	file = get_empty_filp();
+	file = alloc_empty_file(current_cred());
 	if (IS_ERR(file))
 		return file;
 
diff --git a/fs/internal.h b/fs/internal.h
index 5645b4ebf494..66473bf388e4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -93,7 +93,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 /*
  * file_table.c
  */
-extern struct file *get_empty_filp(void);
+extern struct file *alloc_empty_file(const struct cred *);
 
 /*
  * super.c
diff --git a/fs/namei.c b/fs/namei.c
index 734cef54fdf8..af2ec1803f57 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3513,7 +3513,7 @@ static struct file *path_openat(struct nameidata *nd,
 	int opened = 0;
 	int error;
 
-	file = get_empty_filp();
+	file = alloc_empty_file(current_cred());
 	if (IS_ERR(file))
 		return file;
 
diff --git a/fs/open.c b/fs/open.c
index 558802e66e00..c0dbc67c31f1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -923,7 +923,7 @@ struct file *dentry_open(const struct path *path, int flags,
 	/* We must always pass in a valid mount pointer. */
 	BUG_ON(!path->mnt);
 
-	f = get_empty_filp();
+	f = alloc_empty_file(cred);
 	if (!IS_ERR(f)) {
 		f->f_flags = flags;
 		error = vfs_open(path, f, cred);
-- 
2.11.0

