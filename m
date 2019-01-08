Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA42C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF3B206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfAHOIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:08:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfAHOIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D2921650;
        Tue,  8 Jan 2019 06:08:37 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81E793F70D;
        Tue,  8 Jan 2019 06:08:35 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 17/26] arm64: Switch to PMR masking when starting CPUs
Date:   Tue,  8 Jan 2019 14:07:35 +0000
Message-Id: <1546956464-48825-18-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
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
 arch/arm64/kernel/smp.c      | 26 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c |  8 +++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a944edd..824de70 100644
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
@@ -180,6 +181,24 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+static void init_gic_priority_masking(void)
+{
+	u32 cpuflags;
+
+	if (WARN_ON(!gic_enable_sre()))
+		return;
+
+	cpuflags = read_sysreg(daif);
+
+	WARN_ON(!(cpuflags & PSR_I_BIT));
+
+	gic_write_pmr(GIC_PRIO_IRQOFF);
+
+	/* We can only unmask PSR.I if we can take aborts */
+	if (!(cpuflags & PSR_A_BIT))
+		write_sysreg(cpuflags & ~PSR_I_BIT, daif);
+}
+
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
@@ -206,6 +225,9 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	cpu_uninstall_idmap();
 
+	if (system_uses_irq_prio_masking())
+		init_gic_priority_masking();
+
 	preempt_disable();
 	trace_hardirqs_off();
 
@@ -426,6 +448,10 @@ void __init smp_prepare_boot_cpu(void)
 	 * and/or scheduling is enabled.
 	 */
 	apply_boot_alternatives();
+
+	/* Conditionally switch to GIC PMR for interrupt masking */
+	if (system_uses_irq_prio_masking())
+		init_gic_priority_masking();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index da547e0..5a703ae 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -415,6 +415,9 @@ static u32 gic_get_pribits(void)
 static bool gic_has_group0(void)
 {
 	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();
 
 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -430,6 +433,8 @@ static bool gic_has_group0(void)
 	gic_write_pmr(BIT(8 - gic_get_pribits()));
 	val = gic_read_pmr();
 
+	gic_write_pmr(old_pmr);
+
 	return val != 0;
 }
 
@@ -591,7 +596,8 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();
 
 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	if (!gic_prio_masking_enabled())
+		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
-- 
1.9.1

