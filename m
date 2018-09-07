Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A8DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ECB20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ECB20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIHBnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIHBmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:14 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC4820878;
        Fri,  7 Sep 2018 20:59:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNql-0001ns-Nn; Fri, 07 Sep 2018 16:59:31 -0400
Message-Id: <20180907205931.634338824@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:09 -0400
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
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 12/24] irqchip/gic-v3-its: Move ITS ->pend_page allocation into an early
 CPU up hook
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit e083f14dc2e98ced872bf077b4d1cccf95b7e4f8 ]

The AP-GIC-starting hook allocates memory for the ->pend_page while the
CPU is started during boot-up. This callback is invoked on the target
CPU with disabled interrupts.
This does not work on -RT beacuse memory allocations are not possible
with disabled interrupts.
Move the memory allocation to an earlier hotplug step which invoked with
enabled interrupts on the boot CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 60 ++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8217ebe8c1e..60533a795124 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -165,6 +165,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
@@ -1734,15 +1735,17 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
-static struct page *its_allocate_pending_table(gfp_t gfp_flags)
+static struct page *its_allocate_pending_table(unsigned int cpu)
 {
 	struct page *pend_page;
+	unsigned int order;
 	/*
 	 * The pending pages have to be at least 64kB aligned,
 	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 	 */
-	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
+	order = get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
+	pend_page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				     order);
 	if (!pend_page)
 		return NULL;
 
@@ -1758,6 +1761,28 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
+static int its_alloc_pend_page(unsigned int cpu)
+{
+	struct page *pend_page;
+	phys_addr_t paddr;
+
+	pend_page = gic_data_rdist_cpu(cpu)->pend_page;
+	if (pend_page)
+		return 0;
+
+	pend_page = its_allocate_pending_table(cpu);
+	if (!pend_page) {
+		pr_err("Failed to allocate PENDBASE for CPU%d\n",
+		       smp_processor_id());
+		return -ENOMEM;
+	}
+
+	paddr = page_to_phys(pend_page);
+	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
+	gic_data_rdist_cpu(cpu)->pend_page = pend_page;
+	return 0;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
@@ -1766,21 +1791,8 @@ static void its_cpu_init_lpis(void)
 
 	/* If we didn't allocate the pending table yet, do it now */
 	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page) {
-		phys_addr_t paddr;
-
-		pend_page = its_allocate_pending_table(GFP_NOWAIT);
-		if (!pend_page) {
-			pr_err("Failed to allocate PENDBASE for CPU%d\n",
-			       smp_processor_id());
-			return;
-		}
-
-		paddr = page_to_phys(pend_page);
-		pr_info("CPU%d: using LPI pending table @%pa\n",
-			smp_processor_id(), &paddr);
-		gic_data_rdist()->pend_page = pend_page;
-	}
+	if (!pend_page)
+		return;
 
 	/* Disable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
@@ -2599,7 +2611,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(GFP_KERNEL);
+	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3282,6 +3294,16 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (err)
 		return err;
 
+	err = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepare",
+				its_alloc_pend_page, NULL);
+	if (err < 0) {
+		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
+		return err;
+	}
+	err = its_alloc_pend_page(smp_processor_id());
+	if (err < 0)
+		return err;
+
 	list_for_each_entry(its, &its_nodes, entry)
 		has_v4 |= its->is_v4;
 
-- 
2.18.0


