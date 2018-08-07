Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A13C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12526214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12526214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbeHGNtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:49:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeHGNtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:49:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E421691B3E82F;
        Tue,  7 Aug 2018 19:35:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 19:34:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <santosh.shilimkar@oracle.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] RDS: IB: fix 'passing zero to ERR_PTR()' warning
Date:   Tue, 7 Aug 2018 19:34:16 +0800
Message-ID: <20180807113416.12680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
 net/rds/ib_frmr.c:82 rds_ib_alloc_frmr() warn: passing zero to 'ERR_PTR'

The error path for ib_alloc_mr failure should set err to PTR_ERR.

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode") 
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/rds/ib_frmr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index b371cf0..6431a02 100644
--- a/net/rds/ib_frmr.c
+++ b/net/rds/ib_frmr.c
@@ -61,6 +61,7 @@ static struct rds_ib_mr *rds_ib_alloc_frmr(struct rds_ib_device *rds_ibdev,
 			 pool->fmr_attr.max_pages);
 	if (IS_ERR(frmr->mr)) {
 		pr_warn("RDS/IB: %s failed to allocate MR", __func__);
+		err = PTR_ERR(frmr->mr);
 		goto out_no_cigar;
 	}
 
-- 
2.7.0


