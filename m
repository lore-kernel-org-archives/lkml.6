Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F62C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628F20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B4Gn8ltD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1628F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeHaX3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:23 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJKElr109044;
        Fri, 31 Aug 2018 14:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535743214;
        bh=08n2LAUmPmCaDsmnTmEZoNwDbS6cNoEos6kiWKNQg/I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B4Gn8ltDq2UsuCzgXI3qoW+48WHlXOcWeS7nL2I6Czw2f95z2y350EPF1GqmgGQEe
         mMdzGyilR19tnpmkSbR4Ehw6N4UqxsOUTozpjxlTPINyr0V7NYxJZzwoCyqSxkR1lr
         l+DzkVPcz6g+BHxiNBjhDpQ+l/FajvDllwyEK3Ic=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJKEkw025659;
        Fri, 31 Aug 2018 14:20:14 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:20:13 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:20:13 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJKDCB011481;
        Fri, 31 Aug 2018 14:20:13 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJKDx13949;
        Fri, 31 Aug 2018 14:20:13 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [4.14.66-rt TEST PATCH 3/3] irqchip/gic-v3-its: Move pending table allocation to init time
Date:   Fri, 31 Aug 2018 14:20:09 -0500
Message-ID: <20180831192009.17257-3-grygorii.strashko@ti.com>
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

From: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[bigeasy: backport commit effe377d415 ("irqchip/gic-v3-its: Move pending
          table allocation to init time")]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its.c   | 79 +++++++++++++++++---------------------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 23c5818..1aaa757 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1446,7 +1446,7 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static int __init its_alloc_lpi_prop_table(void)
 {
 	phys_addr_t paddr;
 
@@ -1739,17 +1739,15 @@ static int its_alloc_collections(struct its_node *its)
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
 
@@ -1765,25 +1763,31 @@ static void its_free_pending_table(struct page *pt)
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
 
@@ -1791,22 +1795,14 @@ static void its_cpu_init_lpis(void)
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
 
-	/* Disable LPIs */
-	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
-
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
 
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
@@ -1859,6 +1855,10 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+		smp_processor_id(),
+		&paddr);
 }
 
 static void its_cpu_init_collection(void)
@@ -2615,7 +2615,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
+	vpt_page = its_allocate_pending_table(GFP_KERNEL);
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3358,18 +3358,9 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
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
index bacb499..688f256 100644
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
2.10.5

