Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7282F20779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7282F20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeI1WHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeI1WHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10-v6so6919648wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VkQge49IGWrDW7K/E4CFUpAZEAY3ZcQMKOdIIHysoO8=;
        b=eGp0fhFHtwIpbmaiGqrTItfRAPHvsS6bEUboIMIrmKqJDc4Ektg6q4KlYe0ozfI15R
         I7NKAHC/WO2+AtsxVCcySRb0b1w4XQPg4F2y+NFz1TYxL6Z5QDjpHwu14nomCqdJ05am
         PUwdn7y+ZEkjgrlf83rCrhRF819GwPVMLMjETKfzswULW1HoXK3FoFZeB2H935ishuAB
         Wrx9zXHNraLDvq9ZUBaOK0MUP94oIGV/5KtGL5QYlbKPQyRbZ225teMygSSGq9SjagQD
         IQgn7Anvh63YM7MBGuFwVKRpXjtGBavtjTCVRjwZ3A7nZnY/+wU6CcqX0M/n4LajU1Yb
         bHpw==
X-Gm-Message-State: ABuFfogfNpd/d/jhTnVlNivcAlVKf7Aq0YwFdEHyw+dFzzqhop4MO0dD
        w+/Hq8a6cvee0aOAan4j5ooNujtv61I=
X-Google-Smtp-Source: ACcGV601mxeznXONLrn0lw0fBqbV6rilRJ2nsyPbwWEJkQXqOkql5T4mVUB7jHPJvOGmhu8aOjb44w==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr1845025wrj.237.1538149371606;
        Fri, 28 Sep 2018 08:42:51 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:50 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] fuse: reduce size of struct fuse_inode
Date:   Fri, 28 Sep 2018 17:42:34 +0200
Message-Id: <20180928154234.19270-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do this by grouping fields used for cached writes and putting them into a
union with fileds used for cached readdir (with obviously no overlap, since
we don't have hybrid objects).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c    | 13 +++++++++++-
 fs/fuse/file.c   |  8 ++++++++
 fs/fuse/fuse_i.h | 62 +++++++++++++++++++++++++++++++-------------------------
 fs/fuse/inode.c  | 16 ++++-----------
 4 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6800fdc3e730..d1b2f42d746e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1414,8 +1414,11 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		file = NULL;
 	}
 
-	if (attr->ia_valid & ATTR_SIZE)
+	if (attr->ia_valid & ATTR_SIZE) {
+		if (WARN_ON(!S_ISREG(inode->i_mode)))
+			return -EIO;
 		is_truncate = true;
+	}
 
 	if (is_truncate) {
 		fuse_set_nowrite(inode);
@@ -1619,8 +1622,16 @@ void fuse_init_common(struct inode *inode)
 
 void fuse_init_dir(struct inode *inode)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
 	inode->i_op = &fuse_dir_inode_operations;
 	inode->i_fop = &fuse_dir_operations;
+
+	spin_lock_init(&fi->rdc.lock);
+	fi->rdc.cached = false;
+	fi->rdc.size = 0;
+	fi->rdc.pos = 0;
+	fi->rdc.version = 0;
 }
 
 void fuse_init_symlink(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 101e64897b5f..1ca3fe5be3e4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3064,6 +3064,14 @@ static const struct address_space_operations fuse_file_aops  = {
 
 void fuse_init_file_inode(struct inode *inode)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
+
+	INIT_LIST_HEAD(&fi->write_files);
+	INIT_LIST_HEAD(&fi->queued_writes);
+	fi->writectr = 0;
+	init_waitqueue_head(&fi->page_waitq);
+	INIT_LIST_HEAD(&fi->writepages);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1e8d20e86760..41cc9fb33d02 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -87,45 +87,51 @@ struct fuse_inode {
 	/** Version of last attribute change */
 	u64 attr_version;
 
-	/** Files usable in writepage.  Protected by fc->lock */
-	struct list_head write_files;
+	union {
+		/* Write related fields (regular file only) */
+		struct {
+			/** Files usable in writepage.  Protected by fc->lock */
+			struct list_head write_files;
 
-	/** Writepages pending on truncate or fsync */
-	struct list_head queued_writes;
+			/** Writepages pending on truncate or fsync */
+			struct list_head queued_writes;
 
-	/** Number of sent writes, a negative bias (FUSE_NOWRITE)
-	 * means more writes are blocked */
-	int writectr;
+			/** Number of sent writes, a negative bias
+			 * (FUSE_NOWRITE) means more writes are blocked */
+			int writectr;
 
-	/** Waitq for writepage completion */
-	wait_queue_head_t page_waitq;
+			/** Waitq for writepage completion */
+			wait_queue_head_t page_waitq;
 
-	/** List of writepage requestst (pending or sent) */
-	struct list_head writepages;
+			/** List of writepage requestst (pending or sent) */
+			struct list_head writepages;
+		};
 
-	/** readdir cache */
-	struct {
-		/** true if fully cached */
-		bool cached;
+		/** readdir cache (directory only) */
+		struct {
+			/** true if fully cached */
+			bool cached;
 
-		/** size of cache */
-		loff_t size;
+			/** size of cache */
+			loff_t size;
 
-		/** position at end of cache (position of next entry) */
-		loff_t pos;
+			/** position at end of cache (position of next entry) */
+			loff_t pos;
 
-		/** version of the cache */
-		u64 version;
+			/** version of the cache */
+			u64 version;
 
-		/** modification time of directory when cache was started */
-		struct timespec64 mtime;
+			/** modification time of directory when cache was
+			 *  started */
+			struct timespec64 mtime;
 
-		/** iversion of directory when cache was started */
-		u64 iversion;
+			/** iversion of directory when cache was started */
+			u64 iversion;
 
-		/** protects above fields */
-		spinlock_t lock;
-	} rdc;
+			/** protects above fields */
+			spinlock_t lock;
+		} rdc;
+	};
 
 	/** Miscellaneous bits describing inode state */
 	unsigned long state;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6d0a87308f86..bd58ab7e1858 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -93,18 +93,8 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->attr_version = 0;
-	fi->writectr = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
-	INIT_LIST_HEAD(&fi->write_files);
-	INIT_LIST_HEAD(&fi->queued_writes);
-	INIT_LIST_HEAD(&fi->writepages);
-	init_waitqueue_head(&fi->page_waitq);
-	spin_lock_init(&fi->rdc.lock);
-	fi->rdc.cached = false;
-	fi->rdc.size = 0;
-	fi->rdc.pos = 0;
-	fi->rdc.version = 0;
 	mutex_init(&fi->mutex);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
@@ -124,8 +114,10 @@ static void fuse_i_callback(struct rcu_head *head)
 static void fuse_destroy_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	BUG_ON(!list_empty(&fi->write_files));
-	BUG_ON(!list_empty(&fi->queued_writes));
+	if (S_ISREG(inode->i_mode)) {
+		WARN_ON(!list_empty(&fi->write_files));
+		WARN_ON(!list_empty(&fi->queued_writes));
+	}
 	mutex_destroy(&fi->mutex);
 	kfree(fi->forget);
 	call_rcu(&inode->i_rcu, fuse_i_callback);
-- 
2.14.3

