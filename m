Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73512C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0D2208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0D2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeLET5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:57:16 -0500
Received: from foss.arm.com ([217.140.101.70]:34506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeLET5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A09115AB;
        Wed,  5 Dec 2018 11:57:14 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7FE03F614;
        Wed,  5 Dec 2018 11:57:12 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Date:   Wed,  5 Dec 2018 19:56:52 +0000
Message-Id: <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the prealloc_memory() logic a little more general and robust so
that it serves for runtime reallocations too. The first thing we can
do with that is clean up dma_debug_resize_entries() a bit.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Give it a better name, simplify the locking mess

 kernel/dma/debug.c | 87 +++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 29486eb9d1dc..1b0858d7edfd 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -646,6 +646,36 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
+static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
+{
+	struct dma_debug_entry *entry, *next_entry;
+	LIST_HEAD(tmp);
+	int i;
+
+	for (i = 0; i < num_entries; ++i) {
+		entry = kzalloc(sizeof(*entry), gfp);
+		if (!entry)
+			goto out_err;
+
+		list_add_tail(&entry->list, &tmp);
+	}
+
+	list_splice(&tmp, &free_entries);
+	num_free_entries += num_entries;
+	nr_total_entries += num_entries;
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
@@ -715,28 +745,13 @@ int dma_debug_resize_entries(u32 num_entries)
 	int i, delta, ret = 0;
 	unsigned long flags;
 	struct dma_debug_entry *entry;
-	LIST_HEAD(tmp);
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 
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
+		ret = dma_debug_add_entries(delta, GFP_ATOMIC);
 	} else {
 		delta = nr_total_entries - num_entries;
 
@@ -746,11 +761,10 @@ int dma_debug_resize_entries(u32 num_entries)
 		}
 
 		nr_total_entries -= i;
+		if (nr_total_entries != num_entries)
+			ret = -EBUSY;
 	}
 
-	if (nr_total_entries != num_entries)
-		ret = 1;
-
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
 	return ret;
@@ -764,36 +778,6 @@ int dma_debug_resize_entries(u32 num_entries)
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
@@ -1038,14 +1022,15 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (prealloc_memory(nr_prealloc_entries) != 0) {
+	if (dma_debug_add_entries(nr_prealloc_entries, GFP_KERNEL) != 0) {
 		pr_err("debugging out of memory error - disabled\n");
 		global_disable = true;
 
 		return 0;
 	}
 
-	nr_total_entries = num_free_entries;
+	min_free_entries = num_free_entries;
+	pr_info("preallocated %d debug entries\n", nr_total_entries);
 
 	dma_debug_initialized = true;
 
-- 
2.19.1.dirty

