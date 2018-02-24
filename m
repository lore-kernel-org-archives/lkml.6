Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeBXAxY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:53:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeBXAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:53:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8391600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A90B77E.8040105@codeaurora.org>
Date: Fri, 23 Feb 2018 16:53:18 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: will.deacon@arm.com, mark.rutland@arm.com, robh@kernel.org,
        sudeep.holla@arm.com, mathieu.poirier@linaro.org, peterz@infradead.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, leo.yan@linaro.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com>
In-Reply-To: <20180102112533.13640-9-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
> The DSU integrates one or more cores with an L3 memory system, control
> logic, and external interfaces to form a multicore cluster. The PMU
> allows counting the various events related to L3, SCU etc, along with
> providing a cycle counter.
>
> The PMU can be accessed via system registers, which are common
> to the cores in the same cluster. The PMU registers follow the
> semantics of the ARMv8 PMU, mostly, with the exception that
> the counters record the cluster wide events.
>
> This driver is mostly based on the ARMv8 and CCI PMU drivers.
> The driver only supports ARM64 at the moment. It can be extended
> to support ARM32 by providing register accessors like we do in
> arch/arm64/include/arm_dsu_pmu.h.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V9:
>   - Rely on cpuhp callback for probing the PMU.
>   - Clear the overflow mask whenever the first CPU is brought up.
>   - Remove dsu_pmu_get_online_cpu(), which is not needed anymore.
>   - Flip the order of context migration and setting the active CPU.
>
> Changes since V8:
>   - Include required header files (Mark Rutland)
>   - Remove Kconfig dependency on PERF_EVENTS (Mark Rutland)
>   - Fix typo in event name, bus_acesss => bus_access (Mark Rutland)
>   - Use find_first_zero_bit instead of find_next_zero_bit (Mark Rutland)
>   - Change order of checks in dsu_pmu_event_init (Mark Rutland)
>   - Allow lazy initialisation of DSU PMU to handle cases where CPUs
>     may be brought up later (e.g, maxcpus=N)- Mark Rutland.
>   - Clear the interrupt overflow status upon initialisation (Mark Rutland)
>   - Change the CPU check to "

" from "active_cpus",
>     as when we migrate the perf context we will access the DSU
>     from two different CPUs (source and destination).
>   - Fill in the "module" field for the PMU to prevent the module unload
>     when the PMU is active.
> Changes since V6:
>   - Address comments from Jonathan
>   - Add Reviewed-by tags from Jonathan
> Changes since V5:
>   - Address comments on V5 by Mark.
>   - Use IRQ_NOBALANCING for IRQ handler
>   - Don't expose events which could be unimplemented.
>   - Get rid of dsu_pmu_event_supported and allow raw event
>     code to be used without validating whether it is supported.
>   - Rename "supported_cpus" mask to "associated_cpus"
>   - Add Documentation for the PMU driver
>   - Don't disable IRQ for dsu_pmu_{enable/disable}_counters
>   - Use consistent return codes for validate_event/group calls.
>   - Check PERF_ATTACH_TASK flag in event_init.
>   - Allow missing CPUs in dsu_pmu_dt_get_cpus, to handle cases
>     where kernel could have capped nr_cpus.
>   - Cleanup sanity checking for the CPU before accessing DSU
>   - Reject events with counting CPU not associated with the DSU.
> Changes since V4:
>   - Reflect the changed generic helper for mapping CPU id
> Changes since V2:
>   - Cleanup dsu_pmu_device_probe error handling.
>   - Fix event validate_group to invert the result check of validate_event
>   - Return errors if we failed to parse CPUs in the DSU.
>   - Add MODULE_DEVICE_TABLE entry
>   - Use hlist_entry_safe for converting cpuhp_node to dsu_pmu.
> ---
>   Documentation/perf/arm_dsu_pmu.txt   |  28 ++
>   arch/arm64/include/asm/arm_dsu_pmu.h | 129 ++++++
>   drivers/perf/Kconfig                 |   9 +
>   drivers/perf/Makefile                |   1 +
>   drivers/perf/arm_dsu_pmu.c           | 843 +++++++++++++++++++++++++++++++++++
>   5 files changed, 1010 insertions(+)
>   create mode 100644 Documentation/perf/arm_dsu_pmu.txt
>   create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
>   create mode 100644 drivers/perf/arm_dsu_pmu.c
>
> diff --git a/Documentation/perf/arm_dsu_pmu.txt b/Documentation/perf/arm_dsu_pmu.txt
> new file mode 100644
> index 000000000000..d611e15f5add
> --- /dev/null
> +++ b/Documentation/perf/arm_dsu_pmu.txt
> @@ -0,0 +1,28 @@
> +ARM DynamIQ Shared Unit (DSU) PMU
> +==================================
> +
> +ARM DynamIQ Shared Unit integrates one or more cores with an L3 memory system,
> +control logic and external interfaces to form a multicore cluster. The PMU
> +allows counting the various events related to the L3 cache, Snoop Control Unit
> +etc, using 32bit independent counters. It also provides a 64bit cycle counter.
> +
> +The PMU can only be accessed via CPU system registers and are common to the
> +cores connected to the same DSU. Like most of the other uncore PMUs, DSU
> +PMU doesn't support process specific events and cannot be used in sampling mode.
> +
> +The DSU provides a bitmap for a subset of implemented events via hardware
> +registers. There is no way for the driver to determine if the other events
> +are available or not. Hence the driver exposes only those events advertised
> +by the DSU, in "events" directory under :
> +
> +  /sys/bus/event_sources/devices/arm_dsu_<N>/
> +
> +The user should refer to the TRM of the product to figure out the supported events
> +and use the raw event code for the unlisted events.
> +
> +The driver also exposes the CPUs connected to the DSU instance in "associated_cpus".
> +
> +
> +e.g usage :
> +
> +	perf stat -a -e arm_dsu_0/cycles/
> diff --git a/arch/arm64/include/asm/arm_dsu_pmu.h b/arch/arm64/include/asm/arm_dsu_pmu.h
> new file mode 100644
> index 000000000000..82e5cc3356bf
> --- /dev/null
> +++ b/arch/arm64/include/asm/arm_dsu_pmu.h
> @@ -0,0 +1,129 @@
> +/*
> + * ARM DynamIQ Shared Unit (DSU) PMU Low level register access routines.
> + *
> + * Copyright (C) ARM Limited, 2017.
> + *
> + * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/build_bug.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <asm/barrier.h>
> +#include <asm/sysreg.h>
> +
> +
> +#define CLUSTERPMCR_EL1			sys_reg(3, 0, 15, 5, 0)
> +#define CLUSTERPMCNTENSET_EL1		sys_reg(3, 0, 15, 5, 1)
> +#define CLUSTERPMCNTENCLR_EL1		sys_reg(3, 0, 15, 5, 2)
> +#define CLUSTERPMOVSSET_EL1		sys_reg(3, 0, 15, 5, 3)
> +#define CLUSTERPMOVSCLR_EL1		sys_reg(3, 0, 15, 5, 4)
> +#define CLUSTERPMSELR_EL1		sys_reg(3, 0, 15, 5, 5)
> +#define CLUSTERPMINTENSET_EL1		sys_reg(3, 0, 15, 5, 6)
> +#define CLUSTERPMINTENCLR_EL1		sys_reg(3, 0, 15, 5, 7)
> +#define CLUSTERPMCCNTR_EL1		sys_reg(3, 0, 15, 6, 0)
> +#define CLUSTERPMXEVTYPER_EL1		sys_reg(3, 0, 15, 6, 1)
> +#define CLUSTERPMXEVCNTR_EL1		sys_reg(3, 0, 15, 6, 2)
> +#define CLUSTERPMMDCR_EL1		sys_reg(3, 0, 15, 6, 3)
> +#define CLUSTERPMCEID0_EL1		sys_reg(3, 0, 15, 6, 4)
> +#define CLUSTERPMCEID1_EL1		sys_reg(3, 0, 15, 6, 5)
> +
> +static inline u32 __dsu_pmu_read_pmcr(void)
> +{
> +	return read_sysreg_s(CLUSTERPMCR_EL1);
> +}
> +
> +static inline void __dsu_pmu_write_pmcr(u32 val)
> +{
> +	write_sysreg_s(val, CLUSTERPMCR_EL1);
> +	isb();
> +}
> +
> +static inline u32 __dsu_pmu_get_reset_overflow(void)
> +{
> +	u32 val = read_sysreg_s(CLUSTERPMOVSCLR_EL1);
> +	/* Clear the bit */
> +	write_sysreg_s(val, CLUSTERPMOVSCLR_EL1);
> +	isb();
> +	return val;
> +}
> +
> +static inline void __dsu_pmu_select_counter(int counter)
> +{
> +	write_sysreg_s(counter, CLUSTERPMSELR_EL1);
> +	isb();
> +}
> +
> +static inline u64 __dsu_pmu_read_counter(int counter)
> +{
> +	__dsu_pmu_select_counter(counter);
> +	return read_sysreg_s(CLUSTERPMXEVCNTR_EL1);
> +}
> +
> +static inline void __dsu_pmu_write_counter(int counter, u64 val)
> +{
> +	__dsu_pmu_select_counter(counter);
> +	write_sysreg_s(val, CLUSTERPMXEVCNTR_EL1);
> +	isb();
> +}
> +
> +static inline void __dsu_pmu_set_event(int counter, u32 event)
> +{
> +	__dsu_pmu_select_counter(counter);
> +	write_sysreg_s(event, CLUSTERPMXEVTYPER_EL1);
> +	isb();
> +}
> +
> +static inline u64 __dsu_pmu_read_pmccntr(void)
> +{
> +	return read_sysreg_s(CLUSTERPMCCNTR_EL1);
> +}
> +
> +static inline void __dsu_pmu_write_pmccntr(u64 val)
> +{
> +	write_sysreg_s(val, CLUSTERPMCCNTR_EL1);
> +	isb();
> +}
> +
> +static inline void __dsu_pmu_disable_counter(int counter)
> +{
> +	write_sysreg_s(BIT(counter), CLUSTERPMCNTENCLR_EL1);
> +	isb();
> +}
> +
> +static inline void __dsu_pmu_enable_counter(int counter)
> +{
> +	write_sysreg_s(BIT(counter), CLUSTERPMCNTENSET_EL1);
> +	isb();
> +}
> +
> +static inline void __dsu_pmu_counter_interrupt_enable(int counter)
> +{
> +	write_sysreg_s(BIT(counter), CLUSTERPMINTENSET_EL1);
> +	isb();
> +}
> +
> +static inline void __dsu_pmu_counter_interrupt_disable(int counter)
> +{
> +	write_sysreg_s(BIT(counter), CLUSTERPMINTENCLR_EL1);
> +	isb();
> +}
> +
> +
> +static inline u32 __dsu_pmu_read_pmceid(int n)
> +{
> +	switch (n) {
> +	case 0:
> +		return read_sysreg_s(CLUSTERPMCEID0_EL1);
> +	case 1:
> +		return read_sysreg_s(CLUSTERPMCEID1_EL1);
> +	default:
> +		BUILD_BUG();
> +		return 0;
> +	}
> +}
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index b8f44b068fc6..da5724cd89cf 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -17,6 +17,15 @@ config ARM_PMU_ACPI
>   	depends on ARM_PMU && ACPI
>   	def_bool y
>
> +config ARM_DSU_PMU
> +	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
> +	depends on ARM64
> +	  help
> +	  Provides support for performance monitor unit in ARM DynamIQ Shared
> +	  Unit (DSU). The DSU integrates one or more cores with an L3 memory
> +	  system, control logic. The PMU allows counting various events related
> +	  to DSU.
> +
>   config HISI_PMU
>          bool "HiSilicon SoC PMU"
>          depends on ARM64 && ACPI
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 710a0135bd61..c2f27419bdf0 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
>   obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
>   obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>   obj-$(CONFIG_HISI_PMU) += hisilicon/
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> new file mode 100644
> index 000000000000..37c0526c93d5
> --- /dev/null
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -0,0 +1,843 @@
> +/*
> + * ARM DynamIQ Shared Unit (DSU) PMU driver
> + *
> + * Copyright (C) ARM Limited, 2017.
> + *
> + * Based on ARM CCI-PMU, ARMv8 PMU-v3 drivers.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#define PMUNAME		"arm_dsu"
> +#define DRVNAME		PMUNAME "_pmu"
> +#define pr_fmt(fmt)	DRVNAME ": " fmt
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/smp.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <asm/arm_dsu_pmu.h>
> +#include <asm/local64.h>
> +
> +/* PMU event codes */
> +#define DSU_PMU_EVT_CYCLES		0x11
> +#define DSU_PMU_EVT_CHAIN		0x1e
> +
> +#define DSU_PMU_MAX_COMMON_EVENTS	0x40
> +
> +#define DSU_PMU_MAX_HW_CNTRS		32
> +#define DSU_PMU_HW_COUNTER_MASK		(DSU_PMU_MAX_HW_CNTRS - 1)
> +
> +#define CLUSTERPMCR_E			BIT(0)
> +#define CLUSTERPMCR_P			BIT(1)
> +#define CLUSTERPMCR_C			BIT(2)
> +#define CLUSTERPMCR_N_SHIFT		11
> +#define CLUSTERPMCR_N_MASK		0x1f
> +#define CLUSTERPMCR_IDCODE_SHIFT	16
> +#define CLUSTERPMCR_IDCODE_MASK		0xff
> +#define CLUSTERPMCR_IMP_SHIFT		24
> +#define CLUSTERPMCR_IMP_MASK		0xff
> +#define CLUSTERPMCR_RES_MASK		0x7e8
> +#define CLUSTERPMCR_RES_VAL		0x40
> +
> +#define DSU_ACTIVE_CPU_MASK		0x0
> +#define DSU_ASSOCIATED_CPU_MASK		0x1
> +
> +/*
> + * We use the index of the counters as they appear in the counter
> + * bit maps in the PMU registers (e.g CLUSTERPMSELR).
> + * i.e,
> + *	counter 0	- Bit 0
> + *	counter 1	- Bit 1
> + *	...
> + *	Cycle counter	- Bit 31
> + */
> +#define DSU_PMU_IDX_CYCLE_COUNTER	31
> +
> +/* All event counters are 32bit, with a 64bit Cycle counter */
> +#define DSU_PMU_COUNTER_WIDTH(idx)	\
> +	(((idx) == DSU_PMU_IDX_CYCLE_COUNTER) ? 64 : 32)
> +
> +#define DSU_PMU_COUNTER_MASK(idx)	\
> +	GENMASK_ULL((DSU_PMU_COUNTER_WIDTH((idx)) - 1), 0)
> +
> +#define DSU_EXT_ATTR(_name, _func, _config)		\
> +	(&((struct dev_ext_attribute[]) {				\
> +		{							\
> +			.attr = __ATTR(_name, 0444, _func, NULL),	\
> +			.var = (void *)_config				\
> +		}							\
> +	})[0].attr.attr)
> +
> +#define DSU_EVENT_ATTR(_name, _config)		\
> +	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_event_show, (unsigned long)_config)
> +
> +#define DSU_FORMAT_ATTR(_name, _config)		\
> +	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_format_show, (char *)_config)
> +
> +#define DSU_CPUMASK_ATTR(_name, _config)	\
> +	DSU_EXT_ATTR(_name, dsu_pmu_cpumask_show, (unsigned long)_config)
> +
> +struct dsu_hw_events {
> +	DECLARE_BITMAP(used_mask, DSU_PMU_MAX_HW_CNTRS);
> +	struct perf_event	*events[DSU_PMU_MAX_HW_CNTRS];
> +};
> +
> +/*
> + * struct dsu_pmu	- DSU PMU descriptor
> + *
> + * @pmu_lock		: Protects accesses to DSU PMU register from normal vs
> + *			  interrupt handler contexts.
> + * @hw_events		: Holds the event counter state.
> + * @associated_cpus	: CPUs attached to the DSU.
> + * @active_cpu		: CPU to which the PMU is bound for accesses.
> + * @cpuhp_node		: Node for CPU hotplug notifier link.
> + * @num_counters	: Number of event counters implemented by the PMU,
> + *			  excluding the cycle counter.
> + * @irq			: Interrupt line for counter overflow.
> + * @cpmceid_bitmap	: Bitmap for the availability of architected common
> + *			  events (event_code < 0x40).
> + */
> +struct dsu_pmu {
> +	struct pmu			pmu;
> +	struct device			*dev;
> +	raw_spinlock_t			pmu_lock;
> +	struct dsu_hw_events		hw_events;
> +	cpumask_t			associated_cpus;
> +	cpumask_t			active_cpu;
> +	struct hlist_node		cpuhp_node;
> +	u8				num_counters;
> +	int				irq;
> +	DECLARE_BITMAP(cpmceid_bitmap, DSU_PMU_MAX_COMMON_EVENTS);
> +};
> +
> +static unsigned long dsu_pmu_cpuhp_state;
> +
> +static inline struct dsu_pmu *to_dsu_pmu(struct pmu *pmu)
> +{
> +	return container_of(pmu, struct dsu_pmu, pmu);
> +}
> +
> +static ssize_t dsu_pmu_sysfs_event_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct dev_ext_attribute *eattr = container_of(attr,
> +					struct dev_ext_attribute, attr);
> +	return snprintf(buf, PAGE_SIZE, "event=0x%lx\n",
> +					 (unsigned long)eattr->var);
> +}
> +
> +static ssize_t dsu_pmu_sysfs_format_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct dev_ext_attribute *eattr = container_of(attr,
> +					struct dev_ext_attribute, attr);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", (char *)eattr->var);
> +}
> +
> +static ssize_t dsu_pmu_cpumask_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(pmu);
> +	struct dev_ext_attribute *eattr = container_of(attr,
> +					struct dev_ext_attribute, attr);
> +	unsigned long mask_id = (unsigned long)eattr->var;
> +	const cpumask_t *cpumask;
> +
> +	switch (mask_id) {
> +	case DSU_ACTIVE_CPU_MASK:
> +		cpumask = &dsu_pmu->active_cpu;
> +		break;
> +	case DSU_ASSOCIATED_CPU_MASK:
> +		cpumask = &dsu_pmu->associated_cpus;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +}
> +
> +static struct attribute *dsu_pmu_format_attrs[] = {
> +	DSU_FORMAT_ATTR(event, "config:0-31"),
> +	NULL,
> +};
> +
> +static const struct attribute_group dsu_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = dsu_pmu_format_attrs,
> +};
> +
> +static struct attribute *dsu_pmu_event_attrs[] = {
> +	DSU_EVENT_ATTR(cycles, 0x11),
> +	DSU_EVENT_ATTR(bus_access, 0x19),
> +	DSU_EVENT_ATTR(memory_error, 0x1a),
> +	DSU_EVENT_ATTR(bus_cycles, 0x1d),
> +	DSU_EVENT_ATTR(l3d_cache_allocate, 0x29),
> +	DSU_EVENT_ATTR(l3d_cache_refill, 0x2a),
> +	DSU_EVENT_ATTR(l3d_cache, 0x2b),
> +	DSU_EVENT_ATTR(l3d_cache_wb, 0x2c),
> +	NULL,
> +};
> +
> +static umode_t
> +dsu_pmu_event_attr_is_visible(struct kobject *kobj, struct attribute *attr,
> +				int unused)
> +{
> +	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(pmu);
> +	struct dev_ext_attribute *eattr = container_of(attr,
> +					struct dev_ext_attribute, attr.attr);
> +	unsigned long evt = (unsigned long)eattr->var;
> +
> +	return test_bit(evt, dsu_pmu->cpmceid_bitmap) ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group dsu_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = dsu_pmu_event_attrs,
> +	.is_visible = dsu_pmu_event_attr_is_visible,
> +};
> +
> +static struct attribute *dsu_pmu_cpumask_attrs[] = {
> +	DSU_CPUMASK_ATTR(cpumask, DSU_ACTIVE_CPU_MASK),
> +	DSU_CPUMASK_ATTR(associated_cpus, DSU_ASSOCIATED_CPU_MASK),
> +	NULL,
> +};
> +
> +static const struct attribute_group dsu_pmu_cpumask_attr_group = {
> +	.attrs = dsu_pmu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *dsu_pmu_attr_groups[] = {
> +	&dsu_pmu_cpumask_attr_group,
> +	&dsu_pmu_events_attr_group,
> +	&dsu_pmu_format_attr_group,
> +	NULL,
> +};
> +
> +static int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
> +{
> +	struct cpumask online_supported;
> +
> +	cpumask_and(&online_supported,
> +			 &dsu_pmu->associated_cpus, cpu_online_mask);
> +	return cpumask_any_but(&online_supported, cpu);
> +}
> +
> +static inline bool dsu_pmu_counter_valid(struct dsu_pmu *dsu_pmu, u32 idx)
> +{
> +	return (idx < dsu_pmu->num_counters) ||
> +	       (idx == DSU_PMU_IDX_CYCLE_COUNTER);
> +}
> +
> +static inline u64 dsu_pmu_read_counter(struct perf_event *event)
> +{
> +	u64 val;
> +	unsigned long flags;
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +
> +	if (WARN_ON(!cpumask_test_cpu(smp_processor_id(),
> +				 &dsu_pmu->associated_cpus)))
> +		return 0;
> +
> +	if (!dsu_pmu_counter_valid(dsu_pmu, idx)) {
> +		dev_err(event->pmu->dev,
> +			"Trying reading invalid counter %d\n", idx);
> +		return 0;
> +	}
> +
> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
> +	if (idx == DSU_PMU_IDX_CYCLE_COUNTER)
> +		val = __dsu_pmu_read_pmccntr();
> +	else
> +		val = __dsu_pmu_read_counter(idx);
> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
> +
> +	return val;
> +}
> +
> +static void dsu_pmu_write_counter(struct perf_event *event, u64 val)
> +{
> +	unsigned long flags;
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +
> +	if (WARN_ON(!cpumask_test_cpu(smp_processor_id(),
> +			 &dsu_pmu->associated_cpus)))
> +		return;
> +
> +	if (!dsu_pmu_counter_valid(dsu_pmu, idx)) {
> +		dev_err(event->pmu->dev,
> +			"writing to invalid counter %d\n", idx);
> +		return;
> +	}
> +
> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
> +	if (idx == DSU_PMU_IDX_CYCLE_COUNTER)
> +		__dsu_pmu_write_pmccntr(val);
> +	else
> +		__dsu_pmu_write_counter(idx, val);
> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
> +}
> +
> +static int dsu_pmu_get_event_idx(struct dsu_hw_events *hw_events,
> +				 struct perf_event *event)
> +{
> +	int idx;
> +	unsigned long evtype = event->attr.config;
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +	unsigned long *used_mask = hw_events->used_mask;
> +
> +	if (evtype == DSU_PMU_EVT_CYCLES) {
> +		if (test_and_set_bit(DSU_PMU_IDX_CYCLE_COUNTER, used_mask))
> +			return -EAGAIN;
> +		return DSU_PMU_IDX_CYCLE_COUNTER;
> +	}
> +
> +	idx = find_first_zero_bit(used_mask, dsu_pmu->num_counters);
> +	if (idx >= dsu_pmu->num_counters)
> +		return -EAGAIN;
> +	set_bit(idx, hw_events->used_mask);
> +	return idx;
> +}
> +
> +static void dsu_pmu_enable_counter(struct dsu_pmu *dsu_pmu, int idx)
> +{
> +	__dsu_pmu_counter_interrupt_enable(idx);
> +	__dsu_pmu_enable_counter(idx);
> +}
> +
> +static void dsu_pmu_disable_counter(struct dsu_pmu *dsu_pmu, int idx)
> +{
> +	__dsu_pmu_disable_counter(idx);
> +	__dsu_pmu_counter_interrupt_disable(idx);
> +}
> +
> +static inline void dsu_pmu_set_event(struct dsu_pmu *dsu_pmu,
> +					struct perf_event *event)
> +{
> +	int idx = event->hw.idx;
> +	unsigned long flags;
> +
> +	if (!dsu_pmu_counter_valid(dsu_pmu, idx)) {
> +		dev_err(event->pmu->dev,
> +			"Trying to set invalid counter %d\n", idx);
> +		return;
> +	}
> +
> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
> +	__dsu_pmu_set_event(idx, event->hw.config_base);
> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
> +}
> +
> +static void dsu_pmu_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 delta, prev_count, new_count;
> +
> +	do {
> +		/* We may also be called from the irq handler */
> +		prev_count = local64_read(&hwc->prev_count);
> +		new_count = dsu_pmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
> +			prev_count);
> +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
> +	local64_add(delta, &event->count);
> +}
> +
> +static void dsu_pmu_read(struct perf_event *event)
> +{
> +	dsu_pmu_event_update(event);
> +}
> +
> +static inline u32 dsu_pmu_get_reset_overflow(void)
> +{
> +	return __dsu_pmu_get_reset_overflow();
> +}
> +
> +/**
> + * dsu_pmu_set_event_period: Set the period for the counter.
> + *
> + * All DSU PMU event counters, except the cycle counter are 32bit
> + * counters. To handle cases of extreme interrupt latency, we program
> + * the counter with half of the max count for the counters.
> + */
> +static void dsu_pmu_set_event_period(struct perf_event *event)
> +{
> +	int idx = event->hw.idx;
> +	u64 val = DSU_PMU_COUNTER_MASK(idx) >> 1;
> +
> +	local64_set(&event->hw.prev_count, val);
> +	dsu_pmu_write_counter(event, val);
> +}
> +
> +static irqreturn_t dsu_pmu_handle_irq(int irq_num, void *dev)
> +{
> +	int i;
> +	bool handled = false;
> +	struct dsu_pmu *dsu_pmu = dev;
> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
> +	unsigned long overflow;
> +
> +	overflow = dsu_pmu_get_reset_overflow();
> +	if (!overflow)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(i, &overflow, DSU_PMU_MAX_HW_CNTRS) {
> +		struct perf_event *event = hw_events->events[i];
> +
> +		if (!event)
> +			continue;
> +		dsu_pmu_event_update(event);
> +		dsu_pmu_set_event_period(event);
> +		handled = true;
> +	}
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static void dsu_pmu_start(struct perf_event *event, int pmu_flags)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +
> +	/* We always reprogram the counter */
> +	if (pmu_flags & PERF_EF_RELOAD)
> +		WARN_ON(!(event->hw.state & PERF_HES_UPTODATE));
> +	dsu_pmu_set_event_period(event);
> +	if (event->hw.idx != DSU_PMU_IDX_CYCLE_COUNTER)
> +		dsu_pmu_set_event(dsu_pmu, event);
> +	event->hw.state = 0;
> +	dsu_pmu_enable_counter(dsu_pmu, event->hw.idx);
> +}
> +
> +static void dsu_pmu_stop(struct perf_event *event, int pmu_flags)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;
> +	dsu_pmu_disable_counter(dsu_pmu, event->hw.idx);
> +	dsu_pmu_event_update(event);
> +	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int dsu_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					   &dsu_pmu->associated_cpus)))
> +		return -ENOENT;
> +
> +	idx = dsu_pmu_get_event_idx(hw_events, event);
> +	if (idx < 0)
> +		return idx;
> +
> +	hwc->idx = idx;
> +	hw_events->events[idx] = event;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START)
> +		dsu_pmu_start(event, PERF_EF_RELOAD);
> +
> +	perf_event_update_userpage(event);
> +	return 0;
> +}
> +
> +static void dsu_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	dsu_pmu_stop(event, PERF_EF_UPDATE);
> +	hw_events->events[idx] = NULL;
> +	clear_bit(idx, hw_events->used_mask);
> +	perf_event_update_userpage(event);
> +}
> +
> +static void dsu_pmu_enable(struct pmu *pmu)
> +{
> +	u32 pmcr;
> +	unsigned long flags;
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(pmu);
> +
> +	/* If no counters are added, skip enabling the PMU */
> +	if (bitmap_empty(dsu_pmu->hw_events.used_mask, DSU_PMU_MAX_HW_CNTRS))
> +		return;
> +
> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
> +	pmcr = __dsu_pmu_read_pmcr();
> +	pmcr |= CLUSTERPMCR_E;
> +	__dsu_pmu_write_pmcr(pmcr);
> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
> +}
> +
> +static void dsu_pmu_disable(struct pmu *pmu)
> +{
> +	u32 pmcr;
> +	unsigned long flags;
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(pmu);
> +
> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
> +	pmcr = __dsu_pmu_read_pmcr();
> +	pmcr &= ~CLUSTERPMCR_E;
> +	__dsu_pmu_write_pmcr(pmcr);
> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
> +}
> +
> +static bool dsu_pmu_validate_event(struct pmu *pmu,
> +				  struct dsu_hw_events *hw_events,
> +				  struct perf_event *event)
> +{
> +	if (is_software_event(event))
> +		return true;
> +	/* Reject groups spanning multiple HW PMUs. */
> +	if (event->pmu != pmu)
> +		return false;
> +	return dsu_pmu_get_event_idx(hw_events, event) >= 0;
> +}
> +
> +/*
> + * Make sure the group of events can be scheduled at once
> + * on the PMU.
> + */
> +static bool dsu_pmu_validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	struct dsu_hw_events fake_hw;
> +
> +	if (event->group_leader == event)
> +		return true;
> +
> +	memset(fake_hw.used_mask, 0, sizeof(fake_hw.used_mask));
> +	if (!dsu_pmu_validate_event(event->pmu, &fake_hw, leader))
> +		return false;
> +	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
> +		if (!dsu_pmu_validate_event(event->pmu, &fake_hw, sibling))
> +			return false;
> +	}
> +	return dsu_pmu_validate_event(event->pmu, &fake_hw, event);
> +}
> +
> +static int dsu_pmu_event_init(struct perf_event *event)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* We don't support sampling */
> +	if (is_sampling_event(event)) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* We cannot support task bound events */
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
> +		return -EINVAL;
> +	}
> +
> +	if (has_branch_stack(event) ||
> +	    event->attr.exclude_user ||
> +	    event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv ||
> +	    event->attr.exclude_idle ||
> +	    event->attr.exclude_host ||
> +	    event->attr.exclude_guest) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!cpumask_test_cpu(event->cpu, &dsu_pmu->associated_cpus)) {
> +		dev_dbg(dsu_pmu->pmu.dev,
> +			 "Requested cpu is not associated with the DSU\n");
> +		return -EINVAL;
> +	}


I sent out a patch that'll allow PMUs to set an event flag to avoid 
unnecessary smp calls when the event can be read from any CPU. You could 
just always set that if you can't have multiple DSU's running the kernel 
(I don't know if the current ARM designs support having multiple DSUs in 
a SoC/system) or set it if associated_cpus == cpu_present_mask.

Without that, every single call is going to cause an IPI to whatever CPU 
that was passed in (assuming task == NULL) as part of creating the event.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
