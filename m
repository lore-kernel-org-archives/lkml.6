Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDBEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D257C2177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xrOpY6IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D257C2177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeHUSLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeHUSLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:11:07 -0400
Received: from localhost.localdomain (unknown [121.229.162.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8B0421777;
        Tue, 21 Aug 2018 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534863039;
        bh=fjMe5ftlj5G4DtRQxVloeV1XYQta7tVPOutvBU6SDko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrOpY6IVRUBwjZAW9GE4g+XvtNP5yX3cBE/8eOSh+EvIIRJqmZ9vEE2gSFMlQblu/
         4xxM4zi1d1Bm8HIupPLZ6xxtT19/SHJIExyu1DG5RsC1Ky9o5SWargi4W0qEv6Iupb
         TeM4kgIOc5vCI2Dp1IW24YtlvLicQgJnDHQYWR9I=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 6/9] staging: erofs: fix vle_decompressed_index_clusterofs
Date:   Tue, 21 Aug 2018 22:49:34 +0800
Message-Id: <20180821144937.20555-7-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821144937.20555-1-chao@kernel.org>
References: <20180821144937.20555-1-chao@kernel.org>
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
index f597f079d579..e31393a14e0d 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1419,24 +1419,24 @@ const struct address_space_operations z_erofs_vle_normalaccess_aops = {
 #define vle_cluster_type(di)	\
 	__vle_cluster_type((di)->di_advise)
 
-static inline unsigned
-vle_compressed_index_clusterofs(unsigned clustersize,
-	struct z_erofs_vle_decompressed_index *di)
+static int
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

