Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5331C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A922146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A922146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbeIRUBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:01:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbeIRUBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:01:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36683673FE325;
        Tue, 18 Sep 2018 22:28:42 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 22:28:33 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chen Gong <gongchen4@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 8/8] staging: erofs: replace BUG_ON with DBG_BUGON in data.c
Date:   Tue, 18 Sep 2018 22:27:28 +0800
Message-ID: <1537280848-122331-4-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537280848-122331-1-git-send-email-gaoxiang25@huawei.com>
References: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
 <1537280848-122331-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Gong <gongchen4@huawei.com>

This patch replace BUG_ON with DBG_BUGON in data.c, and add necessary
error handler.

Signed-off-by: Chen Gong <gongchen4@huawei.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/data.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index e191610..6384f73 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -25,7 +25,7 @@ static inline void read_endio(struct bio *bio)
 		struct page *page = bvec->bv_page;
 
 		/* page is already locked */
-		BUG_ON(PageUptodate(page));
+		DBG_BUGON(PageUptodate(page));
 
 		if (unlikely(err))
 			SetPageError(page);
@@ -110,12 +110,12 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	struct erofs_map_blocks *map,
 	int flags)
 {
+	int err = 0;
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
 	struct erofs_vnode *vi = EROFS_V(inode);
 
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
-	BUG_ON(is_inode_layout_compression(inode));
 
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 	lastblk = nblocks - is_inode_layout_inline(inode);
@@ -142,18 +142,27 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 		map->m_plen = inode->i_size - offset;
 
 		/* inline data should locate in one meta block */
-		BUG_ON(erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE);
+		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+			DBG_BUGON(1);
+			err = -EIO;
+			goto err_out;
+		}
+
 		map->m_flags |= EROFS_MAP_META;
 	} else {
 		errln("internal error @ nid: %llu (size %llu), m_la 0x%llx",
 			vi->nid, inode->i_size, map->m_la);
-		BUG();
+		DBG_BUGON(1);
+		err = -EIO;
+		goto err_out;
 	}
 
 out:
 	map->m_llen = map->m_plen;
+
+err_out:
 	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
-	return 0;
+	return err;
 }
 
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -209,7 +218,7 @@ static inline struct bio *erofs_read_raw_page(
 	erofs_off_t current_block = (erofs_off_t)page->index;
 	int err;
 
-	BUG_ON(!nblocks);
+	DBG_BUGON(!nblocks);
 
 	if (PageUptodate(page)) {
 		err = 0;
@@ -252,7 +261,7 @@ static inline struct bio *erofs_read_raw_page(
 		}
 
 		/* for RAW access mode, m_plen must be equal to m_llen */
-		BUG_ON(map.m_plen != map.m_llen);
+		DBG_BUGON(map.m_plen != map.m_llen);
 
 		blknr = erofs_blknr(map.m_pa);
 		blkoff = erofs_blkoff(map.m_pa);
@@ -262,7 +271,7 @@ static inline struct bio *erofs_read_raw_page(
 			void *vsrc, *vto;
 			struct page *ipage;
 
-			BUG_ON(map.m_plen > PAGE_SIZE);
+			DBG_BUGON(map.m_plen > PAGE_SIZE);
 
 			ipage = erofs_get_meta_page(inode->i_sb, blknr, 0);
 
@@ -289,7 +298,7 @@ static inline struct bio *erofs_read_raw_page(
 		}
 
 		/* pa must be block-aligned for raw reading */
-		BUG_ON(erofs_blkoff(map.m_pa) != 0);
+		DBG_BUGON(erofs_blkoff(map.m_pa));
 
 		/* max # of continuous pages */
 		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
@@ -357,7 +366,7 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	BUG_ON(bio != NULL);	/* since we have only one bio -- must be NULL */
+	DBG_BUGON(bio);	/* since we have only one bio -- must be NULL */
 	return 0;
 }
 
@@ -395,7 +404,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 		/* pages could still be locked */
 		put_page(page);
 	}
-	BUG_ON(!list_empty(pages));
+	DBG_BUGON(!list_empty(pages));
 
 	/* the rare case (end in gaps) */
 	if (unlikely(bio != NULL))
-- 
1.9.1

