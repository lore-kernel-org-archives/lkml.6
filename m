Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F98C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A812E214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A812E214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeIZSLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:11:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727201AbeIZSLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:11:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0CD892B182AD;
        Wed, 26 Sep 2018 19:58:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Wed, 26 Sep 2018 19:58:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <paulus@samba.org>, <benh@kernel.crashing.org>,
        <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: Move a dereference below a NULL test
Date:   Wed, 26 Sep 2018 19:46:08 +0800
Message-ID: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safe to move dereference below a NULL test.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/powerpc/kernel/cacheinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index a8f20e5..7f19714 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -401,14 +401,13 @@ static struct cache *cache_lookup_or_instantiate(struct device_node *node,
 	struct cache *cache;
 
 	cache = cache_lookup_by_node(node);
+	if (!cache)
+		cache = cache_do_one_devnode(node, level);
 
 	WARN_ONCE(cache && cache->level != level,
 		  "cache level mismatch on lookup (got %d, expected %d)\n",
 		  cache->level, level);
 
-	if (!cache)
-		cache = cache_do_one_devnode(node, level);
-
 	return cache;
 }
 
-- 
1.7.12.4

