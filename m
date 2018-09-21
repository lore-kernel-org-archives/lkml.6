Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04835C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF7220858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391478AbeIVBuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:46 -0400
Received: from foss.arm.com ([217.140.101.70]:41340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391436AbeIVBup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D394B1688;
        Fri, 21 Sep 2018 13:00:20 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798AC3F5BD;
        Fri, 21 Sep 2018 13:00:20 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 06/10] irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
Date:   Fri, 21 Sep 2018 20:59:50 +0100
Message-Id: <20180921195954.21574-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cope with kexec and GICv3, let's try and spot when
we're booting with LPIs already enabled, and the tables already
programmed into the redistributors.

This code is currently guarded by a predicate that is always false,
meaning this is not functionnal just yet.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 73 ++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c2f1138034fd..e29ce9f2ac8a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -52,6 +52,7 @@
 #define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
+#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
 static u32 lpi_id_bits;
 
@@ -1628,18 +1629,32 @@ static void its_free_prop_table(struct page *prop_page)
 
 static int __init its_alloc_lpi_prop_table(void)
 {
-	struct page *page;
+	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
+		u64 val;
 
-	lpi_id_bits = min_t(u32, GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
-				ITS_MAX_LPI_NRBITS);
-	page = its_allocate_prop_table(GFP_NOWAIT);
-	if (!page) {
-		pr_err("Failed to allocate PROPBASE\n");
-		return -ENOMEM;
-	}
+		val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
+		lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
 
-	gic_rdists->prop_table_pa = page_to_phys(page);
-	gic_rdists->prop_table_va = page_address(page);
+		gic_rdists->prop_table_pa = val & GENMASK_ULL(51, 12);
+		gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
+						     LPI_PROPBASE_SZ,
+						     MEMREMAP_WB);
+		gic_reset_prop_table(gic_rdists->prop_table_va);
+	} else {
+		struct page *page;
+
+		lpi_id_bits = min_t(u32,
+				    GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
+				    ITS_MAX_LPI_NRBITS);
+		page = its_allocate_prop_table(GFP_NOWAIT);
+		if (!page) {
+			pr_err("Failed to allocate PROPBASE\n");
+			return -ENOMEM;
+		}
+
+		gic_rdists->prop_table_pa = page_to_phys(page);
+		gic_rdists->prop_table_va = page_address(page);
+	}
 
 	pr_info("GICv3: using LPI property table @%pa\n",
 		&gic_rdists->prop_table_pa);
@@ -1948,10 +1963,27 @@ static void its_free_pending_table(struct page *pt)
 	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
 }
 
+static bool enabled_lpis_allowed(void)
+{
+	return false;
+}
+
 static int __init allocate_lpi_tables(void)
 {
+	u64 val;
 	int err, cpu;
 
+	/*
+	 * If LPIs are enabled while we run this from the boot CPU,
+	 * flag the RD tables as pre-allocated if the stars do align.
+	 */
+	val = readl_relaxed(gic_data_rdist_rd_base() + GICR_CTLR);
+	if ((val & GICR_CTLR_ENABLE_LPIS) && enabled_lpis_allowed()) {
+		gic_rdists->flags |= (RDIST_FLAGS_RD_TABLES_PREALLOCATED |
+				      RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING);
+		pr_info("GICv3: Using preallocated redistributor tables\n");
+	}
+
 	err = its_alloc_lpi_prop_table();
 	if (err)
 		return err;
@@ -1986,6 +2018,18 @@ static void its_cpu_init_lpis(void)
 	if (gic_data_rdist()->lpi_enabled)
 		return;
 
+	val = readl_relaxed(rbase + GICR_CTLR);
+	if ((gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) &&
+	    (val & GICR_CTLR_ENABLE_LPIS)) {
+		paddr = gicr_read_pendbaser(rbase + GICR_PENDBASER);
+		paddr &= GENMASK_ULL(51, 16);
+
+		its_free_pending_table(gic_data_rdist()->pend_page);
+		gic_data_rdist()->pend_page = NULL;
+
+		goto out;
+	}
+
 	pend_page = gic_data_rdist()->pend_page;
 	paddr = page_to_phys(pend_page);
 
@@ -2040,9 +2084,11 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+out:
 	gic_data_rdist()->lpi_enabled = true;
-	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
+		gic_data_rdist()->pend_page ? "allocated" : "reserved",
 		&paddr);
 }
 
@@ -3535,8 +3581,11 @@ static int redist_disable_lpis(void)
 	 * If coming via a CPU hotplug event, we don't need to disable
 	 * LPIs before trying to re-enable them. They are already
 	 * configured and all is well in the world.
+	 *
+	 * If running with preallocated tables, there is nothing to do.
 	 */
-	if (gic_data_rdist()->lpi_enabled)
+	if (gic_data_rdist()->lpi_enabled ||
+	    (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED))
 		return 0;
 
 	/*
-- 
2.18.0

