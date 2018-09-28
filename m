Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82320C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459F920779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459F920779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeI1WHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34413 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeI1WHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id z4-v6so5513491wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B2ZwOEo60CdExzSgD8bIEzDFyWtJeUcZ0M09C+yFE00=;
        b=OEa4GDePfHWi2r9R1i8T6kMF8CkZlaky6SddrtKDckCJk7m+m+JpfuCnjYA07WpBpz
         E4OBXay+O+gsglSk4BJVHj7FS9GXJOAKagrJEwKog0EQ7QSI5qERi9m1vVvpDGkph3hI
         0oNWSXoJmYA9CWFYm4d+0sxP0vMgow7LeYwvzYqKlOT/8MoKoY8U1h0scYzZ+4QWqk8n
         Vp/p097JJ8yR1F6W6UnHfGyL5ddio1wOh0es+t934wb+7ehqz6Zl0nLUaZ/02ZRw59sY
         RwLymyU+7OuUdZTSvK4uQwx4EmDwd4o6C9Gabtaw7ruR4kotNsFeP5SDBnPiyDhgsCcE
         b1kw==
X-Gm-Message-State: ABuFfoiNNw9zNBNeHL+E0UWcxGRkZ4Z6cb+j/pMES/6YYrchzN6gJ0+k
        fMUyPFkJrQ6eua8APHlkoXkRJw==
X-Google-Smtp-Source: ACcGV624Ai74gf20ZHY6Qn04ZIp5HmytJWMSksJEoTRQtUyzQFNQX6E1b2Uw2uPqG5M5diyLintijA==
X-Received: by 2002:adf:afdd:: with SMTP id y29-v6mr9268990wrd.176.1538149370293;
        Fri, 28 Sep 2018 08:42:50 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:49 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] fuse: use iversion for readdir cache verification
Date:   Fri, 28 Sep 2018 17:42:33 +0200
Message-Id: <20180928154234.19270-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the internal iversion counter to make sure modifications of the
directory through this filesystem are not missed by the mtime check (due to
mtime granularity).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c     | 21 ++++++++++++++-------
 fs/fuse/fuse_i.h  |  3 +++
 fs/fuse/readdir.c |  5 ++++-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3a333b0ea9ad..6800fdc3e730 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -14,6 +14,7 @@
 #include <linux/namei.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/iversion.h>
 #include <linux/posix_acl.h>
 
 static void fuse_advise_use_readdirplus(struct inode *dir)
@@ -89,6 +90,12 @@ void fuse_invalidate_attr(struct inode *inode)
 	get_fuse_inode(inode)->i_time = 0;
 }
 
+static void fuse_dir_changed(struct inode *dir)
+{
+	fuse_invalidate_attr(dir);
+	inode_maybe_inc_iversion(dir, false);
+}
+
 /**
  * Mark the attributes as stale due to an atime change.  Avoid the invalidate if
  * atime is not used.
@@ -447,7 +454,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	kfree(forget);
 	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
-	fuse_invalidate_attr(dir);
+	fuse_dir_changed(dir);
 	err = finish_open(file, entry, generic_file_open);
 	if (err) {
 		fuse_sync_release(ff, flags);
@@ -561,7 +568,7 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 	} else {
 		fuse_change_entry_timeout(entry, &outarg);
 	}
-	fuse_invalidate_attr(dir);
+	fuse_dir_changed(dir);
 	return 0;
 
  out_put_forget_req:
@@ -671,7 +678,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 			drop_nlink(inode);
 		spin_unlock(&fc->lock);
 		fuse_invalidate_attr(inode);
-		fuse_invalidate_attr(dir);
+		fuse_dir_changed(dir);
 		fuse_invalidate_entry_cache(entry);
 		fuse_update_ctime(inode);
 	} else if (err == -EINTR)
@@ -693,7 +700,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	err = fuse_simple_request(fc, &args);
 	if (!err) {
 		clear_nlink(d_inode(entry));
-		fuse_invalidate_attr(dir);
+		fuse_dir_changed(dir);
 		fuse_invalidate_entry_cache(entry);
 	} else if (err == -EINTR)
 		fuse_invalidate_entry(entry);
@@ -732,9 +739,9 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 			fuse_update_ctime(d_inode(newent));
 		}
 
-		fuse_invalidate_attr(olddir);
+		fuse_dir_changed(olddir);
 		if (olddir != newdir)
-			fuse_invalidate_attr(newdir);
+			fuse_dir_changed(newdir);
 
 		/* newent will end up negative */
 		if (!(flags & RENAME_EXCHANGE) && d_really_is_positive(newent)) {
@@ -967,7 +974,7 @@ int fuse_reverse_inval_entry(struct super_block *sb, u64 parent_nodeid,
 	if (!entry)
 		goto unlock;
 
-	fuse_invalidate_attr(parent);
+	fuse_dir_changed(parent);
 	fuse_invalidate_entry(entry);
 
 	if (child_nodeid != 0 && d_really_is_positive(entry)) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e498f9edf01f..1e8d20e86760 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -120,6 +120,9 @@ struct fuse_inode {
 		/** modification time of directory when cache was started */
 		struct timespec64 mtime;
 
+		/** iversion of directory when cache was started */
+		u64 iversion;
+
 		/** protects above fields */
 		spinlock_t lock;
 	} rdc;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index f96525cef518..d91ae7449b73 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -8,6 +8,7 @@
 
 
 #include "fuse_i.h"
+#include <linux/iversion.h>
 #include <linux/posix_acl.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
@@ -445,6 +446,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		/* Starting cache? Set cache mtime. */
 		if (!ctx->pos && !fi->rdc.size) {
 			fi->rdc.mtime = inode->i_mtime;
+			fi->rdc.iversion = inode_query_iversion(inode);
 		}
 		spin_unlock(&fi->rdc.lock);
 		return UNCACHED;
@@ -455,7 +457,8 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	 * changed, and reset the cache if so.
 	 */
 	if (!ctx->pos) {
-		if (!timespec64_equal(&fi->rdc.mtime, &inode->i_mtime)) {
+		if (inode_peek_iversion(inode) != fi->rdc.iversion ||
+		    !timespec64_equal(&fi->rdc.mtime, &inode->i_mtime)) {
 			fuse_rdc_reset(inode);
 			goto retry_locked;
 		}
-- 
2.14.3

