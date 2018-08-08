Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A11C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F802088E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F802088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeHHRyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730600AbeHHRyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F448162D455C;
        Wed,  8 Aug 2018 23:34:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 23:34:29 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <axboe@kernel.dk>, <lars.ellenberg@linbit.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/block/drbd: remove the null check for kmem_cache_destroy
Date:   Wed, 8 Aug 2018 23:22:47 +0800
Message-ID: <1533741767-13055-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_destroy has taken null pointer into account. So it is
safe to drop the null check before calling the function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/drbd/drbd_main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a80809b..ef8212a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2103,14 +2103,10 @@ static void drbd_destroy_mempools(void)
 	mempool_exit(&drbd_md_io_page_pool);
 	mempool_exit(&drbd_ee_mempool);
 	mempool_exit(&drbd_request_mempool);
-	if (drbd_ee_cache)
-		kmem_cache_destroy(drbd_ee_cache);
-	if (drbd_request_cache)
-		kmem_cache_destroy(drbd_request_cache);
-	if (drbd_bm_ext_cache)
-		kmem_cache_destroy(drbd_bm_ext_cache);
-	if (drbd_al_ext_cache)
-		kmem_cache_destroy(drbd_al_ext_cache);
+	kmem_cache_destroy(drbd_ee_cache);
+	kmem_cache_destroy(drbd_request_cache);
+	kmem_cache_destroy(drbd_bm_ext_cache);
+	kmem_cache_destroy(drbd_al_ext_cache);
 
 	drbd_ee_cache        = NULL;
 	drbd_request_cache   = NULL;
-- 
1.7.12.4

