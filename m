Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6CCC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67832086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeLJOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:00:56 -0500
Received: from foss.arm.com ([217.140.101.70]:54680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbeLJOAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:00:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71C2A169E;
        Mon, 10 Dec 2018 06:00:54 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BCA63F575;
        Mon, 10 Dec 2018 06:00:52 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v3 7/7] dma-debug: Batch dma_debug_entry allocation
Date:   Mon, 10 Dec 2018 14:00:33 +0000
Message-Id: <e927ede58b6d6cd9455ec2a428629ca6a103f238.1544447601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA debug entries are one of those things which aren't that useful
individually - we will always want some larger quantity of them - and
which we don't really need to manage the exact number of - we only care
about having 'enough'. In that regard, the current behaviour of creating
them one-by-one leads to a lot of unwarranted function call overhead and
memory wasted on alignment padding.

Now that we don't have to worry about freeing anything via
dma_debug_resize_entries(), we can optimise the allocation behaviour by
grabbing whole pages at once, which will save considerably on the
aforementioned overheads, and probably offer a little more cache/TLB
locality benefit for traversing the lists under normal operation. This
should also give even less reason for an architecture-level override of
the preallocation size, so make the definition unconditional - if there
is still any desire to change the compile-time value for some platforms
it would be better off as a Kconfig option anyway.

Since freeing a whole page of entries at once becomes enough of a
challenge that it's not really worth complicating dma_debug_init(), we
may as well tweak the preallocation behaviour such that as long as we
manage to allocate *some* pages, we can leave debugging enabled on a
best-effort basis rather than otherwise wasting them.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Clean up #ifdef, misc. cosmetic tweaks, add Christoph's review tag

 Documentation/DMA-API.txt |  4 +++-
 kernel/dma/debug.c        | 50 ++++++++++++++++-----------------------
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 7a7d8a415ce8..016eb6909b8a 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -747,7 +747,9 @@ driver afterwards. This filter can be disabled or changed later using debugfs.
 When the code disables itself at runtime this is most likely because it ran
 out of dma_debug_entries and was unable to allocate more on-demand. 65536
 entries are preallocated at boot - if this is too low for you boot with
-'dma_debug_entries=<your_desired_number>' to overwrite the default. The
+'dma_debug_entries=<your_desired_number>' to overwrite the default. Note
+that the code allocates entries in batches, so the exact number of
+preallocated entries may be greater than the actual number requested. The
 code will print to the kernel log each time it has dynamically allocated
 as many entries as were initially preallocated. This is to indicate that a
 larger preallocation size may be appropriate, or if it happens continually
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 36a42874b05f..20ab0f6c1b70 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -43,12 +43,9 @@
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
-/* allow architectures to override this if absolutely required */
-#ifndef PREALLOC_DMA_DEBUG_ENTRIES
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-#endif
 /* If the pool runs out, add this many new entries at once */
-#define DMA_DEBUG_DYNAMIC_ENTRIES 256
+#define DMA_DEBUG_DYNAMIC_ENTRIES (PAGE_SIZE / sizeof(struct dma_debug_entry))
 
 enum {
 	dma_debug_single,
@@ -648,32 +645,22 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
-static int dma_debug_create_entries(u32 num_entries, gfp_t gfp)
+static int dma_debug_create_entries(gfp_t gfp)
 {
-	struct dma_debug_entry *entry, *next_entry;
+	struct dma_debug_entry *entry;
 	int i;
 
-	for (i = 0; i < num_entries; ++i) {
-		entry = kzalloc(sizeof(*entry), gfp);
-		if (!entry)
-			goto out_err;
+	entry = (void *)get_zeroed_page(gfp);
+	if (!entry)
+		return -ENOMEM;
 
-		list_add_tail(&entry->list, &free_entries);
-	}
+	for (i = 0; i < DMA_DEBUG_DYNAMIC_ENTRIES; i++)
+		list_add_tail(&entry[i].list, &free_entries);
 
-	num_free_entries += num_entries;
-	nr_total_entries += num_entries;
+	num_free_entries += DMA_DEBUG_DYNAMIC_ENTRIES;
+	nr_total_entries += DMA_DEBUG_DYNAMIC_ENTRIES;
 
 	return 0;
-
-out_err:
-
-	list_for_each_entry_safe(entry, next_entry, &free_entries, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
-	return -ENOMEM;
 }
 
 static struct dma_debug_entry *__dma_entry_alloc(void)
@@ -715,8 +702,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
-		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES,
-					     GFP_ATOMIC)) {
+		if (dma_debug_create_entries(GFP_ATOMIC)) {
 			global_disable = true;
 			spin_unlock_irqrestore(&free_entries_lock, flags);
 			pr_err("debugging out of memory - disabling\n");
@@ -987,7 +973,7 @@ void dma_debug_add_bus(struct bus_type *bus)
 
 static int dma_debug_init(void)
 {
-	int i;
+	int i, nr_pages;
 
 	/* Do not use dma_debug_initialized here, since we really want to be
 	 * called to set dma_debug_initialized
@@ -1007,15 +993,21 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (dma_debug_create_entries(nr_prealloc_entries, GFP_KERNEL) != 0) {
+	nr_pages = DIV_ROUND_UP(nr_prealloc_entries, DMA_DEBUG_DYNAMIC_ENTRIES);
+	for (i = 0; i < nr_pages; ++i)
+		dma_debug_create_entries(GFP_KERNEL);
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

