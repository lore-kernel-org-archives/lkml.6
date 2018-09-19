Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E90C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69998206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69998206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeISL1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:27:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeISL1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:27:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F660F62CB7B3;
        Wed, 19 Sep 2018 13:50:44 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 19 Sep
 2018 13:50:38 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Miao Xie" <miaoxie@huawei.com>,
        Du Wei <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 5/6] staging: erofs: add some comments for xattr subsystem
Date:   Wed, 19 Sep 2018 13:49:09 +0800
Message-ID: <1537336150-90604-5-git-send-email-gaoxiang25@huawei.com>
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

As Dan Carpenter pointed out, it is better to document what
return values of these callbacks in `struct xattr_iter_handlers'
mean and why it->ofs is increased regardless of success or
failure in `xattr_foreach'.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/xattr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 4942ca1..7b1367e 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -109,6 +109,13 @@ static int init_inode_xattrs(struct inode *inode)
 	return 0;
 }
 
+/*
+ * the general idea for these return values is
+ * if    0 is returned, go on processing the current xattr;
+ *       1 (> 0) is returned, skip this round to process the next xattr;
+ *    -err (< 0) is returned, an error (maybe ENOXATTR) occurred
+ *                            and need to be handled
+ */
 struct xattr_iter_handlers {
 	int (*entry)(struct xattr_iter *, struct erofs_xattr_entry *);
 	int (*name)(struct xattr_iter *, unsigned int, char *, unsigned int);
@@ -164,6 +171,10 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	return vi->xattr_isize - xattr_header_sz;
 }
 
+/*
+ * Regardless of success or failure, `xattr_foreach' will end up with
+ * `ofs' pointing to the next xattr item rather than an arbitrary position.
+ */
 static int xattr_foreach(struct xattr_iter *it,
 	const struct xattr_iter_handlers *op, unsigned int *tlimit)
 {
@@ -255,7 +266,7 @@ static int xattr_foreach(struct xattr_iter *it,
 	}
 
 out:
-	/* we assume that ofs is aligned with 4 bytes */
+	/* xattrs should be 4-byte aligned (on-disk constraint) */
 	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
 	return err;
 }
-- 
1.9.1

