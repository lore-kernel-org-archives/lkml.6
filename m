Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED67C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BAD2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BAD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeI1WHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbeI1WHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so2696882wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FsG1PcQs0PNOC0pUOJwmI0AoowMviypZIXSn3r8DCmU=;
        b=IHrYVLJG0RiKN3c37gmKVjpesjQH6zs4So94AN9J48codrhi5iAgP0FVpf0dxqNMWv
         q/GMRZgsRtyx/k/KSKgk3Xlw8tRLRWAwR+aQnqQl6YfRQcUV5w2nPjd4XPuERmJUnasR
         0FT19OyYz8x4QbAb35QBNt9xSe5JpsXyqJ/fTlzZa1sQwSBT4NMsN4j4n6eqddecUXR9
         WybR8hV5l5fjkjzNPwMrhx3FJax/xse0vyKbXx3SX3AE1P+efovvE7AaKo6wUjbgxgaH
         9/q/M6PW8Je2wyielzjH6lCWvNqA8MrNPWU2Cmdk3RjDsX+3cZRjZbfscUAiI21scpY9
         FZlw==
X-Gm-Message-State: ABuFfohyUYoclZFA3QhqDHDffz/JjCDihAWJsH5+dQqKfxwms9eJh3vB
        rXALGkkWT8hNks5y5LI/4lNcUA==
X-Google-Smtp-Source: ACcGV60awy0c9wEI45PQHRKW2FE69nnqpUzf647R5vZxs8BgfzwbbyLudCDuF9u+GfLz4PXaHf+/sw==
X-Received: by 2002:a1c:14d1:: with SMTP id 200-v6mr2327532wmu.106.1538149366711;
        Fri, 28 Sep 2018 08:42:46 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:46 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] fuse: allow using readdir cache
Date:   Fri, 28 Sep 2018 17:42:30 +0200
Message-Id: <20180928154234.19270-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache is only used if it's completed, not while it's still being
filled; this constraint could be lifted later, if it turns out to be
useful.

Introduce state in struct fuse_file that indicates the position within the
cache.  After a seek, reset the position to the beginning of the cache and
search the cache for the current position.  If the current position is not
found in the cache, then fall back to uncached readdir.

It can also happen that page(s) disappear from the cache, in which case we
must also fall back to uncached readdir.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c    |   2 +
 fs/fuse/fuse_i.h  |  15 ++++++
 fs/fuse/readdir.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 32d0b883e74f..101e64897b5f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -59,6 +59,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 	}
 
 	INIT_LIST_HEAD(&ff->write_entry);
+	mutex_init(&ff->readdir.lock);
 	refcount_set(&ff->count, 1);
 	RB_CLEAR_NODE(&ff->polled_node);
 	init_waitqueue_head(&ff->poll_wait);
@@ -73,6 +74,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 void fuse_file_free(struct fuse_file *ff)
 {
 	fuse_request_free(ff->reserved_req);
+	mutex_destroy(&ff->readdir.lock);
 	kfree(ff);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d01c4606c149..116fe14053f1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -163,6 +163,21 @@ struct fuse_file {
 	/** Entry on inode's write_files list */
 	struct list_head write_entry;
 
+	/** Readdir related */
+	struct {
+		/**
+		 * Protects below fields against (crazy) parallel readdir on
+		 * same open file.  Uncontended in the normal case.
+		 */
+		struct mutex lock;
+
+		/** Dir stream position */
+		loff_t pos;
+
+		/** Offset in cache */
+		loff_t cache_off;
+	} readdir;
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 180f336b933f..e6ae82f2df9d 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -287,7 +287,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 	return 0;
 }
 
-int fuse_readdir(struct file *file, struct dir_context *ctx)
+static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 {
 	int plus, err;
 	size_t nbytes;
@@ -298,9 +298,6 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	u64 attr_version = 0;
 	bool locked;
 
-	if (is_bad_inode(inode))
-		return -EIO;
-
 	req = fuse_get_req(fc, 1);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -349,3 +346,146 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	fuse_invalidate_atime(inode);
 	return err;
 }
+
+enum fuse_parse_result {
+	FOUND_ERR = -1,
+	FOUND_NONE = 0,
+	FOUND_SOME,
+	FOUND_ALL,
+};
+
+static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
+					       void *addr, unsigned int size,
+					       struct dir_context *ctx)
+{
+	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
+	enum fuse_parse_result res = FOUND_NONE;
+
+	WARN_ON(offset >= size);
+
+	for (;;) {
+		struct fuse_dirent *dirent = addr + offset;
+		unsigned int nbytes = size - offset;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+
+		if (nbytes < FUSE_NAME_OFFSET || !dirent->namelen)
+			break;
+
+		if (WARN_ON(dirent->namelen > FUSE_NAME_MAX))
+			return FOUND_ERR;
+		if (WARN_ON(reclen > nbytes))
+			return FOUND_ERR;
+		if (WARN_ON(memchr(dirent->name, '/', dirent->namelen) != NULL))
+			return FOUND_ERR;
+
+		if (ff->readdir.pos == ctx->pos) {
+			res = FOUND_SOME;
+			if (!dir_emit(ctx, dirent->name, dirent->namelen,
+				      dirent->ino, dirent->type))
+				return FOUND_ALL;
+			ctx->pos = dirent->off;
+		}
+		ff->readdir.pos = dirent->off;
+		ff->readdir.cache_off += reclen;
+
+		offset += reclen;
+	}
+
+	return res;
+}
+
+#define UNCACHED 1
+
+static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
+{
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	enum fuse_parse_result res;
+	pgoff_t index;
+	unsigned int size;
+	struct page *page;
+	void *addr;
+
+	/* Seeked?  If so, reset the cache stream */
+	if (ff->readdir.pos != ctx->pos) {
+		ff->readdir.pos = 0;
+		ff->readdir.cache_off = 0;
+	}
+
+retry:
+	spin_lock(&fi->rdc.lock);
+	if (!fi->rdc.cached) {
+		spin_unlock(&fi->rdc.lock);
+		return UNCACHED;
+	}
+	WARN_ON(fi->rdc.size < ff->readdir.cache_off);
+
+	index = ff->readdir.cache_off >> PAGE_SHIFT;
+
+	if (index == (fi->rdc.size >> PAGE_SHIFT))
+		size = fi->rdc.size & ~PAGE_MASK;
+	else
+		size = PAGE_SIZE;
+	spin_unlock(&fi->rdc.lock);
+
+	/* EOF? */
+	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
+		return 0;
+
+	page = find_get_page_flags(file->f_mapping, index,
+				   FGP_ACCESSED | FGP_LOCK);
+	if (!page) {
+		/*
+		 * Uh-oh: page gone missing, cache is useless
+		 */
+		return UNCACHED;
+	}
+
+	addr = kmap(page);
+	res = fuse_parse_cache(ff, addr, size, ctx);
+	kunmap(page);
+	unlock_page(page);
+	put_page(page);
+
+	if (res == FOUND_ERR)
+		return -EIO;
+
+	if (res == FOUND_ALL)
+		return 0;
+
+	if (size == PAGE_SIZE) {
+		/* We hit end of page: skip to next page. */
+		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, PAGE_SIZE);
+		goto retry;
+	}
+
+	/*
+	 * End of cache reached.  If found position, then we are done, otherwise
+	 * need to fall back to uncached, since the position we were looking for
+	 * wasn't in the cache.
+	 */
+	return res == FOUND_SOME ? 0 : UNCACHED;
+}
+
+int fuse_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file_inode(file);
+	int err;
+
+	if (is_bad_inode(inode))
+		return -EIO;
+
+	mutex_lock(&ff->readdir.lock);
+
+	err = UNCACHED;
+	if (ff->open_flags & FOPEN_CACHE_DIR)
+		err = fuse_readdir_cached(file, ctx);
+	if (err == UNCACHED)
+		err = fuse_readdir_uncached(file, ctx);
+
+	mutex_unlock(&ff->readdir.lock);
+
+	return err;
+}
-- 
2.14.3

