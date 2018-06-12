Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7408EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFB5208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFB5208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeFLOlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:41:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34724 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932750AbeFLOlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:41:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332711529;
        Tue, 12 Jun 2018 07:41:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9263F557;
        Tue, 12 Jun 2018 07:41:06 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:40:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Agustin Vega-Frias <agustinv@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        timur@codeaurora.org
Subject: Re: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
Message-ID: <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 07, 2018 at 09:56:48AM -0400, Agustin Vega-Frias wrote:
> Selection of these events can be envisioned as indexing them from
> a 3D matrix:
> - the first index selects a Region Event Selection Register (PMRESRx_EL0)
> - the second index selects a group from which only one event at a time
>   can be selected
> - the third index selects the event
> 
> The event is encoded into perf_event_attr.config as 0xPRCCG, where:
>   P  [config:16   ] = prefix   (flag that indicates a matrix-based event)
>   R  [config:12-15] = register (specifies the PMRESRx_EL0 instance)
>   G  [config:0-3  ] = group    (specifies the event group)
>   CC [config:4-11 ] = code     (specifies the event)
> 
> Events with the P flag set to zero are treated as common PMUv3 events
> and are directly programmed into PMXEVTYPERx_EL0.
> 
> The first two indexes are set combining the RESR and group number with
> a base number and writing it into the architected PMXEVTYPER_EL0 register.
> The third index is set by writing the code into the bits corresponding
> with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
> register.

When are the IMP DEF registers accessible at EL0? Are those goverend by
the same controls as the architected registers?

[...]

> +/*
> + * Qualcomm Technologies CPU PMU IMPLEMENTATION DEFINED extensions support
> + *
> + * Current extensions supported:
> + *
> + * - Matrix-based microarchitectural events support
> + *
> + *   Selection of these events can be envisioned as indexing them from
> + *   a 3D matrix:
> + *   - the first index selects a Region Event Selection Register (PMRESRx_EL0)
> + *   - the second index selects a group from which only one event at a time
> + *     can be selected
> + *   - the third index selects the event
> + *
> + *   The event is encoded into perf_event_attr.config as 0xPRCCG, where:
> + *     P  [config:16   ] = prefix   (flag that indicates a matrix-based event)
> + *     R  [config:12-15] = register (specifies the PMRESRx_EL0 instance)
> + *     G  [config:0-3  ] = group    (specifies the event group)
> + *     CC [config:4-11 ] = code     (specifies the event)
> + *
> + *   Events with the P flag set to zero are treated as common PMUv3 events
> + *   and are directly programmed into PMXEVTYPERx_EL0.

When PMUv3 is given a raw event code, the config fields should be the
PMU event number, and this conflicts with RESERVED encodings.

I'd rather we used a separate field for the QC extension events. e.g.
turn config1 into a flags field, and move the P flag there.

We *should* add code to sanity check those fields are zero in the PMUv3
driver, even though it's a potential ABI break to start now.

> + *
> + *   The first two indexes are set combining the RESR and group number with
> + *   a base number and writing it into the architected PMXEVTYPER_EL0 register.
> + *   The third index is set by writing the code into the bits corresponding
> + *   with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
> + *   register.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/perf/arm_pmu.h>

You'll also need:

#include <linux/bitops.h>
#include <linux/device.h>
#include <linux/perf_event.h>
#include <linux/printk.h>
#include <linux/types.h>

#include <asm/barrier.h>
#include <asm/sysreg.h>

> +
> +#define pmresr0_el0         sys_reg(3, 5, 11, 3, 0)
> +#define pmresr1_el0         sys_reg(3, 5, 11, 3, 2)
> +#define pmresr2_el0         sys_reg(3, 5, 11, 3, 4)
> +#define pmxevcntcr_el0      sys_reg(3, 5, 11, 0, 3)
> +
> +#define QC_EVT_PFX_SHIFT    16
> +#define QC_EVT_REG_SHIFT    12
> +#define QC_EVT_CODE_SHIFT   4
> +#define QC_EVT_GRP_SHIFT    0
> +#define QC_EVT_PFX_MASK     GENMASK(QC_EVT_PFX_SHIFT,  QC_EVT_PFX_SHIFT)
> +#define QC_EVT_REG_MASK     GENMASK(QC_EVT_REG_SHIFT + 3,  QC_EVT_REG_SHIFT)
> +#define QC_EVT_CODE_MASK    GENMASK(QC_EVT_CODE_SHIFT + 7, QC_EVT_CODE_SHIFT)
> +#define QC_EVT_GRP_MASK     GENMASK(QC_EVT_GRP_SHIFT + 3,  QC_EVT_GRP_SHIFT)
> +#define QC_EVT_PRG_MASK     (QC_EVT_PFX_MASK | QC_EVT_REG_MASK | QC_EVT_GRP_MASK)
> +#define QC_EVT_PRG(event)   ((event) & QC_EVT_PRG_MASK)
> +#define QC_EVT_REG(event)   (((event) & QC_EVT_REG_MASK)  >> QC_EVT_REG_SHIFT)
> +#define QC_EVT_CODE(event)  (((event) & QC_EVT_CODE_MASK) >> QC_EVT_CODE_SHIFT)
> +#define QC_EVT_GROUP(event) (((event) & QC_EVT_GRP_MASK)  >> QC_EVT_GRP_SHIFT)
> +
> +#define QC_MAX_GROUP        7
> +#define QC_MAX_RESR         2
> +#define QC_BITS_PER_GROUP   8
> +#define QC_RESR_ENABLE      BIT_ULL(63)
> +#define QC_RESR_EVT_BASE    0xd8
> +
> +static struct arm_pmu *def_ops;
> +
> +static inline void falkor_write_pmresr(u64 reg, u64 val)
> +{
> +	if (reg == 0)
> +		write_sysreg_s(val, pmresr0_el0);
> +	else if (reg == 1)
> +		write_sysreg_s(val, pmresr1_el0);
> +	else
> +		write_sysreg_s(val, pmresr2_el0);
> +}
> +
> +static inline u64 falkor_read_pmresr(u64 reg)
> +{
> +	return (reg == 0 ? read_sysreg_s(pmresr0_el0) :
> +		reg == 1 ? read_sysreg_s(pmresr1_el0) :
> +			   read_sysreg_s(pmresr2_el0));
> +}

Please use switch statements for both of these.

> +
> +static void falkor_set_resr(u64 reg, u64 group, u64 code)
> +{
> +	u64 shift = group * QC_BITS_PER_GROUP;
> +	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
> +	u64 val;
> +
> +	val = falkor_read_pmresr(reg) & ~mask;
> +	val |= (code << shift);
> +	val |= QC_RESR_ENABLE;
> +	falkor_write_pmresr(reg, val);
> +}
> +
> +static void falkor_clear_resr(u64 reg, u64 group)
> +{
> +	u32 shift = group * QC_BITS_PER_GROUP;
> +	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
> +	u64 val = falkor_read_pmresr(reg) & ~mask;
> +
> +	falkor_write_pmresr(reg, val == QC_RESR_ENABLE ? 0 : val);
> +}
> +
> +/*
> + * Check if e1 and e2 conflict with each other
> + *
> + * e1 is a matrix-based microarchitectural event we are checking against e2.
> + * A conflict exists if the events use the same reg, group, and a different
> + * code. Events with the same code are allowed because they could be using
> + * different filters (e.g. one to count user space and the other to count
> + * kernel space events).
> + */

What problem occurs when there's a conflict?

Does the filter matter at all? When happens if I open two identical
events, both counting the same reg, group, and code, with the same
filter?

> +static inline int events_conflict(struct perf_event *e1, struct perf_event *e2)
> +{
> +	if ((e1 != e2) &&
> +	    (e1->pmu == e2->pmu) &&
> +	    (QC_EVT_PRG(e1->attr.config) == QC_EVT_PRG(e2->attr.config)) &&
> +	    (QC_EVT_CODE(e1->attr.config) != QC_EVT_CODE(e2->attr.config))) {
> +		pr_debug_ratelimited(
> +			"Group exclusion: conflicting events %llx %llx\n",
> +			e1->attr.config,
> +			e2->attr.config);
> +		return 1;
> +	}
> +	return 0;
> +}

This would be easier to read as a series of tests:

static inline bool events_conflict(struct perf_event *new,
				   struct perf_event *other)
{
	/* own group leader */
	if (new == other)
		return false;
	
	/* software events can't conflict */
	if (is_sw_event(other))
		return false;

	/* No conflict if using different reg or group */
	if (QC_EVT_PRG(new->attr.config) != QC_EVT_PRG(other->attr.config))
		return false;
	
	/* Same reg and group is fine so long as code matches */
	if (QC_EVT_CODE(new->attr.config) == QC_EVT_PRG(other->attr.config)
		return false;


	pr_debug_ratelimited("Group exclusion: conflicting events %llx %llx\n",
		new->attr.config, other->attr.config);

	return true;

}

> +
> +/*
> + * Check if the given event is valid for the PMU and if so return the value
> + * that can be used in PMXEVTYPER_EL0 to select the event
> + */
> +static int falkor_map_event(struct perf_event *event)
> +{
> +	u64 reg = QC_EVT_REG(event->attr.config);
> +	u64 group = QC_EVT_GROUP(event->attr.config);
> +	struct perf_event *leader;
> +	struct perf_event *sibling;
> +
> +	if (!(event->attr.config & QC_EVT_PFX_MASK))
> +		/* Common PMUv3 event, forward to the original op */
> +		return def_ops->map_event(event);

The QC event codes should only be used when either:

* event->attr.type is PERF_TYPE_RAW, or:

* event->pmu.type is this PMU's dynamic type

... otherwise this will accept events meant for other PMUs, and/or
override conflicting events in other type namespaces (e.g.
PERF_EVENT_TYPE_HW, PERF_EVENT_TYPE_CACHE).

> +
> +	/* Is it a valid matrix event? */
> +	if ((group > QC_MAX_GROUP) || (reg > QC_MAX_RESR))
> +		return -ENOENT;
> +
> +	/* If part of an event group, check if the event can be put in it */
> +
> +	leader = event->group_leader;
> +	if (events_conflict(event, leader))
> +		return -ENOENT;
> +
> +	for_each_sibling_event(sibling, leader)
> +		if (events_conflict(event, sibling))
> +			return -ENOENT;
> +
> +	return QC_RESR_EVT_BASE + reg*8 + group;

Nit: spacing around binary operators please.

> +}
> +
> +/*
> + * Find a slot for the event on the current CPU
> + */
> +static int falkor_get_event_idx(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +	int idx;
> +
> +	if (!!(event->attr.config & QC_EVT_PFX_MASK))

The '!!' isn't required.

> +		/* Matrix event, check for conflicts with existing events */
> +		for_each_set_bit(idx, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
> +			if (cpuc->events[idx] &&
> +			    events_conflict(event, cpuc->events[idx]))
> +				return -ENOENT;
> +
> +	/* Let the original op handle the rest */
> +	idx = def_ops->get_event_idx(cpuc, event);

Same comments as for falkor_map_event().

> +
> +	/*
> +	 * This is called for actually allocating the events, but also with
> +	 * a dummy pmu_hw_events when validating groups, for that case we
> +	 * need to ensure that cpuc->events[idx] is NULL so we don't use
> +	 * an uninitialized pointer. Conflicts for matrix events in groups
> +	 * are checked during event mapping anyway (see falkor_event_map).
> +	 */
> +	cpuc->events[idx] = NULL;
> +
> +	return idx;
> +}
> +
> +/*
> + * Reset the PMU
> + */
> +static void falkor_reset(void *info)
> +{
> +	struct arm_pmu *pmu = (struct arm_pmu *)info;
> +	u32 i, ctrs = pmu->num_events;
> +
> +	/* PMRESRx_EL0 regs are unknown at reset, except for the EN field */
> +	for (i = 0; i <= QC_MAX_RESR; i++)
> +		falkor_write_pmresr(i, 0);
> +
> +	/* PMXEVCNTCRx_EL0 regs are unknown at reset */
> +	for (i = 0; i <= ctrs; i++) {
> +		write_sysreg(i, pmselr_el0);
> +		isb();
> +		write_sysreg_s(0, pmxevcntcr_el0);
> +	}
> +
> +	/* Let the original op handle the rest */
> +	def_ops->reset(info);
> +}
> +
> +/*
> + * Enable the given event
> + */
> +static void falkor_enable(struct perf_event *event)
> +{
> +	if (!!(event->attr.config & QC_EVT_PFX_MASK)) {

The '!!' isn't required.

> +		/* Matrix event, program the appropriate PMRESRx_EL0 */
> +		struct arm_pmu *pmu = to_arm_pmu(event->pmu);
> +		struct pmu_hw_events *events = this_cpu_ptr(pmu->hw_events);
> +		u64 reg = QC_EVT_REG(event->attr.config);
> +		u64 code = QC_EVT_CODE(event->attr.config);
> +		u64 group = QC_EVT_GROUP(event->attr.config);
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +		falkor_set_resr(reg, group, code);
> +		raw_spin_unlock_irqrestore(&events->pmu_lock, flags);

Why is the spinlock required?

AFACIT this should only ever be called in contexts where IRQs are
disabled already.

> +	}
> +
> +	/* Let the original op handle the rest */
> +	def_ops->enable(event);
> +}
> +
> +/*
> + * Disable the given event
> + */
> +static void falkor_disable(struct perf_event *event)
> +{
> +	/* Use the original op to disable the counter and interrupt  */
> +	def_ops->enable(event);
> +
> +	if (!!(event->attr.config & QC_EVT_PFX_MASK)) {
> +		/* Matrix event, de-program the appropriate PMRESRx_EL0 */
> +		struct arm_pmu *pmu = to_arm_pmu(event->pmu);
> +		struct pmu_hw_events *events = this_cpu_ptr(pmu->hw_events);
> +		u64 reg = QC_EVT_REG(event->attr.config);
> +		u64 group = QC_EVT_GROUP(event->attr.config);
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +		falkor_clear_resr(reg, group);
> +		raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> +	}
> +}

Same comments as with falkor_enable().

> +
> +PMU_FORMAT_ATTR(event,  "config:0-15");
> +PMU_FORMAT_ATTR(prefix, "config:16");
> +PMU_FORMAT_ATTR(reg,    "config:12-15");
> +PMU_FORMAT_ATTR(code,   "config:4-11");
> +PMU_FORMAT_ATTR(group,  "config:0-3");

What sort of events are available? Do you plan to add anything to the
userspace event database in tools/perf/pmu-events/ ?

> +
> +static struct attribute *falkor_pmu_formats[] = {
> +	&format_attr_event.attr,
> +	&format_attr_prefix.attr,
> +	&format_attr_reg.attr,
> +	&format_attr_code.attr,
> +	&format_attr_group.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group falkor_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = falkor_pmu_formats,
> +};
> +
> +static int qcom_falkor_pmu_init(struct arm_pmu *pmu, struct device *dev)
> +{
> +	/* Save base arm_pmu so we can invoke its ops when appropriate */
> +	def_ops = devm_kmemdup(dev, pmu, sizeof(*def_ops), GFP_KERNEL);
> +	if (!def_ops) {
> +		pr_warn("Failed to allocate arm_pmu for QCOM extensions");
> +		return -ENODEV;
> +	}
> +
> +	pmu->name = "qcom_pmuv3";

All the other CPU PMUs on an ARM ACPI system will have an index suffix,
e.g. "armv8_pmuv3_0". I can see why we might want to change the name to
indicate the QC extensions, but I think we should keep the existing
pattern, with a '_0' suffix here.

> +
> +	/* Override the necessary ops */
> +	pmu->map_event     = falkor_map_event;
> +	pmu->get_event_idx = falkor_get_event_idx;
> +	pmu->reset         = falkor_reset;
> +	pmu->enable        = falkor_enable;
> +	pmu->disable       = falkor_disable;

I'm somewhat concerned by hooking into the existing PMU code at this
level, but I don't currently have a better suggestion.

Thanks,
Mark.

> +
> +	/* Override the necessary attributes */
> +	pmu->pmu.attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
> +		&falkor_pmu_format_attr_group;
> +
> +	return 1;
> +}
> +
> +ACPI_DECLARE_PMU_VARIANT(qcom_falkor, "QCOM8150", qcom_falkor_pmu_init);
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
