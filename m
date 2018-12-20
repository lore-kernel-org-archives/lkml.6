Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A14C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734621852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297999;
	bh=C9jsjI5YADVWV+JNXjZOFhD+T6Zg6pP4aSbr9p6inPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLp7DQfGbS+vuOzuosHyVw/zxjOjC93j1mh6e8X/3G96/or+eeeEvP9UGfqznH8EH
	 3fXBw6tvN2BDOsebDZyqnIf2XYlgeGBxLn/lUcWHdmUlwDCm7rK4MhAgIVX7A9NfcP
	 bd10FP/v2AalLoSb/+QAspJf84GV9GCXlX7doJSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeLTJ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbeLTJ0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA25217D7;
        Thu, 20 Dec 2018 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297993;
        bh=C9jsjI5YADVWV+JNXjZOFhD+T6Zg6pP4aSbr9p6inPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfpwXA2yyO8wSLsT9k3rYN2ynOFgnbizEFjbEHVoE4EIVhXv7nPND//oKxMFIm0Gp
         jImK27vgUX17D1hEGvXmbcUoj3HyvJ64bBtl6EUJ9/C0QWuAs/rLsfNQaYInqWVdZM
         8fvI2kVB0SEUpwzJSeG+tBbfV0XA057CHOS77Xhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Austin <chadaustin@fb.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 08/72] fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS
Date:   Thu, 20 Dec 2018 10:18:07 +0100
Message-Id: <20181220085922.664081342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chad Austin <chadaustin@fb.com>

commit 2e64ff154ce6ce9a8dc0f9556463916efa6ff460 upstream.

When FUSE_OPEN returns ENOSYS, the no_open bit is set on the connection.

Because the FUSE_RELEASE and FUSE_RELEASEDIR paths share code, this
incorrectly caused the FUSE_RELEASEDIR request to be dropped and never sent
to userspace.

Pass an isdir bool to distinguish between FUSE_RELEASE and FUSE_RELEASEDIR
inside of fuse_file_put.

Fixes: 7678ac50615d ("fuse: support clients that don't implement 'open'")
Cc: <stable@vger.kernel.org> # v3.14
Signed-off-by: Chad Austin <chadaustin@fb.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dir.c    |    2 +-
 fs/fuse/file.c   |   21 +++++++++++----------
 fs/fuse/fuse_i.h |    2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1424,7 +1424,7 @@ static int fuse_dir_open(struct inode *i
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
-	fuse_release_common(file, FUSE_RELEASEDIR);
+	fuse_release_common(file, true);
 
 	return 0;
 }
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -86,12 +86,12 @@ static void fuse_release_end(struct fuse
 	iput(req->misc.release.inode);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_req *req = ff->reserved_req;
 
-		if (ff->fc->no_open) {
+		if (ff->fc->no_open && !isdir) {
 			/*
 			 * Drop the release request when client does not
 			 * implement 'open'
@@ -244,10 +244,11 @@ static void fuse_prepare_release(struct
 	req->in.args[0].value = inarg;
 }
 
-void fuse_release_common(struct file *file, int opcode)
+void fuse_release_common(struct file *file, bool isdir)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_req *req = ff->reserved_req;
+	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
 	fuse_prepare_release(ff, file->f_flags, opcode);
 
@@ -269,7 +270,7 @@ void fuse_release_common(struct file *fi
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fc->destroy_req != NULL);
+	fuse_file_put(ff, ff->fc->destroy_req != NULL, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
@@ -285,7 +286,7 @@ static int fuse_release(struct inode *in
 	if (fc->writeback_cache)
 		write_inode_now(inode, 1);
 
-	fuse_release_common(file, FUSE_RELEASE);
+	fuse_release_common(file, false);
 
 	/* return value is ignored by VFS */
 	return 0;
@@ -299,7 +300,7 @@ void fuse_sync_release(struct fuse_file
 	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
 	 * synchronous, we are fine with not doing igrab() here"
 	 */
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, true, false);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -804,7 +805,7 @@ static void fuse_readpages_end(struct fu
 		put_page(page);
 	}
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
 
 static void fuse_send_readpages(struct fuse_req *req, struct file *file)
@@ -1458,7 +1459,7 @@ static void fuse_writepage_free(struct f
 		__free_page(req->pages[i]);
 
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
 
 static void fuse_writepage_finish(struct fuse_conn *fc, struct fuse_req *req)
@@ -1615,7 +1616,7 @@ int fuse_write_inode(struct inode *inode
 	ff = __fuse_write_file_get(fc, fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, 0);
+		fuse_file_put(ff, false, false);
 
 	return err;
 }
@@ -1929,7 +1930,7 @@ static int fuse_writepages(struct addres
 		err = 0;
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false);
+		fuse_file_put(data.ff, false, false);
 
 	kfree(data.orig_pages);
 out:
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -739,7 +739,7 @@ void fuse_sync_release(struct fuse_file
 /**
  * Send RELEASE or RELEASEDIR request
  */
-void fuse_release_common(struct file *file, int opcode);
+void fuse_release_common(struct file *file, bool isdir);
 
 /**
  * Send FSYNC or FSYNCDIR request


