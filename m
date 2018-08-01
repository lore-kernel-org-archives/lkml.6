Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF24AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7111420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7111420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbeHALWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388612AbeHALWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE7EDD0867067;
        Wed,  1 Aug 2018 17:37:09 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 1 Aug 2018
 17:37:03 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <yuchao0@huawei.com>, <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        <hsiangkao@aol.com>, <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH RESEND 1/2] staging: erofs: add the missing break in z_erofs_map_blocks_iter
Date:   Wed, 1 Aug 2018 17:36:54 +0800
Message-ID: <1533116214-70017-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <ea978a27-efd4-9d58-e4c0-f9d00420304f@huawei.com>
References: <ea978a27-efd4-9d58-e4c0-f9d00420304f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing break after adding the default case.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
As pointed out by Dan Carpenter:
 - fix the wrong place of fallthrough comments

 drivers/staging/erofs/unzip_vle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index bd2d7a8..1030ca5 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1599,6 +1599,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (ofs_rem >= logical_cluster_ofs)
 			map->m_flags ^= EROFS_MAP_ZIPPED;
+		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (ofs_rem == logical_cluster_ofs) {
 			pcn = le32_to_cpu(di->di_u.blkaddr);
@@ -1619,11 +1620,13 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			goto unmap_out;
 		}
 		end = (lcn-- * clustersize) | logical_cluster_ofs;
+		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		ofs = vle_get_logical_extent_head(inode, mpage_ret,
 			&kaddr, lcn, &pcn, &map->m_flags);
 		mpage = *mpage_ret;
+		break;
 	default:
 		errln("unknown cluster type %u at offset %llu of nid %llu",
 			cluster_type, ofs, EROFS_V(inode)->nid);
-- 
1.9.1

