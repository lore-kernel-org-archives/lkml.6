Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B2BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354BB218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfAYQMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:12:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfAYQMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:12:00 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD4CBEE5E90FFE2D0494;
        Sat, 26 Jan 2019 00:11:56 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.207)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 26 Jan 2019 00:11:36
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 1/2] staging: erofs: use xattr_prefix to wrap up
Date:   Sat, 26 Jan 2019 00:10:06 +0800
Message-ID: <20190125161007.4447-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use xattr_prefix instead of open code.
No logic changes.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v2:
 - remove the confusing line according to Dan Carpenter;

 drivers/staging/erofs/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 1c9498e38f0e..7de46690d972 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -520,8 +520,7 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	if (h == NULL || (h->list != NULL && !h->list(it->dentry)))
 		return 1;
 
-	/* Note that at least one of 'prefix' and 'name' should be non-NULL */
-	prefix = h->prefix != NULL ? h->prefix : h->name;
+	prefix = xattr_prefix(h);
 	prefix_len = strlen(prefix);
 
 	if (it->buffer == NULL) {
-- 
2.14.4

