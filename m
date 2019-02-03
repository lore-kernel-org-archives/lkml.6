Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA733C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC393218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfBCNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728694AbfBCNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:30 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIAH-0003tl-CS; Sun, 03 Feb 2019 13:50:29 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9s-0007Pk-NU; Sun, 03 Feb 2019 14:50:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Miklos Szeredi" <mszeredi@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.859284484@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 280/305] fuse: cleanup fuse_file refcounting
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 267d84449f52349ee252db684ed95ede18e51744 upstream.

struct fuse_file is stored in file->private_data.  Make this always be a
counting reference for consistency.

This also allows fuse_sync_release() to call fuse_file_put() instead of
partially duplicating its functionality.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[bwh: Backported to 3.16: force and background flags are bitfields]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 18 +++++++++---------
 fs/fuse/fuse_i.h |  1 -
 3 files changed, 10 insertions(+), 11 deletions(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -488,7 +488,7 @@ static int fuse_create_open(struct inode
 	if (err) {
 		fuse_sync_release(ff, flags);
 	} else {
-		file->private_data = fuse_file_get(ff);
+		file->private_data = ff;
 		fuse_finish_open(inode, file);
 	}
 	return err;
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -66,7 +66,7 @@ struct fuse_file *fuse_file_alloc(struct
 	}
 
 	INIT_LIST_HEAD(&ff->write_entry);
-	atomic_set(&ff->count, 0);
+	atomic_set(&ff->count, 1);
 	RB_CLEAR_NODE(&ff->polled_node);
 	init_waitqueue_head(&ff->poll_wait);
 
@@ -83,7 +83,7 @@ void fuse_file_free(struct fuse_file *ff
 	kfree(ff);
 }
 
-struct fuse_file *fuse_file_get(struct fuse_file *ff)
+static struct fuse_file *fuse_file_get(struct fuse_file *ff)
 {
 	atomic_inc(&ff->count);
 	return ff;
@@ -183,7 +183,7 @@ int fuse_do_open(struct fuse_conn *fc, u
 		ff->open_flags &= ~FOPEN_DIRECT_IO;
 
 	ff->nodeid = nodeid;
-	file->private_data = fuse_file_get(ff);
+	file->private_data = ff;
 
 	return 0;
 }
@@ -335,13 +335,13 @@ static int fuse_release(struct inode *in
 
 void fuse_sync_release(struct fuse_file *ff, int flags)
 {
-	WARN_ON(atomic_read(&ff->count) > 1);
+	WARN_ON(atomic_read(&ff->count) != 1);
 	fuse_prepare_release(ff, flags, FUSE_RELEASE);
-	ff->reserved_req->force = 1;
-	ff->reserved_req->background = 0;
-	fuse_request_send(ff->fc, ff->reserved_req);
-	fuse_put_request(ff->fc, ff->reserved_req);
-	kfree(ff);
+	/*
+	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
+	 * synchronous, we are fine with not doing igrab() here"
+	 */
+	fuse_file_put(ff, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -663,7 +663,6 @@ void fuse_read_fill(struct fuse_req *req
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
 struct fuse_file *fuse_file_alloc(struct fuse_conn *fc);
-struct fuse_file *fuse_file_get(struct fuse_file *ff);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 

