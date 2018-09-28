Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EACC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55E920779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55E920779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeI1WHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbeI1WHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id n23-v6so2682124wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EDWMFV49gBlH8cSAnLfUF8WzQZs8zpiaL/HwKhmVZBg=;
        b=o7/TVxSGhHrLDJkitd34dXne2VuTwBVZ5ipMMyhl/lqpFL5Vkd2eUfBhK+8suxb014
         qiub1XNShJ9PI9o02o7oSB3uey+ebKRqMM66wj1ycfEUt+RMnXK5Wjn1x2XmY4kZjimS
         KWtZESpe21MLo2jD3A6wtL9+W179YsetK9MOl0sVUY+i/oI54Y0ApFb60VuULf4RJpZK
         4XRKFLQIUrK4EDvKAYoDsqCussF6JjmkFtCdK0JIcgTKLKmKOTJd67GxrOLsDvwIghk8
         f3RyOMV5ZT5p5DZH1lKwQxfsmuR1EnOAAy0JNq5hFP6uuEzLfeVNbVYldzcrNeM3LD7n
         VsOQ==
X-Gm-Message-State: ABuFfohHbiI/yDtPPd/rt8TZkPnklo3sUgJh5K1jCQ33zCd0/lnvOPmg
        Qi4Uf+PyV2HwKJARpQMq1jI4Uw==
X-Google-Smtp-Source: ACcGV61CXP/ZTXQp5KOeK4OpRmrHGGgRFQOm/HuhcNNoli10XSz2du4oMZ/cy5KyF5G7S6reLuQ/pA==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr2251532wmx.38.1538149369223;
        Fri, 28 Sep 2018 08:42:49 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:48 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] fuse: use mtime for readdir cache verification
Date:   Fri, 28 Sep 2018 17:42:32 +0200
Message-Id: <20180928154234.19270-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the modification time of the directory in the cache, obtained before
starting to fill the cache.

When reading the cache, verify that the directory hasn't changed, by
checking if current modification time is the same as the one stored in the
cache.

This only needs to be done when the current file position is at the
beginning of the directory, as mandated by POSIX.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h  |  3 +++
 fs/fuse/readdir.c | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ef018ea5bcd9..e498f9edf01f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -117,6 +117,9 @@ struct fuse_inode {
 		/** version of the cache */
 		u64 version;
 
+		/** modification time of directory when cache was started */
+		struct timespec64 mtime;
+
 		/** protects above fields */
 		spinlock_t lock;
 	} rdc;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index edb445c4cfbd..f96525cef518 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -397,8 +397,10 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 	return res;
 }
 
-static void fuse_rdc_reset(struct fuse_inode *fi)
+static void fuse_rdc_reset(struct inode *inode)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
 	fi->rdc.cached = false;
 	fi->rdc.version++;
 	fi->rdc.size = 0;
@@ -411,6 +413,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 {
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	enum fuse_parse_result res;
 	pgoff_t index;
@@ -424,12 +427,40 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		ff->readdir.cache_off = 0;
 	}
 
+	/*
+	 * We're just about to start reading into the cache or reading the
+	 * cache; both cases require an up-to-date mtime value.
+	 */
+	if (!ctx->pos && fc->auto_inval_data) {
+		int err = fuse_update_attributes(inode, file);
+
+		if (err)
+			return err;
+	}
+
 retry:
 	spin_lock(&fi->rdc.lock);
+retry_locked:
 	if (!fi->rdc.cached) {
+		/* Starting cache? Set cache mtime. */
+		if (!ctx->pos && !fi->rdc.size) {
+			fi->rdc.mtime = inode->i_mtime;
+		}
 		spin_unlock(&fi->rdc.lock);
 		return UNCACHED;
 	}
+	/*
+	 * When at the beginning of the directory (i.e. just after opendir(3) or
+	 * rewinddir(3)), then need to check whether directory contents have
+	 * changed, and reset the cache if so.
+	 */
+	if (!ctx->pos) {
+		if (!timespec64_equal(&fi->rdc.mtime, &inode->i_mtime)) {
+			fuse_rdc_reset(inode);
+			goto retry_locked;
+		}
+	}
+
 	/*
 	 * If cache version changed since the last getdents() call, then reset
 	 * the cache stream.
@@ -467,9 +498,8 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		 * Uh-oh: page gone missing, cache is useless
 		 */
 		if (fi->rdc.version == ff->readdir.version)
-			fuse_rdc_reset(fi);
-		spin_unlock(&fi->rdc.lock);
-		return UNCACHED;
+			fuse_rdc_reset(inode);
+		goto retry_locked;
 	}
 
 	/* Make sure it's still the same version after getting the page. */
-- 
2.14.3

