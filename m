Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC6620673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC6620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLGQF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:05:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeLGQF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:05:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C8C3795B81979;
        Sat,  8 Dec 2018 00:05:21 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 8 Dec 2018
 00:05:14 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4/7] staging: erofs: revisit the page submission flow
Date:   Sat, 8 Dec 2018 00:19:15 +0800
Message-ID: <20181207161918.20747-5-gaoxiang25@huawei.com>
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

Previously, the submission flow works with cached compressed pages
reclaim path in a tricky way, and it could be buggy if the reclaim
path changes later without such tricky restrictions. For example,
currently one PagePrivate(page) is evaluated without taking page
lock (it only follows a wait_for_page_locked which closes such race)
and no handling solves the potential page truncation case.

In addition, it's also full of #ifdefs in the function, which
is hard to understand and maintain. this patch fixes them all.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 183 +++++++++++++++++++++++---------------
 1 file changed, 112 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f39e495f4369..de41f7b739ac 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1047,6 +1047,107 @@ static void z_erofs_vle_unzip_wq(struct work_struct *work)
 	kvfree(iosb);
 }
 
+static struct page *
+pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
+			   unsigned int nr,
+			   struct list_head *pagepool,
+			   struct address_space *mc,
+			   gfp_t gfp)
+{
+	/* determined at compile time to avoid too many #ifdefs */
+	const bool nocache = __builtin_constant_p(mc) ? !mc : false;
+	const pgoff_t index = grp->obj.index;
+	bool tocache = false;
+
+	struct address_space *mapping;
+	struct page *oldpage, *page;
+
+repeat:
+	page = READ_ONCE(grp->compressed_pages[nr]);
+	oldpage = page;
+
+	if (!page)
+		goto out_allocpage;
+
+	/*
+	 * the cached page has not been allocated and
+	 * an placeholder is out there, prepare it now.
+	 */
+	if (!nocache && page == PAGE_UNALLOCATED) {
+		tocache = true;
+		goto out_allocpage;
+	}
+
+	mapping = READ_ONCE(page->mapping);
+
+	/*
+	 * if managed cache is disabled, it's no way to
+	 * get such a cached-like page.
+	 */
+	if (nocache) {
+		/* should be locked, not uptodate, and not truncated */
+		DBG_BUGON(!PageLocked(page));
+		DBG_BUGON(PageUptodate(page));
+		DBG_BUGON(!mapping);
+		goto out;
+	}
+
+	/*
+	 * unmanaged (file) pages are all locked solidly,
+	 * therefore it is impossible for `mapping' to be NULL.
+	 */
+	if (mapping && mapping != mc)
+		/* ought to be unmanaged pages */
+		goto out;
+
+	lock_page(page);
+
+	/* the page is still in manage cache */
+	if (page->mapping == mc) {
+		WRITE_ONCE(grp->compressed_pages[nr], page);
+
+		if (!PagePrivate(page)) {
+			set_page_private(page, (unsigned long)grp);
+			SetPagePrivate(page);
+		}
+
+		/* no need to submit io if it is already up-to-date */
+		if (PageUptodate(page)) {
+			unlock_page(page);
+			page = NULL;
+		}
+		goto out;
+	}
+
+	/*
+	 * the managed page has been truncated, it's unsafe to
+	 * reuse this one, let's allocate a new cache-managed page.
+	 */
+	DBG_BUGON(page->mapping);
+
+	tocache = true;
+	unlock_page(page);
+	put_page(page);
+out_allocpage:
+	page = __stagingpage_alloc(pagepool, gfp);
+	if (oldpage != cmpxchg(&grp->compressed_pages[nr], oldpage, page)) {
+		list_add(&page->lru, pagepool);
+		cpu_relax();
+		goto repeat;
+	}
+	if (nocache || !tocache)
+		goto out;
+	if (add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		page->mapping = Z_EROFS_MAPPING_STAGING;
+		goto out;
+	}
+
+	set_page_private(page, (unsigned long)grp);
+	SetPagePrivate(page);
+out:	/* the only exit (for tracing and debugging) */
+	return page;
+}
+
 static inline struct z_erofs_vle_unzip_io *
 prepare_io_handler(struct super_block *sb,
 		   struct z_erofs_vle_unzip_io *io,
@@ -1082,26 +1183,6 @@ prepare_io_handler(struct super_block *sb,
 }
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-/* true - unlocked (noio), false - locked (need submit io) */
-static inline bool recover_managed_page(struct z_erofs_vle_workgroup *grp,
-					struct page *page)
-{
-	wait_on_page_locked(page);
-	if (PagePrivate(page) && PageUptodate(page))
-		return true;
-
-	lock_page(page);
-	if (unlikely(!PagePrivate(page))) {
-		set_page_private(page, (unsigned long)grp);
-		SetPagePrivate(page);
-	}
-	if (unlikely(PageUptodate(page))) {
-		unlock_page(page);
-		return true;
-	}
-	return false;
-}
-
 #define __FSIO_1 1
 #else
 #define __FSIO_1 0
@@ -1117,7 +1198,6 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	const unsigned int clusterpages = erofs_clusterpages(sbi);
 	const gfp_t gfp = GFP_NOFS;
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-	struct address_space *const mc = MNGD_MAPPING(sbi);
 	struct z_erofs_vle_workgroup *lstgrp_noio = NULL, *lstgrp_io = NULL;
 #endif
 	struct z_erofs_vle_unzip_io *ios[1 + __FSIO_1];
@@ -1156,13 +1236,9 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 
 	do {
 		struct z_erofs_vle_workgroup *grp;
-		struct page **compressed_pages, *oldpage, *page;
 		pgoff_t first_index;
-		unsigned int i = 0;
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-		unsigned int noio = 0;
-		bool cachemngd;
-#endif
+		struct page *page;
+		unsigned int i = 0, bypass = 0;
 		int err;
 
 		/* no possible 'owned_head' equals the following */
@@ -1173,51 +1249,18 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 
 		/* close the main owned chain at first */
 		owned_head = cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_TAIL,
-			Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
+				     Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
 
 		first_index = grp->obj.index;
-		compressed_pages = grp->compressed_pages;
-
 		force_submit |= (first_index != last_index + 1);
-repeat:
-		/* fulfill all compressed pages */
-		oldpage = page = READ_ONCE(compressed_pages[i]);
 
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-		cachemngd = false;
-
-		if (page == PAGE_UNALLOCATED) {
-			cachemngd = true;
-			goto do_allocpage;
-		} else if (page) {
-			if (page->mapping != mc)
-				BUG_ON(PageUptodate(page));
-			else if (recover_managed_page(grp, page)) {
-				/* page is uptodate, skip io submission */
-				force_submit = true;
-				++noio;
-				goto skippage;
-			}
-		} else {
-do_allocpage:
-#else
-		if (page)
-			BUG_ON(PageUptodate(page));
-		else {
-#endif
-			page = __stagingpage_alloc(pagepool, gfp);
-
-			if (oldpage != cmpxchg(compressed_pages + i,
-				oldpage, page)) {
-				list_add(&page->lru, pagepool);
-				goto repeat;
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-			} else if (cachemngd && !add_to_page_cache_lru(page,
-				   mc, first_index + i, gfp)) {
-				set_page_private(page, (unsigned long)grp);
-				SetPagePrivate(page);
-#endif
-			}
+repeat:
+		page = pickup_page_for_submission(grp, i, pagepool,
+						  MNGD_MAPPING(sbi), gfp);
+		if (!page) {
+			force_submit = true;
+			++bypass;
+			goto skippage;
 		}
 
 		if (bio && force_submit) {
@@ -1240,14 +1283,12 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 
 		force_submit = false;
 		last_index = first_index + i;
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
 skippage:
-#endif
 		if (++i < clusterpages)
 			goto repeat;
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (noio < clusterpages) {
+		if (bypass < clusterpages) {
 			lstgrp_io = grp;
 		} else {
 			z_erofs_vle_owned_workgrp_t iogrp_next =
-- 
2.14.4

