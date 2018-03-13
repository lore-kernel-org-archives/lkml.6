Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeCMNeL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:34:11 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57812 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752254AbeCMNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:34:06 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        brendanhiggins@google.com, avifishman70@gmail.com,
        julien.thierry@arm.com, pombredanne@nexb.com, arnd@arndb.de,
        olof@lixom.net, khilman@kernel.org, joel@jms.id.au
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v12 1/3] arm: npcm: add basic support for Nuvoton BMCs
Date: Tue, 13 Mar 2018 15:32:09 +0200
Message-Id: <1520947931-15426-2-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1520947931-15426-1-git-send-email-tmaimon77@gmail.com>
References: <1520947931-15426-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds basic support for the Nuvoton NPCM750 BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
Tested-by: Avi Fishman <avifishman70@gmail.com>
---
 arch/arm/Kconfig             |  2 ++
 arch/arm/Makefile            |  1 +
 arch/arm/mach-npcm/Kconfig   | 30 ++++++++++++++++
 arch/arm/mach-npcm/Makefile  |  6 ++++
 arch/arm/mach-npcm/headsmp.S | 17 ++++++++++
 arch/arm/mach-npcm/npcm7xx.c | 23 +++++++++++++
 arch/arm/mach-npcm/platsmp.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 160 insertions(+)
 create mode 100644 arch/arm/mach-npcm/Kconfig
 create mode 100644 arch/arm/mach-npcm/Makefile
 create mode 100644 arch/arm/mach-npcm/headsmp.S
 create mode 100644 arch/arm/mach-npcm/npcm7xx.c
 create mode 100644 arch/arm/mach-npcm/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d53575486..6a8404cd5150 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -779,6 +779,8 @@ source "arch/arm/mach-netx/Kconfig"
 
 source "arch/arm/mach-nomadik/Kconfig"
 
+source "arch/arm/mach-npcm/Kconfig"
+
 source "arch/arm/mach-nspire/Kconfig"
 
 source "arch/arm/plat-omap/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e83f5161fdd8..e4e537f27339 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -196,6 +196,7 @@ machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
 machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
+machine-$(CONFIG_ARCH_NPCM)		+= npcm
 machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
 machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
new file mode 100644
index 000000000000..684c9c9a32bd
--- /dev/null
+++ b/arch/arm/mach-npcm/Kconfig
@@ -0,0 +1,30 @@
+menuconfig ARCH_NPCM
+	bool "Nuvoton NPCM Architecture"
+	depends on ARCH_MULTI_V7
+	select PINCTRL
+
+if ARCH_NPCM
+
+config ARCH_NPCM7XX
+	bool "Support for NPCM7xx BMC (Poleg)"
+	depends on ARCH_MULTI_V7
+	select PINCTRL_NPCM7XX
+	select NPCM7XX_TIMER
+	select ARCH_REQUIRE_GPIOLIB
+	select CACHE_L2X0
+	select ARM_GIC
+	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_794072
+	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
+	select MFD_SYSCON
+	help
+	  General support for NPCM7xx BMC (Poleg).
+
+	  Nuvoton NPCM7xx BMC based on the Cortex A9.
+
+endif
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
new file mode 100644
index 000000000000..227aebbfeb40
--- /dev/null
+++ b/arch/arm/mach-npcm/Makefile
@@ -0,0 +1,6 @@
+AFLAGS_headsmp.o		+= -march=armv7-a
+
+obj-$(CONFIG_ARCH_NPCM7XX)	+= npcm7xx.o
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+
+
diff --git a/arch/arm/mach-npcm/headsmp.S b/arch/arm/mach-npcm/headsmp.S
new file mode 100644
index 000000000000..c083fe09a07b
--- /dev/null
+++ b/arch/arm/mach-npcm/headsmp.S
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology corporation.
+// Copyright 2018 Google, Inc.
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/assembler.h>
+
+/*
+ * The boot ROM does not start secondary CPUs in SVC mode, so we need to do that
+ * here.
+ */
+ENTRY(npcm7xx_secondary_startup)
+	safe_svcmode_maskall r0
+
+	b	secondary_startup
+ENDPROC(npcm7xx_secondary_startup)
diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
new file mode 100644
index 000000000000..a039dc755561
--- /dev/null
+++ b/arch/arm/mach-npcm/npcm7xx.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology corporation.
+// Copyright 2018 Google, Inc.
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <asm/mach/map.h>
+#include <asm/hardware/cache-l2x0.h>
+
+static const char *const npcm7xx_dt_match[] = {
+	"nuvoton,npcm750",
+	"nuvoton,npcm730",
+	NULL
+};
+
+DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
+	.atag_offset	= 0x100,
+	.dt_compat	= npcm7xx_dt_match,
+	.l2c_aux_val	= 0x0,
+	.l2c_aux_mask	= ~0x0,
+MACHINE_END
diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
new file mode 100644
index 000000000000..21633c70fe7f
--- /dev/null
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology corporation.
+// Copyright 2018 Google, Inc.
+
+#define pr_fmt(fmt) "nuvoton,npcm7xx-smp: " fmt
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <asm/cacheflush.h>
+#include <asm/smp.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#define NPCM7XX_SCRPAD_REG 0x13c
+
+extern void npcm7xx_secondary_startup(void);
+
+static int npcm7xx_smp_boot_secondary(unsigned int cpu,
+				      struct task_struct *idle)
+{
+	struct device_node *gcr_np;
+	void __iomem *gcr_base;
+	int ret = 0;
+
+	gcr_np = of_find_compatible_node(NULL, NULL, "nuvoton,npcm750-gcr");
+	if (!gcr_np) {
+		pr_err("no gcr device node\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	gcr_base = of_iomap(gcr_np, 0);
+	if (!gcr_base) {
+		pr_err("could not iomap gcr");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* give boot ROM kernel start address. */
+	iowrite32(__pa_symbol(npcm7xx_secondary_startup), gcr_base +
+		  NPCM7XX_SCRPAD_REG);
+	/* make sure the previous write is seen by all observers. */
+	dsb_sev();
+
+	iounmap(gcr_base);
+out:
+	return ret;
+}
+
+static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *scu_np;
+	void __iomem *scu_base;
+
+	scu_np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	if (!scu_np) {
+		pr_err("no scu device node\n");
+		return;
+	}
+	scu_base = of_iomap(scu_np, 0);
+	if (!scu_base) {
+		pr_err("could not iomap scu");
+		return;
+	}
+
+	scu_enable(scu_base);
+
+	iounmap(scu_base);
+}
+
+static struct smp_operations npcm7xx_smp_ops __initdata = {
+	.smp_prepare_cpus = npcm7xx_smp_prepare_cpus,
+	.smp_boot_secondary = npcm7xx_smp_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(npcm7xx_smp, "nuvoton,npcm750-smp", &npcm7xx_smp_ops);
-- 
2.14.1
