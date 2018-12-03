Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14181C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5F320850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5F320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLCR2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:28:34 -0500
Received: from foss.arm.com ([217.140.101.70]:42888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeLCR2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:28:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 792E5169E;
        Mon,  3 Dec 2018 09:28:29 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22DE53F59C;
        Mon,  3 Dec 2018 09:28:27 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH 2/4] dma-debug: Refactor dma_debug_entry allocation
Date:   Mon,  3 Dec 2018 17:28:07 +0000
Message-Id: <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1543856576.git.robin.murphy@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make prealloc_memory() a little more general and robust so that it
serves for runtime reallocations too. The first thing we can do with
that is clean up dma_debug_resize_entries() quite a bit.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/debug.c | 95 +++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 91b84140e4a5..de5db800dbfc 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -645,6 +645,39 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
+static int prealloc_memory(u32 num_entries)
+{
+	struct dma_debug_entry *entry, *next_entry;
+	unsigned long flags;
+	LIST_HEAD(tmp);
+	int i;
+
+	for (i = 0; i < num_entries; ++i) {
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			goto out_err;
+
+		list_add_tail(&entry->list, &tmp);
+	}
+
+	spin_lock_irqsave(&free_entries_lock, flags);
+	list_splice(&tmp, &free_entries);
+	num_free_entries += num_entries;
+	nr_total_entries += num_entries;
+	spin_unlock_irqrestore(&free_entries_lock, flags);
+
+	return 0;
+
+out_err:
+
+	list_for_each_entry_safe(entry, next_entry, &tmp, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	return -ENOMEM;
+}
+
 static struct dma_debug_entry *__dma_entry_alloc(void)
 {
 	struct dma_debug_entry *entry;
@@ -714,44 +747,25 @@ int dma_debug_resize_entries(u32 num_entries)
 	int i, delta, ret = 0;
 	unsigned long flags;
 	struct dma_debug_entry *entry;
-	LIST_HEAD(tmp);
-
-	spin_lock_irqsave(&free_entries_lock, flags);
 
 	if (nr_total_entries < num_entries) {
 		delta = num_entries - nr_total_entries;
 
-		spin_unlock_irqrestore(&free_entries_lock, flags);
-
-		for (i = 0; i < delta; i++) {
-			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-			if (!entry)
-				break;
-
-			list_add_tail(&entry->list, &tmp);
-		}
-
-		spin_lock_irqsave(&free_entries_lock, flags);
-
-		list_splice(&tmp, &free_entries);
-		nr_total_entries += i;
-		num_free_entries += i;
+		ret = prealloc_memory(delta);
 	} else {
 		delta = nr_total_entries - num_entries;
 
+		spin_lock_irqsave(&free_entries_lock, flags);
 		for (i = 0; i < delta && !list_empty(&free_entries); i++) {
 			entry = __dma_entry_alloc();
 			kfree(entry);
 		}
+		spin_unlock_irqrestore(&free_entries_lock, flags);
 
 		nr_total_entries -= i;
+		if (nr_total_entries != num_entries)
+			ret = -EBUSY;
 	}
-
-	if (nr_total_entries != num_entries)
-		ret = 1;
-
-	spin_unlock_irqrestore(&free_entries_lock, flags);
-
 	return ret;
 }
 
@@ -763,36 +777,6 @@ int dma_debug_resize_entries(u32 num_entries)
  *   2. Preallocate a given number of dma_debug_entry structs
  */
 
-static int prealloc_memory(u32 num_entries)
-{
-	struct dma_debug_entry *entry, *next_entry;
-	int i;
-
-	for (i = 0; i < num_entries; ++i) {
-		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-		if (!entry)
-			goto out_err;
-
-		list_add_tail(&entry->list, &free_entries);
-	}
-
-	num_free_entries = num_entries;
-	min_free_entries = num_entries;
-
-	pr_info("preallocated %d debug entries\n", num_entries);
-
-	return 0;
-
-out_err:
-
-	list_for_each_entry_safe(entry, next_entry, &free_entries, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
-	return -ENOMEM;
-}
-
 static ssize_t filter_read(struct file *file, char __user *user_buf,
 			   size_t count, loff_t *ppos)
 {
@@ -1038,7 +1022,8 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	nr_total_entries = num_free_entries;
+	min_free_entries = num_free_entries;
+	pr_info("preallocated %d debug entries\n", nr_total_entries);
 
 	dma_debug_initialized = true;
 
-- 
2.19.1.dirty

