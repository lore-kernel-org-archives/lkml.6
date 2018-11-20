Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C86C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5DB20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5DB20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeKUAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:51:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbeKUAvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:51:47 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93AE49DE5D6E6;
        Tue, 20 Nov 2018 22:22:20 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Nov
 2018 22:22:14 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 10/10] staging: erofs: rename strange variable names in z_erofs_vle_frontend
Date:   Tue, 20 Nov 2018 22:34:25 +0800
Message-ID: <20181120143425.43637-11-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181120143425.43637-1-gaoxiang25@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, 2 members called `initial' and `cachedzone_la' are used
for applying caching policy (whether the workgroup is at either end),
which are hard to understand, rename them to `backmost' and `headoffset'.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 824d2c12c2f3..1ef178e7ac39 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -586,10 +586,9 @@ struct z_erofs_vle_frontend {
 
 	z_erofs_vle_owned_workgrp_t owned_head;
 
-	bool initial;
-#if (EROFS_FS_ZIP_CACHE_LVL >= 2)
-	erofs_off_t cachedzone_la;
-#endif
+	/* used for applying cache strategy on the fly */
+	bool backmost;
+	erofs_off_t headoffset;
 };
 
 #define VLE_FRONTEND_INIT(__i) { \
@@ -600,7 +599,7 @@ struct z_erofs_vle_frontend {
 	}, \
 	.builder = VLE_WORK_BUILDER_INIT(), \
 	.owned_head = Z_EROFS_VLE_WORKGRP_TAIL, \
-	.initial = true, }
+	.backmost = true, }
 
 static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 				struct page *page,
@@ -643,7 +642,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
 
 	if (z_erofs_vle_work_iter_end(builder))
-		fe->initial = false;
+		fe->backmost = false;
 
 	map->m_la = offset + cur;
 	map->m_llen = 0;
@@ -669,8 +668,8 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 		erofs_blknr(map->m_pa),
 		grp->compressed_pages, erofs_blknr(map->m_plen),
 		/* compressed page caching selection strategy */
-		fe->initial | (EROFS_FS_ZIP_CACHE_LVL >= 2 ?
-			map->m_la < fe->cachedzone_la : 0));
+		fe->backmost | (EROFS_FS_ZIP_CACHE_LVL >= 2 ?
+				map->m_la < fe->headoffset : 0));
 
 	if (noio_outoforder && builder_is_followed(builder))
 		builder->role = Z_EROFS_VLE_WORK_PRIMARY;
@@ -1316,9 +1315,8 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 
 	trace_erofs_readpage(page, false);
 
-#if (EROFS_FS_ZIP_CACHE_LVL >= 2)
-	f.cachedzone_la = (erofs_off_t)page->index << PAGE_SHIFT;
-#endif
+	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
+
 	err = z_erofs_do_read_page(&f, page, &pagepool);
 	(void)z_erofs_vle_work_iter_end(&f.builder);
 
@@ -1354,9 +1352,8 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 	trace_erofs_readpages(mapping->host, lru_to_page(pages),
 			      nr_pages, false);
 
-#if (EROFS_FS_ZIP_CACHE_LVL >= 2)
-	f.cachedzone_la = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
-#endif
+	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
+
 	for (; nr_pages; --nr_pages) {
 		struct page *page = lru_to_page(pages);
 
-- 
2.14.4

