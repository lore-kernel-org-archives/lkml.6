Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5916C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfANLmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfANLmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:42:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 320C3E06620366D8B4A5;
        Mon, 14 Jan 2019 19:42:15 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan 2019 19:42:05
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 5/5] staging: erofs: clean up erofs_map_blocks_iter
Date:   Mon, 14 Jan 2019 19:40:26 +0800
Message-ID: <20190114114026.11728-6-gaoxiang25@huawei.com>
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

From: Chao Yu <yuchao0@huawei.com>

This patch cleans up erofs_map_blocks* function and structure family,
just simply the code, no logic change.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/data.c      | 31 +++++--------------------------
 drivers/staging/erofs/internal.h  | 28 +++++++++++++++-------------
 drivers/staging/erofs/unzip_vle.c | 30 +++++++++++++++---------------
 3 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 329fa4fa3e9c..9c471f08ffd4 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -165,37 +165,16 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return err;
 }
 
-int erofs_map_blocks_iter(struct inode *inode,
-			  struct erofs_map_blocks *map,
-			  struct page **mpage_ret, int flags)
-{
-	/* by default, reading raw data never use erofs_map_blocks_iter */
-	if (unlikely(!is_inode_layout_compression(inode))) {
-		if (*mpage_ret)
-			put_page(*mpage_ret);
-		*mpage_ret = NULL;
-
-		return erofs_map_blocks(inode, map, flags);
-	}
-
-#ifdef CONFIG_EROFS_FS_ZIP
-	return z_erofs_map_blocks_iter(inode, map, mpage_ret, flags);
-#else
-	/* data compression is not available */
-	return -ENOTSUPP;
-#endif
-}
-
 int erofs_map_blocks(struct inode *inode,
 		     struct erofs_map_blocks *map, int flags)
 {
 	if (unlikely(is_inode_layout_compression(inode))) {
-		struct page *mpage = NULL;
-		int err;
+		int err = z_erofs_map_blocks_iter(inode, map, flags);
 
-		err = erofs_map_blocks_iter(inode, map, &mpage, flags);
-		if (mpage)
-			put_page(mpage);
+		if (map->mpage) {
+			put_page(map->mpage);
+			map->mpage = NULL;
+		}
 		return err;
 	}
 	return erofs_map_blocks_flatmode(inode, map, flags);
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 99b50b981335..e2103804584b 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -461,11 +461,26 @@ struct erofs_map_blocks {
 	u64 m_plen, m_llen;
 
 	unsigned int m_flags;
+
+	struct page *mpage;
 };
 
 /* Flags used by erofs_map_blocks() */
 #define EROFS_GET_BLOCKS_RAW    0x0001
 
+#ifdef CONFIG_EROFS_FS_ZIP
+int z_erofs_map_blocks_iter(struct inode *inode,
+			    struct erofs_map_blocks *map,
+			    int flags);
+#else
+static inline int z_erofs_map_blocks_iter(struct inode *inode,
+					  struct erofs_map_blocks *map,
+					  int flags);
+{
+	return -ENOTSUPP;
+}
+#endif
+
 /* data.c */
 static inline struct bio *
 erofs_grab_bio(struct super_block *sb,
@@ -522,19 +537,6 @@ static inline struct page *erofs_get_meta_page_nofail(struct super_block *sb,
 }
 
 extern int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
-extern int erofs_map_blocks_iter(struct inode *, struct erofs_map_blocks *,
-	struct page **, int);
-
-struct erofs_map_blocks_iter {
-	struct erofs_map_blocks map;
-	struct page *mpage;
-};
-
-#ifdef CONFIG_EROFS_FS_ZIP
-extern int z_erofs_map_blocks_iter(struct inode *,
-				   struct erofs_map_blocks *,
-				   struct page **, int);
-#endif
 
 static inline struct page *
 erofs_get_inline_page(struct inode *inode,
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 584612b47369..29b3b1dc67f1 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -636,7 +636,7 @@ struct z_erofs_vle_frontend {
 	struct inode *const inode;
 
 	struct z_erofs_vle_work_builder builder;
-	struct erofs_map_blocks_iter m_iter;
+	struct erofs_map_blocks map;
 
 	z_erofs_vle_owned_workgrp_t owned_head;
 
@@ -647,8 +647,9 @@ struct z_erofs_vle_frontend {
 
 #define VLE_FRONTEND_INIT(__i) { \
 	.inode = __i, \
-	.m_iter = { \
-		{ .m_llen = 0, .m_plen = 0 }, \
+	.map = { \
+		.m_llen = 0, \
+		.m_plen = 0, \
 		.mpage = NULL \
 	}, \
 	.builder = VLE_WORK_BUILDER_INIT(), \
@@ -681,8 +682,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 {
 	struct super_block *const sb = fe->inode->i_sb;
 	struct erofs_sb_info *const sbi __maybe_unused = EROFS_SB(sb);
-	struct erofs_map_blocks_iter *const m = &fe->m_iter;
-	struct erofs_map_blocks *const map = &m->map;
+	struct erofs_map_blocks *const map = &fe->map;
 	struct z_erofs_vle_work_builder *const builder = &fe->builder;
 	const loff_t offset = page_offset(page);
 
@@ -715,7 +715,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 
 	map->m_la = offset + cur;
 	map->m_llen = 0;
-	err = erofs_map_blocks_iter(fe->inode, map, &m->mpage, 0);
+	err = z_erofs_map_blocks_iter(fe->inode, map, 0);
 	if (unlikely(err))
 		goto err_out;
 
@@ -1484,8 +1484,8 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 
 	z_erofs_submit_and_unzip(&f, &pagepool, true);
 out:
-	if (f.m_iter.mpage)
-		put_page(f.m_iter.mpage);
+	if (f.map.mpage)
+		put_page(f.map.mpage);
 
 	/* clean up the remaining free pages */
 	put_pages_list(&pagepool);
@@ -1555,8 +1555,8 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 
 	z_erofs_submit_and_unzip(&f, &pagepool, sync);
 
-	if (f.m_iter.mpage)
-		put_page(f.m_iter.mpage);
+	if (f.map.mpage)
+		put_page(f.map.mpage);
 
 	/* clean up the remaining free pages */
 	put_pages_list(&pagepool);
@@ -1701,14 +1701,14 @@ vle_get_logical_extent_head(const struct vle_map_blocks_iter_ctx *ctx,
 
 int z_erofs_map_blocks_iter(struct inode *inode,
 	struct erofs_map_blocks *map,
-	struct page **mpage_ret, int flags)
+	int flags)
 {
 	void *kaddr;
 	const struct vle_map_blocks_iter_ctx ctx = {
 		.inode = inode,
 		.sb = inode->i_sb,
 		.clusterbits = EROFS_I_SB(inode)->clusterbits,
-		.mpage_ret = mpage_ret,
+		.mpage_ret = &map->mpage,
 		.kaddr_ret = &kaddr
 	};
 	const unsigned int clustersize = 1 << ctx.clusterbits;
@@ -1722,7 +1722,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	/* initialize `pblk' to keep gcc from printing foolish warnings */
 	erofs_blk_t mblk, pblk = 0;
-	struct page *mpage = *mpage_ret;
+	struct page *mpage = map->mpage;
 	struct z_erofs_vle_decompressed_index *di;
 	unsigned int cluster_type, logical_cluster_ofs;
 	int err = 0;
@@ -1758,7 +1758,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			err = PTR_ERR(mpage);
 			goto out;
 		}
-		*mpage_ret = mpage;
+		map->mpage = mpage;
 	} else {
 		lock_page(mpage);
 		DBG_BUGON(!PageUptodate(mpage));
@@ -1818,7 +1818,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		/* get the correspoinding first chunk */
 		err = vle_get_logical_extent_head(&ctx, lcn, &ofs,
 						  &pblk, &map->m_flags);
-		mpage = *mpage_ret;
+		mpage = map->mpage;
 
 		if (unlikely(err)) {
 			if (mpage)
-- 
2.14.4

