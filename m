Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFABC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B0120870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B0120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeIJPzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:55:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbeIJPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:55:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A016D18A;
        Mon, 10 Sep 2018 04:02:09 -0700 (PDT)
Received: from [10.1.34.200] (desktop-vlo843j.cambridge.arm.com [10.1.34.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2998F3F575;
        Mon, 10 Sep 2018 04:02:07 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com,
        john.garry@huawei.com, pabba@codeaurora.org,
        vkilari@codeaurora.org, rruigrok@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        neil.m.leeder@gmail.com
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-4-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <935f7572-38d7-070a-dba6-3f18189de4d3@arm.com>
Date:   Mon, 10 Sep 2018 12:02:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724114515.21764-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ note: for some reason I decided to review this from the bottom up,
   so it probably makes no sense unless you read it backwards ]

On 2018-07-24 12:45 PM, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Adds a new driver to support the SMMU v3 PMU and add it into the
> perf events framework.
> 
> Each SMMU node may have multiple PMUs associated with it, each of
> which may support different events.
> 
> SMMUv3 PMCG devices are named as arm_smmu_v3_x_pmcg_y where x
> denotes the associated smmuv3 dev id(if any) and y denotes the
> pmu dev id.
> 
> Filtering by stream id is done by specifying filtering parameters
> with the event. options are:
>     filter_enable    - 0 = no filtering, 1 = filtering enabled
>     filter_span      - 0 = exact match, 1 = pattern match
>     filter_stream_id - pattern to filter against
> Further filtering information is available in the SMMU documentation.
> 
> Example: perf stat -e arm_smmu_v3_0_pmcg_6/transaction,filter_enable=1,
>                         filter_span=1,filter_stream_id=0x42/ -a pwd
> Applies filter pattern 0x42 to transaction events.
> 
> SMMU events are not attributable to a CPU, so task mode and sampling
> are not supported.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/perf/Kconfig          |   9 +
>   drivers/perf/Makefile         |   1 +
>   drivers/perf/arm_smmuv3_pmu.c | 838 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 848 insertions(+)
>   create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 08ebaf7..0b9cc1a 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -52,6 +52,15 @@ config ARM_PMU_ACPI
>   	depends on ARM_PMU && ACPI
>   	def_bool y
>   
> +config ARM_SMMUV3_PMU
> +	 bool "ARM SMMUv3 PMU"

Nit: I'd be inlined to use "Performance Monitors {Extension}" or "PMCG" 
in user-facing text, since "PMU" is not the architectural terminology in 
this particular case.

> +	 depends on ARM64 && ACPI
> +	   help
> +	   Provides support for the SMMU version 3 performance monitor unit (PMU)
> +	   on ARM-based systems.
> +	   Adds the SMMU PMU into the perf events subsystem for
> +	   monitoring SMMU performance events.
> +
>   config ARM_DSU_PMU
>   	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
>   	depends on ARM64
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index b3902bd..b3ae48d 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_CCN) += arm-ccn.o
>   obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
>   obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
>   obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> +obj-$(CONFIG_ARM_SMMUV3_PMU) += arm_smmuv3_pmu.o
>   obj-$(CONFIG_HISI_PMU) += hisilicon/
>   obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>   obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> new file mode 100644
> index 0000000..b3dc394
> --- /dev/null
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -0,0 +1,838 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2017 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You don't really need to add the license text as well as SPDX. Except 
for the fact that in this case they don't match - which is it?

> + */
> +
> +/*
> + * This driver adds support for perf events to use the Performance
> + * Monitor Counter Groups (PMCG) associated with an SMMUv3 node
> + * to monitor that node.
> + *
> + * SMMUv3 PMCG devices are named as arm_smmu_v3.x_pmcg.y where x
> + * denotes the associated smmuv3 dev id and y denotes the pmu dev id.
> + *
> + * Filtering by stream id is done by specifying filtering parameters
> + * with the event. options are:
> + *   filter_enable    - 0 = no filtering, 1 = filtering enabled
> + *   filter_span      - 0 = exact match, 1 = pattern match
> + *   filter_stream_id - pattern to filter against
> + * Further filtering information is available in the SMMU documentation.
> + *
> + * Example: perf stat -e arm_smmu_v3.0_pmcg.6/transaction,filter_enable=1,
> + *                       filter_span=1,filter_stream_id=0x42/ -a pwd
> + * Applies filter pattern 0x42 to transaction events.
> + *
> + * SMMU events are not attributable to a CPU, so task mode and sampling
> + * are not supported.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
> +#include <linux/bitops.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/msi.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <asm/local64.h>

asm/ headers in drivers always look a bit suspicious; since the 
dependency on local64_t is from the perf API anyway, I reckon it's safe 
to pick this up implicitly from perf_event.h (like most others do).

> +
> +#define SMMU_PMCG_EVCNTR0               0x0
> +#define SMMU_PMCG_EVCNTR(n, stride)     (SMMU_PMCG_EVCNTR0 + (n) * (stride))
> +#define SMMU_PMCG_EVTYPER0              0x400
> +#define SMMU_PMCG_EVTYPER(n)            (SMMU_PMCG_EVTYPER0 + (n) * 4)
> +#define SMMU_PMCG_EVTYPER_SEC_SID_SHIFT       30
> +#define SMMU_PMCG_EVTYPER_SID_SPAN_SHIFT      29
> +#define SMMU_PMCG_EVTYPER_EVENT_MASK          GENMASK(15, 0)
> +#define SMMU_PMCG_SVR0                  0x600
> +#define SMMU_PMCG_SVR(n, stride)        (SMMU_PMCG_SVR0 + (n) * (stride))
> +#define SMMU_PMCG_SMR0                  0xA00
> +#define SMMU_PMCG_SMR(n)                (SMMU_PMCG_SMR0 + (n) * 4)
> +#define SMMU_PMCG_CNTENSET0             0xC00
> +#define SMMU_PMCG_CNTENCLR0             0xC20
> +#define SMMU_PMCG_INTENSET0             0xC40
> +#define SMMU_PMCG_INTENCLR0             0xC60
> +#define SMMU_PMCG_OVSCLR0               0xC80
> +#define SMMU_PMCG_OVSSET0               0xCC0
> +#define SMMU_PMCG_CAPR                  0xD88
> +#define SMMU_PMCG_SCR                   0xDF8
> +#define SMMU_PMCG_CFGR                  0xE00
> +#define SMMU_PMCG_CFGR_SID_FILTER_TYPE        BIT(23)
> +#define SMMU_PMCG_CFGR_CAPTURE                BIT(22)
> +#define SMMU_PMCG_CFGR_MSI                    BIT(21)
> +#define SMMU_PMCG_CFGR_RELOC_CTRS             BIT(20)
> +#define SMMU_PMCG_CFGR_SIZE_MASK              GENMASK(13, 8)
> +#define SMMU_PMCG_CFGR_SIZE_SHIFT             8
> +#define SMMU_PMCG_CFGR_COUNTER_SIZE_32        31
> +#define SMMU_PMCG_CFGR_NCTR_MASK              GENMASK(5, 0)
> +#define SMMU_PMCG_CFGR_NCTR_SHIFT             0
> +#define SMMU_PMCG_CR                    0xE04
> +#define SMMU_PMCG_CR_ENABLE                   BIT(0)
> +#define SMMU_PMCG_CEID0                 0xE20
> +#define SMMU_PMCG_CEID1                 0xE28
> +#define SMMU_PMCG_IRQ_CTRL              0xE50
> +#define SMMU_PMCG_IRQ_CTRL_IRQEN              BIT(0)
> +#define SMMU_PMCG_IRQ_CFG0              0xE58
> +#define SMMU_PMCG_IRQ_CFG1              0xE60
> +#define SMMU_PMCG_IRQ_CFG2              0xE64
> +#define SMMU_PMCG_IRQ_STATUS            0xE68
> +
> +#define SMMU_COUNTER_RELOAD             BIT(31)
> +#define SMMU_DEFAULT_FILTER_SEC         0
> +#define SMMU_DEFAULT_FILTER_SPAN        1
> +#define SMMU_DEFAULT_FILTER_STREAM_ID   GENMASK(31, 0)
> +
> +#define SMMU_MAX_COUNTERS               64
> +#define SMMU_ARCH_MAX_EVENT_ID          128
> +
> +#define SMMU_IMPDEF_MAX_EVENT_ID        0xFFFF
> +
> +#define SMMU_PA_SHIFT                   12
> +
> +/* Events */
> +#define SMMU_PMU_CYCLES                 0
> +#define SMMU_PMU_TRANSACTION            1
> +#define SMMU_PMU_TLB_MISS               2
> +#define SMMU_PMU_CONFIG_CACHE_MISS      3
> +#define SMMU_PMU_TRANS_TABLE_WALK       4
> +#define SMMU_PMU_CONFIG_STRUCT_ACCESS   5
> +#define SMMU_PMU_PCIE_ATS_TRANS_RQ      6
> +#define SMMU_PMU_PCIE_ATS_TRANS_PASSED  7

It might just be me, but I actually find it *less* helpful to have this 
extra level of indirection between the event names and numbers.

> +
> +static int cpuhp_state_num;
> +
> +struct smmu_pmu {
> +	struct hlist_node node;
> +	struct perf_event *events[SMMU_MAX_COUNTERS];
> +	DECLARE_BITMAP(used_counters, SMMU_MAX_COUNTERS);
> +	DECLARE_BITMAP(supported_events, SMMU_ARCH_MAX_EVENT_ID);
> +	unsigned int irq;
> +	unsigned int on_cpu;
> +	struct pmu pmu;
> +	unsigned int num_counters;
> +	struct device *dev;
> +	void __iomem *reg_base;
> +	void __iomem *reloc_base;
> +	u64 counter_present_mask;
> +	u64 counter_mask;
> +};
> +
> +#define to_smmu_pmu(p) (container_of(p, struct smmu_pmu, pmu))
> +
> +#define SMMU_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _size, _shift)    \
> +	static inline u32 get_##_name(struct perf_event *event)         \
> +	{                                                               \
> +		return (event->attr._config >> (_shift)) &              \
> +			GENMASK_ULL((_size) - 1, 0);                    \
> +	}
> +
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(event, config, 16, 0);
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_stream_id, config1, 32, 0);
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_span, config1, 1, 32);
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_enable, config1, 1, 34);
> +
> +static inline void smmu_pmu_enable(struct pmu *pmu)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
> +
> +	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base + SMMU_PMCG_CR);
> +	writel(SMMU_PMCG_IRQ_CTRL_IRQEN,
> +	       smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
> +}
> +
> +static inline void smmu_pmu_disable(struct pmu *pmu)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
> +
> +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_CR);
> +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
> +}
> +
> +static inline void smmu_pmu_counter_set_value(struct smmu_pmu *smmu_pmu,
> +					      u32 idx, u64 value)
> +{
> +	if (smmu_pmu->counter_mask & BIT(32))
> +		writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 8));
> +	else
> +		writel(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 4));
> +}
> +
> +static inline u64 smmu_pmu_counter_get_value(struct smmu_pmu *smmu_pmu, u32 idx)
> +{
> +	u64 value;
> +
> +	if (smmu_pmu->counter_mask & BIT(32))
> +		value = readq(smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 8));
> +	else
> +		value = readl(smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 4));
> +
> +	return value;
> +}
> +
> +static inline void smmu_pmu_counter_enable(struct smmu_pmu *smmu_pmu, u32 idx)
> +{
> +	writeq(BIT(idx), smmu_pmu->reg_base + SMMU_PMCG_CNTENSET0);
> +}
> +
> +static inline void smmu_pmu_counter_disable(struct smmu_pmu *smmu_pmu, u32 idx)
> +{
> +	writeq(BIT(idx), smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
> +}
> +
> +static inline void smmu_pmu_interrupt_enable(struct smmu_pmu *smmu_pmu, u32 idx)
> +{
> +	writeq(BIT(idx), smmu_pmu->reg_base + SMMU_PMCG_INTENSET0);
> +}
> +
> +static inline void smmu_pmu_interrupt_disable(struct smmu_pmu *smmu_pmu,
> +					      u32 idx)
> +{
> +	writeq(BIT(idx), smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);
> +}
> +
> +static inline void smmu_pmu_set_evtyper(struct smmu_pmu *smmu_pmu, u32 idx,
> +					u32 val)
> +{
> +	writel(val, smmu_pmu->reg_base + SMMU_PMCG_EVTYPER(idx));
> +}
> +
> +static inline void smmu_pmu_set_smr(struct smmu_pmu *smmu_pmu, u32 idx, u32 val)
> +{
> +	writel(val, smmu_pmu->reg_base + SMMU_PMCG_SMR(idx));
> +}
> +
> +static inline u64 smmu_pmu_getreset_ovsr(struct smmu_pmu *smmu_pmu)
> +{
> +	u64 result = readq_relaxed(smmu_pmu->reloc_base + SMMU_PMCG_OVSSET0);

Hmm, this is the only relaxed access in the driver, but IIRC the IRQ 
status is about the one place where you usually *do* want a non-relaxed 
access :/

> +
> +	writeq(result, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
> +	return result;

Again, I very much think this would be clearer *not* broken out into a 
single-use helper (the name isn't entirely self-explanatory either). 
Plus, as-is you can't avoid pointlessly writing back 0 to OVSCLR in the 
shared-interrupt case.

> +}
> +
> +static void smmu_pmu_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx = hwc->idx;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		now = smmu_pmu_counter_get_value(smmu_pmu, idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	/* handle overflow. */
> +	delta = now - prev;
> +	delta &= smmu_pmu->counter_mask;
> +
> +	local64_add(delta, &event->count);
> +}
> +
> +static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
> +				struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +	u64 new;
> +
> +	/*
> +	 * We limit the max period to half the max counter value of the counter
> +	 * size, so that even in the case of extreme interrupt latency the
> +	 * counter will (hopefully) not wrap past its initial value.
> +	 */
> +	new = smmu_pmu->counter_mask >> 1;
> +
> +	local64_set(&hwc->prev_count, new);
> +	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
> +}
> +
> +static unsigned int smmu_pmu_get_event_idx(struct smmu_pmu *smmu_pmu)
> +{
> +	unsigned int idx;
> +	unsigned int num_ctrs = smmu_pmu->num_counters;
> +
> +	idx = find_first_zero_bit(smmu_pmu->used_counters, num_ctrs);
> +	if (idx == num_ctrs)
> +		/* The counters are all in use. */
> +		return -EAGAIN;
> +
> +	set_bit(idx, smmu_pmu->used_counters);
> +
> +	return idx;
> +}
> +
> +/*
> + * Implementation of abstract pmu functionality required by
> + * the core perf events code.
> + */
> +
> +static int smmu_pmu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event *sibling;
> +	struct smmu_pmu *smmu_pmu;
> +	u32 event_id;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	smmu_pmu = to_smmu_pmu(event->pmu);
> +
> +	if (hwc->sample_period) {
> +		dev_dbg_ratelimited(smmu_pmu->dev,
> +				    "Sampling not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_dbg_ratelimited(smmu_pmu->dev,
> +				    "Per-task mode not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* We cannot filter accurately so we just don't allow it. */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv || event->attr.exclude_idle) {
> +		dev_dbg_ratelimited(smmu_pmu->dev,
> +				    "Can't exclude execution levels\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Verify specified event is supported on this PMU */
> +	event_id = get_event(event);
> +	if (((event_id < SMMU_ARCH_MAX_EVENT_ID) &&
> +	    (!test_bit(event_id, smmu_pmu->supported_events))) ||
> +	    (event_id > SMMU_IMPDEF_MAX_EVENT_ID)) {
> +		dev_dbg_ratelimited(smmu_pmu->dev,
> +				    "Invalid event %d for this PMU\n",
> +				    event_id);
> +		return -EINVAL;
> +	}
> +
> +	/* Don't allow groups with mixed PMUs, except for s/w events */
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader)) {
> +		dev_dbg_ratelimited(smmu_pmu->dev,
> +			 "Can't create mixed PMU group\n");
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> +			    sibling_list)
> +		if (sibling->pmu != event->pmu &&
> +		    !is_software_event(sibling)) {
> +			dev_dbg_ratelimited(smmu_pmu->dev,
> +				 "Can't create mixed PMU group\n");
> +			return -EINVAL;
> +		}
> +
> +	/* Ensure all events in a group are on the same cpu */
> +	if ((event->group_leader != event) &&
> +	    (event->cpu != event->group_leader->cpu)) {
> +		dev_dbg_ratelimited(smmu_pmu->dev,
> +			 "Can't create group on CPUs %d and %d",
> +			 event->cpu, event->group_leader->cpu);
> +		return -EINVAL;
> +	}
> +
> +	hwc->idx = -1;
> +
> +	/*
> +	 * Ensure all events are on the same cpu so all events are in the
> +	 * same cpu context, to avoid races on pmu_enable etc.
> +	 */
> +	event->cpu = smmu_pmu->on_cpu;
> +
> +	return 0;
> +}
> +
> +static void smmu_pmu_event_start(struct perf_event *event, int flags)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +	u32 evtyper;
> +	u32 filter_span;
> +	u32 filter_stream_id;
> +
> +	hwc->state = 0;
> +
> +	smmu_pmu_set_period(smmu_pmu, hwc);
> +
> +	if (get_filter_enable(event)) {
> +		filter_span = get_filter_span(event);
> +		filter_stream_id = get_filter_stream_id(event);
> +	} else {
> +		filter_span = SMMU_DEFAULT_FILTER_SPAN;
> +		filter_stream_id = SMMU_DEFAULT_FILTER_STREAM_ID;
> +	}
> +
> +	evtyper = get_event(event) |
> +		  filter_span << SMMU_PMCG_EVTYPER_SID_SPAN_SHIFT;
> +
> +	smmu_pmu_set_evtyper(smmu_pmu, idx, evtyper);
> +	smmu_pmu_set_smr(smmu_pmu, idx, filter_stream_id);
> +	smmu_pmu_interrupt_enable(smmu_pmu, idx);
> +	smmu_pmu_counter_enable(smmu_pmu, idx);
> +}
> +
> +static void smmu_pmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	smmu_pmu_interrupt_disable(smmu_pmu, idx);

Is there any need to toggle the interrupt like this? As long as the 
counter's stopped, it's not going to overflow and generate an IRQ. Yes, 
there's a race where you might take an interrupt for a stopped counter 
if it overflows *while* CNTENCLR is being written, but explicitly 
writing INTENCLR like this doesn't solve that anyway - an IRQ may be 
latched at the GIC (or be an in-flight MSI write) as you write INTENCLR, 
so you could still end up taking it 'spuriously' after hitting CNTENCLR.

> +	smmu_pmu_counter_disable(smmu_pmu, idx);
> +
> +	if (flags & PERF_EF_UPDATE)
> +		smmu_pmu_event_update(event);
> +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int smmu_pmu_event_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> +
> +	idx = smmu_pmu_get_event_idx(smmu_pmu);
> +	if (idx < 0)
> +		return idx;
> +
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	smmu_pmu->events[idx] = event;
> +	local64_set(&hwc->prev_count, 0);
> +
> +	if (flags & PERF_EF_START)
> +		smmu_pmu_event_start(event, flags);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void smmu_pmu_event_del(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> +	int idx = hwc->idx;
> +
> +	smmu_pmu_event_stop(event, flags | PERF_EF_UPDATE);
> +	smmu_pmu->events[idx] = NULL;
> +	clear_bit(idx, smmu_pmu->used_counters);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void smmu_pmu_event_read(struct perf_event *event)
> +{
> +	smmu_pmu_event_update(event);
> +}
> +
> +/* cpumask */
> +
> +static ssize_t smmu_pmu_cpumask_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(smmu_pmu->on_cpu));
> +}
> +
> +static struct device_attribute smmu_pmu_cpumask_attr =
> +		__ATTR(cpumask, 0444, smmu_pmu_cpumask_show, NULL);
> +
> +static struct attribute *smmu_pmu_cpumask_attrs[] = {
> +	&smmu_pmu_cpumask_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group smmu_pmu_cpumask_group = {
> +	.attrs = smmu_pmu_cpumask_attrs,
> +};
> +
> +/* Events */
> +
> +ssize_t smmu_pmu_event_show(struct device *dev,
> +			    struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define SMMU_EVENT_ATTR(_name, _id)					  \
> +	(&((struct perf_pmu_events_attr[]) {				  \
> +		{ .attr = __ATTR(_name, 0444, smmu_pmu_event_show, NULL), \
> +		  .id = _id, }						  \
> +	})[0].attr.attr)
> +
> +static struct attribute *smmu_pmu_events[] = {
> +	SMMU_EVENT_ATTR(cycles, SMMU_PMU_CYCLES),
> +	SMMU_EVENT_ATTR(transaction, SMMU_PMU_TRANSACTION),
> +	SMMU_EVENT_ATTR(tlb_miss, SMMU_PMU_TLB_MISS),
> +	SMMU_EVENT_ATTR(config_cache_miss, SMMU_PMU_CONFIG_CACHE_MISS),
> +	SMMU_EVENT_ATTR(trans_table_walk, SMMU_PMU_TRANS_TABLE_WALK),
> +	SMMU_EVENT_ATTR(config_struct_access, SMMU_PMU_CONFIG_STRUCT_ACCESS),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_rq, SMMU_PMU_PCIE_ATS_TRANS_RQ),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_passed, SMMU_PMU_PCIE_ATS_TRANS_PASSED),
> +	NULL
> +};
> +
> +static umode_t smmu_pmu_event_is_visible(struct kobject *kobj,
> +					 struct attribute *attr, int unused)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
> +
> +	if (test_bit(pmu_attr->id, smmu_pmu->supported_events))
> +		return attr->mode;
> +
> +	return 0;
> +}
> +static struct attribute_group smmu_pmu_events_group = {
> +	.name = "events",
> +	.attrs = smmu_pmu_events,
> +	.is_visible = smmu_pmu_event_is_visible,
> +};
> +
> +/* Formats */
> +PMU_FORMAT_ATTR(event,		   "config:0-15");
> +PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
> +PMU_FORMAT_ATTR(filter_span,	   "config1:32");
> +PMU_FORMAT_ATTR(filter_enable,	   "config1:33");
> +
> +static struct attribute *smmu_pmu_formats[] = {
> +	&format_attr_event.attr,
> +	&format_attr_filter_stream_id.attr,
> +	&format_attr_filter_span.attr,
> +	&format_attr_filter_enable.attr,
> +	NULL
> +};
> +
> +static struct attribute_group smmu_pmu_format_group = {
> +	.name = "format",
> +	.attrs = smmu_pmu_formats,
> +};
> +
> +static const struct attribute_group *smmu_pmu_attr_grps[] = {
> +	&smmu_pmu_cpumask_group,
> +	&smmu_pmu_events_group,
> +	&smmu_pmu_format_group,
> +	NULL,
> +};
> +
> +/*
> + * Generic device handlers
> + */
> +
> +static unsigned int get_num_counters(struct smmu_pmu *smmu_pmu)
> +{
> +	u32 cfgr = readl(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
> +
> +	return ((cfgr & SMMU_PMCG_CFGR_NCTR_MASK) >> SMMU_PMCG_CFGR_NCTR_SHIFT)
> +		+ 1;

The code would be considerably simpler if this were inline at the one 
single place it's ever used. Re-reading CFGR for every single field is 
just silly.

> +}
> +
> +static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct smmu_pmu *smmu_pmu;
> +	unsigned int target;
> +
> +	smmu_pmu = hlist_entry_safe(node, struct smmu_pmu, node);
> +	if (cpu != smmu_pmu->on_cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> +	smmu_pmu->on_cpu = target;
> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
> +
> +	return 0;
> +}
> +
> +static int smmu_pmu_get_dev_id(const char *name, unsigned long *id)
> +{
> +	char *temp, *start, *end;
> +	int ret = -EINVAL;
> +
> +	temp = kstrdup(name, GFP_KERNEL);
> +	if (!temp)
> +		return ret;
> +
> +	end = strrchr(temp, '.');
> +	if (!end)
> +		goto out;
> +
> +	temp[end - temp] = '\0';
> +	start = strchr(temp, '.');
> +	if (!start)
> +		goto out;
> +
> +	ret = kstrtoul(&temp[start - temp + 1], 10, id);

That's a pretty roundabout way to not simply dereference 
to_platform_device(dev)->id ;)

Also, how relevant is it going to be for future DT support? We don't 
really want too many artificial dependencies on the way ACPI support 
happens to currently be implemented.

> +out:
> +	kfree(temp);
> +	return ret;
> +}
> +
> +
> +static char *smmu_pmu_assign_name(struct smmu_pmu *pmu)
> +{
> +	unsigned long id;
> +	struct device *smmu, *dev = pmu->dev;
> +	char *s_name = NULL, *p_name = NULL;
> +
> +	smmu = iort_find_pmcg_ref_smmu(dev);
> +	if (smmu) {
> +		if (!smmu_pmu_get_dev_id(dev_name(smmu), &id))
> +			s_name = kasprintf(GFP_KERNEL, "arm_smmu_v3_%lu", id);
> +	}
> +
> +	if (!s_name)
> +		s_name = kasprintf(GFP_KERNEL, "arm_smmu_v3");

As I touched on before, I think it's worth generalising this from the 
start, and trying to resolve the component reference to a struct device 
rather than IORT/SMMU specific internals. However it also occurs to me 
that maybe this isn't as important as it first seemed - since the 
auto-numbered ID doesn't actually say which PMCG is which, the only way 
for the user to actually identify which PMU is the correct one to count 
events for a particular endpoint is still to grovel up the base address, 
so as long as the PMU name uniquely correlates to the PMCG device, I'm 
not sure anything really matters beyond that.

> +
> +	if (smmu_pmu_get_dev_id(dev_name(dev), &id))
> +		goto out;
> +
> +	p_name = devm_kasprintf(dev, GFP_KERNEL, "%s_pmcg_%lu", s_name, id);
> +out:
> +	kfree(s_name);
> +	return p_name;
> +}
> +
> +static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
> +{
> +	struct smmu_pmu *smmu_pmu = data;
> +	u64 ovsr;
> +	unsigned int idx;
> +
> +	ovsr = smmu_pmu_getreset_ovsr(smmu_pmu);
> +	if (!ovsr)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) {
> +		struct perf_event *event = smmu_pmu->events[idx];
> +		struct hw_perf_event *hwc;
> +
> +		if (WARN_ON_ONCE(!event))
> +			continue;
> +
> +		smmu_pmu_event_update(event);
> +		hwc = &event->hw;
> +
> +		smmu_pmu_set_period(smmu_pmu, hwc);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
> +{
> +	/* Disable counter and interrupt */
> +	writeq(smmu_pmu->counter_present_mask,
> +			smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
> +	writeq(smmu_pmu->counter_present_mask,
> +		smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);

There are a number of other registers like OVS and IRQ_CFG* which have 
unknown reset values so probably want sanitising.

> +
> +	smmu_pmu_disable(&smmu_pmu->pmu);

It might make more sense to hit the global disable first, then clean up 
the rest of the state.

> +	return 0;
> +}
> +
> +static int smmu_pmu_probe(struct platform_device *pdev)
> +{
> +	struct smmu_pmu *smmu_pmu;
> +	struct resource *mem_resource_0, *mem_resource_1;
> +	void __iomem *mem_map_0, *mem_map_1;
> +	unsigned int reg_size;
> +	u64 ceid_64[2];
> +	int irq, err;
> +	struct device *dev = &pdev->dev;
> +
> +	smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu), GFP_KERNEL);
> +	if (!smmu_pmu)
> +		return -ENOMEM;
> +
> +	smmu_pmu->dev = dev;
> +
> +	platform_set_drvdata(pdev, smmu_pmu);
> +	smmu_pmu->pmu = (struct pmu) {
> +		.task_ctx_nr    = perf_invalid_context,
> +		.pmu_enable	= smmu_pmu_enable,
> +		.pmu_disable	= smmu_pmu_disable,
> +		.event_init	= smmu_pmu_event_init,
> +		.add		= smmu_pmu_event_add,
> +		.del		= smmu_pmu_event_del,
> +		.start		= smmu_pmu_event_start,
> +		.stop		= smmu_pmu_event_stop,
> +		.read		= smmu_pmu_event_read,
> +		.attr_groups	= smmu_pmu_attr_grps,
> +	};
> +
> +	mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mem_map_0 = devm_ioremap_resource(dev, mem_resource_0);
> +
> +	if (IS_ERR(mem_map_0)) {
> +		dev_err(dev, "Can't map SMMU PMU @%pa\n",
> +			&mem_resource_0->start);
> +		return PTR_ERR(mem_map_0);
> +	}
> +
> +	smmu_pmu->reg_base = mem_map_0;
> +
> +	smmu_pmu->pmu.name = smmu_pmu_assign_name(smmu_pmu);

It seems a bit odd to assign to pmu.name directly, given that that's 
really perf_pmu_register()'s job. (Bonus nit: it also feels a bit odd to 
be worrying about the PMU name right in the middle of discovering the 
hardware; personally I'd leave it until the end it's actually needed. 
TBH the whole function seems a bit mixed up in terms of logical order)

> +	if (!smmu_pmu->pmu.name) {
> +		dev_err(dev, "Failed to create PMU name");
> +		return -EINVAL;
> +	}
> +
> +	ceid_64[0] = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
> +	ceid_64[1] = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
> +	bitmap_from_arr32(smmu_pmu->supported_events, (u32 *)ceid_64,
> +					SMMU_ARCH_MAX_EVENT_ID);

I probably said this before and have forgotten the outcome, but is this 
endian-safe, or does it risk shuffling alternate words in the bitmap?

> +
> +	/* Determine if page 1 is present */
> +	if (readl(smmu_pmu->reg_base + SMMU_PMCG_CFGR) &
> +	    SMMU_PMCG_CFGR_RELOC_CTRS) {
> +		mem_resource_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		mem_map_1 = devm_ioremap_resource(dev, mem_resource_1);
> +
> +		if (IS_ERR(mem_map_1)) {
> +			dev_err(dev, "Can't map SMMU PMU @%pa\n",
> +				&mem_resource_1->start);
> +			return PTR_ERR(mem_map_1);
> +		}
> +		smmu_pmu->reloc_base = mem_map_1;
> +	} else {
> +		smmu_pmu->reloc_base = smmu_pmu->reg_base;
> +	}

Actually, you may as well pull the number-of-counters stuff up here, 
because it's silly to go and read CFGR twice in the same function.

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "Failed to get valid irq for smmu @%pa\n",
> +			&mem_resource_0->start);
> +		return irq;
> +	}
> +
> +	err = devm_request_irq(dev, irq, smmu_pmu_handle_irq,
> +			       IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD,
> +			       "smmu-pmu", smmu_pmu);
> +	if (err) {
> +		dev_err(dev,
> +			"Unable to request IRQ%d for SMMU PMU counters\n", irq);
> +		return err;
> +	}
> +
> +	smmu_pmu->irq = irq;
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	smmu_pmu->on_cpu = smp_processor_id();

Do we want this to be a get_cpu() to avoid complications from hotplug 
events between here and actually having registered the handler? ISTR 
copying that pattern from somewhere (probably arm-cci) for one of my 
drivers.

> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> +
> +	smmu_pmu->num_counters = get_num_counters(smmu_pmu);
> +	smmu_pmu->counter_present_mask = GENMASK(smmu_pmu->num_counters - 1, 0);
> +	reg_size = (readl(smmu_pmu->reg_base + SMMU_PMCG_CFGR) &
> +		    SMMU_PMCG_CFGR_SIZE_MASK) >> SMMU_PMCG_CFGR_SIZE_SHIFT;

Nit: it might be worth using some bitfield.h magic to clean up accessors 
like this (yes, it's still my new favourite thing). Also, we may as well 
use relaxed reads for the ID registers at least, since they definitely 
have no subtle ordering to worry about.

> +	smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
> +
> +	smmu_pmu_reset(smmu_pmu);
> +
> +	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> +					       &smmu_pmu->node);
> +	if (err) {
> +		dev_err(dev, "Error %d registering hotplug", err);
> +		return err;
> +	}
> +
> +	err = perf_pmu_register(&smmu_pmu->pmu, smmu_pmu->pmu.name, -1);
> +	if (err) {
> +		dev_err(dev, "Error %d registering SMMU PMU\n", err);
> +		goto out_unregister;
> +	}
> +
> +	dev_info(dev, "Registered SMMU PMU @ %pa using %d counters\n",
> +		 &mem_resource_0->start, smmu_pmu->num_counters);
> +
> +	return err;
> +
> +out_unregister:
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +	return err;
> +}
> +
> +static int smmu_pmu_remove(struct platform_device *pdev)
> +{
> +	struct smmu_pmu *smmu_pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&smmu_pmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +
> +	return 0;
> +}
> +
> +static void smmu_pmu_shutdown(struct platform_device *pdev)
> +{
> +	struct smmu_pmu *smmu_pmu = platform_get_drvdata(pdev);
> +
> +	smmu_pmu_disable(&smmu_pmu->pmu);
> +}
> +
> +static struct platform_driver smmu_pmu_driver = {
> +	.driver = {
> +		.name = "arm-smmu-v3-pmu",
> +	},
> +	.probe = smmu_pmu_probe,
> +	.remove = smmu_pmu_remove,
> +	.shutdown = smmu_pmu_shutdown,
> +};
> +
> +static int __init arm_smmu_pmu_init(void)
> +{
> +	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "perf/arm/smmupmu:online",

Nit: "smmupmu" looks a bit wacky as a name - TBH I think just "smmuv3" 
or "pmcg" would be enough.

> +				      NULL,
> +				      smmu_pmu_offline_cpu);
> +	if (cpuhp_state_num < 0)
> +		return cpuhp_state_num;
> +
> +	return platform_driver_register(&smmu_pmu_driver);
> +}
> +module_init(arm_smmu_pmu_init);
> +
> +static void __exit arm_smmu_pmu_exit(void)
> +{

Should we not be removing the hotplug state?

Robin.

> +	platform_driver_unregister(&smmu_pmu_driver);
> +}
> +
> +module_exit(arm_smmu_pmu_exit);
> +MODULE_LICENSE("GPL v2");
> 
