Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB9920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB9920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeGZNpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:45:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730178AbeGZNnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A7E8F2F7EA116;
        Thu, 26 Jul 2018 20:27:06 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:27:01 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 17/25] staging: erofs: globalize prepare_bio and __submit_bio
Date:   Thu, 26 Jul 2018 20:22:00 +0800
Message-ID: <1532607728-103372-18-git-send-email-gaoxiang25@huawei.com>
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

The unzip subsystem also uses these functions,
let's export them to internal.h.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/data.c     | 34 +++++++++-------------------------
 drivers/staging/erofs/internal.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 163bfe6..ac263a1 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -38,26 +38,6 @@ static inline void read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-static void __submit_bio(struct bio *bio, unsigned op, unsigned op_flags)
-{
-	bio_set_op_attrs(bio, op, op_flags);
-	submit_bio(bio);
-}
-
-static struct bio *prepare_bio(struct super_block *sb,
-	erofs_blk_t blkaddr, unsigned nr_pages)
-{
-	struct bio *bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, nr_pages);
-
-	BUG_ON(bio == NULL);
-
-	bio->bi_end_io = read_endio;
-	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_iter.bi_sector = blkaddr << LOG_SECTORS_PER_BLOCK;
-
-	return bio;
-}
-
 /* prio -- true is used for dir */
 struct page *erofs_get_meta_page(struct super_block *sb,
 	erofs_blk_t blkaddr, bool prio)
@@ -80,7 +60,7 @@ struct page *erofs_get_meta_page(struct super_block *sb,
 		struct bio *bio;
 		int err;
 
-		bio = prepare_bio(sb, blkaddr, 1);
+		bio = prepare_bio(sb, blkaddr, 1, read_endio);
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
 		BUG_ON(err != PAGE_SIZE);
 
@@ -236,6 +216,8 @@ static inline struct bio *erofs_read_raw_page(
 		struct erofs_map_blocks map = {
 			.m_la = blknr_to_addr(current_block),
 		};
+		erofs_blk_t blknr;
+		unsigned blkoff;
 
 		err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
 		if (unlikely(err))
@@ -253,6 +235,9 @@ static inline struct bio *erofs_read_raw_page(
 		/* for RAW access mode, m_plen must be equal to m_llen */
 		BUG_ON(map.m_plen != map.m_llen);
 
+		blknr = erofs_blknr(map.m_pa);
+		blkoff = erofs_blkoff(map.m_pa);
+
 		/* deal with inline page */
 		if (map.m_flags & EROFS_MAP_META) {
 			void *vsrc, *vto;
@@ -260,8 +245,7 @@ static inline struct bio *erofs_read_raw_page(
 
 			BUG_ON(map.m_plen > PAGE_SIZE);
 
-			ipage = erofs_get_meta_page(inode->i_sb,
-				erofs_blknr(map.m_pa), 0);
+			ipage = erofs_get_meta_page(inode->i_sb, blknr, 0);
 
 			if (IS_ERR(ipage)) {
 				err = PTR_ERR(ipage);
@@ -270,7 +254,7 @@ static inline struct bio *erofs_read_raw_page(
 
 			vsrc = kmap_atomic(ipage);
 			vto = kmap_atomic(page);
-			memcpy(vto, vsrc + erofs_blkoff(map.m_pa), map.m_plen);
+			memcpy(vto, vsrc + blkoff, map.m_plen);
 			memset(vto + map.m_plen, 0, PAGE_SIZE - map.m_plen);
 			kunmap_atomic(vto);
 			kunmap_atomic(vsrc);
@@ -294,7 +278,7 @@ static inline struct bio *erofs_read_raw_page(
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = prepare_bio(inode->i_sb, erofs_blknr(map.m_pa), nblocks);
+		bio = prepare_bio(inode->i_sb, blknr, nblocks, read_endio);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 210ab6c..6a0f045 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -285,6 +285,39 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_RAW    0x0001
 
 /* data.c */
+static inline struct bio *prepare_bio(
+	struct super_block *sb,
+	erofs_blk_t blkaddr, unsigned nr_pages,
+	bio_end_io_t endio)
+{
+	gfp_t gfp = GFP_NOIO;
+	struct bio *bio = bio_alloc(gfp, nr_pages);
+
+	if (unlikely(bio == NULL) &&
+		(current->flags & PF_MEMALLOC)) {
+		do {
+			nr_pages /= 2;
+			if (unlikely(!nr_pages)) {
+				bio = bio_alloc(gfp | __GFP_NOFAIL, 1);
+				BUG_ON(bio == NULL);
+				break;
+			}
+			bio = bio_alloc(gfp, nr_pages);
+		} while (bio == NULL);
+	}
+
+	bio->bi_end_io = endio;
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_iter.bi_sector = blkaddr << LOG_SECTORS_PER_BLOCK;
+	return bio;
+}
+
+static inline void __submit_bio(struct bio *bio, unsigned op, unsigned op_flags)
+{
+	bio_set_op_attrs(bio, op, op_flags);
+	submit_bio(bio);
+}
+
 extern struct page *erofs_get_meta_page(struct super_block *sb,
 	erofs_blk_t blkaddr, bool prio);
 extern int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
-- 
1.9.1

