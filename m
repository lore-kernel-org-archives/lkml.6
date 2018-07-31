Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895A6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8020862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC8020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeGaSOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:14:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbeGaSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:14:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 658BD33F8FE7;
        Wed,  1 Aug 2018 00:33:22 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 00:33:21 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tglx@linutronix.de>, <longman@redhat.com>
CC:     <arnd@arndb.de>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/sg_pool: remove unnecessary null check when free the object
Date:   Wed, 1 Aug 2018 00:21:47 +0800
Message-ID: <1533054107-35657-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_destroy/mempool_destroy has taken null check into account.
so remove the redundant check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 lib/sg_pool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/sg_pool.c b/lib/sg_pool.c
index 6dd3061..d1c1e63 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -148,10 +148,9 @@ static __init int sg_pool_init(void)
 cleanup_sdb:
 	for (i = 0; i < SG_MEMPOOL_NR; i++) {
 		struct sg_pool *sgp = sg_pools + i;
-		if (sgp->pool)
-			mempool_destroy(sgp->pool);
-		if (sgp->slab)
-			kmem_cache_destroy(sgp->slab);
+
+		mempool_destroy(sgp->pool);
+		kmem_cache_destroy(sgp->slab);
 	}
 
 	return -ENOMEM;
-- 
1.7.12.4

