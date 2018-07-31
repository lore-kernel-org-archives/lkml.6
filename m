Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD25C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BEB20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BEB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeGaRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:47:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbeGaRr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:47:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C28CD8256B2B4;
        Wed,  1 Aug 2018 00:06:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 00:06:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tglx@linutronix.de>, <longman@redhat.com>
CC:     <yang.shi@linux.alibaba.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/sg_pool,debugobjects: remove unnecessary null check when free the object
Date:   Tue, 31 Jul 2018 23:55:19 +0800
Message-ID: <1533052519-34372-1-git-send-email-zhongjiang@huawei.com>
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
 lib/debugobjects.c | 3 +--
 lib/sg_pool.c      | 7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 994be48..7a6d80b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1185,8 +1185,7 @@ void __init debug_objects_mem_init(void)
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-		if (obj_cache)
-			kmem_cache_destroy(obj_cache);
+		kmem_cache_destroy(obj_cache);
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
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

