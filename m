Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5282084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130014;
	bh=tn/0xs6/4ruTlGkwaD8MqiOgI9rWu2T277qpx2XO+Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ev+UstoNIBl3jNOVQ1ActzxKc4o9/5FbEgVPp///s0BK2uRtpuIrU42b4lXw4F6XE
	 zUP8mYMLsKEC9qd8bgzNFHb483YOvLbmY2wbqJyE74vg49GIeKAbKbghvrIqePwIbr
	 7toZ0I3xg5q6lEUkzn737APxikVNxIYuQ50LFoT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfBYV0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731646AbfBYV0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8B32146F;
        Mon, 25 Feb 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130007;
        bh=tn/0xs6/4ruTlGkwaD8MqiOgI9rWu2T277qpx2XO+Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0bbphVykmChtdWKA3dlC99L0IsA8a6dUklVY/r50OIv7O0OH1AjYX+BeS5/r/R0Q
         t1TVu0Pvo9I/Unb/XKl/Nd//gGExi7TF3fml7Zwl6yk9FPlN4EPE9YGid8BdeesR4a
         /40tzmJ1IwjPAuw2NiYv5CheBprkKH4hMHgQmMwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Gong <gongchen4@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.19 136/152] staging: erofs: replace BUG_ON with DBG_BUGON in data.c
Date:   Mon, 25 Feb 2019 22:12:08 +0100
Message-Id: <20190225195053.168576608@linuxfoundation.org>
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

From: Chen Gong <gongchen4@huawei.com>

commit 9141b60cf6a53c99f8a9309bf8e1c6650a6785c1 upstream.

This patch replace BUG_ON with DBG_BUGON in data.c, and add necessary
error handler.

Signed-off-by: Chen Gong <gongchen4@huawei.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/data.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -25,7 +25,7 @@ static inline void read_endio(struct bio
 		struct page *page = bvec->bv_page;
 
 		/* page is already locked */
-		BUG_ON(PageUptodate(page));
+		DBG_BUGON(PageUptodate(page));
 
 		if (unlikely(err))
 			SetPageError(page);
@@ -91,12 +91,12 @@ static int erofs_map_blocks_flatmode(str
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
@@ -123,18 +123,27 @@ static int erofs_map_blocks_flatmode(str
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
@@ -190,7 +199,7 @@ static inline struct bio *erofs_read_raw
 	erofs_off_t current_block = (erofs_off_t)page->index;
 	int err;
 
-	BUG_ON(!nblocks);
+	DBG_BUGON(!nblocks);
 
 	if (PageUptodate(page)) {
 		err = 0;
@@ -233,7 +242,7 @@ submit_bio_retry:
 		}
 
 		/* for RAW access mode, m_plen must be equal to m_llen */
-		BUG_ON(map.m_plen != map.m_llen);
+		DBG_BUGON(map.m_plen != map.m_llen);
 
 		blknr = erofs_blknr(map.m_pa);
 		blkoff = erofs_blkoff(map.m_pa);
@@ -243,7 +252,7 @@ submit_bio_retry:
 			void *vsrc, *vto;
 			struct page *ipage;
 
-			BUG_ON(map.m_plen > PAGE_SIZE);
+			DBG_BUGON(map.m_plen > PAGE_SIZE);
 
 			ipage = erofs_get_meta_page(inode->i_sb, blknr, 0);
 
@@ -270,7 +279,7 @@ submit_bio_retry:
 		}
 
 		/* pa must be block-aligned for raw reading */
-		BUG_ON(erofs_blkoff(map.m_pa) != 0);
+		DBG_BUGON(erofs_blkoff(map.m_pa));
 
 		/* max # of continuous pages */
 		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
@@ -331,7 +340,7 @@ static int erofs_raw_access_readpage(str
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	BUG_ON(bio != NULL);	/* since we have only one bio -- must be NULL */
+	DBG_BUGON(bio);	/* since we have only one bio -- must be NULL */
 	return 0;
 }
 
@@ -369,7 +378,7 @@ static int erofs_raw_access_readpages(st
 		/* pages could still be locked */
 		put_page(page);
 	}
-	BUG_ON(!list_empty(pages));
+	DBG_BUGON(!list_empty(pages));
 
 	/* the rare case (end in gaps) */
 	if (unlikely(bio != NULL))


