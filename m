Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeCLGun (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:50:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751849AbeCLGu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:50:27 -0400
From: Yang Yingliang <yangyingliang@huawei.com>
To: <marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>
Subject: [RFC PATCH 3/4] irqchip/gic-v3-its: change prop_page to per-cpu type to support CommonLPIAff field
Date: Mon, 12 Mar 2018 14:49:54 +0800
Message-ID: <1520837395-10288-4-git-send-email-yangyingliang@huawei.com>
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

Change prop_page to per-cpu type and add its_cpu_allocate_prop_tables()
to allocate LPI property tables. This function is called by each oneline
cpu and allocate tables according to the value of CommonLPIAff.
The spec defines the field:
    CommonLPIAff, bits [25:24]
    The affinity level at which Redistributors share a LPI Configuration table.
    00 All Redistributors must share a LPI Configuration table.
    01 All Redistributors with the same Aff3 value must share an LPI Configurationt table.
    10 All Redistributors with the same Aff3.Aff2 value must share an LPI Configuration table.
    11 All Redistributors with the same Aff3.Aff2.Aff1 value must share an LPI Configuration table.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 81 ++++++++++++++++++++++++++++----------
 include/linux/irqchip/arm-gic-v3.h |  6 ++-
 2 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4ebe131..02a5d95 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1070,7 +1070,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		map->properties &= ~clr;
 		map->properties |= set | LPI_PROP_GROUP1;
 	} else {
-		prop_page = gic_rdists->prop_page;
+		prop_page = gic_data_rdist()->prop_page;
 		hwirq = d->hwirq;
 	}
 
@@ -1582,24 +1582,6 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
-{
-	phys_addr_t paddr;
-
-	lpi_id_bits = min_t(u32, gic_rdists->id_bits, ITS_MAX_LPI_NRBITS);
-	gic_rdists->prop_page = its_allocate_prop_table(cpu_to_node(smp_processor_id()),
-							GFP_NOWAIT);
-	if (!gic_rdists->prop_page) {
-		pr_err("Failed to allocate PROPBASE\n");
-		return -ENOMEM;
-	}
-
-	paddr = page_to_phys(gic_rdists->prop_page);
-	pr_info("GIC: using LPI property table @%pa\n", &paddr);
-
-	return its_lpi_init(lpi_id_bits);
-}
-
 static const char *its_base_type_string[] = {
 	[GITS_BASER_TYPE_DEVICE]	= "Devices",
 	[GITS_BASER_TYPE_VCPU]		= "Virtual CPUs",
@@ -1935,7 +1917,7 @@ static void its_cpu_init_lpis(void)
 	dsb(sy);
 
 	/* set PROPBASE */
-	val = (page_to_phys(gic_rdists->prop_page) |
+	val = (page_to_phys(gic_data_rdist()->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
 	       GICR_PROPBASER_RaWaWb |
 	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
@@ -2037,6 +2019,59 @@ static void its_cpu_init_collection(void)
 	spin_unlock(&its_lock);
 }
 
+static int __init its_cpu_allocate_prop_tables(void)
+{
+	phys_addr_t paddr;
+	unsigned long flags;
+	int match_cpu;
+	u64 aff_mask = 0;
+	struct page *prop_page = NULL;
+	int cpu = smp_processor_id();
+
+	switch (gic_rdists->common_aff_lpi) {
+	case GICR_COMMON_ALL_SHARE:
+		aff_mask = 0;
+		break;
+	case GICR_COMMON_AFF3_SHARE:
+		aff_mask = 0xffULL << MPIDR_LEVEL_SHIFT(3);
+		break;
+	case GICR_COMMON_AFF3_AFF2_SHARE:
+		aff_mask = (0xffULL << MPIDR_LEVEL_SHIFT(3)) |
+			   (0xffULL << MPIDR_LEVEL_SHIFT(2));
+		break;
+	case GICR_COMMON_AFF3_AFF2_AFF1_SHARE:
+		aff_mask = (0xffULL << MPIDR_LEVEL_SHIFT(3)) |
+			   (0xffULL << MPIDR_LEVEL_SHIFT(2)) |
+			   (0xffULL << MPIDR_LEVEL_SHIFT(1));
+		break;
+	default:
+		pr_err("Bad common_aff_lpi:%d\n", gic_rdists->common_aff_lpi);
+	}
+
+	raw_spin_lock_irqsave(&gic_rdists->lock, flags);
+	for_each_cpu(match_cpu, cpu_possible_mask) {
+		struct page *match_prop_page = per_cpu_ptr(gic_rdists->rdist, match_cpu)->prop_page;
+		if ((cpu_logical_map(cpu) & aff_mask) == (cpu_logical_map(match_cpu) & aff_mask) &&
+		    match_prop_page) {
+			prop_page = match_prop_page;
+			break;
+		}
+	}
+	if (!prop_page) {
+		prop_page = its_allocate_prop_table(cpu_to_node(cpu), GFP_NOWAIT);
+		pr_err("Failed to allocate PROPBASE\n");
+		raw_spin_unlock_irqrestore(&gic_rdists->lock, flags);
+		return -ENOMEM;
+	}
+	gic_data_rdist()->prop_page = prop_page;
+	raw_spin_unlock_irqrestore(&gic_rdists->lock, flags);
+
+	paddr = page_to_phys(gic_data_rdist()->prop_page);
+	pr_info("CPU%d using LPI property table @%pa\n", cpu, &paddr);
+
+	return 0;
+}
+
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
 {
 	struct its_device *its_dev = NULL, *tmp;
@@ -3340,10 +3375,14 @@ static bool gic_rdists_supports_plpis(void)
 int its_cpu_init(void)
 {
 	if (!list_empty(&its_nodes)) {
+		int err;
 		if (!gic_rdists_supports_plpis()) {
 			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 			return -ENXIO;
 		}
+		err = its_cpu_allocate_prop_tables();
+		if (err)
+			return err;
 		its_cpu_init_lpis();
 		its_cpu_init_collection();
 	}
@@ -3551,7 +3590,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
+	err = its_lpi_init(min_t(u32, gic_rdists->id_bits, ITS_MAX_LPI_NRBITS));
 	if (err)
 		return err;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6da670a..35cafd9 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -109,6 +109,10 @@
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 #define GICR_TYPER_COMMON_AFF_LPI(r)	(((r) >> 24) & 3)
+#define GICR_COMMON_ALL_SHARE			0
+#define GICR_COMMON_AFF3_SHARE			1
+#define GICR_COMMON_AFF3_AFF2_SHARE		2
+#define GICR_COMMON_AFF3_AFF2_AFF1_SHARE	3
 
 #define GICR_WAKER_ProcessorSleep	(1U << 1)
 #define GICR_WAKER_ChildrenAsleep	(1U << 2)
@@ -571,9 +575,9 @@ struct rdists {
 	struct {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
+		struct page	*prop_page;
 		phys_addr_t	phys_base;
 	} __percpu		*rdist;
-	struct page		*prop_page;
 	int			id_bits;
 	u64			flags;
 	bool			has_vlpis;
-- 
1.8.3
