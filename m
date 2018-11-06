Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3855C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A013D2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A013D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeKFTIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:59850 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFTIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:12 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxtj-00035Q-Gx; Tue, 06 Nov 2018 12:43:47 +0300
Subject: [PATCH 2/6] fuse: Add fuse_inode argument to fuse_prepare_release()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:43:46 +0300
Message-ID: <154149742692.18189.9352264643667833361.stgit@localhost.localdomain>
In-Reply-To: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is preparation for next patches, which introduce
new fuse_inode::lock for protection fuse_file::write_entry
linked into fuse_inode::write_files.

This patch just passes new argument to the function.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/cuse.c   |    3 ++-
 fs/fuse/dir.c    |    6 ++++--
 fs/fuse/file.c   |   10 ++++++----
 fs/fuse/fuse_i.h |    2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 8f68181256c0..d73eba592ba1 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -141,10 +141,11 @@ static int cuse_open(struct inode *inode, struct file *file)
 
 static int cuse_release(struct inode *inode, struct file *file)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fc;
 
-	fuse_sync_release(ff, file->f_flags);
+	fuse_sync_release(fi, ff, file->f_flags);
 	fuse_conn_put(fc);
 
 	return 0;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c71f7e9ee0f7..7058bbf69c3c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -400,6 +400,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_create_in inarg;
 	struct fuse_open_out outopen;
 	struct fuse_entry_out outentry;
+	struct fuse_inode *fi;
 	struct fuse_file *ff;
 
 	/* Userspace expects S_IFREG in create mode */
@@ -451,7 +452,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
-		fuse_sync_release(ff, flags);
+		fuse_sync_release(NULL, ff, flags);
 		fuse_queue_forget(fc, forget, outentry.nodeid, 1);
 		err = -ENOMEM;
 		goto out_err;
@@ -462,7 +463,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	fuse_dir_changed(dir);
 	err = finish_open(file, entry, generic_file_open);
 	if (err) {
-		fuse_sync_release(ff, flags);
+		fi = get_fuse_inode(inode);
+		fuse_sync_release(fi, ff, flags);
 	} else {
 		file->private_data = ff;
 		fuse_finish_open(inode, file);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d5bd29610875..fa7580d47d0c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -224,7 +224,8 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	return err;
 }
 
-static void fuse_prepare_release(struct fuse_file *ff, int flags, int opcode)
+static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
+				 int flags, int opcode)
 {
 	struct fuse_conn *fc = ff->fc;
 	struct fuse_req *req = ff->reserved_req;
@@ -249,10 +250,11 @@ static void fuse_prepare_release(struct fuse_file *ff, int flags, int opcode)
 
 void fuse_release_common(struct file *file, int opcode)
 {
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	struct fuse_file *ff = file->private_data;
 	struct fuse_req *req = ff->reserved_req;
 
-	fuse_prepare_release(ff, file->f_flags, opcode);
+	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
 	if (ff->flock) {
 		struct fuse_release_in *inarg = &req->misc.release.in;
@@ -294,10 +296,10 @@ static int fuse_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-void fuse_sync_release(struct fuse_file *ff, int flags)
+void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff, int flags)
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
-	fuse_prepare_release(ff, flags, FUSE_RELEASE);
+	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE);
 	/*
 	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
 	 * synchronous, we are fine with not doing igrab() here"
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 38bd7ca1908a..9e23e871873b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -817,7 +817,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 
-void fuse_sync_release(struct fuse_file *ff, int flags);
+void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff, int flags);
 
 /**
  * Send RELEASE or RELEASEDIR request

