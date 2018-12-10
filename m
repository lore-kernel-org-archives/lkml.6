Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1543AC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2B020831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rt7gDOvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2B020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeLJAg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:36:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47284 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeLJAgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:36:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA0Y9G8045438;
        Mon, 10 Dec 2018 00:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=AAAJaR+x+qU37PF8a6qz97uABI2WDq58EMRbRYKVo/0=;
 b=rt7gDOvQs1NpLS3OXJY76DNmY2JK4n7+5mIj92OAdeIvPysQ6ZbJT2uNxQC7KyhmQrVY
 iQJq6K94buR3kpJC6VVwLOZPwmB22a5TerIx4XxYBgmgXN1lg/8c04gBGTozaEUbC9Tg
 YCwfay4fcQ5iR5E6nt7XWZOH3ny350p3zdtgQRbmL+yPrF7r1eT2P5XwdEzkNubGoNse
 MTENLqiRdDPBXvVJOhWLdMeAW7c2DKpVPOCAZyrcaKgWTKPC+KtD/YkiGHH2f7ITSKAA
 CZs4PLAxWHFoUoJQrC1xUoNTsVUQ0WO2VspQEIjp0K0n7nfPKT60O8DOEqIJEa7KK3Kv Sw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p86kqk6as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 00:36:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBA0a97V032634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 00:36:09 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBA0a7hm021194;
        Mon, 10 Dec 2018 00:36:08 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 16:36:06 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH v2 2/2] swiotlb: checking whether swiotlb buffer is full with io_tlb_used
Date:   Mon, 10 Dec 2018 08:37:58 +0800
Message-Id: <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9102 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=807
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses io_tlb_used to help check whether swiotlb buffer is full.
io_tlb_used is no longer used for only debugfs. It is also used to help
optimize swiotlb_tbl_map_single().

Suggested-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3979c2c..9300341 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -76,12 +76,10 @@ static phys_addr_t io_tlb_start, io_tlb_end;
  */
 static unsigned long io_tlb_nslabs;
 
-#ifdef CONFIG_DEBUG_FS
 /*
  * The number of used IO TLB block
  */
 static unsigned long io_tlb_used;
-#endif
 
 /*
  * This is a free list describing the number of free entries available from
@@ -489,6 +487,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * request and allocate a buffer from that IO TLB pool.
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
+
+	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
+		goto not_found;
+
 	index = ALIGN(io_tlb_index, stride);
 	if (index >= io_tlb_nslabs)
 		index = 0;
@@ -538,9 +540,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
-#ifdef CONFIG_DEBUG_FS
 	io_tlb_used += nslots;
-#endif
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -602,9 +602,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
 
-#ifdef CONFIG_DEBUG_FS
 		io_tlb_used -= nslots;
-#endif
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
-- 
2.7.4

