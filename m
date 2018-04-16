Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeDPJjz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:39:55 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:39732 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754200AbeDPJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:39:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517842800";
   d="scan'208";a="278331339"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlo Caione <carlo@endlessm.com>, Juri Lelli <juri.lelli@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] arm: rzn1: Add support for the second CPU.
Date: Mon, 16 Apr 2018 10:34:56 +0100
Message-Id: <1523871304-48517-2-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables starting the second CA7 core. Also handles the case the
bootloader has had to change the second CPU parking address to allow
booting in NONSEC/HYP.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile          |  1 +
 arch/arm/mach-shmobile/r9a06g032.h       |  7 +++
 arch/arm/mach-shmobile/setup-r9a06g032.c |  2 +
 arch/arm/mach-shmobile/smp-r9a06g032.c   | 88 ++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/r9a06g032.h
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index a63e5c2..e0f8c97 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -36,6 +36,7 @@ smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
+smp-$(CONFIG_ARCH_R9A06G032)	+= smp-r9a06g032.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/arm/mach-shmobile/r9a06g032.h b/arch/arm/mach-shmobile/r9a06g032.h
new file mode 100644
index 0000000..3992e97
--- /dev/null
+++ b/arch/arm/mach-shmobile/r9a06g032.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __R9A06G032_H__
+#define __R9A06G032_H__
+
+extern const struct smp_operations rzn1_smp_ops;
+
+#endif /* __R9A06G032_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r9a06g032.c b/arch/arm/mach-shmobile/setup-r9a06g032.c
index 65288e1..7bc6216 100644
--- a/arch/arm/mach-shmobile/setup-r9a06g032.c
+++ b/arch/arm/mach-shmobile/setup-r9a06g032.c
@@ -11,6 +11,7 @@
 #include <asm/mach/arch.h>
 #include <dt-bindings/soc/renesas,rzn1-map.h>
 #include <soc/rzn1/sysctrl.h>
+#include "r9a06g032.h"
 
 static void __iomem *sysctrl_base_addr;
 
@@ -50,6 +51,7 @@ static const char *rzn1_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(RZN1_DT, "Renesas RZ/N1 (Device Tree)")
+	.smp		= smp_ops(rzn1_smp_ops),
 	.dt_compat      = rzn1_boards_compat_dt,
 	.restart	= rzn1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c b/arch/arm/mach-shmobile/smp-r9a06g032.c
new file mode 100644
index 0000000..e441188
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SMP support for Renesas RZ/N1D
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
+ *
+ * Based on code
+ *  Copyright (C) 2012-2013 Allwinner Ltd.
+ *
+ */
+
+#include <linux/of.h>
+#include <soc/rzn1/sysctrl.h>
+#include "r9a06g032.h"
+
+#define BOOTADDR2_CANARY	0x525a4e31
+
+static void __iomem *pen2_base;
+
+static DEFINE_SPINLOCK(cpu_lock);
+
+/*
+ * The alternate boot address for the second core can be overridden in the DT,
+ * typically this will happen if the bootloader decides to park the second
+ * core somewhere else than the fixed ALT_BOOTADDR address.
+ *
+ * This use case is required for NONSEC, as the SYSCTRL BOOTADDR register isn't
+ * available after switching mode, so the bootloader parks the CPU#2 in a pen
+ * is SRAM to await on an alternate address (followed by a canary) then the
+ * bootloader switches mode, and finaly starts the kernel...
+ * The address of that alternate 'register' is passed in /chosen.
+ */
+static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus)
+{
+	u32 bootaddr = 0;
+	struct device_node *np = of_find_node_by_path("/chosen");
+
+	if (np)
+		of_property_read_u32(np, "rzn1,bootaddr", &bootaddr);
+
+	if (bootaddr &&
+		bootaddr != RZN1_SYSCTRL_REG_BOOTADDR &&
+		bootaddr != (RZN1_SYSTEM_CTRL_BASE+RZN1_SYSCTRL_REG_BOOTADDR)) {
+
+		pr_info("RZ/N1 CPU#2 boot address %08x\n", bootaddr);
+		pen2_base = ioremap(bootaddr, 8);
+
+		if (!pen2_base)
+			pr_warn("Couldn't map RZ/N1 CPU#2 PEN2\n");
+		return;
+	}
+	pr_info("RZ/N1 CPU#2 boot address not specified - using SYSCTRL reg\n");
+}
+
+static int __init rzn1_smp_boot_secondary(unsigned int cpu,
+				    struct task_struct *idle)
+{
+	u32 t = (u32)virt_to_phys(secondary_startup);
+
+	/* Inform on what is the second CPU boot address */
+	if (pen2_base && (readl(pen2_base + 4) == BOOTADDR2_CANARY))
+		pr_info("RZ/N1 CPU#%d writing %08x to boot address\n", cpu, t);
+	else
+		pr_info("RZ/N1 CPU#%d writing %08x to SYSCTRL reg\n", cpu, t);
+
+	spin_lock(&cpu_lock);
+
+	/* Set CPU boot address */
+	if (pen2_base && (readl(pen2_base + 4) == BOOTADDR2_CANARY))
+		writel(virt_to_phys(secondary_startup), pen2_base);
+	else
+		rzn1_sysctrl_writel(virt_to_phys(secondary_startup),
+			RZN1_SYSCTRL_REG_BOOTADDR);
+
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	spin_unlock(&cpu_lock);
+
+	return 0;
+}
+
+const struct smp_operations rzn1_smp_ops __initconst = {
+	.smp_prepare_cpus	= rzn1_smp_prepare_cpus,
+	.smp_boot_secondary	= rzn1_smp_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(rzn1_smp, "renesas,r9a06g032", &rzn1_smp_ops);
-- 
2.7.4
