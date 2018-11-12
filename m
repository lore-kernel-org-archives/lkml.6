Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949CC0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4192243B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4192243B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbeKLVu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:50:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34686 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbeKLVu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:50:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB861650;
        Mon, 12 Nov 2018 03:58:00 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91C193F5A0;
        Mon, 12 Nov 2018 03:57:58 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 15/24] arm64: Switch to PMR masking when starting CPUs
Date:   Mon, 12 Nov 2018 11:57:06 +0000
Message-Id: <1542023835-21446-16-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the boot CPU has been prepared or a new secondary CPU has been
brought up, use ICC_PMR_EL1 to mask interrupts on that CPU and clear
PSR.I bit.

Since ICC_PMR_EL1 is initialized at CPU bringup, avoid overwriting
it in the GICv3 driver.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/smp.c      | 27 +++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c |  8 +++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8dc9dde..e495360 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -35,6 +35,7 @@
 #include <linux/smp.h>
 #include <linux/seq_file.h>
 #include <linux/irq.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
@@ -175,6 +176,25 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+static void init_gic_priority_masking(void)
+{
+	u32 gic_sre = gic_read_sre();
+	u32 cpuflags;
+
+	if (WARN_ON(!(gic_sre & ICC_SRE_EL1_SRE)))
+		return;
+
+	WARN_ON(!irqs_disabled());
+
+	gic_write_pmr(GIC_PRIO_IRQOFF);
+
+	cpuflags = read_sysreg(daif);
+
+	/* We can only unmask PSR.I if we can take aborts */
+	if (!(cpuflags & PSR_A_BIT))
+		write_sysreg(cpuflags & ~PSR_I_BIT, daif);
+}
+
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
@@ -211,6 +231,9 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	check_local_cpu_capabilities();
 
+	if (system_supports_irq_prio_masking())
+		init_gic_priority_masking();
+
 	if (cpu_ops[cpu]->cpu_postboot)
 		cpu_ops[cpu]->cpu_postboot();
 
@@ -421,6 +444,10 @@ void __init smp_prepare_boot_cpu(void)
 	 * and/or scheduling is enabled.
 	 */
 	apply_boot_alternatives();
+
+	/* Conditionally switch to GIC PMR for interrupt masking */
+	if (system_supports_irq_prio_masking())
+		init_gic_priority_masking();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbf5247..7f0b2e8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -414,6 +414,9 @@ static u32 gic_get_pribits(void)
 static bool gic_has_group0(void)
 {
 	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();
 
 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -429,6 +432,8 @@ static bool gic_has_group0(void)
 	gic_write_pmr(BIT(8 - gic_get_pribits()));
 	val = gic_read_pmr();
 
+	gic_write_pmr(old_pmr);
+
 	return val != 0;
 }
 
@@ -590,7 +595,8 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();
 
 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	if (!gic_prio_masking_enabled())
+		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
-- 
1.9.1

