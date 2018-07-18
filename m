Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC1ECDFBC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0120854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C0120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeGRQUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:20:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbeGRQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:20:46 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffoak-0000sh-KC; Wed, 18 Jul 2018 17:42:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] irqchip/gic-v3-its: Move ITS' ->pend_page allocation into an early CPU up callback
Date:   Wed, 18 Jul 2018 17:42:05 +0200
Message-Id: <20180718154205.13704-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718154205.13704-1-bigeasy@linutronix.de>
References: <20180718154205.13704-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AP-GIC-starting callback allocates memory for the ->pend_page while
the CPU is started during boot-up. This callback is invoked on the
target CPU with disabled interrupts.
This does not work on -RT because memory allocations are not possible
with disabled interrupts.
Move the memory allocation to an earlier hotplug step which is invoked
with enabled interrupts on the boot CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its.c | 60 ++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index a616043d25ee..acc3d44c356d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -171,6 +171,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
=20
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
=20
@@ -1853,15 +1854,17 @@ static int its_alloc_collections(struct its_node *i=
ts)
 	return 0;
 }
=20
-static struct page *its_allocate_pending_table(gfp_t gfp_flags)
+static struct page *its_allocate_pending_table(unsigned int cpu)
 {
 	struct page *pend_page;
+	unsigned int order;
 	/*
 	 * The pending pages have to be at least 64kB aligned,
 	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 	 */
-	pend_page =3D alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
+	order =3D get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
+	pend_page =3D alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				     order);
 	if (!pend_page)
 		return NULL;
=20
@@ -1877,6 +1880,28 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
=20
+static int its_alloc_pend_page(unsigned int cpu)
+{
+	struct page *pend_page;
+	phys_addr_t paddr;
+
+	pend_page =3D gic_data_rdist_cpu(cpu)->pend_page;
+	if (pend_page)
+		return 0;
+
+	pend_page =3D its_allocate_pending_table(cpu);
+	if (!pend_page) {
+		pr_err("Failed to allocate PENDBASE for CPU%d\n",
+		       smp_processor_id());
+		return -ENOMEM;
+	}
+
+	paddr =3D page_to_phys(pend_page);
+	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
+	gic_data_rdist_cpu(cpu)->pend_page =3D pend_page;
+	return 0;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase =3D gic_data_rdist_rd_base();
@@ -1885,21 +1910,8 @@ static void its_cpu_init_lpis(void)
=20
 	/* If we didn't allocate the pending table yet, do it now */
 	pend_page =3D gic_data_rdist()->pend_page;
-	if (!pend_page) {
-		phys_addr_t paddr;
-
-		pend_page =3D its_allocate_pending_table(GFP_NOWAIT);
-		if (!pend_page) {
-			pr_err("Failed to allocate PENDBASE for CPU%d\n",
-			       smp_processor_id());
-			return;
-		}
-
-		paddr =3D page_to_phys(pend_page);
-		pr_info("CPU%d: using LPI pending table @%pa\n",
-			smp_processor_id(), &paddr);
-		gic_data_rdist()->pend_page =3D pend_page;
-	}
+	if (WARN_ON(!pend_page))
+		return;
=20
 	/* set PROPBASE */
 	val =3D (page_to_phys(gic_rdists->prop_page) |
@@ -2732,7 +2744,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
=20
 	/* Allocate VPT */
-	vpt_page =3D its_allocate_pending_table(GFP_KERNEL);
+	vpt_page =3D its_allocate_pending_table(raw_smp_processor_id());
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3706,6 +3718,16 @@ int __init its_init(struct fwnode_handle *handle, st=
ruct rdists *rdists,
 	if (err)
 		return err;
=20
+	err =3D cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepar=
e",
+				its_alloc_pend_page, NULL);
+	if (err < 0) {
+		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
+		return err;
+	}
+	err =3D its_alloc_pend_page(smp_processor_id());
+	if (err < 0)
+		return err;
+
 	list_for_each_entry(its, &its_nodes, entry)
 		has_v4 |=3D its->is_v4;
=20
--=20
2.18.0

