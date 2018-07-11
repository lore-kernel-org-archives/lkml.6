Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA63208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA63208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbeGKC1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:27:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45566 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732381AbeGKCYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003Im-Gl; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 14/42] fold put_filp() into fput()
Date:   Wed, 11 Jul 2018 03:21:38 +0100
Message-Id: <20180711022206.12571-14-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Just check FMODE_OPENED in __fput() and be done with that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c      | 15 +++++----------
 fs/namei.c           |  4 ++--
 fs/open.c            | 11 +++--------
 include/linux/file.h |  1 -
 4 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eaee481295de..d55dc579ae4e 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -190,6 +190,9 @@ static void __fput(struct file *file)
 	struct vfsmount *mnt = file->f_path.mnt;
 	struct inode *inode = file->f_inode;
 
+	if (unlikely(!(file->f_mode & FMODE_OPENED)))
+		goto out;
+
 	might_sleep();
 
 	fsnotify_close(file);
@@ -219,12 +222,10 @@ static void __fput(struct file *file)
 		put_write_access(inode);
 		__mnt_drop_write(mnt);
 	}
-	file->f_path.dentry = NULL;
-	file->f_path.mnt = NULL;
-	file->f_inode = NULL;
-	file_free(file);
 	dput(dentry);
 	mntput(mnt);
+out:
+	file_free(file);
 }
 
 static LLIST_HEAD(delayed_fput_list);
@@ -299,12 +300,6 @@ void __fput_sync(struct file *file)
 
 EXPORT_SYMBOL(fput);
 
-void put_filp(struct file *file)
-{
-	if (atomic_long_dec_and_test(&file->f_count))
-		file_free(file);
-}
-
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
diff --git a/fs/namei.c b/fs/namei.c
index 7b1fe5e30a0d..3d4e20a1c756 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3533,7 +3533,7 @@ static struct file *path_openat(struct nameidata *nd,
 
 	s = path_init(nd, flags);
 	if (IS_ERR(s)) {
-		put_filp(file);
+		fput(file);
 		return ERR_CAST(s);
 	}
 	while (!(error = link_path_walk(s, nd)) &&
@@ -3549,7 +3549,7 @@ static struct file *path_openat(struct nameidata *nd,
 out2:
 	if (!(opened & FILE_OPENED)) {
 		BUG_ON(!error);
-		put_filp(file);
+		fput(file);
 	}
 	if (unlikely(error)) {
 		if (error == -EOPENSTALE) {
diff --git a/fs/open.c b/fs/open.c
index ce092dda5472..affdeebe5fd5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -925,15 +925,10 @@ struct file *dentry_open(const struct path *path, int flags,
 	if (!IS_ERR(f)) {
 		f->f_flags = flags;
 		error = vfs_open(path, f);
-		if (!error) {
-			/* from now on we need fput() to dispose of f */
+		if (!error)
 			error = open_check_o_direct(f);
-			if (error) {
-				fput(f);
-				f = ERR_PTR(error);
-			}
-		} else { 
-			put_filp(f);
+		if (error) {
+			fput(f);
 			f = ERR_PTR(error);
 		}
 	}
diff --git a/include/linux/file.h b/include/linux/file.h
index 279720db984a..d771bc05da77 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -78,7 +78,6 @@ extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
 extern bool get_close_on_exec(unsigned int fd);
-extern void put_filp(struct file *);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
 
-- 
2.11.0

