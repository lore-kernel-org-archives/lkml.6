Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B6220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfANLm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbfANLmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:42:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 262BA10D8723FAB51F9A;
        Mon, 14 Jan 2019 19:42:10 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan 2019 19:42:02
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4/5] staging: erofs: move erofs_xattr_handlers to xattr.h
Date:   Mon, 14 Jan 2019 19:40:25 +0800
Message-ID: <20190114114026.11728-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190114114026.11728-1-gaoxiang25@huawei.com>
References: <20190114114026.11728-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move independent xattr-related stuffs to xattr.h.
No logic changes.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 5 -----
 drivers/staging/erofs/super.c    | 1 +
 drivers/staging/erofs/xattr.h    | 2 ++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index ae4f2555f497..99b50b981335 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -580,11 +580,6 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
-#ifdef CONFIG_EROFS_FS_XATTR
-/* xattr.c */
-extern const struct xattr_handler *erofs_xattr_handlers[];
-#endif
-
 static inline void *erofs_vmap(struct page **pages, unsigned int count)
 {
 #ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 1c2eb69682ef..45c7f6ddb9f5 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -16,6 +16,7 @@
 #include <linux/parser.h>
 #include <linux/seq_file.h>
 #include "internal.h"
+#include "xattr.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 810fc947701d..634dae9aaa0b 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -68,6 +68,8 @@ static const struct xattr_handler *xattr_handler_map[] = {
 }
 
 #ifdef CONFIG_EROFS_FS_XATTR
+extern const struct xattr_handler *erofs_xattr_handlers[];
+
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
-- 
2.14.4

