Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1128DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC0620836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC0620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeFTNxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:53:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754345AbeFTNx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:53:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6C915B2;
        Wed, 20 Jun 2018 06:53:29 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.31.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F2A93F578;
        Wed, 20 Jun 2018 06:53:23 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        MaJun <majun258@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 4/7] irqchip/gic-v3-its: Drop chunk allocation compatibility
Date:   Wed, 20 Jun 2018 14:52:31 +0100
Message-Id: <20180620135234.32101-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620135234.32101-1-marc.zyngier@arm.com>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chunk allocation system is now officially dead, so let's
remove it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 41 +++++++++++++-------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cfe65776bb4c..554c9d040c5a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1424,12 +1424,6 @@ static struct irq_chip its_irq_chip = {
  * freeing is expensive. We assumes that freeing rarely occurs.
  */
 
-/*
- * Compatibility defines until we fully refactor the allocator
- */
-#define IRQS_PER_CHUNK_SHIFT	5
-#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
-
 static DEFINE_MUTEX(lpi_range_lock);
 static LIST_HEAD(lpi_range_list);
 
@@ -1542,30 +1536,27 @@ static int __init its_lpi_init(u32 id_bits)
 	return err;
 }
 
-static unsigned long *its_lpi_alloc_chunks(int nr_irqs, u32 *base, int *nr_ids)
+static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 {
 	unsigned long *bitmap = NULL;
 	int err = 0;
-	int nr_lpis;
-
-	nr_lpis = round_up(nr_irqs, IRQS_PER_CHUNK);
 
 	do {
-		err = alloc_lpi_range(nr_lpis, base);
+		err = alloc_lpi_range(nr_irqs, base);
 		if (!err)
 			break;
 
-		nr_lpis -= IRQS_PER_CHUNK;
-	} while (nr_lpis > 0);
+		nr_irqs /= 2;
+	} while (nr_irqs > 0);
 
 	if (err)
 		goto out;
 
-	bitmap = kcalloc(BITS_TO_LONGS(nr_lpis), sizeof (long), GFP_ATOMIC);
+	bitmap = kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
 
-	*nr_ids = nr_lpis;
+	*nr_ids = nr_irqs;
 
 out:
 	if (!bitmap)
@@ -1574,7 +1565,7 @@ static unsigned long *its_lpi_alloc_chunks(int nr_irqs, u32 *base, int *nr_ids)
 	return bitmap;
 }
 
-static void its_lpi_free_chunks(unsigned long *bitmap, u32 base, u32 nr_ids)
+static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
 	WARN_ON(free_lpi_range(base, nr_ids));
 	kfree(bitmap);
@@ -2192,7 +2183,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc(sz, GFP_KERNEL);
 	if (alloc_lpis) {
-		lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
+		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
 			col_map = kcalloc(nr_lpis, sizeof(*col_map),
 					  GFP_KERNEL);
@@ -2420,9 +2411,9 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	/* If all interrupts have been freed, start mopping the floor */
 	if (bitmap_empty(its_dev->event_map.lpi_map,
 			 its_dev->event_map.nr_lpis)) {
-		its_lpi_free_chunks(its_dev->event_map.lpi_map,
-				    its_dev->event_map.lpi_base,
-				    its_dev->event_map.nr_lpis);
+		its_lpi_free(its_dev->event_map.lpi_map,
+			     its_dev->event_map.lpi_base,
+			     its_dev->event_map.nr_lpis);
 		kfree(its_dev->event_map.col_map);
 
 		/* Unmap device/itt */
@@ -2821,7 +2812,7 @@ static void its_vpe_irq_domain_free(struct irq_domain *domain,
 	}
 
 	if (bitmap_empty(vm->db_bitmap, vm->nr_db_lpis)) {
-		its_lpi_free_chunks(vm->db_bitmap, vm->db_lpi_base, vm->nr_db_lpis);
+		its_lpi_free(vm->db_bitmap, vm->db_lpi_base, vm->nr_db_lpis);
 		its_free_prop_table(vm->vprop_page);
 	}
 }
@@ -2836,18 +2827,18 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 	BUG_ON(!vm);
 
-	bitmap = its_lpi_alloc_chunks(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
+	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
 
 	if (nr_ids < nr_irqs) {
-		its_lpi_free_chunks(bitmap, base, nr_ids);
+		its_lpi_free(bitmap, base, nr_ids);
 		return -ENOMEM;
 	}
 
 	vprop_page = its_allocate_prop_table(GFP_KERNEL);
 	if (!vprop_page) {
-		its_lpi_free_chunks(bitmap, base, nr_ids);
+		its_lpi_free(bitmap, base, nr_ids);
 		return -ENOMEM;
 	}
 
@@ -2874,7 +2865,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		if (i > 0)
 			its_vpe_irq_domain_free(domain, virq, i - 1);
 
-		its_lpi_free_chunks(bitmap, base, nr_ids);
+		its_lpi_free(bitmap, base, nr_ids);
 		its_free_prop_table(vprop_page);
 	}
 
-- 
2.17.1

