Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FFDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76DE20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vg6vk9X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76DE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHaX3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55974 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJKDoG101644;
        Fri, 31 Aug 2018 14:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535743213;
        bh=Ph9uCGujt34SYSo8TnGJHtyq7N6jTSpj62WKS5kMEl0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vg6vk9X4+AvMz2ZHd5jeuDb249nxbgS3w7qhGkUxOmgEPj3SjiSIxEyp/pQfLMuDu
         unBc2UzF4f2v/FaER80UVezJv7uK0lemnjZ37iU8yGj1ku6E1n5eiR2aEP3ihBBCnp
         ZvNyRAbir3tphvabRH3daFJ0h+wtGWbWkcHWLBFY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJKD3T002890;
        Fri, 31 Aug 2018 14:20:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:20:13 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:20:13 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJKDop030371;
        Fri, 31 Aug 2018 14:20:13 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJKDx13945;
        Fri, 31 Aug 2018 14:20:13 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [4.14.66-rt TEST PATCH 2/3] irqchip/gic-v3-its: Move ITS' ->pend_page allocation into an early CPU up hook
Date:   Fri, 31 Aug 2018 14:20:08 -0500
Message-ID: <20180831192009.17257-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20180831192009.17257-1-grygorii.strashko@ti.com>
References: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
 <20180831192009.17257-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The AP-GIC-starting hook allocates memory for the ->pend_page while the
CPU is started during boot-up. This callback is invoked on the target
CPU with disabled interrupts.
This does not work on -RT beacuse memory allocations are not possible
with disabled interrupts.
Move the memory allocation to an earlier hotplug step which invoked with
enabled interrupts on the boot CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its.c | 60 +++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0b691d1..23c5818 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -171,6 +171,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
@@ -1738,15 +1739,17 @@ static int its_alloc_collections(struct its_node *its)
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
 
@@ -1762,6 +1765,28 @@ static void its_free_pending_table(struct page *pt)
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
@@ -1770,21 +1795,8 @@ static void its_cpu_init_lpis(void)
 
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
@@ -2603,7 +2615,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(GFP_KERNEL);
+	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3350,6 +3362,16 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
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
2.10.5

