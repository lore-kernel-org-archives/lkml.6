Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D97C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD9620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeLET53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:57:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbeLET5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F1B41682;
        Wed,  5 Dec 2018 11:57:24 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDCD43F614;
        Wed,  5 Dec 2018 11:57:22 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v2 8/8] dma-debug: Batch dma_debug_entry allocation
Date:   Wed,  5 Dec 2018 19:56:57 +0000
Message-Id: <e438dfe197a0e33ac8ab71a86167b69c56db77c5.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA debug entries are one of those things which aren't that useful
individually - we will always want some larger quantity of them - and
that we don't really need to manage the exact number of - we only care
about having 'enough'. In that regard, the current behaviour of creating
them one-by-one from the slab allocator means an awful lot of function
call overhead and memory wasted on alignment padding.

Now that we don't have to worry about freeing anything via
dma_debug_resize_entries(), we can optimise the allocation behaviour by
grabbing whole pages at once, which will save considerably on the
aforementioned overheads, and probably offer a little more cache/TLB
locality benefit for traversing the lists under normal operation.

Since freeing a whole page of entries at once becomes enough of a
challenge that it's not really worth complicating dma_debug_init(),
we may as well tweak the preallocation behaviour so that as long as we
manage to allocate *some* pages, we can leave debugging enabled on a
best-effort basis rather than otherwise wasting them.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 Documentation/DMA-API.txt |  4 +++-
 kernel/dma/debug.c        | 45 +++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 7a7d8a415ce8..097c51b79330 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -747,7 +747,9 @@ driver afterwards. This filter can be disabled or changed later using debugfs.
 When the code disables itself at runtime this is most likely because it ran
 out of dma_debug_entries and was unable to allocate more on-demand. 65536
 entries are preallocated at boot - if this is too low for you boot with
-'dma_debug_entries=<your_desired_number>' to overwrite the default. The
+'dma_debug_entries=<your_desired_number>' to overwrite the default. Note
+that the code allocates entires in batches, so the exact number of
+preallocated entries may be greater than the actual number requested. The
 code will print to the kernel log each time it has dynamically allocated
 as many entries as were initially preallocated. This is to indicate that a
 larger preallocation size may be appropriate, or if it happens continually
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2202402afe9a..a6a603526c8f 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -48,7 +48,7 @@
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 #endif
 /* If the pool runs out, add this many new entries at once */
-#define DMA_DEBUG_DYNAMIC_ENTRIES 256
+#define DMA_DEBUG_DYNAMIC_ENTRIES (PAGE_SIZE / sizeof(struct dma_debug_entry))
 
 enum {
 	dma_debug_single,
@@ -648,34 +648,22 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
-static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
+static int dma_debug_add_entries(gfp_t gfp)
 {
-	struct dma_debug_entry *entry, *next_entry;
-	LIST_HEAD(tmp);
+	struct dma_debug_entry *entry;
 	int i;
 
-	for (i = 0; i < num_entries; ++i) {
-		entry = kzalloc(sizeof(*entry), gfp);
-		if (!entry)
-			goto out_err;
+	entry = (void *)get_zeroed_page(gfp);
+	if (!entry)
+		return -ENOMEM;
 
-		list_add_tail(&entry->list, &tmp);
-	}
+	for (i = 0; i < DMA_DEBUG_DYNAMIC_ENTRIES; i++)
+		list_add_tail(&entry[i].list, &free_entries);
 
-	list_splice(&tmp, &free_entries);
-	num_free_entries += num_entries;
-	nr_total_entries += num_entries;
+	num_free_entries += DMA_DEBUG_DYNAMIC_ENTRIES;
+	nr_total_entries += DMA_DEBUG_DYNAMIC_ENTRIES;
 
 	return 0;
-
-out_err:
-
-	list_for_each_entry_safe(entry, next_entry, &tmp, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
-	return -ENOMEM;
 }
 
 static struct dma_debug_entry *__dma_entry_alloc(void)
@@ -717,7 +705,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
-		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES, GFP_ATOMIC)) {
+		if (dma_debug_add_entries(GFP_ATOMIC)) {
 			global_disable = true;
 			spin_unlock_irqrestore(&free_entries_lock, flags);
 			pr_err("debugging out of memory - disabling\n");
@@ -1008,15 +996,20 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (dma_debug_add_entries(nr_prealloc_entries, GFP_KERNEL) != 0) {
+	for (i = 0; i < DIV_ROUND_UP(nr_prealloc_entries, DMA_DEBUG_DYNAMIC_ENTRIES); ++i)
+		dma_debug_add_entries(GFP_KERNEL);
+	if (num_free_entries >= nr_prealloc_entries) {
+		pr_info("preallocated %d debug entries\n", nr_total_entries);
+	} else if (num_free_entries > 0) {
+		pr_warn("%d debug entries requested but only %d allocated\n",
+			nr_prealloc_entries, nr_total_entries);
+	} else {
 		pr_err("debugging out of memory error - disabled\n");
 		global_disable = true;
 
 		return 0;
 	}
-
 	min_free_entries = num_free_entries;
-	pr_info("preallocated %d debug entries\n", nr_total_entries);
 
 	dma_debug_initialized = true;
 
-- 
2.19.1.dirty

