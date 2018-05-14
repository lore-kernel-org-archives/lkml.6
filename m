Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeENNMW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:12:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbeENNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:12:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A97D760D81
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v6 01/14] soc: qcom: Separate kryo l2 accessors from PMU driver
Date: Mon, 14 May 2018 16:11:47 +0300
Message-Id: <1526303520-5843-2-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver provides kernel level API for other drivers
to access the MSM8996 L2 cache registers.
Separating the L2 access code from the PMU driver and
making it public to allow other drivers use it.
The accesses must be separated with a single spinlock,
maintained in this driver.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/perf/Kconfig                 |  1 +
 drivers/perf/qcom_l2_pmu.c           | 90 ++++++++++--------------------------
 drivers/soc/qcom/Kconfig             |  3 ++
 drivers/soc/qcom/Makefile            |  1 +
 drivers/soc/qcom/kryo-l2-accessors.c | 65 ++++++++++++++++++++++++++
 include/soc/qcom/kryo-l2-accessors.h | 21 +++++++++
 6 files changed, 115 insertions(+), 66 deletions(-)
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 28bb5a0..561252a 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -69,6 +69,7 @@ config HISI_PMU
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
+	select QCOM_KRYO_L2_ACCESSORS
 	  help
 	  Provides support for the L2 cache performance monitor unit (PMU)
 	  in Qualcomm Technologies processors.
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 842135c..cc31f51 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -31,6 +31,7 @@
 #include <asm/barrier.h>
 #include <asm/local64.h>
 #include <asm/sysreg.h>
+#include <soc/qcom/kryo-l2-accessors.h>
 
 #define MAX_L2_CTRS             9
 
@@ -87,8 +88,6 @@
 #define L2_COUNTER_RELOAD       BIT_ULL(31)
 #define L2_CYCLE_COUNTER_RELOAD BIT_ULL(63)
 
-#define L2CPUSRSELR_EL1         sys_reg(3, 3, 15, 0, 6)
-#define L2CPUSRDR_EL1           sys_reg(3, 3, 15, 0, 7)
 
 #define reg_idx(reg, i)         (((i) * IA_L2_REG_OFFSET) + reg##_BASE)
 
@@ -107,48 +106,7 @@
 #define L2_EVENT_STREX                     0x421
 #define L2_EVENT_CLREX                     0x422
 
-static DEFINE_RAW_SPINLOCK(l2_access_lock);
 
-/**
- * set_l2_indirect_reg: write value to an L2 register
- * @reg: Address of L2 register.
- * @value: Value to be written to register.
- *
- * Use architecturally required barriers for ordering between system register
- * accesses
- */
-static void set_l2_indirect_reg(u64 reg, u64 val)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2_access_lock, flags);
-	write_sysreg_s(reg, L2CPUSRSELR_EL1);
-	isb();
-	write_sysreg_s(val, L2CPUSRDR_EL1);
-	isb();
-	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
-}
-
-/**
- * get_l2_indirect_reg: read an L2 register value
- * @reg: Address of L2 register.
- *
- * Use architecturally required barriers for ordering between system register
- * accesses
- */
-static u64 get_l2_indirect_reg(u64 reg)
-{
-	u64 val;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2_access_lock, flags);
-	write_sysreg_s(reg, L2CPUSRSELR_EL1);
-	isb();
-	val = read_sysreg_s(L2CPUSRDR_EL1);
-	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
-
-	return val;
-}
 
 struct cluster_pmu;
 
@@ -219,28 +177,28 @@ static inline struct cluster_pmu *get_cluster_pmu(
 static void cluster_pmu_reset(void)
 {
 	/* Reset all counters */
-	set_l2_indirect_reg(L2PMCR, L2PMCR_RESET_ALL);
-	set_l2_indirect_reg(L2PMCNTENCLR, l2_counter_present_mask);
-	set_l2_indirect_reg(L2PMINTENCLR, l2_counter_present_mask);
-	set_l2_indirect_reg(L2PMOVSCLR, l2_counter_present_mask);
+	kryo_l2_set_indirect_reg(L2PMCR, L2PMCR_RESET_ALL);
+	kryo_l2_set_indirect_reg(L2PMCNTENCLR, l2_counter_present_mask);
+	kryo_l2_set_indirect_reg(L2PMINTENCLR, l2_counter_present_mask);
+	kryo_l2_set_indirect_reg(L2PMOVSCLR, l2_counter_present_mask);
 }
 
 static inline void cluster_pmu_enable(void)
 {
-	set_l2_indirect_reg(L2PMCR, L2PMCR_COUNTERS_ENABLE);
+	kryo_l2_set_indirect_reg(L2PMCR, L2PMCR_COUNTERS_ENABLE);
 }
 
 static inline void cluster_pmu_disable(void)
 {
-	set_l2_indirect_reg(L2PMCR, L2PMCR_COUNTERS_DISABLE);
+	kryo_l2_set_indirect_reg(L2PMCR, L2PMCR_COUNTERS_DISABLE);
 }
 
 static inline void cluster_pmu_counter_set_value(u32 idx, u64 value)
 {
 	if (idx == l2_cycle_ctr_idx)
-		set_l2_indirect_reg(L2PMCCNTR, value);
+		kryo_l2_set_indirect_reg(L2PMCCNTR, value);
 	else
-		set_l2_indirect_reg(reg_idx(IA_L2PMXEVCNTR, idx), value);
+		kryo_l2_set_indirect_reg(reg_idx(IA_L2PMXEVCNTR, idx), value);
 }
 
 static inline u64 cluster_pmu_counter_get_value(u32 idx)
@@ -248,46 +206,46 @@ static inline u64 cluster_pmu_counter_get_value(u32 idx)
 	u64 value;
 
 	if (idx == l2_cycle_ctr_idx)
-		value = get_l2_indirect_reg(L2PMCCNTR);
+		value = kryo_l2_get_indirect_reg(L2PMCCNTR);
 	else
-		value = get_l2_indirect_reg(reg_idx(IA_L2PMXEVCNTR, idx));
+		value = kryo_l2_get_indirect_reg(reg_idx(IA_L2PMXEVCNTR, idx));
 
 	return value;
 }
 
 static inline void cluster_pmu_counter_enable(u32 idx)
 {
-	set_l2_indirect_reg(L2PMCNTENSET, idx_to_reg_bit(idx));
+	kryo_l2_set_indirect_reg(L2PMCNTENSET, idx_to_reg_bit(idx));
 }
 
 static inline void cluster_pmu_counter_disable(u32 idx)
 {
-	set_l2_indirect_reg(L2PMCNTENCLR, idx_to_reg_bit(idx));
+	kryo_l2_set_indirect_reg(L2PMCNTENCLR, idx_to_reg_bit(idx));
 }
 
 static inline void cluster_pmu_counter_enable_interrupt(u32 idx)
 {
-	set_l2_indirect_reg(L2PMINTENSET, idx_to_reg_bit(idx));
+	kryo_l2_set_indirect_reg(L2PMINTENSET, idx_to_reg_bit(idx));
 }
 
 static inline void cluster_pmu_counter_disable_interrupt(u32 idx)
 {
-	set_l2_indirect_reg(L2PMINTENCLR, idx_to_reg_bit(idx));
+	kryo_l2_set_indirect_reg(L2PMINTENCLR, idx_to_reg_bit(idx));
 }
 
 static inline void cluster_pmu_set_evccntcr(u32 val)
 {
-	set_l2_indirect_reg(L2PMCCNTCR, val);
+	kryo_l2_set_indirect_reg(L2PMCCNTCR, val);
 }
 
 static inline void cluster_pmu_set_evcntcr(u32 ctr, u32 val)
 {
-	set_l2_indirect_reg(reg_idx(IA_L2PMXEVCNTCR, ctr), val);
+	kryo_l2_set_indirect_reg(reg_idx(IA_L2PMXEVCNTCR, ctr), val);
 }
 
 static inline void cluster_pmu_set_evtyper(u32 ctr, u32 val)
 {
-	set_l2_indirect_reg(reg_idx(IA_L2PMXEVTYPER, ctr), val);
+	kryo_l2_set_indirect_reg(reg_idx(IA_L2PMXEVTYPER, ctr), val);
 }
 
 static void cluster_pmu_set_resr(struct cluster_pmu *cluster,
@@ -303,11 +261,11 @@ static void cluster_pmu_set_resr(struct cluster_pmu *cluster,
 
 	spin_lock_irqsave(&cluster->pmu_lock, flags);
 
-	resr_val = get_l2_indirect_reg(L2PMRESR);
+	resr_val = kryo_l2_get_indirect_reg(L2PMRESR);
 	resr_val &= ~(L2PMRESR_GROUP_MASK << shift);
 	resr_val |= field;
 	resr_val |= L2PMRESR_EN;
-	set_l2_indirect_reg(L2PMRESR, resr_val);
+	kryo_l2_set_indirect_reg(L2PMRESR, resr_val);
 
 	spin_unlock_irqrestore(&cluster->pmu_lock, flags);
 }
@@ -323,14 +281,14 @@ static inline void cluster_pmu_set_evfilter_sys_mode(u32 ctr)
 		   L2PMXEVFILTER_ORGFILTER_IDINDEP |
 		   L2PMXEVFILTER_ORGFILTER_ALL;
 
-	set_l2_indirect_reg(reg_idx(IA_L2PMXEVFILTER, ctr), val);
+	kryo_l2_set_indirect_reg(reg_idx(IA_L2PMXEVFILTER, ctr), val);
 }
 
 static inline u32 cluster_pmu_getreset_ovsr(void)
 {
-	u32 result = get_l2_indirect_reg(L2PMOVSSET);
+	u32 result = kryo_l2_get_indirect_reg(L2PMOVSSET);
 
-	set_l2_indirect_reg(L2PMOVSCLR, result);
+	kryo_l2_set_indirect_reg(L2PMOVSCLR, result);
 	return result;
 }
 
@@ -783,7 +741,7 @@ static int get_num_counters(void)
 {
 	int val;
 
-	val = get_l2_indirect_reg(L2PMCR);
+	val = kryo_l2_get_indirect_reg(L2PMCR);
 
 	/*
 	 * Read number of counters from L2PMCR and add 1
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7093fe7..0567dff 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -39,6 +39,9 @@ config QCOM_GSBI
           functions for connecting the underlying serial UART, SPI, and I2C
           devices to the output pins.
 
+config QCOM_KRYO_L2_ACCESSORS
+       bool
+
 config QCOM_MDT_LOADER
 	tristate
 	select QCOM_SCM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index cbf414c..e4d3f5a 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
+obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
diff --git a/drivers/soc/qcom/kryo-l2-accessors.c b/drivers/soc/qcom/kryo-l2-accessors.c
new file mode 100644
index 0000000..d35a860
--- /dev/null
+++ b/drivers/soc/qcom/kryo-l2-accessors.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/spinlock.h>
+#include <asm/sysreg.h>
+#include <soc/qcom/kryo-l2-accessors.h>
+
+#define L2CPUSRSELR_EL1         sys_reg(3, 3, 15, 0, 6)
+#define L2CPUSRDR_EL1           sys_reg(3, 3, 15, 0, 7)
+
+static DEFINE_RAW_SPINLOCK(l2_access_lock);
+
+/**
+ * kryo_l2_set_indirect_reg() - write value to an L2 register
+ * @reg: Address of L2 register.
+ * @value: Value to be written to register.
+ *
+ * Use architecturally required barriers for ordering between system register
+ * accesses, and system registers with respect to device memory
+ */
+void kryo_l2_set_indirect_reg(u64 reg, u64 val)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2_access_lock, flags);
+	write_sysreg_s(reg, L2CPUSRSELR_EL1);
+	isb();
+	write_sysreg_s(val, L2CPUSRDR_EL1);
+	isb();
+	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
+}
+EXPORT_SYMBOL(kryo_l2_set_indirect_reg);
+
+/**
+ * kryo_l2_get_indirect_reg() - read an L2 register value
+ * @reg: Address of L2 register.
+ *
+ * Use architecturally required barriers for ordering between system register
+ * accesses, and system registers with respect to device memory
+ */
+u64 kryo_l2_get_indirect_reg(u64 reg)
+{
+	u64 val;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2_access_lock, flags);
+	write_sysreg_s(reg, L2CPUSRSELR_EL1);
+	isb();
+	val = read_sysreg_s(L2CPUSRDR_EL1);
+	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
+
+	return val;
+}
+EXPORT_SYMBOL(kryo_l2_get_indirect_reg);
diff --git a/include/soc/qcom/kryo-l2-accessors.h b/include/soc/qcom/kryo-l2-accessors.h
new file mode 100644
index 0000000..0840e87
--- /dev/null
+++ b/include/soc/qcom/kryo-l2-accessors.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __SOC_ARCH_QCOM_KRYO_L2_ACCESSORS_H
+#define __SOC_ARCH_QCOM_KRYO_L2_ACCESSORS_H
+
+void kryo_l2_set_indirect_reg(u64 reg, u64 val);
+u64 kryo_l2_get_indirect_reg(u64 reg);
+
+#endif
-- 
1.9.1
