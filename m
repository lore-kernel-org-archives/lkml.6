Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeBTPNo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:13:44 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35933 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeBTPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:13:42 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] soc: renesas: rcar-sysc: Add R-Car M3-N support
Date: Tue, 20 Feb 2018 16:12:06 +0100
Message-Id: <1519139541-18783-5-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for R-Car M3-N (R8A77965) power areas.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

---
v1->v2:
- Remove A2VC0 power area
- Add A3VP power area
---
 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Kconfig                        |  5 +++
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a77965-sysc.c                | 37 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 include/dt-bindings/power/r8a77965-sysc.h          | 30 ++++++++++++++++++
 7 files changed, 78 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
 create mode 100644 include/dt-bindings/power/r8a77965-sysc.h

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index 8690f10..b9c9e28 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -17,6 +17,7 @@ Required properties:
       - "renesas,r8a7794-sysc" (R-Car E2)
       - "renesas,r8a7795-sysc" (R-Car H3)
       - "renesas,r8a7796-sysc" (R-Car M3-W)
+      - "renesas,r8a77965-sysc" (R-Car M3-N)
       - "renesas,r8a77970-sysc" (R-Car V3M)
       - "renesas,r8a77995-sysc" (R-Car D3)
   - reg: Address start and address range for the device.
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 741b7cd..c262a4b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -14,6 +14,7 @@ config SOC_RENESAS
 	select SYSC_R8A7794 if ARCH_R8A7794
 	select SYSC_R8A7795 if ARCH_R8A7795
 	select SYSC_R8A7796 if ARCH_R8A7796
+	select SYSC_R8A77965 if ARCH_R8A77965
 	select SYSC_R8A77970 if ARCH_R8A77970
 	select SYSC_R8A77995 if ARCH_R8A77995
 
@@ -56,6 +57,10 @@ config SYSC_R8A7796
 	bool "R-Car M3-W System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A77965
+	bool "R-Car M3-N System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A77970
 	bool "R-Car V3M System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 845d62a..9f360b8 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
 obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
 obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
 obj-$(CONFIG_SYSC_R8A7796)	+= r8a7796-sysc.o
+obj-$(CONFIG_SYSC_R8A77965)	+= r8a77965-sysc.o
 obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
 obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
 
diff --git a/drivers/soc/renesas/r8a77965-sysc.c b/drivers/soc/renesas/r8a77965-sysc.c
new file mode 100644
index 0000000..d7f7928
--- /dev/null
+++ b/drivers/soc/renesas/r8a77965-sysc.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas R-Car M3-N System Controller
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ *
+ * Based on Renesas R-Car M3-W System Controller
+ * Copyright (C) 2016 Glider bvba
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a77965-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a77965_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A77965_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca57-scu",	0x1c0, 0, R8A77965_PD_CA57_SCU,	R8A77965_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca57-cpu0",	 0x80, 0, R8A77965_PD_CA57_CPU0, R8A77965_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca57-cpu1",	 0x80, 1, R8A77965_PD_CA57_CPU1, R8A77965_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "cr7",	0x240, 0, R8A77965_PD_CR7,	R8A77965_PD_ALWAYS_ON },
+	{ "a3vc",	0x380, 0, R8A77965_PD_A3VC,	R8A77965_PD_ALWAYS_ON },
+	{ "a3vp",	0x340, 0, R8A77965_PD_A3VP,	R8A77965_PD_ALWAYS_ON },
+	{ "a2vc1",	0x3c0, 1, R8A77965_PD_A2VC1,	R8A77965_PD_A3VC },
+	{ "3dg-a",	0x100, 0, R8A77965_PD_3DG_A,	R8A77965_PD_ALWAYS_ON },
+	{ "3dg-b",	0x100, 1, R8A77965_PD_3DG_B,	R8A77965_PD_3DG_A },
+	{ "a3ir",	0x180, 0, R8A77965_PD_A3IR,	R8A77965_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a77965_sysc_info __initconst = {
+	.areas = r8a77965_areas,
+	.num_areas = ARRAY_SIZE(r8a77965_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 636872b..d87f83a 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -284,6 +284,9 @@ static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #ifdef CONFIG_SYSC_R8A7796
 	{ .compatible = "renesas,r8a7796-sysc", .data = &r8a7796_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A77965
+	{ .compatible = "renesas,r8a77965-sysc", .data = &r8a77965_sysc_info },
+#endif
 #ifdef CONFIG_SYSC_R8A77970
 	{ .compatible = "renesas,r8a77970-sysc", .data = &r8a77970_sysc_info },
 #endif
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 9d9daf9..c892105 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -58,6 +58,7 @@ extern const struct rcar_sysc_info r8a7792_sysc_info;
 extern const struct rcar_sysc_info r8a7794_sysc_info;
 extern const struct rcar_sysc_info r8a7795_sysc_info;
 extern const struct rcar_sysc_info r8a7796_sysc_info;
+extern const struct rcar_sysc_info r8a77965_sysc_info;
 extern const struct rcar_sysc_info r8a77970_sysc_info;
 extern const struct rcar_sysc_info r8a77995_sysc_info;
 
diff --git a/include/dt-bindings/power/r8a77965-sysc.h b/include/dt-bindings/power/r8a77965-sysc.h
new file mode 100644
index 0000000..05a4b59
--- /dev/null
+++ b/include/dt-bindings/power/r8a77965-sysc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ * Copyright (C) 2016 Glider bvba
+ */
+
+#ifndef __DT_BINDINGS_POWER_R8A77965_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A77965_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A77965_PD_CA57_CPU0		 0
+#define R8A77965_PD_CA57_CPU1		 1
+#define R8A77965_PD_A3VP		 9
+#define R8A77965_PD_CA57_SCU		12
+#define R8A77965_PD_CR7			13
+#define R8A77965_PD_A3VC		14
+#define R8A77965_PD_3DG_A		17
+#define R8A77965_PD_3DG_B		18
+#define R8A77965_PD_A3IR		24
+#define R8A77965_PD_A2VC1		26
+
+/* Always-on power area */
+#define R8A77965_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A77965_SYSC_H__ */
-- 
2.7.4
