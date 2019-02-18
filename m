Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636FBC10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B57B218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfBRHU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:20:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfBRHU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:20:56 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45A4FA8305B9445E3DFF;
        Mon, 18 Feb 2019 15:20:53 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 18 Feb 2019 15:20:45
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH] staging: erofs: fix race of initializing xattrs of a inode at the same time
Date:   Mon, 18 Feb 2019 15:19:04 +0800
Message-ID: <20190218071904.5784-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190214153450.28221-1-gaoxiang25@huawei.com>
References: <20190214153450.28221-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In real scenario, there could be several threads accessing xattrs
of the same xattr-uninitialized inode, and init_inode_xattrs()
almost at the same time.

That's actually an unexpected behavior, this patch closes the race.

Fixes: b17500a0fdba ("staging: erofs: introduce xattr & acl support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
[previewed at https://lists.ozlabs.org/pipermail/linux-erofs/2019-February/001345.html]

 drivers/staging/erofs/internal.h | 11 ++++++++---
 drivers/staging/erofs/xattr.c    | 41 ++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 3a27c255950b..e3bfde00c7d2 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -327,12 +327,17 @@ static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
 }
 
-#define inode_set_inited_xattr(inode)   (EROFS_V(inode)->flags |= 1)
-#define inode_has_inited_xattr(inode)   (EROFS_V(inode)->flags & 1)
+/* atomic flag definitions */
+#define EROFS_V_EA_INITED_BIT	0
+
+/* bitlock definitions (arranged in reverse order) */
+#define EROFS_V_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 
 struct erofs_vnode {
 	erofs_nid_t nid;
-	unsigned int flags;
+
+	/* atomic flags (including bitlocks) */
+	unsigned long flags;
 
 	unsigned char data_mapping_mode;
 	/* inline size in bytes */
diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 8c48b0ab31fd..f716ab0446e5 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -44,18 +44,25 @@ static inline void xattr_iter_end_final(struct xattr_iter *it)
 
 static int init_inode_xattrs(struct inode *inode)
 {
+	struct erofs_vnode *const vi = EROFS_V(inode);
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
 	struct super_block *sb;
 	struct erofs_sb_info *sbi;
-	struct erofs_vnode *vi;
 	bool atomic_map;
+	int ret = 0;
 
-	if (likely(inode_has_inited_xattr(inode)))
+	/* the most case is that xattrs of this inode are initialized. */
+	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
 		return 0;
 
-	vi = EROFS_V(inode);
+	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_XATTR_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	/* someone has initialized xattrs for us? */
+	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
+		goto out_unlock;
 
 	/*
 	 * bypass all xattr operations if ->xattr_isize is not greater than
@@ -68,13 +75,16 @@ static int init_inode_xattrs(struct inode *inode)
 	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
 		errln("xattr_isize %d of nid %llu is not supported yet",
 		      vi->xattr_isize, vi->nid);
-		return -ENOTSUPP;
+		ret = -ENOTSUPP;
+		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
 		if (unlikely(vi->xattr_isize)) {
 			DBG_BUGON(1);
-			return -EIO;	/* xattr ondisk layout error */
+			ret = -EIO;
+			goto out_unlock;	/* xattr ondisk layout error */
 		}
-		return -ENOATTR;
+		ret = -ENOATTR;
+		goto out_unlock;
 	}
 
 	sb = inode->i_sb;
@@ -83,8 +93,10 @@ static int init_inode_xattrs(struct inode *inode)
 	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
 
 	it.page = erofs_get_inline_page(inode, it.blkaddr);
-	if (IS_ERR(it.page))
-		return PTR_ERR(it.page);
+	if (IS_ERR(it.page)) {
+		ret = PTR_ERR(it.page);
+		goto out_unlock;
+	}
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
 	it.kaddr = kmap(it.page);
@@ -97,7 +109,8 @@ static int init_inode_xattrs(struct inode *inode)
 						sizeof(uint), GFP_KERNEL);
 	if (vi->xattr_shared_xattrs == NULL) {
 		xattr_iter_end(&it, atomic_map);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_unlock;
 	}
 
 	/* let's skip ibody header */
@@ -114,7 +127,8 @@ static int init_inode_xattrs(struct inode *inode)
 			if (IS_ERR(it.page)) {
 				kfree(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
-				return PTR_ERR(it.page);
+				ret = PTR_ERR(it.page);
+				goto out_unlock;
 			}
 
 			it.kaddr = kmap_atomic(it.page);
@@ -127,8 +141,11 @@ static int init_inode_xattrs(struct inode *inode)
 	}
 	xattr_iter_end(&it, atomic_map);
 
-	inode_set_inited_xattr(inode);
-	return 0;
+	set_bit(EROFS_V_EA_INITED_BIT, &vi->flags);
+
+out_unlock:
+	clear_and_wake_up_bit(EROFS_V_BL_XATTR_BIT, &vi->flags);
+	return ret;
 }
 
 /*
-- 
2.14.4

