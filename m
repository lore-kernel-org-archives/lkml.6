Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C7C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B59218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfAZGTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 01:19:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfAZGTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 01:19:30 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82BCA97E98C81D4BF8DF;
        Sat, 26 Jan 2019 14:19:28 +0800 (CST)
Received: from HGHY1z004218071.china.huawei.com (10.177.29.32) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 26 Jan 2019 14:19:19 +0800
From:   Zheng Xiang <zhengxiang9@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <wanghaibin.wang@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Lock its device list during find and create its device
Date:   Sat, 26 Jan 2019 14:16:24 +0800
Message-ID: <20190126061624.5260-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently each PCI device under a PCI Bridge shares the same device id
and ITS device. Assume there are two PCI devices call its_msi_prepare
concurrently and they are both going to find and create their ITS
device. There is a chance that the later one couldn't find ITS device
before the other one creating the ITS device. It will cause the later
one to create a different ITS device even if they have the same
device_id.

Signed-off-by: Zheng Xiang <zhengxiang9@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 52 +++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..397edc8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2205,25 +2205,6 @@ static void its_cpu_init_collections(void)
 	raw_spin_unlock(&its_lock);
 }
 
-static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
-{
-	struct its_device *its_dev = NULL, *tmp;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&its->lock, flags);
-
-	list_for_each_entry(tmp, &its->its_device_list, entry) {
-		if (tmp->device_id == dev_id) {
-			its_dev = tmp;
-			break;
-		}
-	}
-
-	raw_spin_unlock_irqrestore(&its->lock, flags);
-
-	return its_dev;
-}
-
 static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 {
 	int i;
@@ -2321,7 +2302,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 					    int nvecs, bool alloc_lpis)
 {
-	struct its_device *dev;
+	struct its_device *dev = NULL, *tmp;
 	unsigned long *lpi_map = NULL;
 	unsigned long flags;
 	u16 *col_map = NULL;
@@ -2331,6 +2312,24 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	int nr_ites;
 	int sz;
 
+	raw_spin_lock_irqsave(&its->lock, flags);
+	list_for_each_entry(tmp, &its->its_device_list, entry) {
+		if (tmp->device_id == dev_id) {
+			dev = tmp;
+			break;
+		}
+	}
+	if (dev) {
+		/*
+		 * We already have seen this ID, probably through
+		 * another alias (PCI bridge of some sort). No need to
+		 * create the device.
+		 */
+		pr_debug("Reusing ITT for devID %x\n", dev_id);
+		raw_spin_unlock_irqrestore(&its->lock, flags);
+		return dev;
+	}
+
 	if (!its_alloc_device_table(its, dev_id))
 		return NULL;
 
@@ -2378,7 +2377,6 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	dev->device_id = dev_id;
 	INIT_LIST_HEAD(&dev->entry);
 
-	raw_spin_lock_irqsave(&its->lock, flags);
 	list_add(&dev->entry, &its->its_device_list);
 	raw_spin_unlock_irqrestore(&its->lock, flags);
 
@@ -2443,23 +2441,11 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		return -EINVAL;
 	}
 
-	its_dev = its_find_device(its, dev_id);
-	if (its_dev) {
-		/*
-		 * We already have seen this ID, probably through
-		 * another alias (PCI bridge of some sort). No need to
-		 * create the device.
-		 */
-		pr_debug("Reusing ITT for devID %x\n", dev_id);
-		goto out;
-	}
-
 	its_dev = its_create_device(its, dev_id, nvec, true);
 	if (!its_dev)
 		return -ENOMEM;
 
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
-out:
 	info->scratchpad[0].ptr = its_dev;
 	return 0;
 }
-- 
1.8.3.1


