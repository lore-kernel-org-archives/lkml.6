Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BBEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710332080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeLSMlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:41:13 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40297 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbeLSMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:41:13 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJCarvl020631;
        Wed, 19 Dec 2018 13:40:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xwu14-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Dec 2018 13:40:50 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0659034;
        Wed, 19 Dec 2018 12:40:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9098026A5;
        Wed, 19 Dec 2018 12:40:49 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 19 Dec 2018 13:40:48
 +0100
From:   <patrice.chotard@st.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@st.com>, Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 1/1] ARM: sti: remove pen_release and boot_lock
Date:   Wed, 19 Dec 2018 13:40:41 +0100
Message-ID: <1545223241-24330-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

The pen_release implementation was created for Versatile platforms to
work around boot loaders that did not differentiate between the
various different secondary CPUs on this ARM development platform.
This should not be true of modern platforms where we send IPIs to
specific CPUs to wake them up.  Remove the pen_release stuff from
SoCs that make use of the per-CPU IPI mechanism.

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Due to pen_release and boot_lock removal, .smp_prepare_cpus and
.smp_boot_secondary STi callbacks must be reworked properly to
allow secondary CPU bring up.

Secondary CPU is initialized and started by a U-BOOTROM firmware.
Secondary CPU is spinning and waiting for a write at cpu_strt_ptr.
Writing secondary_startup address at cpu_strt_ptr makes it to
jump directly to secondary_startup().

This write must be done in .smp_boot_secondary callback and not
in .smp_prepare_cpus as previously, this insures that secondary_data
struct is populated in __cpu_up() (stack, pgdir and swapper_pg_dir fields).

The IPI in sti_boot_secondary() is useless, so remove it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/mach-sti/Makefile  |  2 +-
 arch/arm/mach-sti/headsmp.S | 43 ----------------------
 arch/arm/mach-sti/platsmp.c | 88 ++++++++-------------------------------------
 3 files changed, 15 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/mach-sti/headsmp.S

diff --git a/arch/arm/mach-sti/Makefile b/arch/arm/mach-sti/Makefile
index acb3309..f85ff05 100644
--- a/arch/arm/mach-sti/Makefile
+++ b/arch/arm/mach-sti/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_ARCH_STI) 		+= board-dt.o
diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
deleted file mode 100644
index e0ad4517..0000000
--- a/arch/arm/mach-sti/headsmp.S
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  arch/arm/mach-sti/headsmp.S
- *
- * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
- *		http://www.st.com
- *
- * Cloned from linux/arch/arm/mach-vexpress/headsmp.S
- *
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-/*
- * ST specific entry point for secondary CPUs.  This provides
- * a "holding pen" into which all secondary cores are held until we're
- * ready for them to initialise.
- */
-ENTRY(sti_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
-pen:	ldr	r7, [r6]
-	cmp	r7, r0
-	bne	pen
-
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
-ENDPROC(sti_secondary_startup)
-
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e..d0272a8 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -28,82 +28,33 @@
 
 #include "smp.h"
 
-static void write_pen_release(int val)
-{
-	pen_release = val;
-	smp_wmb();
-	sync_cache_w(&pen_release);
-}
-
-static DEFINE_SPINLOCK(boot_lock);
-
-static void sti_secondary_init(unsigned int cpu)
-{
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	write_pen_release(-1);
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-}
+static u32 __iomem *cpu_strt_ptr;
 
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
-
-	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
+	unsigned long entry_pa = __pa_symbol(secondary_startup);
 
 	/*
-	 * The secondary processor is waiting to be released from
-	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
-	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
-	 * "cpu" is Linux's internal ID.
+	 * Secondary CPU is initialised and started by a U-BOOTROM firmware.
+	 * Secondary CPU is spinning and waiting for a write at cpu_strt_ptr.
+	 * Writing secondary_startup address at cpu_strt_ptr makes it to
+	 * jump directly to secondary_startup().
 	 */
-	write_pen_release(cpu_logical_map(cpu));
+	__raw_writel(entry_pa, cpu_strt_ptr);
 
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * it to jump to the secondary entrypoint.
-	 */
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
+	/* wmb so that data is actually written before cache flush is done */
+	smp_wmb();
+	sync_cache_w(cpu_strt_ptr);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return 0;
 }
 
 static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
 	void __iomem *scu_base;
-	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
-	unsigned long entry_pa = __pa_symbol(sti_secondary_startup);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
@@ -131,8 +82,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		/*
-		 * holding pen is usually configured in SBC DMEM but can also be
-		 * in RAM.
+		 * cpu-release-addr is usually configured in SBC DMEM but can
+		 * also be in RAM.
 		 */
 
 		if (!memblock_is_memory(release_phys))
@@ -142,22 +93,11 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 			cpu_strt_ptr =
 				(u32 __iomem *)phys_to_virt(release_phys);
 
-		__raw_writel(entry_pa, cpu_strt_ptr);
-
-		/*
-		 * wmb so that data is actually written
-		 * before cache flush is done
-		 */
-		smp_wmb();
-		sync_cache_w(cpu_strt_ptr);
-
-		if (!memblock_is_memory(release_phys))
-			iounmap(cpu_strt_ptr);
+		set_cpu_possible(cpu, true);
 	}
 }
 
 const struct smp_operations sti_smp_ops __initconst = {
 	.smp_prepare_cpus	= sti_smp_prepare_cpus,
-	.smp_secondary_init	= sti_secondary_init,
 	.smp_boot_secondary	= sti_boot_secondary,
 };
-- 
1.9.1

