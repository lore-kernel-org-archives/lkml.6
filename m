Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF99C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E020218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfB0Ffh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 00:35:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfB0Ffh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 00:35:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 710C026722DB91B90D98;
        Wed, 27 Feb 2019 13:35:34 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.201)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 27 Feb 2019 13:35:26
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] staging: erofs: compressed_pages should not be accessed again after freed
Date:   Wed, 27 Feb 2019 13:33:30 +0800
Message-ID: <20190227053332.38504-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the following page use-after-free issue,
z_erofs_vle_unzip:
    ...
    for (i = 0; i < nr_pages; ++i) {
        ...
        z_erofs_onlinepage_endio(page);  (1)
    }

    for (i = 0; i < clusterpages; ++i) {
        page = compressed_pages[i];

        if (page->mapping == mngda)      (2)
            continue;
        /* recycle all individual staging pages */
        (void)z_erofs_gather_if_stagingpage(page_pool, page); (3)
        WRITE_ONCE(compressed_pages[i], NULL);
    }
    ...

After (1) is executed, page is freed and could be then reused, if
compressed_pages is scanned after that, it could fall info (2) or
(3) by mistake and that could finally be in a mess.

This patch aims to solve the above issue only with little changes
as much as possible in order to make the fix backport easier.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c     | 38 ++++++++++++++++++-----------------
 drivers/staging/erofs/unzip_vle.h     |  3 +--
 drivers/staging/erofs/unzip_vle_lz4.c | 19 ++++++++----------
 3 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index a127d8db76d8..416dde4e8ea1 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -986,11 +986,10 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	if (llen > grp->llen)
 		llen = grp->llen;
 
-	err = z_erofs_vle_unzip_fast_percpu(compressed_pages,
-		clusterpages, pages, llen, work->pageofs,
-		z_erofs_onlinepage_endio);
+	err = z_erofs_vle_unzip_fast_percpu(compressed_pages, clusterpages,
+					    pages, llen, work->pageofs);
 	if (err != -ENOTSUPP)
-		goto out_percpu;
+		goto out;
 
 	if (sparsemem_pages >= nr_pages)
 		goto skip_allocpage;
@@ -1011,8 +1010,25 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	erofs_vunmap(vout, nr_pages);
 
 out:
+	/* must handle all compressed pages before endding pages */
+	for (i = 0; i < clusterpages; ++i) {
+		page = compressed_pages[i];
+
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+		if (page->mapping == MNGD_MAPPING(sbi))
+			continue;
+#endif
+		/* recycle all individual staging pages */
+		(void)z_erofs_gather_if_stagingpage(page_pool, page);
+
+		WRITE_ONCE(compressed_pages[i], NULL);
+	}
+
 	for (i = 0; i < nr_pages; ++i) {
 		page = pages[i];
+		if (!page)
+			continue;
+
 		DBG_BUGON(!page->mapping);
 
 		/* recycle all individual staging pages */
@@ -1025,20 +1041,6 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		z_erofs_onlinepage_endio(page);
 	}
 
-out_percpu:
-	for (i = 0; i < clusterpages; ++i) {
-		page = compressed_pages[i];
-
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (page->mapping == MNGD_MAPPING(sbi))
-			continue;
-#endif
-		/* recycle all individual staging pages */
-		(void)z_erofs_gather_if_stagingpage(page_pool, page);
-
-		WRITE_ONCE(compressed_pages[i], NULL);
-	}
-
 	if (pages == z_pagemap_global)
 		mutex_unlock(&z_pagemap_global_lock);
 	else if (unlikely(pages != pages_onstack))
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 9dafa8dc712c..517e5ce8c5e9 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -218,8 +218,7 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 				  unsigned int clusterpages,
 				  struct page **pages, unsigned int outlen,
-				  unsigned short pageofs,
-				  void (*endio)(struct page *));
+				  unsigned short pageofs);
 int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 			   unsigned int clusterpages,
 			   void *vaddr, unsigned int llen,
diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index 8e8d705a6861..48b263a2731a 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -125,8 +125,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 				  unsigned int clusterpages,
 				  struct page **pages,
 				  unsigned int outlen,
-				  unsigned short pageofs,
-				  void (*endio)(struct page *))
+				  unsigned short pageofs)
 {
 	void *vin, *vout;
 	unsigned int nr_pages, i, j;
@@ -148,19 +147,16 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
 				clusterpages * PAGE_SIZE, outlen);
 
-	if (ret >= 0) {
-		outlen = ret;
-		ret = 0;
-	}
+	if (ret < 0)
+		goto out;
+	ret = 0;
 
 	for (i = 0; i < nr_pages; ++i) {
 		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
 
 		if (pages[i]) {
-			if (ret < 0) {
-				SetPageError(pages[i]);
-			} else if (clusterpages == 1 &&
-				   pages[i] == compressed_pages[0]) {
+			if (clusterpages == 1 &&
+			    pages[i] == compressed_pages[0]) {
 				memcpy(vin + pageofs, vout + pageofs, j);
 			} else {
 				void *dst = kmap_atomic(pages[i]);
@@ -168,12 +164,13 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 				memcpy(dst + pageofs, vout + pageofs, j);
 				kunmap_atomic(dst);
 			}
-			endio(pages[i]);
 		}
 		vout += PAGE_SIZE;
 		outlen -= j;
 		pageofs = 0;
 	}
+
+out:
 	preempt_enable();
 
 	if (clusterpages == 1)
-- 
2.14.5

