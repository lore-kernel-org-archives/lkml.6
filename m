Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD07C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093D2206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfAJKJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:09:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59210 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfAJKJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:09:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A040B80D;
        Thu, 10 Jan 2019 02:09:34 -0800 (PST)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9058C3F694;
        Thu, 10 Jan 2019 02:09:33 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: fix a migrating irq bug when hotplug cpu
Date:   Thu, 10 Jan 2019 10:09:22 +0000
Message-Id: <20190110100922.20280-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm TC2 fails cpu hotplug stress test.

This issue was tracked down to a missing copy of the new affinity
cpumask for the vexpress-spc interrupt into struct
irq_common_data.affinity when the interrupt is migrated in
migrate_one_irq().

Fix it by replacing the arm specific hotplug cpu migration with the
generic irq code.

This is the counterpart implementation to commit 217d453d473c ("arm64:
fix a migrating irq bug when hotplug cpu").

Tested with cpu hotplug stress test on Arm TC2 (multi_v7_defconfig plus
CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y).
The vexpress-spc interrupt (irq=22) on this board is affine to CPU0.
Its affinity cpumask now changes correctly e.g. from 0 to 1-4 when
CPU0 is hotplugged out.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/irq.h |  1 -
 arch/arm/kernel/irq.c      | 62 ----------------------------------------------
 arch/arm/kernel/smp.c      |  2 +-
 4 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..26524b75970a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1400,6 +1400,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
+	select GENERIC_IRQ_MIGRATION
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index c883fcbe93b6..46d41140df27 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -25,7 +25,6 @@
 #ifndef __ASSEMBLY__
 struct irqaction;
 struct pt_regs;
-extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 9908dacf9229..844861368cd5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -31,7 +31,6 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
-#include <linux/ratelimit.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/kallsyms.h>
@@ -109,64 +108,3 @@ int __init arch_probe_nr_irqs(void)
 	return nr_irqs;
 }
 #endif
-
-#ifdef CONFIG_HOTPLUG_CPU
-static bool migrate_one_irq(struct irq_desc *desc)
-{
-	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
-	struct irq_chip *c;
-	bool ret = false;
-
-	/*
-	 * If this is a per-CPU interrupt, or the affinity does not
-	 * include this CPU, then we have nothing to do.
-	 */
-	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
-		return false;
-
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-		affinity = cpu_online_mask;
-		ret = true;
-	}
-
-	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
-		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
-
-	return ret;
-}
-
-/*
- * The current CPU has been marked offline.  Migrate IRQs off this CPU.
- * If the affinity settings do not allow other CPUs, force them onto any
- * available CPU.
- *
- * Note: we must iterate over all IRQs, whether they have an attached
- * action structure or not, as we need to get chained interrupts too.
- */
-void migrate_irqs(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	for_each_irq_desc(i, desc) {
-		bool affinity_broken;
-
-		raw_spin_lock(&desc->lock);
-		affinity_broken = migrate_one_irq(desc);
-		raw_spin_unlock(&desc->lock);
-
-		if (affinity_broken)
-			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
-				i, smp_processor_id());
-	}
-
-	local_irq_restore(flags);
-}
-#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3bf82232b1be..1d6f5ea522f4 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -254,7 +254,7 @@ int __cpu_disable(void)
 	/*
 	 * OK - migrate IRQs away from this CPU
 	 */
-	migrate_irqs();
+	irq_migrate_all_off_this_cpu();
 
 	/*
 	 * Flush user cache and TLB mappings, and then remove this CPU
-- 
2.11.0

