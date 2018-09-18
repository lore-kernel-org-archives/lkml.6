Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31927ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC432146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC432146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeIRT7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:59:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730065AbeIRT7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:59:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AD15FC0FAF70;
        Tue, 18 Sep 2018 22:26:11 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 22:26:03 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 1/8] staging: erofs: fix a missing endian conversion
Date:   Tue, 18 Sep 2018 22:25:33 +0800
Message-ID: <1537280740-122019-2-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
References: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a missing endian conversion in
vle_get_logical_extent_head.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 21874b7..d16e3dc 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1488,6 +1488,7 @@ static erofs_off_t vle_get_logical_extent_head(
 	struct super_block *const sb = inode->i_sb;
 	const unsigned int clusterbits = EROFS_SB(sb)->clusterbits;
 	const unsigned int clustersize = 1 << clusterbits;
+	unsigned int delta0;
 
 	if (page->index != blkaddr) {
 		kunmap_atomic(*kaddr_iter);
@@ -1502,12 +1503,13 @@ static erofs_off_t vle_get_logical_extent_head(
 	di = *kaddr_iter + vle_extent_blkoff(inode, lcn);
 	switch (vle_cluster_type(di)) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		BUG_ON(!di->di_u.delta[0]);
-		BUG_ON(lcn < di->di_u.delta[0]);
+		delta0 = le16_to_cpu(di->di_u.delta[0]);
+		DBG_BUGON(!delta0);
+		DBG_BUGON(lcn < delta0);
 
 		ofs = vle_get_logical_extent_head(inode,
 			page_iter, kaddr_iter,
-			lcn - di->di_u.delta[0], pcn, flags);
+			lcn - delta0, pcn, flags);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		*flags ^= EROFS_MAP_ZIPPED;
-- 
1.9.1

