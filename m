Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E709C2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E709C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIHBmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbeIHBmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:14 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB79F20879;
        Fri,  7 Sep 2018 20:59:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNql-0001oP-Sd; Fri, 07 Sep 2018 16:59:31 -0400
Message-Id: <20180907205931.777012731@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH RT 13/24] irqchip/gic-v3-its: Move pending table allocation to init time
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 4a0819bb25d12d39c0390636122eefba232596c1 ]

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[bigeasy: backport commit effe377d415 ("irqchip/gic-v3-its: Move pending
          table allocation to init time")]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 71 +++++++++++++++---------------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 60533a795124..a3e23d0fc4af 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1433,7 +1433,7 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static int __init its_alloc_lpi_prop_table(void)
 {
 	phys_addr_t paddr;
 
@@ -1735,17 +1735,15 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
-static struct page *its_allocate_pending_table(unsigned int cpu)
+static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
-	unsigned int order;
 	/*
 	 * The pending pages have to be at least 64kB aligned,
 	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 	 */
-	order = get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
-	pend_page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
-				     order);
+	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
+				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 	if (!pend_page)
 		return NULL;
 
@@ -1761,25 +1759,31 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
-static int its_alloc_pend_page(unsigned int cpu)
+static int __init allocate_lpi_tables(void)
 {
-	struct page *pend_page;
-	phys_addr_t paddr;
+	int err, cpu;
 
-	pend_page = gic_data_rdist_cpu(cpu)->pend_page;
-	if (pend_page)
-		return 0;
+	err = its_alloc_lpi_prop_table();
+	if (err)
+		return err;
 
-	pend_page = its_allocate_pending_table(cpu);
-	if (!pend_page) {
-		pr_err("Failed to allocate PENDBASE for CPU%d\n",
-		       smp_processor_id());
-		return -ENOMEM;
+	/*
+	 * We allocate all the pending tables anyway, as we may have a
+	 * mix of RDs that have had LPIs enabled, and some that
+	 * don't. We'll free the unused ones as each CPU comes online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *pend_page;
+
+		pend_page = its_allocate_pending_table(GFP_NOWAIT);
+		if (!pend_page) {
+			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
+			return -ENOMEM;
+		}
+
+		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
 
-	paddr = page_to_phys(pend_page);
-	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
-	gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	return 0;
 }
 
@@ -1787,13 +1791,15 @@ static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
+	phys_addr_t paddr;
 	u64 val, tmp;
 
-	/* If we didn't allocate the pending table yet, do it now */
-	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page)
+	if (gic_data_rdist()->lpi_enabled)
 		return;
 
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
+
 	/* Disable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
 	val &= ~GICR_CTLR_ENABLE_LPIS;
@@ -1855,6 +1861,10 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+		smp_processor_id(),
+		&paddr);
 }
 
 static void its_cpu_init_collection(void)
@@ -2611,7 +2621,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
+	vpt_page = its_allocate_pending_table(GFP_KERNEL);
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3290,18 +3300,9 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
-	if (err)
-		return err;
 
-	err = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepare",
-				its_alloc_pend_page, NULL);
-	if (err < 0) {
-		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
-		return err;
-	}
-	err = its_alloc_pend_page(smp_processor_id());
-	if (err < 0)
+	err = allocate_lpi_tables();
+	if (err)
 		return err;
 
 	list_for_each_entry(its, &its_nodes, entry)
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index bacb499c512c..688f2565294c 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -568,6 +568,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
+		bool		lpi_enabled;
 	} __percpu		*rdist;
 	struct page		*prop_page;
 	int			id_bits;
-- 
2.18.0


