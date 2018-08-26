Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14816C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 10:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1562124D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 10:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1562124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeHZOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 10:25:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:9612 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeHZOZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 10:25:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2018 03:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,290,1531810800"; 
   d="scan'208";a="86474575"
Received: from kohsamui.iil.intel.com ([10.236.193.12])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2018 03:43:10 -0700
From:   Alexey Skidanov <alexey.skidanov@intel.com>
To:     labbott@redhat.com, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Skidanov <alexey.skidanov@intel.com>
Subject: [PATCH] staging: android: ion: Clean unused debug_show memeber of the heap object
Date:   Sun, 26 Aug 2018 13:44:12 +0300
Message-Id: <1535280252-26647-1-git-send-email-alexey.skidanov@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
---
 drivers/staging/android/ion/ion.h             |  5 -----
 drivers/staging/android/ion/ion_system_heap.c | 24 ------------------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 876197b..0afa9cd 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -158,8 +158,6 @@ struct ion_heap_ops {
  * @lock:		protects the free list
  * @waitqueue:		queue to wait on from deferred free thread
  * @task:		task struct of deferred free thread
- * @debug_show:		called when heap debug file is read to add any
- *			heap specific debug info to output
  *
  * Represents a pool of memory from which buffers can be made.  In some
  * systems the only heap is regular system memory allocated via vmalloc.
@@ -180,9 +178,6 @@ struct ion_heap {
 	spinlock_t free_lock;
 	wait_queue_head_t waitqueue;
 	struct task_struct *task;
-
-	int (*debug_show)(struct ion_heap *heap, struct seq_file *s,
-			  void *unused);
 };
 
 /**
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b5c3195..d0d0490 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -213,29 +213,6 @@ static struct ion_heap_ops system_heap_ops = {
 	.shrink = ion_system_heap_shrink,
 };
 
-static int ion_system_heap_debug_show(struct ion_heap *heap, struct seq_file *s,
-				      void *unused)
-{
-	struct ion_system_heap *sys_heap = container_of(heap,
-							struct ion_system_heap,
-							heap);
-	int i;
-	struct ion_page_pool *pool;
-
-	for (i = 0; i < NUM_ORDERS; i++) {
-		pool = sys_heap->pools[i];
-
-		seq_printf(s, "%d order %u highmem pages %lu total\n",
-			   pool->high_count, pool->order,
-			   (PAGE_SIZE << pool->order) * pool->high_count);
-		seq_printf(s, "%d order %u lowmem pages %lu total\n",
-			   pool->low_count, pool->order,
-			   (PAGE_SIZE << pool->order) * pool->low_count);
-	}
-
-	return 0;
-}
-
 static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
 {
 	int i;
@@ -282,7 +259,6 @@ static struct ion_heap *__ion_system_heap_create(void)
 	if (ion_system_heap_create_pools(heap->pools))
 		goto free_heap;
 
-	heap->heap.debug_show = ion_system_heap_debug_show;
 	return &heap->heap;
 
 free_heap:
-- 
2.7.4

