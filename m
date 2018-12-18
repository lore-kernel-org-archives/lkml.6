Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B88C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF44121873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151445;
	bh=7zwowiG9zQsRQ8jh+kAtdTCq3+zDYXPdmIN+ICL8a4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JHQwaLCvOQf6nNWo7eHjkfNBH5BVe+IfCbJgecb3gFKS7fpyBYPAjOmu5KokwznGO
	 RRIdGAMwibCr6FngoroWsi5eNpcnzflqcV+QtmqdjfBNY9kqvSjvF+h0M39ldHyxXZ
	 ywxOZ1RfWdeNjY3HJqm9d4HimmeQ74McSmE4QagQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeLRQoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbeLRQki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511CB21873;
        Tue, 18 Dec 2018 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151236;
        bh=7zwowiG9zQsRQ8jh+kAtdTCq3+zDYXPdmIN+ICL8a4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I46zsYpnyz+OXdFNebKBo6BHWag5IM2k38Yp0vDUwNEpSHy9DoGfmXgTxS38U6g4S
         dRoFH+x4UqFW3koaKsxbCREU8Gxz93flL7hyTih+OXhZLQJqhysXGBvE2TCmDgD3St
         1SKC/2fNoV/4TFE4aIwSscIruUyUCuX5SMY0iC1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Austin <chadaustin@fb.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 21/44] fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS
Date:   Tue, 18 Dec 2018 17:39:33 +0100
Message-Id: <20181218163929.991130990@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1439,7 +1439,7 @@ static int fuse_dir_open(struct inode *i
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
-	fuse_release_common(file, FUSE_RELEASEDIR);
+	fuse_release_common(file, true);
 
 	return 0;
 }
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -87,12 +87,12 @@ static void fuse_release_end(struct fuse
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
@@ -245,10 +245,11 @@ static void fuse_prepare_release(struct
 	req->in.args[0].value = inarg;
 }
 
-void fuse_release_common(struct file *file, int opcode)
+void fuse_release_common(struct file *file, bool isdir)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_req *req = ff->reserved_req;
+	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
 	fuse_prepare_release(ff, file->f_flags, opcode);
 
@@ -270,7 +271,7 @@ void fuse_release_common(struct file *fi
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fc->destroy_req != NULL);
+	fuse_file_put(ff, ff->fc->destroy_req != NULL, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
@@ -286,7 +287,7 @@ static int fuse_release(struct inode *in
 	if (fc->writeback_cache)
 		write_inode_now(inode, 1);
 
-	fuse_release_common(file, FUSE_RELEASE);
+	fuse_release_common(file, false);
 
 	/* return value is ignored by VFS */
 	return 0;
@@ -300,7 +301,7 @@ void fuse_sync_release(struct fuse_file
 	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
 	 * synchronous, we are fine with not doing igrab() here"
 	 */
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, true, false);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -805,7 +806,7 @@ static void fuse_readpages_end(struct fu
 		put_page(page);
 	}
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
 
 static void fuse_send_readpages(struct fuse_req *req, struct file *file)
@@ -1459,7 +1460,7 @@ static void fuse_writepage_free(struct f
 		__free_page(req->pages[i]);
 
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
 
 static void fuse_writepage_finish(struct fuse_conn *fc, struct fuse_req *req)
@@ -1616,7 +1617,7 @@ int fuse_write_inode(struct inode *inode
 	ff = __fuse_write_file_get(fc, fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, 0);
+		fuse_file_put(ff, false, false);
 
 	return err;
 }
@@ -1930,7 +1931,7 @@ static int fuse_writepages(struct addres
 		err = 0;
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false);
+		fuse_file_put(data.ff, false, false);
 
 	kfree(data.orig_pages);
 out:
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -749,7 +749,7 @@ void fuse_sync_release(struct fuse_file
 /**
  * Send RELEASE or RELEASEDIR request
  */
-void fuse_release_common(struct file *file, int opcode);
+void fuse_release_common(struct file *file, bool isdir);
 
 /**
  * Send FSYNC or FSYNCDIR request


