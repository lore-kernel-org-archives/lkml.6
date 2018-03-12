Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCLGu5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:50:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751990AbeCLGu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:50:56 -0400
From: Yang Yingliang <yangyingliang@huawei.com>
To: <marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>
Subject: [RFC PATCH 4/4] irqchip/gic-v3-its: sync config of LPIs if there are more than one prop_page
Date: Mon, 12 Mar 2018 14:49:55 +0800
Message-ID: <1520837395-10288-5-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
In-Reply-To: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
References: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config of LPIs need to be same in each prop_page.
So if one prop_page is modified, other prop_page should
be updated too.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 02a5d95..27306a5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1051,11 +1051,25 @@ static inline u32 its_get_event_id(struct irq_data *d)
 	return d->hwirq - its_dev->event_map.lpi_base;
 }
 
+static inline void lpi_flush_config(u8 *cfg)
+{
+	/*
+	 * Make the above write visible to the redistributors.
+	 * And yes, we're flushing exactly: One. Single. Byte.
+	 * Humpf...
+	 */
+	if (gic_rdists->flags & RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING)
+		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
+	else
+		dsb(ishst);
+}
+
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	irq_hw_number_t hwirq;
 	struct page *prop_page;
 	u8 *cfg;
+	int cpu;
 
 	if (irqd_is_forwarded_to_vcpu(d)) {
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -1078,15 +1092,22 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 	*cfg &= ~clr;
 	*cfg |= set | LPI_PROP_GROUP1;
 
-	/*
-	 * Make the above write visible to the redistributors.
-	 * And yes, we're flushing exactly: One. Single. Byte.
-	 * Humpf...
-	 */
-	if (gic_rdists->flags & RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING)
-		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
-	else
-		dsb(ishst);
+	if (gic_rdists->common_aff_lpi) {
+		/* It's protected by desc->lock, don't need lock any more. */
+		for_each_cpu(cpu, cpu_possible_mask) {
+			u8 *other_cfg;
+			struct page *other_prop_page = per_cpu_ptr(gic_rdists->rdist, cpu)->prop_page;
+
+			if (other_prop_page == prop_page)
+				continue;
+
+			other_cfg = page_address(other_prop_page) + hwirq - 8192;
+			*other_cfg = *cfg;
+			lpi_flush_config(other_cfg);
+		}
+	} else {
+		lpi_flush_config(cfg);
+	}
 }
 
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
-- 
1.8.3
