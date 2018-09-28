Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA56C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B8120779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B8120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeI1WHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35245 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeI1WHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so2696942wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VHkYwroxtfKl4m4UAHETv8/4pMVos/KNrqgWkjWkSTA=;
        b=DdJvpD9n0I5FSit1Cp0X8uzcQPDAnQ4AtIGLB2JNT4iJtc9+onfMS+TRuTqc1JkusE
         oIxYCKN4oSuJWGRmDxFgNnd3qYHjBCu3C8grTU0IB8JmYcnOVTMAolQnb+tXUtwekV+7
         LKVVmFaowzWNUCaWCsAhtuKNjjmeM0OvpknHvkMlsWllo9OGI5RhXpM0ndhHsFe/HrzP
         uQIJvDIZarNJQESVrqHCFyjd92M3qnbXPTzBpQbZ2EPwcIuq1xAK9CtwKtIfZ9Jb91tp
         mO+2VVFZrS/g8AQKPzwL+/YLJr6oFZxG+DK6zL8Vstf2ddAdFQcgfA7+s8KaSBwQwRDx
         SZVw==
X-Gm-Message-State: ABuFfojWUQz30zdcOUXCLv4YWizuVGMUxeh5L3DDuImmSaJ+g04rfKvb
        eajNe+Rj4BgFh7ruRm8gWGGAa4jHT3Q=
X-Google-Smtp-Source: ACcGV61qr7SWPN47A9E4txgU070HQIoZS3imfYaFC3W6wijbRfdbjWKiIeData0DglUy5kpKJQm3sA==
X-Received: by 2002:a1c:b90c:: with SMTP id j12-v6mr2367777wmf.32.1538149367789;
        Fri, 28 Sep 2018 08:42:47 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:47 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] fuse: add readdir cache version
Date:   Fri, 28 Sep 2018 17:42:31 +0200
Message-Id: <20180928154234.19270-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the cache to be invalidated when page(s) have gone missing.  In this
case increment the version of the cache and reset to an empty state.

Add a version number to the directory stream in struct fuse_file as well,
indicating the version of the cache it's supposed to be reading.  If the
cache version doesn't match the stream's version, then reset the stream to
the beginning of the cache.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h  |  7 +++++++
 fs/fuse/inode.c   |  1 +
 fs/fuse/readdir.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 116fe14053f1..ef018ea5bcd9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -114,6 +114,9 @@ struct fuse_inode {
 		/** position at end of cache (position of next entry) */
 		loff_t pos;
 
+		/** version of the cache */
+		u64 version;
+
 		/** protects above fields */
 		spinlock_t lock;
 	} rdc;
@@ -176,6 +179,10 @@ struct fuse_file {
 
 		/** Offset in cache */
 		loff_t cache_off;
+
+		/** Version of cache we are reading */
+		u64 version;
+
 	} readdir;
 
 	/** RB node to be linked on fuse_conn->polled_files */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 03d8105a851d..6d0a87308f86 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -104,6 +104,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->rdc.cached = false;
 	fi->rdc.size = 0;
 	fi->rdc.pos = 0;
+	fi->rdc.version = 0;
 	mutex_init(&fi->mutex);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index e6ae82f2df9d..edb445c4cfbd 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -34,6 +34,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	pgoff_t index;
 	struct page *page;
 	loff_t size;
+	u64 version;
 	unsigned int offset;
 	void *addr;
 
@@ -46,6 +47,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
 		spin_unlock(&fi->rdc.lock);
 		return;
 	}
+	version = fi->rdc.version;
 	size = fi->rdc.size;
 	offset = size & ~PAGE_MASK;
 	index = size >> PAGE_SHIFT;
@@ -67,7 +69,8 @@ static void fuse_add_dirent_to_cache(struct file *file,
 
 	spin_lock(&fi->rdc.lock);
 	/* Raced with another readdir */
-	if (fi->rdc.size != size || WARN_ON(fi->rdc.pos != pos))
+	if (fi->rdc.version != version || fi->rdc.size != size ||
+	    WARN_ON(fi->rdc.pos != pos))
 		goto unlock;
 
 	addr = kmap_atomic(page);
@@ -394,6 +397,14 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 	return res;
 }
 
+static void fuse_rdc_reset(struct fuse_inode *fi)
+{
+	fi->rdc.cached = false;
+	fi->rdc.version++;
+	fi->rdc.size = 0;
+	fi->rdc.pos = 0;
+}
+
 #define UNCACHED 1
 
 static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
@@ -419,6 +430,21 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		spin_unlock(&fi->rdc.lock);
 		return UNCACHED;
 	}
+	/*
+	 * If cache version changed since the last getdents() call, then reset
+	 * the cache stream.
+	 */
+	if (ff->readdir.version != fi->rdc.version) {
+		ff->readdir.pos = 0;
+		ff->readdir.cache_off = 0;
+	}
+	/*
+	 * If at the beginning of the cache, than reset version to
+	 * current.
+	 */
+	if (ff->readdir.pos == 0)
+		ff->readdir.version = fi->rdc.version;
+
 	WARN_ON(fi->rdc.size < ff->readdir.cache_off);
 
 	index = ff->readdir.cache_off >> PAGE_SHIFT;
@@ -435,13 +461,30 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 
 	page = find_get_page_flags(file->f_mapping, index,
 				   FGP_ACCESSED | FGP_LOCK);
+	spin_lock(&fi->rdc.lock);
 	if (!page) {
 		/*
 		 * Uh-oh: page gone missing, cache is useless
 		 */
+		if (fi->rdc.version == ff->readdir.version)
+			fuse_rdc_reset(fi);
+		spin_unlock(&fi->rdc.lock);
 		return UNCACHED;
 	}
 
+	/* Make sure it's still the same version after getting the page. */
+	if (ff->readdir.version != fi->rdc.version) {
+		spin_unlock(&fi->rdc.lock);
+		unlock_page(page);
+		put_page(page);
+		goto retry;
+	}
+	spin_unlock(&fi->rdc.lock);
+
+	/*
+	 * Contents of the page are now protected against changing by holding
+	 * the page lock.
+	 */
 	addr = kmap(page);
 	res = fuse_parse_cache(ff, addr, size, ctx);
 	kunmap(page);
-- 
2.14.3

