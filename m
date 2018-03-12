Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeCLGvQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:51:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44981 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751298AbeCLGu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:50:26 -0400
From: Yang Yingliang <yangyingliang@huawei.com>
To: <marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>
Subject: [RFC PATCH 1/4] irqchip/gic-v3: add common_aff_lpi field in struct rdists
Date: Mon, 12 Mar 2018 14:49:52 +0800
Message-ID: <1520837395-10288-2-git-send-email-yangyingliang@huawei.com>
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

Read CommonLPIAff from GICR_TYPER and check whether the
values are same in each register. If they are different,
prints warning message and set CommonLPIAff to zero.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d99cc07..58f55da 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -598,6 +598,10 @@ static int gic_dist_supports_lpis(void)
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
+	u32 typer;
+	unsigned long flags;
+	u16 common_aff_lpi;
+	int cpu = smp_processor_id();
 
 	/* Register ourselves with the rest of the world */
 	if (gic_populate_rdist())
@@ -612,6 +616,21 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
+	typer = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	common_aff_lpi = GICR_TYPER_COMMON_AFF_LPI(typer);
+	if (!cpu) {
+		gic_data.rdists.common_aff_lpi = common_aff_lpi;
+	} else {
+		raw_spin_lock_irqsave(&gic_data.rdists.lock, flags);
+		if (common_aff_lpi != gic_data.rdists.common_aff_lpi) {
+			pr_warn_once("The CommonLPIAff is not consistent.\
+				     It's %d in CPU0, but %d in CPU%d, set CommonLPIAff to 0.\n",
+			gic_data.rdists.common_aff_lpi, cpu, common_aff_lpi);
+			gic_data.rdists.common_aff_lpi = 0;
+		}
+		raw_spin_unlock_irqrestore(&gic_data.rdists.lock, flags);
+	}
+
 	/* Give LPIs a spin */
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_cpu_init();
@@ -1029,6 +1048,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
+	raw_spin_lock_init(&gic_data.rdists.lock);
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c00c4c33..6da670a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -108,6 +108,7 @@
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
+#define GICR_TYPER_COMMON_AFF_LPI(r)	(((r) >> 24) & 3)
 
 #define GICR_WAKER_ProcessorSleep	(1U << 1)
 #define GICR_WAKER_ChildrenAsleep	(1U << 2)
@@ -577,6 +578,8 @@ struct rdists {
 	u64			flags;
 	bool			has_vlpis;
 	bool			has_direct_lpi;
+	u16			common_aff_lpi;
+	raw_spinlock_t		lock;
 };
 
 struct irq_domain;
-- 
1.8.3
