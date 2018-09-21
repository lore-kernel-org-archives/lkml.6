Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94681C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDA820858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDA820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbeIVBu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:59 -0400
Received: from foss.arm.com ([217.140.101.70]:41360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391471AbeIVBuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C7E174E;
        Fri, 21 Sep 2018 13:00:21 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63913F5BD;
        Fri, 21 Sep 2018 13:00:21 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 09/10] irqchip/gic-v3-its: Register LPI tables with EFI config table
Date:   Fri, 21 Sep 2018 20:59:53 +0100
Message-Id: <20180921195954.21574-10-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon enabling a redistributor, let's register the allocated tables
with the EFI table that tracks the memory reservations.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4d9604dd6fb1..4912dc57bf07 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -22,6 +22,7 @@
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
@@ -1628,6 +1629,14 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
+static int gic_reserve_range(phys_addr_t addr, unsigned long size)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		return efi_mem_reserve_persistent(addr, size);
+
+	return 0;
+}
+
 static int __init its_alloc_lpi_prop_table(void)
 {
 	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
@@ -1655,6 +1664,8 @@ static int __init its_alloc_lpi_prop_table(void)
 
 		gic_rdists->prop_table_pa = page_to_phys(page);
 		gic_rdists->prop_table_va = page_address(page);
+		WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
+					  LPI_PROPBASE_SZ));
 	}
 
 	pr_info("GICv3: using LPI property table @%pa\n",
@@ -2049,6 +2060,7 @@ static void its_cpu_init_lpis(void)
 
 	pend_page = gic_data_rdist()->pend_page;
 	paddr = page_to_phys(pend_page);
+	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
 
 	/* set PROPBASE */
 	val = (gic_rdists->prop_table_pa |
-- 
2.18.0

