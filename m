Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeEROjg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:39:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54172 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751909AbeEROjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:39:33 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3 4/5] ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
Date: Fri, 18 May 2018 15:39:12 +0100
Message-Id: <20180518143913.26306-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing stopping the PMUv3 driver from compiling on 32bit
is the lack of defined system registers names. This is easily
solved by providing the sysreg accessors and updating the Kconfig entry.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h | 125 +++++++++++++++++++++++++++++++++++++++
 drivers/perf/Kconfig             |   4 +-
 2 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
new file mode 100644
index 000000000000..e0f66c1d42b4
--- /dev/null
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_PMUV3_H
+#define __ASM_PMUV3_H
+
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+
+#define PMCCNTR		__ACCESS_CP15_64(0, c9)
+
+#define PMCR		__ACCESS_CP15(c9, 0, c12, 0)
+#define PMCNTENSET	__ACCESS_CP15(c9, 0, c12, 1)
+#define PMCNTENCLR	__ACCESS_CP15(c9, 0, c12, 2)
+#define PMOVSR		__ACCESS_CP15(c9, 0, c12, 3)
+#define PMSELR		__ACCESS_CP15(c9, 0, c12, 5)
+#define PMCEID0		__ACCESS_CP15(c9, 0, c12, 6)
+#define PMCEID1		__ACCESS_CP15(c9, 0, c12, 7)
+#define PMXEVTYPER	__ACCESS_CP15(c9, 0, c13, 1)
+#define PMXEVCNTR	__ACCESS_CP15(c9, 0, c13, 2)
+#define PMINTENSET	__ACCESS_CP15(c9, 0, c14, 1)
+#define PMINTENCLR	__ACCESS_CP15(c9, 0, c14, 2)
+
+static inline int read_pmuver(void)
+{
+	/* PMUVers is not a signed field */
+	u32 dfr0 = read_cpuid_ext(CPUID_EXT_DFR0);
+	return (dfr0 >> 24) & 0xf;
+}
+
+static inline void write_pmcr(u32 val)
+{
+	write_sysreg(val, PMCR);
+}
+
+static inline u32 read_pmcr(void)
+{
+	return read_sysreg(PMCR);
+}
+
+static inline void write_pmselr(u32 val)
+{
+	write_sysreg(val, PMSELR);
+}
+
+static inline void write_pmccntr(u64 val)
+{
+	write_sysreg(val, PMCCNTR);
+}
+
+static inline u64 read_pmccntr(void)
+{
+	return read_sysreg(PMCCNTR);
+}
+
+static inline void write_pmxevcntr(u32 val)
+{
+	write_sysreg(val, PMXEVCNTR);
+}
+
+static inline u32 read_pmxevcntr(void)
+{
+	return read_sysreg(PMXEVCNTR);
+}
+
+static inline void write_pmxevtyper(u32 val)
+{
+	write_sysreg(val, PMXEVTYPER);
+}
+
+static inline void write_pmcntenset(u32 val)
+{
+	write_sysreg(val, PMCNTENSET);
+}
+
+static inline void write_pmcntenclr(u32 val)
+{
+	write_sysreg(val, PMCNTENCLR);
+}
+
+static inline void write_pmintenset(u32 val)
+{
+	write_sysreg(val, PMINTENSET);
+}
+
+static inline void write_pmintenclr(u32 val)
+{
+	write_sysreg(val, PMINTENCLR);
+}
+
+static inline void write_pmovsclr(u32 val)
+{
+	write_sysreg(val, PMOVSR);
+}
+
+static inline u32 read_pmovsclr(void)
+{
+	return read_sysreg(PMOVSR);
+}
+
+static inline u32 read_pmceid0(void)
+{
+	return read_sysreg(PMCEID0);
+}
+
+static inline u32 read_pmceid1(void)
+{
+	return read_sysreg(PMCEID1);
+}
+
+#endif
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 39808b86b346..bf01dc1414c8 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -51,9 +51,9 @@ config ARM_PMU_ACPI
 	def_bool y
 
 config ARM_PMUV3
-	depends on HW_PERF_EVENTS && ARM64
+	depends on HW_PERF_EVENTS && ((ARM && CPU_V7) || ARM64)
 	bool "ARM PMUv3 support" if !ARM64
-	default y
+	default ARM64
 	help
 	  Say y if you want to use CPU performance monitors on ARMv8
 	  systems that implement the PMUv3 architecture.
-- 
2.14.2
