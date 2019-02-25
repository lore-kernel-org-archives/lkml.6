Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7C82146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130085;
	bh=BAbZv+oEuxk5FpQCH8lCT1pXG1TemCu8zRIESqsOJt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=16NlRaTvnWprBLJdZ29Mkj1FiZLHN07vLRN/oge1PhWG0E2D12CoOJ7KAMy9nvdxg
	 G9KHX/b0H9kmlWnhd41DIShTZGFIF0vEZdkZOw/j6SHFEAm53hd+XRRfJvJnLnILvG
	 KGel2XMBE4tGhZOGaUwEazQFo7YKQcwQzDzFN/4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfBYV2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731132AbfBYV2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9190A2087C;
        Mon, 25 Feb 2019 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130080;
        bh=BAbZv+oEuxk5FpQCH8lCT1pXG1TemCu8zRIESqsOJt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzUrx4p8A5vQWwSofNE/MxBd2IFB9dQc6k2RbTNZeoDJ5is3QAGHDCrk/neKPiDUB
         c0LmFkHa3PSekhbOlr/jBa5vpKoHfEPnsXNfTBxtdWZeDoy3oF39THk4CAcPRtt5za
         KRevCObAKDz1q2wMXHx9r/HL6BX+Rny4s2cZppNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.19 137/152] staging: erofs: drop multiref support temporarily
Date:   Mon, 25 Feb 2019 22:12:09 +0100
Message-Id: <20190225195053.321303672@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit e5e3abbadf0dbd1068f64f8abe70401c5a178180 upstream.

Multiref support means that a compressed page could have
more than one reference, which is designed for on-disk data
deduplication. However, mkfs doesn't support this mode
at this moment, and the kernel implementation is also broken.

Let's drop multiref support. If it is fully implemented
in the future, it can be reverted later.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/staging/erofs/unzip_vle.c |   40 ++++++--------------------------------
 drivers/staging/erofs/unzip_vle.h |   12 -----------
 2 files changed, 8 insertions(+), 44 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -293,12 +293,9 @@ z_erofs_vle_work_lookup(struct super_blo
 	*grp_ret = grp = container_of(egrp,
 		struct z_erofs_vle_workgroup, obj);
 
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
 	work = z_erofs_vle_grab_work(grp, pageofs);
+	/* if multiref is disabled, `primary' is always true */
 	primary = true;
-#else
-	BUG();
-#endif
 
 	DBG_BUGON(work->pageofs != pageofs);
 
@@ -365,12 +362,9 @@ z_erofs_vle_work_register(struct super_b
 	struct z_erofs_vle_workgroup *grp = *grp_ret;
 	struct z_erofs_vle_work *work;
 
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
+	/* if multiref is disabled, grp should never be nullptr */
 	BUG_ON(grp != NULL);
-#else
-	if (grp != NULL)
-		goto skip;
-#endif
+
 	/* no available workgroup, let's allocate one */
 	grp = kmem_cache_zalloc(z_erofs_workgroup_cachep, GFP_NOFS);
 	if (unlikely(grp == NULL))
@@ -393,13 +387,7 @@ z_erofs_vle_work_register(struct super_b
 	*hosted = true;
 
 	newgrp = true;
-#ifdef CONFIG_EROFS_FS_ZIP_MULTIREF
-skip:
-	/* currently unimplemented */
-	BUG();
-#else
 	work = z_erofs_vle_grab_primary_work(grp);
-#endif
 	work->pageofs = pageofs;
 
 	mutex_init(&work->lock);
@@ -798,10 +786,8 @@ static int z_erofs_vle_unzip(struct supe
 	const unsigned clusterpages = erofs_clusterpages(sbi);
 
 	struct z_erofs_pagevec_ctor ctor;
-	unsigned nr_pages;
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
-	unsigned sparsemem_pages = 0;
-#endif
+	unsigned int nr_pages;
+	unsigned int sparsemem_pages = 0;
 	struct page *pages_onstack[Z_EROFS_VLE_VMAP_ONSTACK_PAGES];
 	struct page **pages, **compressed_pages, *page;
 	unsigned i, llen;
@@ -813,11 +799,7 @@ static int z_erofs_vle_unzip(struct supe
 	int err;
 
 	might_sleep();
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
 	work = z_erofs_vle_grab_primary_work(grp);
-#else
-	BUG();
-#endif
 	BUG_ON(!READ_ONCE(work->nr_pages));
 
 	mutex_lock(&work->lock);
@@ -868,13 +850,11 @@ repeat:
 			pagenr = z_erofs_onlinepage_index(page);
 
 		BUG_ON(pagenr >= nr_pages);
-
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
 		BUG_ON(pages[pagenr] != NULL);
-		++sparsemem_pages;
-#endif
+
 		pages[pagenr] = page;
 	}
+	sparsemem_pages = i;
 
 	z_erofs_pagevec_ctor_exit(&ctor, true);
 
@@ -904,10 +884,8 @@ repeat:
 		pagenr = z_erofs_onlinepage_index(page);
 
 		BUG_ON(pagenr >= nr_pages);
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
 		BUG_ON(pages[pagenr] != NULL);
 		++sparsemem_pages;
-#endif
 		pages[pagenr] = page;
 
 		overlapped = true;
@@ -933,12 +911,10 @@ repeat:
 	if (err != -ENOTSUPP)
 		goto out_percpu;
 
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
 	if (sparsemem_pages >= nr_pages) {
 		BUG_ON(sparsemem_pages > nr_pages);
 		goto skip_allocpage;
 	}
-#endif
 
 	for (i = 0; i < nr_pages; ++i) {
 		if (pages[i] != NULL)
@@ -947,9 +923,7 @@ repeat:
 		pages[i] = __stagingpage_alloc(page_pool, GFP_NOFS);
 	}
 
-#ifndef CONFIG_EROFS_FS_ZIP_MULTIREF
 skip_allocpage:
-#endif
 	vout = erofs_vmap(pages, nr_pages);
 
 	err = z_erofs_vle_unzip_vmap(compressed_pages,
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -47,13 +47,6 @@ static inline bool z_erofs_gather_if_sta
 #define Z_EROFS_VLE_INLINE_PAGEVECS     3
 
 struct z_erofs_vle_work {
-	/* struct z_erofs_vle_work *left, *right; */
-
-#ifdef CONFIG_EROFS_FS_ZIP_MULTIREF
-	struct list_head list;
-
-	atomic_t refcount;
-#endif
 	struct mutex lock;
 
 	/* I: decompression offset in page */
@@ -107,10 +100,8 @@ static inline void z_erofs_vle_set_workg
 	grp->flags = fmt | (grp->flags & ~Z_EROFS_VLE_WORKGRP_FMT_MASK);
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP_MULTIREF
-#error multiref decompression is unimplemented yet
-#else
 
+/* definitions if multiref is disabled */
 #define z_erofs_vle_grab_primary_work(grp)	(&(grp)->work)
 #define z_erofs_vle_grab_work(grp, pageofs)	(&(grp)->work)
 #define z_erofs_vle_work_workgroup(wrk, primary)	\
@@ -118,7 +109,6 @@ static inline void z_erofs_vle_set_workg
 		struct z_erofs_vle_workgroup, work) : \
 		({ BUG(); (void *)NULL; }))
 
-#endif
 
 #define Z_EROFS_WORKGROUP_SIZE       sizeof(struct z_erofs_vle_workgroup)
 


