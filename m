Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F79ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8C7208A0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8C7208A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbeGZNnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:43:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729514AbeGZNnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22F5E44CC6C5D;
        Thu, 26 Jul 2018 20:26:26 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:26:20 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 14/25] staging: erofs: introduce pagevec for unzip subsystem
Date:   Thu, 26 Jul 2018 20:21:57 +0800
Message-ID: <1532607728-103372-15-git-send-email-gaoxiang25@huawei.com>
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

For each compressed cluster, there is a straight-forward
way of allocating a fixed or variable-sized (for VLE) array
to record the corresponding file pages for its decompression
if we decide to decompress these pages asynchronously (eg.
read-ahead case), however it could take much extra on-heap
memory compared with traditional uncompressed filesystems.

This patch introduces a pagevec solution to reuse some
allocated file page in the time-sharing approach storing
parts of the array itself in order to minimize the extra
memory overhead, thus only a constant and small-sized array
used for booting the whole array itself up will be needed.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_pagevec.h | 172 ++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 drivers/staging/erofs/unzip_pagevec.h

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
new file mode 100644
index 0000000..0956615
--- /dev/null
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * linux/drivers/staging/erofs/unzip_pagevec.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of the Linux
+ * distribution for more details.
+ */
+#ifndef __EROFS_UNZIP_PAGEVEC_H
+#define __EROFS_UNZIP_PAGEVEC_H
+
+#include <linux/tagptr.h>
+
+/* page type in pagevec for unzip subsystem */
+enum z_erofs_page_type {
+	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
+	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
+
+	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
+
+	Z_EROFS_VLE_PAGE_TYPE_HEAD,
+	Z_EROFS_VLE_PAGE_TYPE_MAX
+};
+
+extern void __compiletime_error("Z_EROFS_PAGE_TYPE_EXCLUSIVE != 0")
+	__bad_page_type_exclusive(void);
+
+/* pagevec tagged pointer */
+typedef tagptr2_t	erofs_vtptr_t;
+
+/* pagevec collector */
+struct z_erofs_pagevec_ctor {
+	struct page *curr, *next;
+	erofs_vtptr_t *pages;
+
+	unsigned int nr, index;
+};
+
+static inline void z_erofs_pagevec_ctor_exit(struct z_erofs_pagevec_ctor *ctor,
+					     bool atomic)
+{
+	if (ctor->curr == NULL)
+		return;
+
+	if (atomic)
+		kunmap_atomic(ctor->pages);
+	else
+		kunmap(ctor->curr);
+}
+
+static inline struct page *
+z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
+			       unsigned nr)
+{
+	unsigned index;
+
+	/* keep away from occupied pages */
+	if (ctor->next != NULL)
+		return ctor->next;
+
+	for (index = 0; index < nr; ++index) {
+		const erofs_vtptr_t t = ctor->pages[index];
+		const unsigned tags = tagptr_unfold_tags(t);
+
+		if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
+			return tagptr_unfold_ptr(t);
+	}
+
+	if (unlikely(nr >= ctor->nr))
+		BUG();
+
+	return NULL;
+}
+
+static inline void
+z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec_ctor *ctor,
+			      bool atomic)
+{
+	struct page *next = z_erofs_pagevec_ctor_next_page(ctor, ctor->nr);
+
+	z_erofs_pagevec_ctor_exit(ctor, atomic);
+
+	ctor->curr = next;
+	ctor->next = NULL;
+	ctor->pages = atomic ?
+		kmap_atomic(ctor->curr) : kmap(ctor->curr);
+
+	ctor->nr = PAGE_SIZE / sizeof(struct page *);
+	ctor->index = 0;
+}
+
+static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
+					     unsigned nr,
+					     erofs_vtptr_t *pages, unsigned i)
+{
+	ctor->nr = nr;
+	ctor->curr = ctor->next = NULL;
+	ctor->pages = pages;
+
+	if (i >= nr) {
+		i -= nr;
+		z_erofs_pagevec_ctor_pagedown(ctor, false);
+		while (i > ctor->nr) {
+			i -= ctor->nr;
+			z_erofs_pagevec_ctor_pagedown(ctor, false);
+		}
+	}
+
+	ctor->next = z_erofs_pagevec_ctor_next_page(ctor, i);
+	ctor->index = i;
+}
+
+static inline bool
+z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
+			     struct page *page,
+			     enum z_erofs_page_type type,
+			     bool *occupied)
+{
+	*occupied = false;
+	if (unlikely(ctor->next == NULL && type))
+		if (ctor->index + 1 == ctor->nr)
+			return false;
+
+	if (unlikely(ctor->index >= ctor->nr))
+		z_erofs_pagevec_ctor_pagedown(ctor, false);
+
+	/* exclusive page type must be 0 */
+	if (Z_EROFS_PAGE_TYPE_EXCLUSIVE != (uintptr_t)NULL)
+		__bad_page_type_exclusive();
+
+	/* should remind that collector->next never equal to 1, 2 */
+	if (type == (uintptr_t)ctor->next) {
+		ctor->next = page;
+		*occupied = true;
+	}
+
+	ctor->pages[ctor->index++] =
+		tagptr_fold(erofs_vtptr_t, page, type);
+	return true;
+}
+
+static inline struct page *
+z_erofs_pagevec_ctor_dequeue(struct z_erofs_pagevec_ctor *ctor,
+			     enum z_erofs_page_type *type)
+{
+	erofs_vtptr_t t;
+
+	if (unlikely(ctor->index >= ctor->nr)) {
+		BUG_ON(ctor->next == NULL);
+		z_erofs_pagevec_ctor_pagedown(ctor, true);
+	}
+
+	t = ctor->pages[ctor->index];
+
+	*type = tagptr_unfold_tags(t);
+
+	/* should remind that collector->next never equal to 1, 2 */
+	if (*type == (uintptr_t)ctor->next)
+		ctor->next = tagptr_unfold_ptr(t);
+
+	ctor->pages[ctor->index++] =
+		tagptr_fold(erofs_vtptr_t, NULL, 0);
+
+	return tagptr_unfold_ptr(t);
+}
+
+#endif
+
-- 
1.9.1

