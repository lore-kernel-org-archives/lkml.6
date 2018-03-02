Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933814AbeCBWuF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:50:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52397 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933561AbeCBWtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:49:21 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 5/6] MIPS: generic: Add support for Microsemi Ocelot
Date: Fri,  2 Mar 2018 23:48:10 +0100
Message-Id: <20180302224811.26840-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for the MIPS based Microsemi Ocelot SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/Makefile                            |  4 ++
 arch/mips/configs/generic/board-ocelot.config | 40 +++++++++++++
 arch/mips/generic/Kconfig                     | 17 ++++++
 arch/mips/generic/Makefile                    |  1 +
 arch/mips/generic/board-ocelot.c              | 83 +++++++++++++++++++++++++++
 5 files changed, 145 insertions(+)
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/generic/board-ocelot.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d1ca839c3981..d2882244cf1f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -543,6 +543,10 @@ generic_defconfig:
 # now that the boards have been converted to use the generic kernel they are
 # wrappers around the generic rules above.
 #
+.PHONY: ocelot_defconfig
+ocelot_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=ocelot
+
 .PHONY: sead3_defconfig
 sead3_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=sead-3
diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
new file mode 100644
index 000000000000..7f9e1eaccc34
--- /dev/null
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -0,0 +1,40 @@
+# require CONFIG_32BIT=y
+
+CONFIG_LEGACY_BOARD_OCELOT=y
+
+CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
+
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
+
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+
+CONFIG_GPIO_SYSFS=y
+
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_SPIDEV=y
+
+CONFIG_POWER_RESET=y
+
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 2ff3b17bfab1..04b8d2262f9d 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -27,6 +27,23 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
+comment "MSCC Ocelot doesn't work with SEAD3 enabled"
+       depends on LEGACY_BOARD_SEAD3
+
+config LEGACY_BOARD_OCELOT
+	bool "Support MSCC Ocelot boards"
+	depends on LEGACY_BOARD_SEAD3=n
+	select LEGACY_BOARDS
+	select MSCC_OCELOT
+
+config MSCC_OCELOT
+	bool
+	select DMA_NONCOHERENT
+	select GPIOLIB
+	select MSCC_OCELOT_IRQ
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+
 comment "FIT/UHI Boards"
 
 config FIT_IMAGE_FDT_BOSTON
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index 5c31e0c4697d..d03a36f869a4 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -14,5 +14,6 @@ obj-y += proc.o
 
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
+obj-$(CONFIG_LEGACY_BOARD_OCELOT)	+= board-ocelot.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
 obj-$(CONFIG_VIRT_BOARD_RANCHU)		+= board-ranchu.o
diff --git a/arch/mips/generic/board-ocelot.c b/arch/mips/generic/board-ocelot.c
new file mode 100644
index 000000000000..752c6edbe1d5
--- /dev/null
+++ b/arch/mips/generic/board-ocelot.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi MIPS SoC support
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <asm/machine.h>
+#include <asm/prom.h>
+
+#define DEVCPU_GCB_CHIP_REGS_CHIP_ID	0x71070000
+#define CHIP_ID_PART_ID			GENMASK(27, 12)
+
+#define OCELOT_PART_ID			(0x7514 << 12)
+
+#define UART_UART			0x70100000
+
+static __init bool ocelot_detect(void)
+{
+	u32 rev;
+
+	rev = __raw_readl((void *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);
+
+	if ((rev & CHIP_ID_PART_ID) != OCELOT_PART_ID)
+		return 0;
+
+	/* Copy command line from bootloader early for Initrd detection */
+	if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) == 0x80000000) {
+		unsigned int prom_argc = fw_arg0;
+		const char **prom_argv = (const char **)fw_arg1;
+
+		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
+			/* ignore all built-in args if any f/w args given */
+			strcpy(arcs_cmdline, prom_argv[1]);
+	}
+
+	return 1;
+}
+
+static __init unsigned int ocelot_measure_hpt_freq(void)
+{
+	struct device_node *np;
+	u32 freq;
+
+	np = of_find_node_by_name(NULL, "cpus");
+	if (!np)
+		panic("missing 'cpus' DT node");
+	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
+		panic("missing 'mips-hpt-frequency' property");
+	of_node_put(np);
+
+	return freq;
+}
+
+static void __init ocelot_earlyprintk_init(void)
+{
+	void __iomem *uart_base;
+
+	uart_base = ioremap_nocache(UART_UART, 0x20);
+	setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
+}
+
+static void __init ocelot_late_init(void)
+{
+	ocelot_earlyprintk_init();
+}
+
+static __init const void *ocelot_fixup_fdt(const void *fdt,
+					   const void *match_data)
+{
+	/* This has to be done so late because ioremap needs to work */
+	late_time_init = ocelot_late_init;
+
+	return fdt;
+}
+
+extern char __dtb_ocelot_pcb123_begin[];
+
+MIPS_MACHINE(ocelot) = {
+	.fdt = __dtb_ocelot_pcb123_begin,
+	.fixup_fdt = ocelot_fixup_fdt,
+	.detect = ocelot_detect,
+	.measure_hpt_freq = ocelot_measure_hpt_freq,
+};
-- 
2.16.2
