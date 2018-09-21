Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A617DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616DA2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616DA2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbeIVBup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41314 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391421AbeIVBuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F56915BE;
        Fri, 21 Sep 2018 13:00:20 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF2683F73C;
        Fri, 21 Sep 2018 13:00:19 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 04/10] irqchip/gic-v3-its: Move pending table allocation to init time
Date:   Fri, 21 Sep 2018 20:59:48 +0100
Message-Id: <20180921195954.21574-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pending tables for the redistributors are currently allocated
one at a time as each CPU boots. This is causing some grief
for Linux/RT (allocation from within a CPU hotplug notifier is
frown upon).

Let's more this allocation to take place at init time, when we
only have a single CPU. It means we're allocating memory for CPUs
that are not online yet, but most system will boot all of their
CPUs anyway, so that's not completely wasted.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++-----------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7ef6baea2d78..462bba422189 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -173,6 +173,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
@@ -1625,7 +1626,7 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static int __init its_alloc_lpi_prop_table(void)
 {
 	phys_addr_t paddr;
 
@@ -1944,30 +1945,47 @@ static void its_free_pending_table(struct page *pt)
 	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
 }
 
-static void its_cpu_init_lpis(void)
+static int __init allocate_lpi_tables(void)
 {
-	void __iomem *rbase = gic_data_rdist_rd_base();
-	struct page *pend_page;
-	u64 val, tmp;
+	int err, cpu;
 
-	/* If we didn't allocate the pending table yet, do it now */
-	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page) {
-		phys_addr_t paddr;
+	err = its_alloc_lpi_prop_table();
+	if (err)
+		return err;
+
+	/*
+	 * We allocate all the pending tables anyway, as we may have a
+	 * mix of RDs that have had LPIs enabled, and some that
+	 * don't. We'll free the unused ones as each CPU comes online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *pend_page;
 
 		pend_page = its_allocate_pending_table(GFP_NOWAIT);
 		if (!pend_page) {
-			pr_err("Failed to allocate PENDBASE for CPU%d\n",
-			       smp_processor_id());
-			return;
+			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
+			return -ENOMEM;
 		}
 
-		paddr = page_to_phys(pend_page);
-		pr_info("CPU%d: using LPI pending table @%pa\n",
-			smp_processor_id(), &paddr);
-		gic_data_rdist()->pend_page = pend_page;
+		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
 
+	return 0;
+}
+
+static void its_cpu_init_lpis(void)
+{
+	void __iomem *rbase = gic_data_rdist_rd_base();
+	struct page *pend_page;
+	phys_addr_t paddr;
+	u64 val, tmp;
+
+	if (gic_data_rdist()->lpi_enabled)
+		return;
+
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
+
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
@@ -2019,6 +2037,10 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+		smp_processor_id(),
+		&paddr);
 }
 
 static void its_cpu_init_collection(struct its_node *its)
@@ -3497,16 +3519,6 @@ static int redist_disable_lpis(void)
 	u64 timeout = USEC_PER_SEC;
 	u64 val;
 
-	/*
-	 * If coming via a CPU hotplug event, we don't need to disable
-	 * LPIs before trying to re-enable them. They are already
-	 * configured and all is well in the world. Detect this case
-	 * by checking the allocation of the pending table for the
-	 * current CPU.
-	 */
-	if (gic_data_rdist()->pend_page)
-		return 0;
-
 	if (!gic_rdists_supports_plpis()) {
 		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 		return -ENXIO;
@@ -3516,7 +3528,18 @@ static int redist_disable_lpis(void)
 	if (!(val & GICR_CTLR_ENABLE_LPIS))
 		return 0;
 
-	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
+	/*
+	 * If coming via a CPU hotplug event, we don't need to disable
+	 * LPIs before trying to re-enable them. They are already
+	 * configured and all is well in the world.
+	 */
+	if (gic_data_rdist()->lpi_enabled)
+		return 0;
+
+	/*
+	 * From that point on, we only try to do some damage control.
+	 */
+	pr_warn("GICv3: CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
 		smp_processor_id());
 	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
 
@@ -3772,7 +3795,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
+
+	err = allocate_lpi_tables();
 	if (err)
 		return err;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 8bdbb5f29494..266093e845bb 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -585,6 +585,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
+		bool		lpi_enabled;
 	} __percpu		*rdist;
 	struct page		*prop_page;
 	u64			flags;
-- 
2.18.0

