Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD27C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8F92089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8F92089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeI3RNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:13:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbeI3RNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:13:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9462E810E0566;
        Sun, 30 Sep 2018 18:40:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Sun, 30 Sep 2018 18:40:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linux-foundation.org>
CC:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <mhocko@kernel.org>, <mgorman@suse.de>, <vbabka@suse.cz>,
        <andrea@kernel.org>, <kirill@shutemov.name>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [STABLE PATCH] slub: make ->cpu_partial unsigned int
Date:   Sun, 30 Sep 2018 18:28:21 +0800
Message-ID: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit e5d9998f3e09359b372a037a6ac55ba235d95d57 ]

        /*
         * cpu_partial determined the maximum number of objects
         * kept in the per cpu partial lists of a processor.
         */

Can't be negative.

I hit a real issue that it will result in a large number of memory leak.
Becuase Freeing slabs are in interrupt context. So it can trigger this issue.
put_cpu_partial can be interrupted more than once.
due to a union struct of lru and pobjects in struct page, when other core handles
page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
result in pobjects being a negative value(0xdead0000). Therefore, a large number
of slabs will be added to per_cpu partial list.

I had posted the issue to community before. The detailed issue description is as follows.

https://www.spinics.net/lists/kernel/msg2870979.html

After applying the patch, The issue is fixed. So the patch is a effective bugfix.
It should go into stable.

Link: http://lkml.kernel.org/r/20180305200730.15812-15-adobriyan@gmail.com
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 include/linux/slub_def.h | 3 ++-
 mm/slub.c                | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 3388511..9b681f2 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -67,7 +67,8 @@ struct kmem_cache {
 	int size;		/* The size of an object including meta data */
 	int object_size;	/* The size of an object without meta data */
 	int offset;		/* Free pointer offset. */
-	int cpu_partial;	/* Number of per cpu partial objects to keep around */
+	/* Number of per cpu partial objects to keep around */
+	unsigned int cpu_partial;
 	struct kmem_cache_order_objects oo;
 
 	/* Allocation and freeing of slabs */
diff --git a/mm/slub.c b/mm/slub.c
index 2284c43..c33b0e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1661,7 +1661,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 {
 	struct page *page, *page2;
 	void *object = NULL;
-	int available = 0;
+	unsigned int available = 0;
 	int objects;
 
 	/*
@@ -4674,10 +4674,10 @@ static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
 static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
 				 size_t length)
 {
-	unsigned long objects;
+	unsigned int objects;
 	int err;
 
-	err = kstrtoul(buf, 10, &objects);
+	err = kstrtouint(buf, 10, &objects);
 	if (err)
 		return err;
 	if (objects && !kmem_cache_has_cpu_partial(s))
-- 
1.7.12.4

