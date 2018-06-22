Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C69FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20D24817
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kBeRuicM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dkGOWwYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B20D24817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934570AbeFVTrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:47:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934470AbeFVTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:46:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA23160B13; Fri, 22 Jun 2018 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696811;
        bh=rpznV+vRYq6rhEQPQpz7khbZ+M8US7Duvfpu65D+lAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBeRuicMBBk7es+aj7w4+iJBa6cJOkeQ6gI0plzd0uIcyJX3dtTAqOGpCRzQNpwcm
         blQxDhGr7ojADehdTz3CujQEFoil89PrxE5efZhQjb3Gbo1AwjnJBoYPsLF9RT/qcR
         Ko7I6gTBINaBswoTlwjfG92BK0rENu6cWm/csQHc=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B333660B11;
        Fri, 22 Jun 2018 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696810;
        bh=rpznV+vRYq6rhEQPQpz7khbZ+M8US7Duvfpu65D+lAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkGOWwYvxn0b+N+/buDzEYcZ/CQhfuPnkp1PXg/SSbgkizwQ7d0+WDtOk2fmO+fjg
         ed9VPeifwaO6tgnVgUFw3jLqF2B362fC4rEhC/mW3Upyjos0p00kOinQoj7fGRtzdA
         ALbjQSfdahSobRb1FSMZ0ePB/m2jOEEq4wlVjnK8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B333660B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION DEFINED event support
Date:   Fri, 22 Jun 2018 15:46:32 -0400
Message-Id: <1529696792-16903-4-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529696792-16903-1-git-send-email-agustinv@codeaurora.org>
References: <1529696792-16903-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selection of these events can be envisioned as indexing them from
a 3D matrix:
- the first index selects a Region Event Selection Register (PMRESRx_EL0)
- the second index selects a group from which only one event at a time
  can be selected
- the third index selects the event

These events are encoded into perf_event_attr as:
  mbe      [config1:0   ]  (flag that indicates a matrix-based event)
  reg      [config:12-15]  (specifies the PMRESRx_EL0 instance)
  group    [config:0-3  ]  (specifies the event group)
  code     [config:4-11 ]  (specifies the event)

Events with the mbe flag set to zero are treated as common or raw PMUv3
events and are handled by the base PMUv3 driver code.

The first two indexes are set combining the RESR and group number with
a base number and writing it into the architected PMXEVTYPER_EL0 register.
The third index is set by writing the code into the bits corresponding
with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
register.

Support for this extension is signaled by the presence of the Falkor PMU
device node under each Falkor CPU device node in the DSDT ACPI table. E.g.:

    Device (CPU0)
    {
        Name (_HID, "ACPI0007" /* Processor Device */)
        ...
        Device (PMU0)
        {
            Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */
            ...
        }
    }

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/perf/Makefile       |   2 +-
 drivers/perf/qcom_arm_pmu.c | 342 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/qcom_arm_pmu.c

diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b3902bd..a61afd9 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
 obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
-obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o qcom_arm_pmu.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
diff --git a/drivers/perf/qcom_arm_pmu.c b/drivers/perf/qcom_arm_pmu.c
new file mode 100644
index 0000000..2f5e736
--- /dev/null
+++ b/drivers/perf/qcom_arm_pmu.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
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
+/*
+ * Qualcomm Technologies CPU PMU IMPLEMENTATION DEFINED extensions support
+ *
+ * Current extensions supported:
+ *
+ * - Matrix-based microarchitectural events support
+ *
+ *   Selection of these events can be envisioned as indexing them from
+ *   a 3D matrix:
+ *   - the first index selects a Region Event Selection Register (PMRESRx_EL0)
+ *   - the second index selects a group from which only one event at a time
+ *     can be selected
+ *   - the third index selects the event
+ *
+ *   These events are encoded into perf_event_attr as:
+ *     mbe      [config1:0   ]  (flag that indicates a matrix-based event)
+ *     reg      [config:12-15]  (specifies the PMRESRx_EL0 instance)
+ *     group    [config:0-3  ]  (specifies the event group)
+ *     code     [config:4-11 ]  (specifies the event)
+ *
+ *   Events with the mbe flag set to zero are treated as common or raw PMUv3
+ *   events and are handled by the base PMUv3 driver code.
+ *
+ *   The first two indexes are set combining the RESR and group number with a
+ *   base number and writing it into the architected PMXEVTYPER_EL0.evtCount.
+ *   The third index is set by writing the code into the bits corresponding
+ *   with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
+ *   register.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/sysreg.h>
+
+#include <linux/perf/arm_pmu.h>
+
+#define pmresr0_el0         sys_reg(3, 5, 11, 3, 0)
+#define pmresr1_el0         sys_reg(3, 5, 11, 3, 2)
+#define pmresr2_el0         sys_reg(3, 5, 11, 3, 4)
+#define pmxevcntcr_el0      sys_reg(3, 5, 11, 0, 3)
+
+#define QC_EVT_MBE_SHIFT    0
+#define QC_EVT_REG_SHIFT    12
+#define QC_EVT_CODE_SHIFT   4
+#define QC_EVT_GRP_SHIFT    0
+#define QC_EVT_MBE_MASK     GENMASK(QC_EVT_MBE_SHIFT + 1,  QC_EVT_MBE_SHIFT)
+#define QC_EVT_REG_MASK     GENMASK(QC_EVT_REG_SHIFT + 3,  QC_EVT_REG_SHIFT)
+#define QC_EVT_CODE_MASK    GENMASK(QC_EVT_CODE_SHIFT + 7, QC_EVT_CODE_SHIFT)
+#define QC_EVT_GRP_MASK     GENMASK(QC_EVT_GRP_SHIFT + 3,  QC_EVT_GRP_SHIFT)
+#define QC_EVT_RG_MASK      (QC_EVT_REG_MASK | QC_EVT_GRP_MASK)
+#define QC_EVT_RG(event)    ((event)->attr.config & QC_EVT_RG_MASK)
+#define QC_EVT_MBE(event)						\
+	(((event)->attr.config1 & QC_EVT_MBE_MASK) >> QC_EVT_MBE_SHIFT)
+#define QC_EVT_REG(event)						\
+	(((event)->attr.config & QC_EVT_REG_MASK) >> QC_EVT_REG_SHIFT)
+#define QC_EVT_CODE(event)						\
+	(((event)->attr.config & QC_EVT_CODE_MASK) >> QC_EVT_CODE_SHIFT)
+#define QC_EVT_GROUP(event)						\
+	(((event)->attr.config & QC_EVT_GRP_MASK) >> QC_EVT_GRP_SHIFT)
+
+#define QC_MAX_GROUP        7
+#define QC_MAX_RESR         2
+#define QC_BITS_PER_GROUP   8
+#define QC_RESR_ENABLE      BIT_ULL(63)
+#define QC_RESR_EVT_BASE    0xd8
+
+static struct arm_pmu *def_ops;
+
+static inline void falkor_write_pmresr(u64 reg, u64 val)
+{
+	switch (reg) {
+	case 0:
+		write_sysreg_s(val, pmresr0_el0);
+		return;
+	case 1:
+		write_sysreg_s(val, pmresr1_el0);
+		return;
+	default:
+		write_sysreg_s(val, pmresr2_el0);
+		return;
+	}
+}
+
+static inline u64 falkor_read_pmresr(u64 reg)
+{
+	switch (reg) {
+	case 0:
+		return read_sysreg_s(pmresr0_el0);
+	case 1:
+		return read_sysreg_s(pmresr1_el0);
+	default:
+		return read_sysreg_s(pmresr2_el0);
+	}
+}
+
+static void falkor_set_resr(u64 reg, u64 group, u64 code)
+{
+	u64 shift = group * QC_BITS_PER_GROUP;
+	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
+	u64 val;
+
+	val = falkor_read_pmresr(reg) & ~mask;
+	val |= (code << shift);
+	val |= QC_RESR_ENABLE;
+	falkor_write_pmresr(reg, val);
+}
+
+static void falkor_clear_resr(u64 reg, u64 group)
+{
+	u32 shift = group * QC_BITS_PER_GROUP;
+	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
+	u64 val = falkor_read_pmresr(reg) & ~mask;
+
+	falkor_write_pmresr(reg, val == QC_RESR_ENABLE ? 0 : val);
+}
+
+/*
+ * Check if e1 and e2 conflict with each other
+ *
+ * e1 is a matrix-based microarchitectural event we are checking against e2.
+ * A conflict exists if the events use the same reg, group, and a different
+ * code.
+ */
+static inline bool events_conflict(struct perf_event *e1, struct perf_event *e2)
+{
+	int type = e2->attr.type;
+	int dynamic = e1->pmu->type;
+
+	/* Same event? */
+	if (e1 == e2)
+		return false;
+
+	/* Other PMU that is not the RAW or this PMU's dynamic type? */
+	if ((e1->pmu != e2->pmu) && ((type != PERF_TYPE_RAW) && (type != dynamic)))
+		return false;
+
+	/* No conflict if using different mbe */
+	if (QC_EVT_MBE(e1) != QC_EVT_MBE(e2))
+		return false;
+
+	/* No conflict if using different reg or group */
+	if (QC_EVT_RG(e1) != QC_EVT_RG(e2))
+		return false;
+
+	/* Same mbe, reg and group is fine so long as code matches */
+	if (QC_EVT_CODE(e1) == QC_EVT_CODE(e2))
+		return false;
+
+	pr_debug_ratelimited("Group exclusion: conflicting events %llx %llx\n",
+			     e1->attr.config,
+			     e2->attr.config);
+	return true;
+}
+
+/*
+ * Check if the given event is valid for the PMU and if so return the value
+ * that can be used in PMXEVTYPER_EL0 to select the event
+ */
+static int falkor_map_event(struct perf_event *event)
+{
+	int type = event->attr.type;
+	int dynamic = event->pmu->type;
+	u64 reg = QC_EVT_REG(event);
+	u64 group = QC_EVT_GROUP(event);
+	struct perf_event *leader;
+	struct perf_event *sibling;
+
+	if (((type != PERF_TYPE_RAW) && (type != dynamic)) || !QC_EVT_MBE(event))
+		/* Common PMUv3 event, forward to the original op */
+		return def_ops->map_event(event);
+
+	/* Is it a valid matrix event? */
+	if ((group > QC_MAX_GROUP) || (reg > QC_MAX_RESR))
+		return -ENOENT;
+
+	/* If part of an event group, check if the event can be put in it */
+
+	leader = event->group_leader;
+	if (events_conflict(event, leader))
+		return -ENOENT;
+
+	for_each_sibling_event(sibling, leader)
+		if (events_conflict(event, sibling))
+			return -ENOENT;
+
+	return QC_RESR_EVT_BASE + reg * 8 + group;
+}
+
+/*
+ * Find a slot for the event on the current CPU
+ */
+static int falkor_get_event_idx(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	int type = event->attr.type;
+	int dynamic = event->pmu->type;
+	int idx;
+
+	if (((type == PERF_TYPE_RAW) || (type == dynamic)) && QC_EVT_MBE(event))
+		/* Matrix event, check for conflicts with existing events */
+		for_each_set_bit(idx, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
+			if (cpuc->events[idx] &&
+			    events_conflict(event, cpuc->events[idx]))
+				return -ENOENT;
+
+	/* Let the original op handle the rest */
+	idx = def_ops->get_event_idx(cpuc, event);
+
+	/*
+	 * This is called for actually allocating the events, but also with
+	 * a dummy pmu_hw_events when validating groups, for that case we
+	 * need to ensure that cpuc->events[idx] is NULL so we don't use
+	 * an uninitialized pointer. Conflicts for matrix events in groups
+	 * are checked during event mapping anyway (see falkor_event_map).
+	 */
+	cpuc->events[idx] = NULL;
+
+	return idx;
+}
+
+/*
+ * Reset the PMU
+ */
+static void falkor_reset(void *info)
+{
+	struct arm_pmu *pmu = (struct arm_pmu *)info;
+	u32 i, ctrs = pmu->num_events;
+
+	/* PMRESRx_EL0 regs are unknown at reset, except for the EN field */
+	for (i = 0; i <= QC_MAX_RESR; i++)
+		falkor_write_pmresr(i, 0);
+
+	/* PMXEVCNTCRx_EL0 regs are unknown at reset */
+	for (i = 0; i <= ctrs; i++) {
+		write_sysreg(i, pmselr_el0);
+		isb();
+		write_sysreg_s(0, pmxevcntcr_el0);
+	}
+
+	/* Let the original op handle the rest */
+	def_ops->reset(info);
+}
+
+/*
+ * Enable the given event
+ */
+static void falkor_enable(struct perf_event *event)
+{
+	if (QC_EVT_MBE(event)) {
+		/* Matrix event, program the appropriate PMRESRx_EL0 */
+		u64 reg = QC_EVT_REG(event);
+		u64 code = QC_EVT_CODE(event);
+		u64 group = QC_EVT_GROUP(event);
+
+		falkor_set_resr(reg, group, code);
+	}
+
+	/* Let the original op handle the rest */
+	def_ops->enable(event);
+}
+
+/*
+ * Disable the given event
+ */
+static void falkor_disable(struct perf_event *event)
+{
+	/* Use the original op to disable the counter and interrupt  */
+	def_ops->enable(event);
+
+	if (QC_EVT_MBE(event)) {
+		/* Matrix event, de-program the appropriate PMRESRx_EL0 */
+		u64 reg = QC_EVT_REG(event);
+		u64 group = QC_EVT_GROUP(event);
+
+		falkor_clear_resr(reg, group);
+	}
+}
+
+PMU_FORMAT_ATTR(event, "config:0-15");
+PMU_FORMAT_ATTR(mbe,   "config1:0");
+PMU_FORMAT_ATTR(reg,   "config:12-15");
+PMU_FORMAT_ATTR(code,  "config:4-11");
+PMU_FORMAT_ATTR(group, "config:0-3");
+
+static struct attribute *falkor_pmu_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_mbe.attr,
+	&format_attr_reg.attr,
+	&format_attr_code.attr,
+	&format_attr_group.attr,
+	NULL,
+};
+
+static struct attribute_group falkor_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = falkor_pmu_formats,
+};
+
+static int qcom_falkor_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	/* Save base arm_pmu so we can invoke its ops when appropriate */
+	def_ops = devm_kmemdup(dev, pmu, sizeof(*def_ops), GFP_KERNEL);
+	if (!def_ops) {
+		pr_warn("Failed to allocate arm_pmu for QCOM extensions");
+		return -ENODEV;
+	}
+
+	pmu->name = "qcom_pmuv3";
+
+	/* Override the necessary ops */
+	pmu->map_event     = falkor_map_event;
+	pmu->get_event_idx = falkor_get_event_idx;
+	pmu->reset         = falkor_reset;
+	pmu->enable        = falkor_enable;
+	pmu->disable       = falkor_disable;
+
+	/* Override the necessary attributes */
+	pmu->pmu.attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&falkor_pmu_format_attr_group;
+
+	return 1;
+}
+
+ACPI_DECLARE_PMU_VARIANT(qcom_falkor, "QCOM8150", qcom_falkor_pmu_init);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

