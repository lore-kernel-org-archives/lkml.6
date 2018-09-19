Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9534C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60341208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60341208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbeISL1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:27:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12617 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeISL1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:27:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B39BDAE6F9305;
        Wed, 19 Sep 2018 13:51:03 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 19 Sep
 2018 13:50:55 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Miao Xie" <miaoxie@huawei.com>,
        Du Wei <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 6/6] staging: erofs: simplify return value of `xattr_foreach'
Date:   Wed, 19 Sep 2018 13:49:10 +0800
Message-ID: <1537336150-90604-6-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dan Carpenter pointed out, there is no need to propagate positive
return values back to its callers.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/xattr.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 7b1367e..80dca6a 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -268,7 +268,7 @@ static int xattr_foreach(struct xattr_iter *it,
 out:
 	/* xattrs should be 4-byte aligned (on-disk constraint) */
 	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
-	return err;
+	return err < 0 ? err : 0;
 }
 
 struct getxattr_iter {
@@ -333,15 +333,12 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
 	remaining = ret;
 	while (remaining) {
 		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
-		if (ret >= 0)
-			break;
-
-		if (ret != -ENOATTR)	/* -ENOMEM, -EIO, etc. */
+		if (ret != -ENOATTR)
 			break;
 	}
 	xattr_iter_end_final(&it->it);
 
-	return ret < 0 ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_size;
 }
 
 static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
@@ -371,16 +368,13 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 		}
 
 		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
-		if (ret >= 0)
-			break;
-
-		if (ret != -ENOATTR)	/* -ENOMEM, -EIO, etc. */
+		if (ret != -ENOATTR)
 			break;
 	}
 	if (vi->xattr_shared_count)
 		xattr_iter_end_final(&it->it);
 
-	return ret < 0 ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_size;
 }
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
@@ -567,11 +561,11 @@ static int inline_listxattr(struct listxattr_iter *it)
 	remaining = ret;
 	while (remaining) {
 		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
-		if (ret < 0)
+		if (ret)
 			break;
 	}
 	xattr_iter_end_final(&it->it);
-	return ret < 0 ? ret : it->buffer_ofs;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static int shared_listxattr(struct listxattr_iter *it)
@@ -601,13 +595,13 @@ static int shared_listxattr(struct listxattr_iter *it)
 		}
 
 		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
-		if (ret < 0)
+		if (ret)
 			break;
 	}
 	if (vi->xattr_shared_count)
 		xattr_iter_end_final(&it->it);
 
-	return ret < 0 ? ret : it->buffer_ofs;
+	return ret ? ret : it->buffer_ofs;
 }
 
 ssize_t erofs_listxattr(struct dentry *dentry,
-- 
1.9.1

