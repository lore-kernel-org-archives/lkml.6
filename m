Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B62920894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B62920894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbeGZNni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:43:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729514AbeGZNnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 888577E414CEE;
        Thu, 26 Jul 2018 20:26:56 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:26:48 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 16/25] staging: erofs: add erofs_allocpage
Date:   Thu, 26 Jul 2018 20:21:59 +0800
Message-ID: <1532607728-103372-17-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces an temporary _on-stack_ page
pool to reuse the freed page directly as much as
it can for better performance and release all pages
at a time, it also slightly reduces the possibility of
the potential memory allocation failure.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Makefile   |  2 +-
 drivers/staging/erofs/internal.h |  7 +++++++
 drivers/staging/erofs/utils.c    | 31 +++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/erofs/utils.c

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index 8558c76..490fa6c 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -7,7 +7,7 @@ ccflags-y += -Wall -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 obj-$(CONFIG_EROFS_FS) += erofs.o
 # staging requirement: to be self-contained in its own directory
 ccflags-y += -I$(src)/include
-erofs-objs := super.o inode.o data.o namei.o dir.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o
 
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index bea5ec4..210ab6c 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -369,5 +369,12 @@ static inline void erofs_vunmap(const void *mem, unsigned int count)
 #endif
 }
 
+/* utils.c */
+extern struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
+
+#ifndef lru_to_page
+#define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#endif
+
 #endif
 
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
new file mode 100644
index 0000000..3dec4f8
--- /dev/null
+++ b/drivers/staging/erofs/utils.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/drivers/staging/erofs/utils.c
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of the Linux
+ * distribution for more details.
+ */
+
+#include "internal.h"
+
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
+{
+	struct page *page;
+
+	if (!list_empty(pool)) {
+		page = lru_to_page(pool);
+		list_del(&page->lru);
+	} else {
+		page = alloc_pages(gfp | __GFP_NOFAIL, 0);
+
+		BUG_ON(page == NULL);
+		BUG_ON(page->mapping != NULL);
+	}
+	return page;
+}
+
-- 
1.9.1

