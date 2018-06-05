Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeFELek (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:34:40 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:58304 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751534AbeFELei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:34:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,478,1520866800";
   d="scan'208";a="283089225"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Carlo Caione <carlo@endlessm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
Date: Tue,  5 Jun 2018 12:28:47 +0100
Message-Id: <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
requires a special enable method to get it started.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c | 79 ++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
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
index 0000000..cd40e6e
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * R9A06G032 Second CA7 enabler.
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
+ * Derived from action,s500-smp
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
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
+static int r9a06g032_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
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
+static void __init r9a06g032_smp_prepare_cpus(unsigned int max_cpus)
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
+	pr_info("CPU#1: cpu-release-addr %08x\n", bootaddr);
+
+	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
+}
+
+static const struct smp_operations r9a06g032_smp_ops __initconst = {
+	.smp_prepare_cpus = r9a06g032_smp_prepare_cpus,
+	.smp_boot_secondary = r9a06g032_smp_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(r9a06g032_smp, "renesas,r9a06g032-smp", &r9a06g032_smp_ops);
-- 
2.7.4
