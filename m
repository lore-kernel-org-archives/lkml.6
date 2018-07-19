Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE159C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808F820671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808F820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeGSPCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:02:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731008AbeGSPCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:02:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F0518CFEFC76;
        Thu, 19 Jul 2018 22:18:40 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 22:18:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] libcxgb: replace vmalloc and memset with vzalloc
Date:   Thu, 19 Jul 2018 22:18:27 +0800
Message-ID: <20180719141827.7776-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc instead of the vmalloc, memset combo

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 0ed1616..74849be 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -412,12 +412,10 @@ int cxgbi_ppm_init(void **ppm_pp, struct net_device *ndev,
 			ppmax * (sizeof(struct cxgbi_ppod_data)) +
 			ppod_bmap_size * sizeof(unsigned long);
 
-	ppm = vmalloc(alloc_sz);
+	ppm = vzalloc(alloc_sz);
 	if (!ppm)
 		goto release_ppm_pool;
 
-	memset(ppm, 0, alloc_sz);
-
 	ppm->ppod_bmap = (unsigned long *)(&ppm->ppod_data[ppmax]);
 
 	if ((ppod_bmap_size >> 3) > (ppmax - ppmax_pool)) {
-- 
2.7.0


