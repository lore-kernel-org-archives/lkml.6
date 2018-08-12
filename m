Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D25CC46471
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FC621A50
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0MZQ0iyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FC621A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeHLQk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeHLQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:40:55 -0400
Received: from localhost.localdomain (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292EB21A2A;
        Sun, 12 Aug 2018 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534082566;
        bh=2NnshIAv3TITB8NEN9LQQagecPgW/HNyAOKhwWJeleU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MZQ0iywQJI8Ih9lvS2YQFK0ynjn3p3X6y24+UV7g0L28iLHfsaWlV/U1oaQR1Xbx
         9lNXnhX5hVe088PtOZtk8o7VDBxsjZ5Gg5OqcR4hqvp7wW+GkQJP58vhI69unmb6r6
         9qhi4rNbeIw0RI7TdEfz3QUxs31t3XF4xxHywwGY=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 6/8] staging: erofs: fix vle_decompressed_index_clusterofs
Date:   Sun, 12 Aug 2018 22:01:48 +0800
Message-Id: <20180812140150.13397-7-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180812140150.13397-1-chao@kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch adds error handing code, and fixes a missing
endian conversion in vle_decompressed_index_clusterofs.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f597f079d579..ae99b6811d4a 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1419,24 +1419,24 @@ const struct address_space_operations z_erofs_vle_normalaccess_aops = {
 #define vle_cluster_type(di)	\
 	__vle_cluster_type((di)->di_advise)
 
-static inline unsigned
-vle_compressed_index_clusterofs(unsigned clustersize,
-	struct z_erofs_vle_decompressed_index *di)
+static inline int
+vle_decompressed_index_clusterofs(unsigned int *clusterofs,
+				  unsigned int clustersize,
+				  struct z_erofs_vle_decompressed_index *di)
 {
-	debugln("%s, vle=%pK, advise=%x (type %u), clusterofs=%x blkaddr=%x",
-		__func__, di, di->di_advise, vle_cluster_type(di),
-		di->di_clusterofs, di->di_u.blkaddr);
-
 	switch (vle_cluster_type(di)) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		*clusterofs = clustersize;
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
-		return di->di_clusterofs;
+		*clusterofs = le16_to_cpu(di->di_clusterofs);
+		break;
 	default:
-		BUG_ON(1);
+		DBG_BUGON(1);
+		return -EIO;
 	}
-	return clustersize;
+	return 0;
 }
 
 static inline erofs_blk_t
@@ -1581,7 +1581,11 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	debugln("%s, lcn %u e_blkaddr %u e_blkoff %u", __func__, lcn,
 		e_blkaddr, vle_extent_blkoff(inode, lcn));
 
-	logical_cluster_ofs = vle_compressed_index_clusterofs(clustersize, di);
+	err = vle_decompressed_index_clusterofs(&logical_cluster_ofs,
+						clustersize, di);
+	if (unlikely(err))
+		goto unmap_out;
+
 	if (!initial) {
 		/* [walking mode] 'map' has been already initialized */
 		map->m_llen += logical_cluster_ofs;
-- 
2.18.0

