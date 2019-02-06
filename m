Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94395C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9CA217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfBFKtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:49:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51278 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBFKtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:49:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B391415BF;
        Wed,  6 Feb 2019 02:49:00 -0800 (PST)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.30.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C8F3F719;
        Wed,  6 Feb 2019 02:48:58 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heyi Guo <guoheyi@huawei.com>, Heyi Guo <heyi.guo@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID
Date:   Wed,  6 Feb 2019 10:48:45 +0000
Message-Id: <20190206104848.12580-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206104848.12580-1-marc.zyngier@arm.com>
References: <20190206104848.12580-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems or VMs where multiple devices share a single DevID
(because they sit behind a PCI bridge, or because the HW is
broken in funky ways), we reuse the save its_device structure
in order to reflect this.

It turns out that there is a distinct lack of locking when looking
up the its_device, and two device being probed concurrently can result
in double allocations. That's obviously not nice.

A solution for this is to have a per-ITS mutex that serializes device
allocation.

A similar issue exists on the freeing side, which can run concurrently
with the allocation. On top of now taking the appropriate lock, we
also make sure that a shared device is never freed, as we have no way
to currently track the life cycle of such object.

Reported-by: Zheng Xiang <zhengxiang9@huawei.com>
Tested-by: Zheng Xiang <zhengxiang9@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 36181197d5e0..f25ec92f23ee 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -97,9 +97,14 @@ struct its_device;
  * The ITS structure - contains most of the infrastructure, with the
  * top-level MSI domain, the command queue, the collections, and the
  * list of devices writing to it.
+ *
+ * dev_alloc_lock has to be taken for device allocations, while the
+ * spinlock must be taken to parse data structures such as the device
+ * list.
  */
 struct its_node {
 	raw_spinlock_t		lock;
+	struct mutex		dev_alloc_lock;
 	struct list_head	entry;
 	void __iomem		*base;
 	phys_addr_t		phys_base;
@@ -156,6 +161,7 @@ struct its_device {
 	void			*itt;
 	u32			nr_ites;
 	u32			device_id;
+	bool			shared;
 };
 
 static struct {
@@ -2469,6 +2475,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	struct its_device *its_dev;
 	struct msi_domain_info *msi_info;
 	u32 dev_id;
+	int err = 0;
 
 	/*
 	 * We ignore "dev" entierely, and rely on the dev_id that has
@@ -2491,6 +2498,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&its->dev_alloc_lock);
 	its_dev = its_find_device(its, dev_id);
 	if (its_dev) {
 		/*
@@ -2498,18 +2506,22 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
+		its_dev->shared = true;
 		pr_debug("Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
 	its_dev = its_create_device(its, dev_id, nvec, true);
-	if (!its_dev)
-		return -ENOMEM;
+	if (!its_dev) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
+	mutex_unlock(&its->dev_alloc_lock);
 	info->scratchpad[0].ptr = its_dev;
-	return 0;
+	return err;
 }
 
 static struct msi_domain_ops its_msi_domain_ops = {
@@ -2613,6 +2625,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_node *its = its_dev->its;
 	int i;
 
 	for (i = 0; i < nr_irqs; i++) {
@@ -2627,8 +2640,14 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		irq_domain_reset_irq_data(data);
 	}
 
-	/* If all interrupts have been freed, start mopping the floor */
-	if (bitmap_empty(its_dev->event_map.lpi_map,
+	mutex_lock(&its->dev_alloc_lock);
+
+	/*
+	 * If all interrupts have been freed, start mopping the
+	 * floor. This is conditionned on the device not being shared.
+	 */
+	if (!its_dev->shared &&
+	    bitmap_empty(its_dev->event_map.lpi_map,
 			 its_dev->event_map.nr_lpis)) {
 		its_lpi_free(its_dev->event_map.lpi_map,
 			     its_dev->event_map.lpi_base,
@@ -2640,6 +2659,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		its_free_device(its_dev);
 	}
 
+	mutex_unlock(&its->dev_alloc_lock);
+
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
@@ -3549,6 +3570,7 @@ static int __init its_probe_one(struct resource *res,
 	}
 
 	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
 	INIT_LIST_HEAD(&its->entry);
 	INIT_LIST_HEAD(&its->its_device_list);
 	typer = gic_read_typer(its_base + GITS_TYPER);
-- 
2.20.1

