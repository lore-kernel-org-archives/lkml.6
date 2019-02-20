Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E38AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1B12147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfBTKR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:17:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfBTKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:17:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78F2AC69D46C9B889770;
        Wed, 20 Feb 2019 18:17:25 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 18:17:16 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH 1/2] jffs2: reset pino_nlink to 0 when inode creation failed
Date:   Wed, 20 Feb 2019 18:21:32 +0800
Message-ID: <20190220102133.7878-2-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190220102133.7878-1-houtao1@huawei.com>
References: <20190220102133.7878-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So jffs2_do_clear_inode() could mark all flash nodes used by
the inode as obsolete and GC procedure will reclaim these
flash nodes, else these flash spaces will not be reclaimable
forever.

Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/dir.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index f20cff1194bb..e02f85e516cb 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -156,6 +156,26 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
 
 /***********************************************************************/
 
+static void jffs2_iget_failed(struct jffs2_sb_info *c, struct inode *inode)
+{
+	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
+
+	/*
+	 * Reset pino_nlink to zero, so jffs2_do_clear_inode() will mark
+	 * all flash nodes used by the inode as obsolete and GC procedure
+	 * will reclaim these flash nodes, else these flash spaces will be
+	 * unreclaimable forever.
+	 *
+	 * Update pino_nlink under inocache_lock, because no proceses could
+	 * get the inode due to I_NEW flag, and only GC procedure may try to
+	 * read pino_nlink under inocache_lock.
+	 */
+	spin_lock(&c->inocache_lock);
+	f->inocache->pino_nlink = 0;
+	spin_unlock(&c->inocache_lock);
+
+	iget_failed(inode);
+}
 
 static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 			umode_t mode, bool excl)
@@ -213,7 +233,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	return 0;
 
  fail:
-	iget_failed(inode);
+	jffs2_iget_failed(c, inode);
 	jffs2_free_raw_inode(ri);
 	return ret;
 }
@@ -433,7 +453,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	return 0;
 
  fail:
-	iget_failed(inode);
+	jffs2_iget_failed(c, inode);
 	return ret;
 }
 
@@ -577,7 +597,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	return 0;
 
  fail:
-	iget_failed(inode);
+	jffs2_iget_failed(c, inode);
 	return ret;
 }
 
@@ -748,7 +768,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	return 0;
 
  fail:
-	iget_failed(inode);
+	jffs2_iget_failed(c, inode);
 	return ret;
 }
 
-- 
2.16.2.dirty

