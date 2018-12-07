Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECDEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BADE2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BADE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLGQFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:05:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGQFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:05:15 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA2D5941A74A4;
        Sat,  8 Dec 2018 00:05:11 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 8 Dec 2018
 00:05:06 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/7] staging: erofs: introduce MNGD_MAPPING helper
Date:   Sat, 8 Dec 2018 00:19:13 +0800
Message-ID: <20181207161918.20747-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181207161918.20747-1-gaoxiang25@huawei.com>
References: <20181207161918.20747-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces MNGD_MAPPING to wrap up
sbi->managed_cache->i_mapping, which will be used
to solve too many #ifdefs in a single function.

No logic changes.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

The following lines will be changed in the next cleanup patch.
-	noio_outoforder = grab_managed_cache_pages(mngda,
+	noio_outoforder = grab_managed_cache_pages(mc,
 		erofs_blknr(map->m_pa),
 		grp->compressed_pages, erofs_blknr(map->m_plen),
 		/* compressed page caching selection strategy */


 drivers/staging/erofs/internal.h  |  4 ++++
 drivers/staging/erofs/unzip_vle.c | 29 +++++++++++++----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 892944355867..b78d6e4c12ab 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -295,6 +295,10 @@ extern int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	struct erofs_workgroup *egrp);
 extern int erofs_try_to_free_cached_page(struct address_space *mapping,
 	struct page *page);
+
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
+#else
+#define MNGD_MAPPING(sbi)	(NULL)
 #endif
 
 #define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	3
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 4404ea6fb9e4..ac2e30474520 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -165,7 +165,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 {
 	struct z_erofs_vle_workgroup *const grp =
 		container_of(egrp, struct z_erofs_vle_workgroup, obj);
-	struct address_space *const mapping = sbi->managed_cache->i_mapping;
+	struct address_space *const mapping = MNGD_MAPPING(sbi);
 	const int clusterpages = erofs_clusterpages(sbi);
 	int i;
 
@@ -617,7 +617,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	struct z_erofs_vle_work *work = builder->work;
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-	struct address_space *const mngda = sbi->managed_cache->i_mapping;
+	struct address_space *const mc = MNGD_MAPPING(sbi);
 	struct z_erofs_vle_workgroup *grp;
 	bool noio_outoforder;
 #endif
@@ -665,7 +665,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	grp = fe->builder.grp;
 
 	/* let's do out-of-order decompression for noio */
-	noio_outoforder = grab_managed_cache_pages(mngda,
+	noio_outoforder = grab_managed_cache_pages(mc,
 		erofs_blknr(map->m_pa),
 		grp->compressed_pages, erofs_blknr(map->m_plen),
 		/* compressed page caching selection strategy */
@@ -764,7 +764,7 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 	unsigned int i;
 	struct bio_vec *bvec;
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-	struct address_space *mngda = NULL;
+	struct address_space *mc = NULL;
 #endif
 
 	bio_for_each_segment_all(bvec, bio, i) {
@@ -775,18 +775,18 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		BUG_ON(!page->mapping);
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (unlikely(!mngda && !z_erofs_is_stagingpage(page))) {
+		if (unlikely(!mc && !z_erofs_is_stagingpage(page))) {
 			struct inode *const inode = page->mapping->host;
 			struct super_block *const sb = inode->i_sb;
 
-			mngda = EROFS_SB(sb)->managed_cache->i_mapping;
+			mc = MNGD_MAPPING(EROFS_SB(sb));
 		}
 
 		/*
-		 * If mngda has not gotten, it equals NULL,
+		 * If mc has not gotten, it equals NULL,
 		 * however, page->mapping never be NULL if working properly.
 		 */
-		cachemngd = (page->mapping == mngda);
+		cachemngd = (page->mapping == mc);
 #endif
 
 		if (unlikely(err))
@@ -810,9 +810,6 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	struct list_head *page_pool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-	struct address_space *const mngda = sbi->managed_cache->i_mapping;
-#endif
 	const unsigned int clusterpages = erofs_clusterpages(sbi);
 
 	struct z_erofs_pagevec_ctor ctor;
@@ -903,7 +900,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		if (z_erofs_is_stagingpage(page))
 			continue;
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		else if (page->mapping == mngda) {
+		if (page->mapping == MNGD_MAPPING(sbi)) {
 			BUG_ON(PageLocked(page));
 			BUG_ON(!PageUptodate(page));
 			continue;
@@ -981,7 +978,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		page = compressed_pages[i];
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (page->mapping == mngda)
+		if (page->mapping == MNGD_MAPPING(sbi))
 			continue;
 #endif
 		/* recycle all individual staging pages */
@@ -1114,7 +1111,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	const unsigned int clusterpages = erofs_clusterpages(sbi);
 	const gfp_t gfp = GFP_NOFS;
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-	struct address_space *const mngda = sbi->managed_cache->i_mapping;
+	struct address_space *const mc = MNGD_MAPPING(sbi);
 	struct z_erofs_vle_workgroup *lstgrp_noio = NULL, *lstgrp_io = NULL;
 #endif
 	struct z_erofs_vle_unzip_io *ios[1 + __FSIO_1];
@@ -1187,7 +1184,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 			cachemngd = true;
 			goto do_allocpage;
 		} else if (page) {
-			if (page->mapping != mngda)
+			if (page->mapping != mc)
 				BUG_ON(PageUptodate(page));
 			else if (recover_managed_page(grp, page)) {
 				/* page is uptodate, skip io submission */
@@ -1210,7 +1207,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 				goto repeat;
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 			} else if (cachemngd && !add_to_page_cache_lru(page,
-				mngda, first_index + i, gfp)) {
+				   mc, first_index + i, gfp)) {
 				set_page_private(page, (unsigned long)grp);
 				SetPagePrivate(page);
 #endif
-- 
2.14.4

