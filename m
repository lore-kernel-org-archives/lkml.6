Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FBC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB48218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfBCNvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:51:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54356 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728993AbfBCNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:51:02 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIAm-0003th-Nu; Sun, 03 Feb 2019 13:51:00 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9s-0007Pr-Q5; Sun, 03 Feb 2019 14:50:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Chad Austin" <chadaustin@fb.com>,
        "Miklos Szeredi" <mszeredi@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.135740693@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 281/305] fuse: continue to send FUSE_RELEASEDIR when
 FUSE_OPEN returns ENOSYS
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Chad Austin <chadaustin@fb.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 21 +++++++++++----------
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1510,7 +1510,7 @@ static int fuse_dir_open(struct inode *i
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
-	fuse_release_common(file, FUSE_RELEASEDIR);
+	fuse_release_common(file, true);
 
 	return 0;
 }
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -122,12 +122,12 @@ static void fuse_release_end(struct fuse
 	}
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
 	if (atomic_dec_and_test(&ff->count)) {
 		struct fuse_req *req = ff->reserved_req;
 
-		if (ff->fc->no_open) {
+		if (ff->fc->no_open && !isdir) {
 			/*
 			 * Drop the release request when client does not
 			 * implement 'open'
@@ -280,10 +280,11 @@ static void fuse_prepare_release(struct
 	req->in.args[0].value = inarg;
 }
 
-void fuse_release_common(struct file *file, int opcode)
+void fuse_release_common(struct file *file, bool isdir)
 {
 	struct fuse_file *ff;
 	struct fuse_req *req;
+	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
 	ff = file->private_data;
 	if (unlikely(!ff))
@@ -311,7 +312,7 @@ void fuse_release_common(struct file *fi
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fc->destroy_req != NULL);
+	fuse_file_put(ff, ff->fc->destroy_req != NULL, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
@@ -327,7 +328,7 @@ static int fuse_release(struct inode *in
 	if (fc->writeback_cache)
 		write_inode_now(inode, 1);
 
-	fuse_release_common(file, FUSE_RELEASE);
+	fuse_release_common(file, false);
 
 	/* return value is ignored by VFS */
 	return 0;
@@ -341,7 +342,7 @@ void fuse_sync_release(struct fuse_file
 	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
 	 * synchronous, we are fine with not doing igrab() here"
 	 */
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, true, false);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -849,7 +850,7 @@ static void fuse_readpages_end(struct fu
 		page_cache_release(page);
 	}
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
 
 static void fuse_send_readpages(struct fuse_req *req, struct file *file)
@@ -1528,7 +1529,7 @@ static void fuse_writepage_free(struct f
 		__free_page(req->pages[i]);
 
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
 
 static void fuse_writepage_finish(struct fuse_conn *fc, struct fuse_req *req)
@@ -1685,7 +1686,7 @@ int fuse_write_inode(struct inode *inode
 	ff = __fuse_write_file_get(fc, fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, 0);
+		fuse_file_put(ff, false, false);
 
 	return err;
 }
@@ -1998,7 +1999,7 @@ static int fuse_writepages(struct addres
 		err = 0;
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false);
+		fuse_file_put(data.ff, false, false);
 
 	kfree(data.orig_pages);
 out:
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -671,7 +671,7 @@ void fuse_sync_release(struct fuse_file
 /**
  * Send RELEASE or RELEASEDIR request
  */
-void fuse_release_common(struct file *file, int opcode);
+void fuse_release_common(struct file *file, bool isdir);
 
 /**
  * Send FSYNC or FSYNCDIR request

