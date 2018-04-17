Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDQMxB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:53:01 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:63586 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753073AbeDQMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:52:59 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="277046832"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlo Caione <carlo@endlessm.com>, Juri Lelli <juri.lelli@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] arm: shmobile: Add the RZ/N1D SMP enabler driver
Date: Tue, 17 Apr 2018 13:48:01 +0100
Message-Id: <1523969291-41756-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1D second CA7 is parked in a ROM pen at boot time, it
requires a special enable method to get it started.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c | 85 ++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 1939f52..d7fc98f 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
+smp-$(CONFIG_ARCH_R9A06G032)	+= smp-r9a06g032.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c b/arch/arm/mach-shmobile/smp-r9a06g032.c
new file mode 100644
index 0000000..a536e89
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/N1D Second CA7 enabler.
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
+ * Derived from action,s500-smp
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+/*
+ * The second CPU is parked in ROM at boot time. It requires waking it after
+ * writing an address into the BOOTADDR register of sysctrl.
+ *
+ * So the default value of the "cpu-release-addr" corresponds to BOOTADDR...
+ *
+ * *However* the BOOTADDR register is not available when the kernel
+ * starts in NONSEC mode.
+ *
+ * So for NONSEC mode, the bootloader re-parks the second CPU into a pen
+ * in SRAM, and changes the "cpu-release-addr" of linux's DT to a SRAM address,
+ * which is not restricted.
+ */
+
+static void __iomem *cpu_bootaddr;
+
+static DEFINE_SPINLOCK(cpu_lock);
+
+static int rzn1_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (!cpu_bootaddr)
+		return -ENODEV;
+
+	spin_lock(&cpu_lock);
+
+	writel(__pa_symbol(secondary_startup), cpu_bootaddr);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	spin_unlock(&cpu_lock);
+
+	return 0;
+}
+
+static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *dn;
+	int ret;
+	u32 bootaddr;
+
+	dn = of_get_cpu_node(1, NULL);
+	if (!dn) {
+		pr_err("CPU#1: missing device tree node\n");
+		return;
+	}
+	/*
+	 * Determine the address from which the CPU is polling.
+	 * The bootloader *does* change this property
+	 */
+	ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
+	of_node_put(dn);
+	if (ret) {
+		pr_err("CPU#1: invalid cpu-release-addr property\n");
+		return;
+	}
+	pr_info("CPU#1: cpu-release-addr %08x\n", (u32)bootaddr);
+
+	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
+	if (!cpu_bootaddr)
+		pr_err("CPU#1: cpu-release-addr map failed\n");
+}
+
+static const struct smp_operations rzn1_smp_ops __initconst = {
+	.smp_prepare_cpus = rzn1_smp_prepare_cpus,
+	.smp_boot_secondary = rzn1_smp_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(rzn1_smp, "renesas,r9a06g032-smp", &rzn1_smp_ops);
-- 
2.7.4
