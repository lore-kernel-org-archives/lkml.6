Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FF02082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FF02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeI1WHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50791 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbeI1WHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so2701296wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XvcPXrV9Q75y8Ybd/TmXj7Yyzj8YIqMI6OsbZktcnUM=;
        b=UAf7UeGpInXLAjJMwCt+s4iaiXeKmYDcj+1YUwZtGp0bZ55JzHjC4/Xm0s+kGSOYQW
         xrkXkLrgp3ff5rspG7wRqrseSV3cMNnM/chUd612pPk5/qszX8mp5I3riQY6IuOsrlKB
         jKOSXC8CtjAg8xwwOPgbrI/w+CZIWEi4fb6GXBz5aPwveFzHm3QgPWOr23+dq7giqHoG
         yjYmZub/aQ0l4kwJsQheO/NWQyXY5Ib/10w+0NlsNq1GkrS2/M38HpwCRaDJ+TtRVDos
         uG1f0AfbfoLzNLXwXvT0xlOEpOYA4kct7nelxyQJekZbKNEWWQv7IO68lI+ioRNK21bK
         5xpg==
X-Gm-Message-State: ABuFfojqo5E147thVFA1iyc0RGHTh1E0pDZISfmfM3I7BeWTxADODuQ+
        DZmjGy0Sj60aQxoNXFp4EiMYpeDqGGk=
X-Google-Smtp-Source: ACcGV61vsGpMlBZv+MGXobyHmoN+829N/huNmGjtdwxbjBjYwD0+CnPvBi22FpEm01IuMY4sCwirxA==
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr2318036wmc.24.1538149365405;
        Fri, 28 Sep 2018 08:42:45 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:44 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] fuse: allow caching readdir
Date:   Fri, 28 Sep 2018 17:42:29 +0200
Message-Id: <20180928154234.19270-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just adds the cache filling functions, which are invoked if
FOPEN_CACHE_DIR flag is set in the OPENDIR reply.

Cache reading and cache invalidation are added by subsequent patches.

The directory cache uses the page cache.  Directory entries are packed into
a page in the same format as in the READDIR reply.  A page only contains
whole entries, the space at the end of the page is cleared.  The page is
locked while being modified.

Multiple parallel readdirs on the same directory can fill the cache; the
only constraint is that continuity must be maintained (d_off of last entry
points to position of current entry).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h  | 15 ++++++++++
 fs/fuse/inode.c   |  4 +++
 fs/fuse/readdir.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5e01ea3d137d..d01c4606c149 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -103,6 +103,21 @@ struct fuse_inode {
 	/** List of writepage requestst (pending or sent) */
 	struct list_head writepages;
 
+	/** readdir cache */
+	struct {
+		/** true if fully cached */
+		bool cached;
+
+		/** size of cache */
+		loff_t size;
+
+		/** position at end of cache (position of next entry) */
+		loff_t pos;
+
+		/** protects above fields */
+		spinlock_t lock;
+	} rdc;
+
 	/** Miscellaneous bits describing inode state */
 	unsigned long state;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index db9e60b7eb69..03d8105a851d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -100,6 +100,10 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->queued_writes);
 	INIT_LIST_HEAD(&fi->writepages);
 	init_waitqueue_head(&fi->page_waitq);
+	spin_lock_init(&fi->rdc.lock);
+	fi->rdc.cached = false;
+	fi->rdc.size = 0;
+	fi->rdc.pos = 0;
 	mutex_init(&fi->mutex);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 65336c93c1f4..180f336b933f 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -26,9 +26,91 @@ static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 	return false;
 }
 
+static void fuse_add_dirent_to_cache(struct file *file,
+				     struct fuse_dirent *dirent, loff_t pos)
+{
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
+	size_t reclen = FUSE_DIRENT_SIZE(dirent);
+	pgoff_t index;
+	struct page *page;
+	loff_t size;
+	unsigned int offset;
+	void *addr;
+
+	spin_lock(&fi->rdc.lock);
+	/*
+	 * Is cache already completed?  Or this entry does not go at the end of
+	 * cache?
+	 */
+	if (fi->rdc.cached || pos != fi->rdc.pos) {
+		spin_unlock(&fi->rdc.lock);
+		return;
+	}
+	size = fi->rdc.size;
+	offset = size & ~PAGE_MASK;
+	index = size >> PAGE_SHIFT;
+	/* Dirent doesn't fit in current page?  Jump to next page. */
+	if (offset + reclen > PAGE_SIZE) {
+		index++;
+		offset = 0;
+	}
+	spin_unlock(&fi->rdc.lock);
+
+	if (offset) {
+		page = find_lock_page(file->f_mapping, index);
+	} else {
+		page = find_or_create_page(file->f_mapping, index,
+					   mapping_gfp_mask(file->f_mapping));
+	}
+	if (!page)
+		return;
+
+	spin_lock(&fi->rdc.lock);
+	/* Raced with another readdir */
+	if (fi->rdc.size != size || WARN_ON(fi->rdc.pos != pos))
+		goto unlock;
+
+	addr = kmap_atomic(page);
+	if (!offset)
+		clear_page(addr);
+	memcpy(addr + offset, dirent, reclen);
+	kunmap_atomic(addr);
+	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
+	fi->rdc.pos = dirent->off;
+unlock:
+	spin_unlock(&fi->rdc.lock);
+	unlock_page(page);
+	put_page(page);
+}
+
+static void fuse_readdir_cache_end(struct file *file, loff_t pos)
+{
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
+	loff_t end;
+
+	spin_lock(&fi->rdc.lock);
+	/* does cache end position match current position? */
+	if (fi->rdc.pos != pos) {
+		spin_unlock(&fi->rdc.lock);
+		return;
+	}
+
+	fi->rdc.cached = true;
+	end = ALIGN(fi->rdc.size, PAGE_SIZE);
+	spin_unlock(&fi->rdc.lock);
+
+	/* truncate unused tail of cache */
+	truncate_inode_pages(file->f_mapping, end);
+}
+
 static bool fuse_emit(struct file *file, struct dir_context *ctx,
 		      struct fuse_dirent *dirent)
 {
+	struct fuse_file *ff = file->private_data;
+
+	if (ff->open_flags & FOPEN_CACHE_DIR)
+		fuse_add_dirent_to_cache(file, dirent, ctx->pos);
+
 	return dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
 			dirent->type);
 }
@@ -249,7 +331,12 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (!err) {
-		if (plus) {
+		if (!nbytes) {
+			struct fuse_file *ff = file->private_data;
+
+			if (ff->open_flags & FOPEN_CACHE_DIR)
+				fuse_readdir_cache_end(file, ctx->pos);
+		} else if (plus) {
 			err = parse_dirplusfile(page_address(page), nbytes,
 						file, ctx, attr_version);
 		} else {
-- 
2.14.3

