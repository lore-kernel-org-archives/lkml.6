Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A529D21772
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t80Ov2ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A529D21772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeHUSLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeHUSLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:11:09 -0400
Received: from localhost.localdomain (unknown [121.229.162.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720B021776;
        Tue, 21 Aug 2018 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534863040;
        bh=ydHf1uZzUG7ePrDl5RKxHdB6052wDu22NX3/uuO4r4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t80Ov2msHPzvyEnD6CHxQsyfOkHNTSe75WzZ3AC/sQ7xyS53CXTvMQYuBU5TcbnlR
         WVUvvWS3ihTlyLbX3v5jgfMVpqi0yjAbuEeuO+4d4YYTahA/LyDPKUMqBshY77xa52
         t4m0sSIoJYF2aYCEofx1KcGe6WSQi5NMe4+dsKS8=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 7/9] staging: erofs: fix integer overflow on 32-bit platform
Date:   Tue, 21 Aug 2018 22:49:35 +0800
Message-Id: <20180821144937.20555-8-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821144937.20555-1-chao@kernel.org>
References: <20180821144937.20555-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch fixes integer overflow on multiplication
of 32-bit `lcn' in z_erofs_map_blocks_iter.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index e31393a14e0d..dab892157e51 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1513,7 +1513,7 @@ static erofs_off_t vle_get_logical_extent_head(
 		*flags ^= EROFS_MAP_ZIPPED;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		/* clustersize should be a power of two */
-		ofs = ((unsigned long long)lcn << clusterbits) +
+		ofs = ((u64)lcn << clusterbits) +
 			(le16_to_cpu(di->di_clusterofs) & (clustersize - 1));
 		*pcn = le32_to_cpu(di->di_u.blkaddr);
 		break;
@@ -1595,7 +1595,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	/* by default, compressed */
 	map->m_flags |= EROFS_MAP_ZIPPED;
 
-	end = (u64)(lcn + 1) * clustersize;
+	end = ((u64)lcn + 1) * clustersize;
 
 	cluster_type = vle_cluster_type(di);
 
@@ -1611,7 +1611,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		}
 
 		if (ofs_rem > logical_cluster_ofs) {
-			ofs = lcn * clustersize | logical_cluster_ofs;
+			ofs = (u64)lcn * clustersize | logical_cluster_ofs;
 			pcn = le32_to_cpu(di->di_u.blkaddr);
 			break;
 		}
@@ -1623,7 +1623,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			err = -EIO;
 			goto unmap_out;
 		}
-		end = (lcn-- * clustersize) | logical_cluster_ofs;
+		end = ((u64)lcn-- * clustersize) | logical_cluster_ofs;
 		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
-- 
2.18.0

