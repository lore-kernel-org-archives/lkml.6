Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CF92085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CF92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeKFTIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:59904 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730426AbeKFTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:23 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxtu-00036Q-CZ; Tue, 06 Nov 2018 12:43:58 +0300
Subject: [PATCH 4/6] fuse: Implement fuse_attr_version_inc()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:43:58 +0300
Message-ID: <154149743811.18189.2448546280541143340.stgit@localhost.localdomain>
In-Reply-To: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cleanup purpose archive repeating pattern:

	spin_lock(&fc->lock);
	fi->attr_version = ++fc->attr_version;
	spin_unlock(&fc->lock);

into separate function.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dir.c    |    8 ++------
 fs/fuse/file.c   |   16 ++++------------
 fs/fuse/fuse_i.h |   11 +++++++++++
 fs/fuse/inode.c  |    4 +---
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 794b9f48fb8e..35f3b3d1e044 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -674,9 +674,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		spin_lock(&fi->lock);
-		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
-		spin_unlock(&fc->lock);
+		fi->attr_version = fuse_attr_version_inc_return(fc);
 		/*
 		 * If i_nlink == 0 then unlink doesn't make sense, yet this can
 		 * happen if userspace filesystem is careless.  It would be
@@ -830,9 +828,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		spin_lock(&fi->lock);
-		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
-		spin_unlock(&fc->lock);
+		fi->attr_version = fuse_attr_version_inc_return(fc);
 		inc_nlink(inode);
 		spin_unlock(&fi->lock);
 		fuse_invalidate_attr(inode);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 48e2889ba6a6..1164d3580c62 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -186,9 +186,7 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		spin_lock(&fi->lock);
-		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
-		spin_unlock(&fc->lock);
+		fi->attr_version = fuse_attr_version_inc_return(fc);
 		i_size_write(inode, 0);
 		spin_unlock(&fi->lock);
 		fuse_invalidate_attr(inode);
@@ -604,9 +602,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			struct fuse_inode *fi = get_fuse_inode(inode);
 
 			spin_lock(&fi->lock);
-			spin_lock(&fc->lock);
-			fi->attr_version = ++fc->attr_version;
-			spin_unlock(&fc->lock);
+			fi->attr_version = fuse_attr_version_inc_return(fc);
 			spin_unlock(&fi->lock);
 		}
 
@@ -685,9 +681,7 @@ static void fuse_read_update_size(struct inode *inode, loff_t size,
 	spin_lock(&fi->lock);
 	if (attr_ver == fi->attr_version && size < inode->i_size &&
 	    !test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
-		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
-		spin_unlock(&fc->lock);
+		fi->attr_version = fuse_attr_version_inc_return(fc);
 		i_size_write(inode, size);
 	}
 	spin_unlock(&fi->lock);
@@ -1006,9 +1000,7 @@ bool fuse_write_update_size(struct inode *inode, loff_t pos)
 	bool ret = false;
 
 	spin_lock(&fi->lock);
-	spin_lock(&fc->lock);
-	fi->attr_version = ++fc->attr_version;
-	spin_unlock(&fc->lock);
+	fi->attr_version = fuse_attr_version_inc_return(fc);
 	if (pos > inode->i_size) {
 		i_size_write(inode, pos);
 		ret = true;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 075da40499b8..f7442bcecbb0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -775,6 +775,17 @@ static inline int invalid_nodeid(u64 nodeid)
 	return !nodeid || nodeid == FUSE_ROOT_ID;
 }
 
+static inline u64 fuse_attr_version_inc_return(struct fuse_conn *fc)
+{
+	u64 attr_version;
+
+	spin_lock(&fc->lock);
+	attr_version = ++fc->attr_version;
+	spin_unlock(&fc->lock);
+
+	return attr_version;
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f62d45686b42..5f488b019cd9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -167,9 +167,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 
 	lockdep_assert_held(&fi->lock);
 
-	spin_lock(&fc->lock);
-	fi->attr_version = ++fc->attr_version;
-	spin_unlock(&fc->lock);
+	fi->attr_version = fuse_attr_version_inc_return(fc);
 
 	fi->i_time = attr_valid;
 	WRITE_ONCE(fi->inval_mask, 0);

