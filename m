Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD81C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC5020882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLrrWuhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC5020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeILO4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeILO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:56:39 -0400
Received: from ziggy.de (unknown [37.223.144.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2943204EC;
        Wed, 12 Sep 2018 09:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536745972;
        bh=b1H5OQ+gG8L6XMUhr98Ih3aT9QGTSgjITBvtWTGY8rQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jLrrWuhhOWpd4UzktITsX/Fmj1SiT+fUW4e1+NWrmE7DywCImNROvlyqbfeASej6f
         gyQE8x97wvYDpp3fbF03bcww1Rij4ZCOar3bVDB3pCtBLDTxR35nJykUXehyRM7zrB
         ilGZ1BU5TmA8EO+KIBZYFnDXZv9Lh1CIlWJQWvdw=
From:   matthias.bgg@kernel.org
To:     catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        robert.richter@cavium.com
Cc:     suzuki.poulose@arm.com, shankerd@codeaurora.org,
        xiexiuqi@huawei.com, Dave.Martin@arm.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
Date:   Wed, 12 Sep 2018 11:52:32 +0200
Message-Id: <20180912095232.2110-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Some hardware does not implement two-level page tables so that
the amount of contigious memory needed by the baser is bigger
then the zone order. This is a known problem on Cavium Thunderx
with 4K page size.

We fix this by adding an errata which allocates the memory early
in the boot cycle, using the memblock allocator.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/Kconfig               | 12 ++++++++
 arch/arm64/include/asm/cpucaps.h |  3 +-
 arch/arm64/kernel/cpu_errata.c   | 33 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------
 4 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..dfd9fe08f0b2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
 
 	  If unsure, say Y.
 
+config CAVIUM_ALLOC_ITS_TABLE_EARLY
+	bool "Cavium Thunderx: Allocate the its table early"
+	default y
+	depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13
+	depends on ARM_GIC_V3_ITS
+	help
+	  Cavium Thunderx needs to allocate 16MB of ITS translation table.
+	  This can be bigger as MAX_ZONE_ORDER and need therefore be done
+	  via the memblock allocator.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ae1f70450fb2..c98be4809b7f 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -51,7 +51,8 @@
 #define ARM64_SSBD				30
 #define ARM64_MISMATCHED_CACHE_TYPE		31
 #define ARM64_HAS_STAGE2_FWB			32
+#define ARM64_WORKAROUND_CAVIUM_ITS_TABLE	33
 
-#define ARM64_NCAPS				33
+#define ARM64_NCAPS				34
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index dec10898d688..7908f8fa3ba8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -411,6 +411,29 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 }
 #endif	/* CONFIG_ARM64_SSBD */
 
+#ifdef CONFIG_CAVIUM_ALLOC_ITS_TABLE_EARLY
+#include <linux/bootmem.h>
+extern void *its_base;
+
+/*
+ * Hardware that doesn't use two-level page table and exceedes
+ * the maximum order of pages that can be allocated by the buddy
+ * allocator. Try to use the memblock allocator instead.
+ * This has been observed on Cavium Thunderx machines with 4K
+ * page size.
+ */
+static bool __init its_early_alloc(const struct arm64_cpu_capabilities *cap,
+		       int scope)
+{
+	/* We need to allocate the table only once */
+	if (scope & ARM64_CPUCAP_SCOPE_BOOT_CPU && !its_base)
+		its_base = (void *)memblock_virt_alloc_nopanic(16 * SZ_1M,
+					64 * SZ_1K);
+
+	return true;
+}
+#endif /* CONFIG_CAVIUM_ALLOC_ITS_TABLE_EARLY */
+
 #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
 	.matches = is_affected_midr_range,			\
 	.midr_range = MIDR_RANGE(model, v_min, r_min, v_max, r_max)
@@ -679,6 +702,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = has_ssbd_mitigation,
 	},
+#endif
+#ifdef CONFIG_CAVIUM_ALLOC_ITS_TABLE_EARLY
+	{
+		/* Cavium ThunderX, pass 1.x - 2.1 */
+		.desc = "Cavium alloc ITS table early",
+		.capability = ARM64_WORKAROUND_CAVIUM_ITS_TABLE,
+		.type = ARM64_CPUCAP_SCOPE_BOOT_CPU,
+		.matches = its_early_alloc,
+		.midr_range = MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
+	},
 #endif
 	{
 	}
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c2df341ff6fa..b78546740a0d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -87,6 +87,8 @@ struct its_baser {
 	u32		psz;
 };
 
+void *its_base;
+
 struct its_device;
 
 /*
@@ -1666,7 +1668,7 @@ static void its_write_baser(struct its_node *its, struct its_baser *baser,
 	baser->val = its_read_baser(its, baser);
 }
 
-static int its_setup_baser(struct its_node *its, struct its_baser *baser,
+static int __init its_setup_baser(struct its_node *its, struct its_baser *baser,
 			   u64 cache, u64 shr, u32 psz, u32 order,
 			   bool indirect)
 {
@@ -1675,7 +1677,6 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	u64 type = GITS_BASER_TYPE(val);
 	u64 baser_phys, tmp;
 	u32 alloc_pages;
-	void *base;
 
 retry_alloc_baser:
 	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
@@ -1687,11 +1688,22 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!base)
-		return -ENOMEM;
+	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_ITS_TABLE)) {
+		if (!its_base) {
+			pr_warn("ITS@%pa: %s Allocation using memblock failed %pS\n",
+				&its->phys_base, its_base_type_string[type],
+				its_base);
+			return -ENOMEM;
+		}
+
+	} else {
+		its_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+							order);
+		if (!its_base)
+			return -ENOMEM;
+	}
 
-	baser_phys = virt_to_phys(base);
+	baser_phys = virt_to_phys(its_base);
 
 	/* Check if the physical address of the memory is above 48bits */
 	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && (baser_phys >> 48)) {
@@ -1699,7 +1711,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		/* 52bit PA is supported only when PageSize=64K */
 		if (psz != SZ_64K) {
 			pr_err("ITS: no 52bit PA support when psz=%d\n", psz);
-			free_pages((unsigned long)base, order);
+			free_pages((unsigned long)its_base, order);
 			return -ENXIO;
 		}
 
@@ -1744,7 +1756,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
 		if (!shr) {
 			cache = GITS_BASER_nC;
-			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+			gic_flush_dcache_to_poc(its_base, PAGE_ORDER_TO_SIZE(order));
 		}
 		goto retry_baser;
 	}
@@ -1755,7 +1767,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		 * size and retry. If we reach 4K, then
 		 * something is horribly wrong...
 		 */
-		free_pages((unsigned long)base, order);
+		free_pages((unsigned long)its_base, order);
 		baser->base = NULL;
 
 		switch (psz) {
@@ -1772,19 +1784,19 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
 		       &its->phys_base, its_base_type_string[type],
 		       val, tmp);
-		free_pages((unsigned long)base, order);
+		free_pages((unsigned long)its_base, order);
 		return -ENXIO;
 	}
 
 	baser->order = order;
-	baser->base = base;
+	baser->base = its_base;
 	baser->psz = psz;
 	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
 	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
 		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
 		its_base_type_string[type],
-		(unsigned long)virt_to_phys(base),
+		(unsigned long)virt_to_phys(its_base),
 		indirect ? "indirect" : "flat", (int)esz,
 		psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
 
@@ -1832,12 +1844,14 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	 * feature is not supported by hardware.
 	 */
 	new_order = max_t(u32, get_order(esz << ids), new_order);
-	if (new_order >= MAX_ORDER) {
-		new_order = MAX_ORDER - 1;
-		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
-			&its->phys_base, its_base_type_string[type],
-			its->device_ids, ids);
+	if (!cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_ITS_TABLE)) {
+		if (new_order >= MAX_ORDER) {
+			new_order = MAX_ORDER - 1;
+			ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
+			pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
+				&its->phys_base, its_base_type_string[type],
+				its->device_ids, ids);
+		}
 	}
 
 	*order = new_order;
-- 
2.18.0

