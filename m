Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75901ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F56520858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F56520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391463AbeIVBup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41330 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391371AbeIVBuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66DFA1684;
        Fri, 21 Sep 2018 13:00:20 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B90D3F5BD;
        Fri, 21 Sep 2018 13:00:20 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 05/10] irqchip/gic-v3-its: Keep track of property table's PA and VA
Date:   Fri, 21 Sep 2018 20:59:49 +0100
Message-Id: <20180921195954.21574-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're currently only tracking the page allocated to contain the
property table by its struct page. In the future, it is going to
be convenient to track both PA and VA for that page instead. Let's
do that.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 23 +++++++++++++----------
 include/linux/irqchip/arm-gic-v3.h |  3 ++-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 462bba422189..c2f1138034fd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1029,7 +1029,7 @@ static inline u32 its_get_event_id(struct irq_data *d)
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	irq_hw_number_t hwirq;
-	struct page *prop_page;
+	void *va;
 	u8 *cfg;
 
 	if (irqd_is_forwarded_to_vcpu(d)) {
@@ -1037,7 +1037,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		u32 event = its_get_event_id(d);
 		struct its_vlpi_map *map;
 
-		prop_page = its_dev->event_map.vm->vprop_page;
+		va = page_address(its_dev->event_map.vm->vprop_page);
 		map = &its_dev->event_map.vlpi_maps[event];
 		hwirq = map->vintid;
 
@@ -1045,11 +1045,11 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		map->properties &= ~clr;
 		map->properties |= set | LPI_PROP_GROUP1;
 	} else {
-		prop_page = gic_rdists->prop_page;
+		va = gic_rdists->prop_table_va;
 		hwirq = d->hwirq;
 	}
 
-	cfg = page_address(prop_page) + hwirq - 8192;
+	cfg = va + hwirq - 8192;
 	*cfg &= ~clr;
 	*cfg |= set | LPI_PROP_GROUP1;
 
@@ -1628,18 +1628,21 @@ static void its_free_prop_table(struct page *prop_page)
 
 static int __init its_alloc_lpi_prop_table(void)
 {
-	phys_addr_t paddr;
+	struct page *page;
 
 	lpi_id_bits = min_t(u32, GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
 				ITS_MAX_LPI_NRBITS);
-	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
-	if (!gic_rdists->prop_page) {
+	page = its_allocate_prop_table(GFP_NOWAIT);
+	if (!page) {
 		pr_err("Failed to allocate PROPBASE\n");
 		return -ENOMEM;
 	}
 
-	paddr = page_to_phys(gic_rdists->prop_page);
-	pr_info("GIC: using LPI property table @%pa\n", &paddr);
+	gic_rdists->prop_table_pa = page_to_phys(page);
+	gic_rdists->prop_table_va = page_address(page);
+
+	pr_info("GICv3: using LPI property table @%pa\n",
+		&gic_rdists->prop_table_pa);
 
 	return its_lpi_init(lpi_id_bits);
 }
@@ -1987,7 +1990,7 @@ static void its_cpu_init_lpis(void)
 	paddr = page_to_phys(pend_page);
 
 	/* set PROPBASE */
-	val = (page_to_phys(gic_rdists->prop_page) |
+	val = (gic_rdists->prop_table_pa |
 	       GICR_PROPBASER_InnerShareable |
 	       GICR_PROPBASER_RaWaWb |
 	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 266093e845bb..c2a7b863fc2e 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -587,7 +587,8 @@ struct rdists {
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
 	} __percpu		*rdist;
-	struct page		*prop_page;
+	phys_addr_t		prop_table_pa;
+	void			*prop_table_va;
 	u64			flags;
 	u32			gicd_typer;
 	bool			has_vlpis;
-- 
2.18.0

