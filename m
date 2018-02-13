Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965742AbeBMUK1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:10:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46227 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965625AbeBMUKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:10:11 -0500
X-Google-Smtp-Source: AH8x2271Sf22jbUtBVGAe7kB2n9t40bZWojPLPeJMH/6vORj1//8KWuRPtC2//AWYzkSpPkpBtrLzg==
From: Brendan Higgins <brendanhiggins@google.com>
To: robh+dt@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        tmaimon77@gmail.com, avifishman70@gmail.com, f.fainelli@gmail.com,
        julien.thierry@arm.com, pombredanne@nexb.com, arnd@arndb.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v10 1/3] arm: npcm: add basic support for Nuvoton BMCs
Date: Tue, 13 Feb 2018 12:09:57 -0800
Message-Id: <20180213200959.160157-2-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180213200959.160157-1-brendanhiggins@google.com>
References: <20180213200959.160157-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds basic support for the Nuvoton NPCM750 BMC.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
Tested-by: Tomer Maimon <tmaimon77@gmail.com>
Tested-by: Avi Fishman <avifishman70@gmail.com>
---
 arch/arm/Kconfig             |  2 ++
 arch/arm/Makefile            |  1 +
 arch/arm/mach-npcm/Kconfig   | 48 ++++++++++++++++++++++++++
 arch/arm/mach-npcm/Makefile  |  3 ++
 arch/arm/mach-npcm/headsmp.S | 17 ++++++++++
 arch/arm/mach-npcm/npcm7xx.c | 20 +++++++++++
 arch/arm/mach-npcm/platsmp.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 172 insertions(+)
 create mode 100644 arch/arm/mach-npcm/Kconfig
 create mode 100644 arch/arm/mach-npcm/Makefile
 create mode 100644 arch/arm/mach-npcm/headsmp.S
 create mode 100644 arch/arm/mach-npcm/npcm7xx.c
 create mode 100644 arch/arm/mach-npcm/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 61a0cb15067e..05543f1cfbde 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -782,6 +782,8 @@ source "arch/arm/mach-netx/Kconfig"
 
 source "arch/arm/mach-nomadik/Kconfig"
 
+source "arch/arm/mach-npcm/Kconfig"
+
 source "arch/arm/mach-nspire/Kconfig"
 
 source "arch/arm/plat-omap/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1ab08d2..60ca50c7d762 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -191,6 +191,7 @@ machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
 machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
+machine-$(CONFIG_ARCH_NPCM)		+= npcm
 machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
 machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
new file mode 100644
index 000000000000..6ff9df2636be
--- /dev/null
+++ b/arch/arm/mach-npcm/Kconfig
@@ -0,0 +1,48 @@
+menuconfig ARCH_NPCM
+	bool "Nuvoton NPCM Architecture"
+	select ARCH_REQUIRE_GPIOLIB
+	select USE_OF
+	select PINCTRL
+	select PINCTRL_NPCM7XX
+
+if ARCH_NPCM
+
+comment "NPCM7XX CPU type"
+
+config ARCH_NPCM750
+	depends on ARCH_NPCM && ARCH_MULTI_V7
+	bool "Support for NPCM750 BMC CPU (Poleg)"
+	select CACHE_L2X0
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_SMP
+	select SMP
+	select SMP_ON_UP
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369
+	select ARM_ERRATA_794072
+	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
+	select USB_EHCI_ROOT_HUB_TT
+	select USB_ARCH_HAS_HCD
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_HCD
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_HCD
+	select USB
+	select FIQ
+	select CPU_USE_DOMAINS
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select COMMON_CLK if OF
+	select NPCM750_TIMER
+	select MFD_SYSCON
+	help
+	  Support for NPCM750 BMC CPU (Poleg).
+
+	  Nuvoton NPCM750 BMC based on the Cortex A9.
+
+endif
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
new file mode 100644
index 000000000000..c7a1316d27c1
--- /dev/null
+++ b/arch/arm/mach-npcm/Makefile
@@ -0,0 +1,3 @@
+AFLAGS_headsmp.o		+= -march=armv7-a
+
+obj-$(CONFIG_ARCH_NPCM750)	+= npcm7xx.o platsmp.o headsmp.o
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
index 000000000000..5f7cd88103ef
--- /dev/null
+++ b/arch/arm/mach-npcm/npcm7xx.c
@@ -0,0 +1,20 @@
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
+	NULL
+};
+
+DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
+	.atag_offset	= 0x100,
+	.dt_compat	= npcm7xx_dt_match,
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
2.16.0.rc1.238.g530d649a79-goog
