Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72EDECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BF82083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BF82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeINT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:56:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728459AbeINT4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:56:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 453A32456250A;
        Fri, 14 Sep 2018 22:41:44 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 14 Sep
 2018 22:41:36 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 3/8] staging: erofs: complete error handing of z_erofs_map_blocks_iter
Date:   Fri, 14 Sep 2018 22:40:25 +0800
Message-ID: <1536936030-62362-4-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch completes error handing of z_erofs_map_blocks_iter
and vle_get_logical_extent_head, including no memory and
io error cases.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index d6e5956..d4998fe 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1500,7 +1500,11 @@ struct vle_map_blocks_iter_ctx {
 		unlock_page(mpage);
 		put_page(mpage);
 
-		mpage = erofs_get_meta_page_nofail(ctx->sb, mblk, false);
+		mpage = erofs_get_meta_page(ctx->sb, mblk, false);
+		if (IS_ERR(mpage)) {
+			*ctx->mpage_ret = NULL;
+			return PTR_ERR(mpage);
+		}
 		*ctx->mpage_ret = mpage;
 		*ctx->kaddr_ret = kmap_atomic(mpage);
 	}
@@ -1511,9 +1515,12 @@ struct vle_map_blocks_iter_ctx {
 	switch (cluster_type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		delta0 = le16_to_cpu(di->di_u.delta[0]);
-		DBG_BUGON(!delta0);
-		DBG_BUGON(lcn < delta0);
-
+		if (unlikely(!delta0 || delta0 > lcn)) {
+			errln("invalid NONHEAD dl0 %u at lcn %u of nid %llu",
+			      delta0, lcn, EROFS_V(ctx->inode)->nid);
+			DBG_BUGON(1);
+			return -EIO;
+		}
 		return vle_get_logical_extent_head(ctx,
 			lcn - delta0, ofs, pblk, flags);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
@@ -1526,7 +1533,10 @@ struct vle_map_blocks_iter_ctx {
 		*pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
 	default:
-		BUG_ON(1);
+		errln("unknown cluster type %u at lcn %u of nid %llu",
+		      cluster_type, lcn, EROFS_V(ctx->inode)->nid);
+		DBG_BUGON(1);
+		return -EIO;
 	}
 	return 0;
 }
@@ -1582,7 +1592,11 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		if (mpage != NULL)
 			put_page(mpage);
 
-		mpage = erofs_get_meta_page_nofail(ctx.sb, mblk, false);
+		mpage = erofs_get_meta_page(ctx.sb, mblk, false);
+		if (IS_ERR(mpage)) {
+			err = PTR_ERR(mpage);
+			goto out;
+		}
 		*mpage_ret = mpage;
 	} else {
 		lock_page(mpage);
@@ -1645,8 +1659,11 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 						  &pblk, &map->m_flags);
 		mpage = *mpage_ret;
 
-		if (unlikely(err))
-			goto unmap_out;
+		if (unlikely(err)) {
+			if (mpage)
+				goto unmap_out;
+			goto out;
+		}
 		break;
 	default:
 		errln("unknown cluster type %u at offset %llu of nid %llu",
@@ -1670,7 +1687,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		map->m_llen, map->m_plen, map->m_flags);
 
 	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
-	DBG_BUGON(err < 0);
+	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
 
-- 
1.9.1

