Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABFECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE0A20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE0A20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbeIVBur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:47 -0400
Received: from foss.arm.com ([217.140.101.70]:41366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391477AbeIVBuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5216719BF;
        Fri, 21 Sep 2018 13:00:22 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 075343F5BD;
        Fri, 21 Sep 2018 13:00:22 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 10/10] irqchip/gic-v3-its: Allow use of LPI tables in reserved memory
Date:   Fri, 21 Sep 2018 20:59:54 +0100
Message-Id: <20180921195954.21574-11-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the LPI tables have been reserved with the EFI reservation
mechanism, we assume that these tables are safe to use even
when we find the redistributors to have LPIs enabled at
boot time, meaning that kexec can now work with GICv3.

You're welcome.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 43 ++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4912dc57bf07..0235b69160bc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/log2.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -1629,6 +1630,33 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
+static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
+{
+	phys_addr_t start, end, addr_end;
+	u64 i;
+
+	/*
+	 * We don't bother checking for a kdump kernel as by
+	 * construction, the LPI tables are out of this kernel's
+	 * memory map.
+	 */
+	if (is_kdump_kernel())
+		return true;
+
+	addr_end = addr + size - 1;
+
+	for_each_reserved_mem_region(i, &start, &end) {
+		if (addr >= start && addr_end <= end)
+			return true;
+	}
+
+	/* Not found, not a good sign... */
+	pr_warn("GICv3: Expected reserved range [%pa:%pa], not found\n",
+		&addr, &addr_end);
+	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+	return false;
+}
+
 static int gic_reserve_range(phys_addr_t addr, unsigned long size)
 {
 	if (efi_enabled(EFI_CONFIG_TABLES))
@@ -1976,15 +2004,19 @@ static void its_free_pending_table(struct page *pt)
 }
 
 /*
- * Booting with kdump and LPIs enabled is generally fine.
+ * Booting with kdump and LPIs enabled is generally fine. Any other
+ * case is wrong in the absence of firmware/EFI support.
  */
 static bool enabled_lpis_allowed(void)
 {
-	/* Allow a kdump kernel */
-	if (is_kdump_kernel())
-		return true;
+	phys_addr_t addr;
+	u64 val;
 
-	return false;
+	/* Check whether the property table is in a reserved region */
+	val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
+	addr = val & GENMASK_ULL(51, 12);
+
+	return gic_check_reserved_range(addr, LPI_PROPBASE_SZ);
 }
 
 static int __init allocate_lpi_tables(void)
@@ -2052,6 +2084,7 @@ static void its_cpu_init_lpis(void)
 		paddr = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 		paddr &= GENMASK_ULL(51, 16);
 
+		WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
 		its_free_pending_table(gic_data_rdist()->pend_page);
 		gic_data_rdist()->pend_page = NULL;
 
-- 
2.18.0

