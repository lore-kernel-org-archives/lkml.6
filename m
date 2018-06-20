Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6275DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1428320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1428320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbeFTNxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:53:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37446 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754077AbeFTNxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:53:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C7A15B2;
        Wed, 20 Jun 2018 06:53:07 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.31.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5090A3F578;
        Wed, 20 Jun 2018 06:53:01 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        MaJun <majun258@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 1/7] irqchip/gic-v3-its: Refactor LPI allocator
Date:   Wed, 20 Jun 2018 14:52:28 +0100
Message-Id: <20180620135234.32101-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620135234.32101-1-marc.zyngier@arm.com>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our current LPI allocator relies on a bitmap, each bit representing
a chunk of 32 LPIs, meaning that each device gets allocated LPIs
in multiple of 32. It served us well so far, but new use cases now
require much more finer grain allocations, down the the individual
LPI.

Given the size of the IntID space (up to 32bit), it isn't practical
to continue using a bitmap, so let's use a different data structure
altogether.

We switch to a list, where each element represent a contiguous range
of LPIs. On allocation, we simply grab the first group big enough to
satisfy the allocation, and substract what we need from it. If the
group becomes empty, we just remove it. On freeing interrupts, we
insert a new group of interrupt in the list, sort it and fuse the
adjacent groups.

This makes freeing interrupt much more expensive than allocating
them (an unusual behaviour), but that's fine as long as we consider
that freeing interrupts is an extremely rare event.

We still allocate interrupts in blocks of 32 for the time being,
but subsequent patches will relax this.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 191 +++++++++++++++++++++----------
 1 file changed, 129 insertions(+), 62 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5377d7e2afba..6d148c2108b9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -23,6 +23,8 @@
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/list.h>
+#include <linux/list_sort.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
@@ -1405,112 +1407,177 @@ static struct irq_chip its_irq_chip = {
 	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
 };
 
+
 /*
  * How we allocate LPIs:
  *
- * The GIC has id_bits bits for interrupt identifiers. From there, we
- * must subtract 8192 which are reserved for SGIs/PPIs/SPIs. Then, as
- * we allocate LPIs by chunks of 32, we can shift the whole thing by 5
- * bits to the right.
+ * lpi_range_list contains ranges of LPIs that are to available to
+ * allocate from. To allocate LPIs, just pick the first range that
+ * fits the required allocation, and reduce it by the required
+ * amount. Once empty, remove the range from the list.
+ *
+ * To free a range of LPIs, add a free range to the list, sort it and
+ * merge the result if the new range happens to be adjacent to an
+ * already free block.
  *
- * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
+ * The consequence of the above is that allocation is cost is low, but
+ * freeing is expensive. We assumes that freeing rarely occurs.
+ */
+
+/*
+ * Compatibility defines until we fully refactor the allocator
  */
 #define IRQS_PER_CHUNK_SHIFT	5
 #define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
 #define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
-static unsigned long *lpi_bitmap;
-static u32 lpi_chunks;
-static DEFINE_SPINLOCK(lpi_lock);
+static DEFINE_MUTEX(lpi_range_lock);
+static LIST_HEAD(lpi_range_list);
 
-static int its_lpi_to_chunk(int lpi)
+struct lpi_range {
+	struct list_head	entry;
+	u32			base_id;
+	u32			span;
+};
+
+static struct lpi_range *mk_lpi_range(u32 base, u32 span)
 {
-	return (lpi - 8192) >> IRQS_PER_CHUNK_SHIFT;
+	struct lpi_range *range;
+
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (range) {
+		INIT_LIST_HEAD(&range->entry);
+		range->base_id = base;
+		range->span = span;
+	}
+
+	return range;
 }
 
-static int its_chunk_to_lpi(int chunk)
+static int lpi_range_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
-	return (chunk << IRQS_PER_CHUNK_SHIFT) + 8192;
+	struct lpi_range *ra, *rb;
+
+	ra = container_of(a, struct lpi_range, entry);
+	rb = container_of(b, struct lpi_range, entry);
+
+	return rb->base_id - ra->base_id;
 }
 
-static int __init its_lpi_init(u32 id_bits)
+static void merge_lpi_ranges(void)
 {
-	lpi_chunks = its_lpi_to_chunk(1UL << id_bits);
+	struct lpi_range *range, *tmp;
 
-	lpi_bitmap = kcalloc(BITS_TO_LONGS(lpi_chunks), sizeof(long),
-			     GFP_KERNEL);
-	if (!lpi_bitmap) {
-		lpi_chunks = 0;
-		return -ENOMEM;
+	list_for_each_entry_safe(range, tmp, &lpi_range_list, entry) {
+		if (!list_is_last(&range->entry, &lpi_range_list) &&
+		    (tmp->base_id == (range->base_id + range->span))) {
+			tmp->base_id = range->base_id;
+			tmp->span += range->span;
+			list_del(&range->entry);
+			kfree(range);
+		}
 	}
+}
 
-	pr_info("ITS: Allocated %d chunks for LPIs\n", (int)lpi_chunks);
-	return 0;
+static int alloc_lpi_range(u32 nr_lpis, u32 *base)
+{
+	struct lpi_range *range, *tmp;
+	int err = -ENOSPC;
+
+	mutex_lock(&lpi_range_lock);
+
+	list_for_each_entry_safe(range, tmp, &lpi_range_list, entry) {
+		if (range->span >= nr_lpis) {
+			*base = range->base_id;
+			range->base_id += nr_lpis;
+			range->span -= nr_lpis;
+
+			if (range->span == 0) {
+				list_del(&range->entry);
+				kfree(range);
+			}
+
+			err = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&lpi_range_lock);
+
+	pr_debug("ITS: alloc %u:%u\n", *base, nr_lpis);
+	return err;
 }
 
-static unsigned long *its_lpi_alloc_chunks(int nr_irqs, int *base, int *nr_ids)
+static int free_lpi_range(u32 base, u32 nr_lpis)
 {
-	unsigned long *bitmap = NULL;
-	int chunk_id;
-	int nr_chunks;
-	int i;
+	struct lpi_range *new;
+	int err = 0;
 
-	nr_chunks = DIV_ROUND_UP(nr_irqs, IRQS_PER_CHUNK);
+	mutex_lock(&lpi_range_lock);
 
-	spin_lock(&lpi_lock);
+	new = mk_lpi_range(base, nr_lpis);
+	if (!new) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	list_add(&new->entry, &lpi_range_list);
+	list_sort(NULL, &lpi_range_list, lpi_range_cmp);
+	merge_lpi_ranges();
+out:
+	mutex_unlock(&lpi_range_lock);
+	return err;
+}
+
+static int __init its_lpi_init(u32 id_bits)
+{
+	u32 lpis = (1UL << id_bits) - 8192;
+	int err;
+
+	/*
+	 * Initializing the allocator is just the same as freeing the
+	 * full range of LPIs.
+	 */
+	err = free_lpi_range(8192, lpis);
+	pr_debug("ITS: Allocator initialized for %u LPIs\n", lpis);
+	return err;
+}
+
+static unsigned long *its_lpi_alloc_chunks(int nr_irqs, u32 *base, int *nr_ids)
+{
+	unsigned long *bitmap = NULL;
+	int err = 0;
+	int nr_lpis;
+
+	nr_lpis = round_up(nr_irqs, IRQS_PER_CHUNK);
 
 	do {
-		chunk_id = bitmap_find_next_zero_area(lpi_bitmap, lpi_chunks,
-						      0, nr_chunks, 0);
-		if (chunk_id < lpi_chunks)
+		err = alloc_lpi_range(nr_lpis, base);
+		if (!err)
 			break;
 
-		nr_chunks--;
-	} while (nr_chunks > 0);
+		nr_lpis -= IRQS_PER_CHUNK;
+	} while (nr_lpis > 0);
 
-	if (!nr_chunks)
+	if (err)
 		goto out;
 
-	bitmap = kcalloc(BITS_TO_LONGS(nr_chunks * IRQS_PER_CHUNK),
-			 sizeof(long),
-			 GFP_ATOMIC);
+	bitmap = kcalloc(BITS_TO_LONGS(nr_lpis), sizeof (long), GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
 
-	for (i = 0; i < nr_chunks; i++)
-		set_bit(chunk_id + i, lpi_bitmap);
-
-	*base = its_chunk_to_lpi(chunk_id);
-	*nr_ids = nr_chunks * IRQS_PER_CHUNK;
+	*nr_ids = nr_lpis;
 
 out:
-	spin_unlock(&lpi_lock);
-
 	if (!bitmap)
 		*base = *nr_ids = 0;
 
 	return bitmap;
 }
 
-static void its_lpi_free_chunks(unsigned long *bitmap, int base, int nr_ids)
+static void its_lpi_free_chunks(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
-	int lpi;
-
-	spin_lock(&lpi_lock);
-
-	for (lpi = base; lpi < (base + nr_ids); lpi += IRQS_PER_CHUNK) {
-		int chunk = its_lpi_to_chunk(lpi);
-
-		BUG_ON(chunk > lpi_chunks);
-		if (test_bit(chunk, lpi_bitmap)) {
-			clear_bit(chunk, lpi_bitmap);
-		} else {
-			pr_err("Bad LPI chunk %d\n", chunk);
-		}
-	}
-
-	spin_unlock(&lpi_lock);
-
+	WARN_ON(free_lpi_range(base, nr_ids));
 	kfree(bitmap);
 }
 
-- 
2.17.1

