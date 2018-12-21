Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24816C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C421905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeLUCT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:19:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43865 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732301AbeLUCT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:19:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E4EEBBAC63C5;
        Fri, 21 Dec 2018 10:19:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 21 Dec 2018
 10:19:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dennis.dalessandro@intel.com>, <mike.marciniszyn@intel.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] IB/qib: Add missing err handle for qib_user_sdma_rb_insert
Date:   Fri, 21 Dec 2018 10:19:38 +0800
Message-ID: <20181221021938.13784-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should goto err handle if qib_user_sdma_rb_insert fails,
other than success return.

Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 31c523b..e87c0a7 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
 
 		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
 					sdma_rb_node);
+		if (ret == 0)
+			goto err_rb;
 	}
 	pq->sdma_rb_node = sdma_rb_node;
 
-- 
2.7.0


