Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268B1214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268B1214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeHUMfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:35:37 -0400
Received: from foss.arm.com ([217.140.101.70]:46732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeHUMfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:35:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83A967A9;
        Tue, 21 Aug 2018 02:16:14 -0700 (PDT)
Received: from [10.37.9.177] (unknown [10.37.9.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658BB3F739;
        Tue, 21 Aug 2018 02:16:11 -0700 (PDT)
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [RFC V1] perf: qcom: add DDR bandwidth PMU support
To:     Rahul Ramasubramanian <rahulr@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        will.deacon@arm.com, mark.rutland@arm.com, jeremy.linton@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com,
        lorenzo.pieralisi@arm.com, rafael@kernel.org
Cc:     agustinv@codeaurora.org
References: <1530723452-11640-1-git-send-email-rahulr@codeaurora.org>
Message-ID: <0fd2f12b-524a-23f1-a900-5c2877c334e9@arm.com>
Date:   Tue, 21 Aug 2018 10:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1530723452-11640-1-git-send-email-rahulr@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On 04/07/18 17:57, Rahul Ramasubramanian wrote:
> Measuring DDR bandwidth allows for an accurate measurement
> of memory throughput achieved for a given workload. It also
> breaks down the traffic measurement on a per DDR channel basis.

The commit description doesn't help much for someone who wants to
know the PMU is about.  It would be good to say some more details about 
the device in commit description, like you have done below in the code
[0]

> 
> Signed-off-by: Rahul Ramasubramanian <rahulr@codeaurora.org>
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>   drivers/perf/Kconfig                      |  10 +
>   drivers/perf/Makefile                     |   1 +
>   drivers/perf/qcom_bandwidth_perf_events.c | 970 ++++++++++++++++++++++++++++++
>   drivers/perf/qcom_bandwidth_perf_events.h | 156 +++++
>   4 files changed, 1137 insertions(+)
>   create mode 100644 drivers/perf/qcom_bandwidth_perf_events.c
>   create mode 100644 drivers/perf/qcom_bandwidth_perf_events.h

super minor nit: you could name the files qcom_mem_bandwidth_pmu.*

> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 08ebaf7..3c9f7e9 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,6 +87,16 @@ config QCOM_L3_PMU
>   	   Adds the L3 cache PMU into the perf events subsystem for
>   	   monitoring L3 cache events.
>   
> +config QCOM_BANDWIDTH_PMU
> +	bool "Qualcomm Technologies Memory Bandwidth PMU"
> +	depends on ARCH_QCOM && ARM64 && ACPI
> +	select QCOM_IRQ_COMBINER
> +	help
> +	   Provides support for the memory bandwidth performance monitor unit (PMU)
> +	   in Qualcomm Technologies processors.
> +	   Adds the Memory Bandwidth PMU into the perf events subsystem for
> +	   monitoring memory bandwidth events.
> +
>   config XGENE_PMU
>           depends on ARCH_XGENE
>           bool "APM X-Gene SoC PMU"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index b3902bd..50c20ec 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>   obj-$(CONFIG_HISI_PMU) += hisilicon/
>   obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>   obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> +obj-$(CONFIG_QCOM_BANDWIDTH_PMU) += qcom_bandwidth_perf_events.o
>   obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>   obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> diff --git a/drivers/perf/qcom_bandwidth_perf_events.c b/drivers/perf/qcom_bandwidth_perf_events.c
> new file mode 100644
> index 0000000..bcc5667
> --- /dev/null
> +++ b/drivers/perf/qcom_bandwidth_perf_events.c
> @@ -0,0 +1,970 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.

it: Please leave the first line of a multi-line comment blank. Like :

/*
  * Copyright....
  *

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +

> +/*
> + * This driver adds support for perf events to monitor the DDR
> + * bandwidth in Qualcomm Technologies chips. Each switch in the
> + * interconnect is connected to tthe memory controller and contains a

nit: s/tthe/the/

> + * performace monitoring unit (PMU) that the driver exposes
> + * through the perf events framework.
> + *
> + * The PMU Event Counters
> + * - Event counters, which count occurrences of a configured event.
> + *
> + * These resources are exposed as perf counting events, there is no
> + * support for sampling based on events exposed by the driver. Event
> + * counters are always accumulating.
> + * Events associated with event counters are the following:
> + * ddr-read-bytes: The driver scales the raw pmu count to provide the
> + * number of bytes read from a specific memory controller.
> + *
> + * ddr-write-bytes: The driver scales the raw pmu count to provide the
> + * number of bytes read from a specific memory controller.
> + *
> + */

[0]. I think the description above could also be added to the commit
description and the documentation under :

Documentation/perf/qcom_bandwidth_pmu.txt

Also giving an example of how to use them. See the existing ones for 
example.

> +
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/acpi.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>

Please keep the headers sorted in the alphabetical order.

> +#include "qcom_bandwidth_perf_events.h"

> +
> +
> +
> +/*
> + * Structures representing a HW PMU and other associated resources
> + */
> +
> +/*
> + * Represents an event counter
> + *
> + * This type is used to make these operations polymorphic depending on the
> + * type of hardware resources an event uses. The general idea is to associate
> + * a perf_event with a switch_pmu_counter via the index contained in its
> + * hw_perf_event. To accomplish this, an array of switch_pmu_counters is used
> + * and event counters use the  BANDWIDTH_NUM_EVENT_COUNTERS indexes, so the
> + *   event counter index is found by the using the index directly:

It is good to have the fields of a structure documented. But please do
not interleave them with the code, which makes it really difficult to
read the code.

Rather you could describe the fields in the comment above the
definition.

i.e, :


/*
  * struct switch_pmu_counter	- Represents a hardware event counter.
  * @event			- The perf_event associated with event
  * @start			- Callback to start the event
  * @stop			- Callback to stop the event
  * @wrap			- Optional callback for handling counter
  *				  overflow.
....

  */

struct switch_pmu_counter {
	struct perf_event	*event;
	void (*start)(struct perf_event *event);
	....
};


> + */
> +struct switch_pmu_counter {
> +	struct perf_event	*event;
> +	/* Called to start event monitoring */
> +	void (*start)(struct perf_event *event);
> +	/* Called to stop event monitoring (optional) */
> +	void (*stop)(struct perf_event *event, int flags);
> +	/* Called when the counter overflows (optional) */
> +	void (*wrap)(struct perf_event *event);
> +	/* Called to update the perf_event */
> +	void (*update)(struct perf_event *event)> +};
> +
> +/*
> + * Represents the hardware PMU
> + *
> + * This type inherits from the core perf events struct pmu and adds data
> + * to manage the PMU resources.
> + */

> +struct switch_pmu {
> +	/* Base perf pmu */
> +	struct pmu	perf_pmu;
> +	/* CPU mask exported for user space tools via sysfs */
> +	cpumask_t       cpu;
> +	/* Node for the hotplug notifier hlist */
> +	struct hlist_node     node;
> +	/* Register base address */
> +	void __iomem	*regs;
> +	/* Spinlock used to protect indexed accesses to event counters */
> +	raw_spinlock_t	ecsel_lock;
> +
> +	/* Bitmap to track counter use */
> +	unsigned long	used_mask[BITS_TO_LONGS(BANDWIDTH_NUM_TOTAL_COUNTERS)];
> +	/* Counter resources */
> +	struct switch_pmu_counter counters[BANDWIDTH_NUM_TOTAL_COUNTERS];
> +};


Same as above.

> +
> +#define FIRST_EVENT_COUNTER 0
> +

Do we need this at all ? All it serves is to complicate the code.

> +#define to_switch_pmu(p) (container_of(p, struct switch_pmu, perf_pmu))
> +
> +static int cpuhp_state_num;
> +
> +/*
> + * Decoding of settings from perf_event_attr
> + *
> + * Common bits:
> + *
> + * The config format for perf events associated with event counters is:
> + * - config: bits 0-3:event selector, bits 16-22:source selector
> + * - config1: bits 0-21,24-30:filter config, bits 32-45,48-54:filter enable
> + *
> + */
> +
> +#define PERF_EVENT_ATTR_EXTRACTOR(_name, _config, _size, _shift)	\
> +	static inline u32 get_##_name(struct perf_event *event)         \
> +	{								\
> +		return (event->attr._config >> _shift)                  \
> +			& GENMASK(_size - 1, 0);                            \
> +	}
> +
> +PERF_EVENT_ATTR_EXTRACTOR(ec_event_sel, config, 4, 0);
> +PERF_EVENT_ATTR_EXTRACTOR(ec_event_lc, config, 1, 32);
> +PERF_EVENT_ATTR_EXTRACTOR(ec_source_sel, config, 7, 16);
> +
> +
> +/*
> + * Implementation of global HW PMU operations
> + */
> +
> +static inline int event_num_counters(struct perf_event *event)
> +{
> +	return (get_ec_event_lc(event) == 0) ? 1 : 2;
> +}
> +
> +static
> +bool switch_pmu__inuse(struct switch_pmu *pmu)

We generally don't use function names abc__xyz() in kernel, unlike
perf tool. So please rename all the symbols accordingly (i.e,
abc_xyz()).

Also please rename switch_pmu__inuse => switch_pmu_in_use()

> +{
> +	/* Check if a given PMU is already in use by IMC */
> +	return readl_relaxed(pmu->regs + BANDWIDTH_EC_ENABLE_SET) == 0xF000;
> +

Is there a public TRM for the component ? If not, do you expect
bits[11-0] to be 0 when in use or do you need a mask for the bits of
interest (bits[15-12]) ?

> +}
> +
> +static
> +void switch_pmu__reset(struct switch_pmu *pmu)
> +{
> +	u32 all = GENMASK(BANDWIDTH_NUM_EVENT_COUNTERS - 1, 0);

Could you define a mask for the counters rather than creating it where
needed ?

e.g, BANDWIDTH_EVT_COUNTERS_MASK_ALL ?

> +
> +	if (!switch_pmu__inuse(pmu)) {
> +		/* Enable access by writing the LAR key */
> +		writel_relaxed(BANDWIDTH_LAR_KEY, pmu->regs + BANDWIDTH_LAR);

Don't you need to lock it back somewhere ?

> +
> +
> +		/* Disable IRQonMSB */
> +

nit: extra line

> +		writel_relaxed(0x0, pmu->regs + BANDWIDTH_EC_IRQ_CONTROL);
> +
> +		/*
> +		 * Assert reset to the EC hardware, use writel to ensure the
> +		 * CLEAR commands have been seen by the device before this
> +		 * write.
> +		 */
> +

and here ^

> +		writel(SET(GLOBAL_RESET, 1), pmu->regs +
> +			BANDWIDTH_EC_GLOBAL_CONTROL);
> +
> +		/*
> +		 * De-assert reset to the EC hardware, use writel to ensure
> +		 *  the reset command has been seen by the device.

nit: spurious white space ^

> +		 */
> +
> +		writel(SET(GLOBAL_RESET, 0), pmu->regs +
> +			BANDWIDTH_EC_GLOBAL_CONTROL);
> +		writel(SET(RETRIEVAL_MODE, 1)
> +			| SET(GLOBAL_ENABLE, 1) | SET(GLOBAL_TRIGOVRD, 1), > +			pmu->regs + BANDWIDTH_EC_GLOBAL_CONTROL);
> +	}
> +
> +	/* clear the interuppts and event counters */

nit: "interrupt"

> +	writel_relaxed(all, pmu->regs + BANDWIDTH_EC_ENABLE_CLEAR);
> +	writel_relaxed(all, pmu->regs + BANDWIDTH_EC_INTERRUPT_ENABLE_CLEAR);
> +};

nit: spurious ";"

> +
> +/*
> + * Event counter operations
> + */
> +
> +static inline
> +void switch_pmu__ec_set_event(struct switch_pmu *pmu, u8 cntr, u32 event)
> +{
> +
> +	writel_relaxed(event, pmu->regs + qcom_bandwidth_ec_source_sel(cntr));
> +}
> +
> +static inline
> +void switch_pmu__ec_enable(struct switch_pmu *pmu, u32 cntr)
> +{
> +	writel_relaxed(SET(ECENSET(cntr), 1), pmu->regs +
> +		BANDWIDTH_EC_ENABLE_SET);

It is better readable if you do :
	writel_relaxed(SET(ECENSET(cntr), 1),
			pmu->regs + BANDWIDTH_EC_ENABLE_SET);

> +}
> +
> +static inline
> +void switch_pmu__ec_disable(struct switch_pmu *pmu, u32 cntr)
> +{
> +	writel_relaxed(SET(ECENSET(cntr), 1),
> +		    pmu->regs + BANDWIDTH_EC_ENABLE_CLEAR);
> +}
> +
> +static inline
> +void switch_pmu__ec_enable_interrupt(struct switch_pmu *pmu, u32 cntr)
> +{
> +	u32 val = readl_relaxed(pmu->regs + BANDWIDTH_EC_IRQ_CONTROL);
> +
> +	writel_relaxed(val | BIT(cntr), pmu->regs + BANDWIDTH_EC_IRQ_CONTROL);
> +	writel_relaxed(SET(ECINTENCLR(cntr), 1),
> +		    pmu->regs + BANDWIDTH_EC_INTERRUPT_ENABLE_SET);

This is not consistent with the _disable_interrupt() sequence below
w.r.t writel vs writel_relaxed.

> +}
> +
> +static inline
> +void switch_pmu__ec_disable_interrupt(struct switch_pmu *pmu, u32 cntr)
> +{
> +	u32 val = readl_relaxed(pmu->regs + BANDWIDTH_EC_IRQ_CONTROL);
> +
> +	writel(val & ~BIT(cntr), pmu->regs + BANDWIDTH_EC_IRQ_CONTROL);
> +	writel(SET(ECINTENCLR(cntr), 1),
> +		    pmu->regs + BANDWIDTH_EC_INTERRUPT_ENABLE_CLEAR);
> +}
> +
> +static inline
> +u32 switch_pmu__ec_read_ovsr(struct switch_pmu *pmu)
> +{
> +	return readl_relaxed(pmu->regs + BANDWIDTH_EC_OVF_STATUS);
> +}
> +
> +static inline
> +void switch_pmu__ec_write_ovsr(struct switch_pmu *pmu, u32 value)
> +{
> +	writel_relaxed(value, pmu->regs + BANDWIDTH_EC_OVF_STATUS);
> +}
> +
> +static inline
> +bool switch_pmu__any_event_counter_overflowed(u32 ovsr)
> +{
> +	return (ovsr & GENMASK(BANDWIDTH_NUM_EVENT_COUNTERS - 1, 0)) != 0;
> +}
> +
> +static inline
> +int switch_pmu__ec_has_overflowed(u32 ovsr, u8 cntr)
> +{
> +	return GET(ECOVF(cntr), ovsr) != 0;
> +}
> +
> +static inline
> +void switch_pmu__ec_set_value(struct switch_pmu *pmu, u8 cntr, u32 value)
> +{
> +	unsigned long flags;
> +	bool reenable = false;
> +
> +	/*
> +	 * Quirk: The counter needs to be disabled before updating.
> +	 */
> +	if ((readl_relaxed(pmu->regs + BANDWIDTH_EC_ENABLE_SET) &
> +		    SET(ECENSET(cntr), 1)) != 0) {
> +		switch_pmu__ec_disable(pmu, cntr);
> +		reenable = true;
> +	}
> +
> +	raw_spin_lock_irqsave(&pmu->ecsel_lock, flags);
> +	writel_relaxed(SET(ECSEL, cntr), pmu->regs + BANDWIDTH_EC_COUNTER_SEL);
> +
> +	/*
> +	 * Use writel because the write to BANDWIDTH_EC_COUNTER_SEL needs
> +	 * to be observed before the write to BANDWIDTH_EC_COUNT.
> +	 */
> +
> +	writel(value, pmu->regs + BANDWIDTH_EC_COUNT);
> +	raw_spin_unlock_irqrestore(&pmu->ecsel_lock, flags);
> +
> +	if (reenable)
> +		switch_pmu__ec_enable(pmu, cntr);
> +}
> +
> +static inline
> +u32 switch_pmu__ec_get_value(struct switch_pmu *pmu, u8 cntr)
> +{
> +	u32 result;
> +	u32 sel;
> +	unsigned long flags;
> +	unsigned long num_attempts = 0;
> +
> +	do {
> +		raw_spin_lock_irqsave(&pmu->ecsel_lock, flags);
> +		writel_relaxed(SET(ECSEL, cntr), pmu->regs +
> +			BANDWIDTH_EC_COUNTER_SEL);
> +
> +		/*
> +		 * The write to BANDWIDTH_EC_COUNTER_SEL needs to be observed
> +		 * before the read to BANDWIDTH_EC_COUNT.
> +		 */
> +		mb();
> +
> +		result = readl_relaxed(pmu->regs + BANDWIDTH_EC_COUNT);
> +		raw_spin_unlock_irqrestore(&pmu->ecsel_lock, flags);
> +		num_attempts++;
> +		sel = readl_relaxed(pmu->regs + BANDWIDTH_EC_COUNTER_SEL);
> +	} while ((sel != SET(ECSEL, cntr))
> +		&& (num_attempts <= DDRBW_MAX_RETRIES));
> +
> +	/* Exit gracefully to avoid freeze */
> +	if (num_attempts >= DDRBW_MAX_RETRIES)
> +		return DDR_BW_READ_FAIL;
> +
> +	return result;
> +}
> +
> +static inline
> +bool switch_pmu__any_event_counter_active(struct switch_pmu *pmu)
> +{
> +	int idx = find_next_bit(pmu->used_mask, BANDWIDTH_NUM_TOTAL_COUNTERS,
> +		    FIRST_EVENT_COUNTER);

See my comment about FIRST_EVENT_COUNTER above. If we get rid of it,
this could be :

find_first_bit(pmu->usd_mask, BANDWIDTH_NUM_TOTAL_COUNTERS);

> +
> +	return idx != BANDWIDTH_NUM_TOTAL_COUNTERS;
> +}
> +
> +/*
> + * Event counter switch_pmu_counter method implementation.
> + */
> +
> +static
> +void switch_pmu__32bit_event_counter_update(struct perf_event *event)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	u32 ec_idx = event->hw.idx - FIRST_EVENT_COUNTER;
> +	u32 delta, prev, now;
> +
> +	do {
> +		prev = (u32)local64_read(&event->hw.prev_count);
> +		now = switch_pmu__ec_get_value(pmu, ec_idx);
> +	} while (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev);
> +
> +	delta = now - prev;
> +	local64_add(delta, &event->count);
> +}
> +
> +static
> +void switch_pmu__64bit_event_counter_update(struct perf_event *event)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	int idx = event->hw.idx - FIRST_EVENT_COUNTER;
> +	u32 hi, lo;
> +	u64 prev, now;
> +
> +	do {
> +		prev = local64_read(&event->hw.prev_count);
> +		do {
> +			hi = switch_pmu__ec_get_value(pmu, idx + 1);
> +			lo = switch_pmu__ec_get_value(pmu, idx);
> +		} while (hi != switch_pmu__ec_get_value(pmu, idx + 1));

If you handle the 32bit/64bit counter aspects in a wrapper function you
don't need the callbacks at all. We do something similar in arm64 pmu
with chaining, (see arch/arm64/kernel/perf_event.c queued for 4.19-rc1)


> +		now = ((u64)hi << 32) | lo;
> +	} while (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev);
> +
> +	local64_add(now - prev, &event->count);
> +}
> +
> +static
> +void switch_pmu__event_counter_program(struct perf_event *event)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +
> +	u32 ec_idx = event->hw.idx - FIRST_EVENT_COUNTER;

Please remove the pointless FIRST_EVENT_COUNTER as mentioned above.

> +	u32 ev_type = SET(ECSOURCESEL, get_ec_source_sel(event)) |
> +		    SET(ECEVENTSEL, get_ec_event_sel(event));
> +

Could we not save this in event->hw.config_base once and for all during
the init ?

> +	event->hw.state = 0;
> +
> +	local64_set(&event->hw.prev_count, 0);
> +	switch_pmu__ec_set_value(pmu, ec_idx, 0);
> +	switch_pmu__ec_set_event(pmu, ec_idx, ev_type);
> +}
> +
> +static
> +void enable_64bit_ganging(struct perf_event *event, u32 idx)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +
> +	/* according to errata doc, this needs to be done

Leav first line empty for multi-line comments. Also this needs
a better explanation. Further below.

> +	 * for the odd counter
> +	 */
> +	u16 gang_regs;
> +	u32 ev_type = SET(ECSOURCESEL, 0x0) | SET(ECEVENTSEL, 0xf);
> +
> +	switch_pmu__ec_set_event(pmu, idx, ev_type);
> +
> +	/* enable ganging RMW */
> +	gang_regs = readl_relaxed(pmu->regs + BANDWIDTH_EC_GANG);
> +	gang_regs |= BIT(idx);
> +	writel_relaxed(gang_regs, pmu->regs + BANDWIDTH_EC_GANG);

What are the restrictions on the Ganging "odd" number event ? What is
the guarantee that the idx is odd ? As far as I can see, there is no
guarantee that the counters reserved via the allocation have a specific
ordering, leave along idx + 1 is always odd.

> +
> +}
> +
> +static
> +void disable_64bit_ganging(struct perf_event *event, u32 idx)
> +{
> +	u16 gang_regs;
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +
> +	gang_regs = readl_relaxed(pmu->regs + BANDWIDTH_EC_GANG);
> +	gang_regs = gang_regs & ~BIT(idx);
> +	writel_relaxed(gang_regs, pmu->regs + BANDWIDTH_EC_GANG);
> +
> +}
> +static
> +void switch_pmu_event_32bit_counter_start(struct perf_event *event)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	u32 ec_idx = event->hw.idx - FIRST_EVENT_COUNTER;
> +
> +	switch_pmu__event_counter_program(pmu->counters[ec_idx].event);
> +	switch_pmu__ec_enable_interrupt(pmu, ec_idx);
> +	switch_pmu__ec_enable(pmu, ec_idx);
> +}
> +
> +static
> +void switch_pmu_event_64bit_counter_start(struct perf_event *event)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	u32 ec_idx = event->hw.idx - FIRST_EVENT_COUNTER;
> +
> +	switch_pmu__event_counter_program(pmu->counters[ec_idx].event);
> +	enable_64bit_ganging(event, ec_idx + 1);
> +	switch_pmu__ec_enable(pmu, ec_idx);
> +	switch_pmu__ec_enable(pmu, ec_idx + 1);

We don't seem to enable interrupt for a 64bit counter. May be thats not
needed. But...

> +}
> +
> +static
> +void switch_pmu_event_32bit_counter_stop(struct perf_event *event, int flags)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	u32 ec_idx = event->hw.idx - FIRST_EVENT_COUNTER;
> +
> +	switch_pmu__ec_disable_interrupt(pmu, ec_idx);
> +	switch_pmu__ec_disable(pmu, ec_idx);
> +}
> +
> +static
> +void switch_pmu_event_64bit_counter_stop(struct perf_event *event, int flags)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	u32 ec_idx = event->hw.idx - FIRST_EVENT_COUNTER;
> +
> +	switch_pmu__ec_disable_interrupt(pmu, ec_idx);

We disable the interrupt. Why ?

> +	switch_pmu__ec_disable(pmu, ec_idx);
> +	switch_pmu__ec_disable_interrupt(pmu, ec_idx + 1);

And here.

> +	switch_pmu__ec_disable(pmu, ec_idx + 1);
> +	disable_64bit_ganging(event, ec_idx + 1);
> +}
> +
> +static
> +void switch_pmu_event_32bit_counter_wrap(struct perf_event *event)
> +{
> +	switch_pmu__32bit_event_counter_update(event);
> +}
> +
> +/*
> + * Core abstract PMU functions and management of the software counters.
> + */
> +
> +static
> +void switch_pmu__nop(struct pmu *perf_pmu)
> +{
> +}
> +
> +static
> +int switch_pmu__reserve_event_counter(struct switch_pmu *pmu,
> +		    struct perf_event *event, int sz)
> +{
> +	int idx;
> +
> +	idx = bitmap_find_free_region(pmu->used_mask,
> +	    BANDWIDTH_NUM_TOTAL_COUNTERS, sz);
> +	if (idx < 0)
> +		return -EAGAIN;
> +	return idx;

As mentioned above, what are the restrictions on ganging ? Does
this function take care of that ?

> +}
> +
> +/*
> + * We must NOT create groups containing events from multiple hardware PMUs,
> + * although mixing different software and hardware PMUs is allowed.
> + */
> +static bool switch_pmu__validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +	int counters = 0;
> +
> +	if (leader->pmu != event->pmu && !is_software_event(leader))
> +		return false;
> +
> +	counters = event_num_counters(event);
> +	counters += event_num_counters(leader);
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +		if (sibling->pmu != event->pmu)
> +			return false;
> +		counters += event_num_counters(sibling);
> +	}
> +
> +	/*
> +	 * If the group requires more counters than the HW has, it
> +	 * cannot ever be scheduled.
> +	 */
> +	return counters <= BANDWIDTH_NUM_TOTAL_COUNTERS;
> +}

nit: missing new line
> +static
> +int switch_pmu__event_init(struct perf_event *event)

This could fit in single line

> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +

..

> +	/*
> +	 * We cannot filter accurately so we just don't allow it at all.
> +	 */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +		    event->attr.exclude_hv || event->attr.exclude_idle)

what about exclude_guest and exclude_host ? Do you support branch_stack
feature ?

> +
> +static
> +int switch_pmu__event_add(struct perf_event *event, int flags)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +	int err = 0;
> +	int sz;
> +
> +	sz = get_ec_event_lc(event);
> +
> +	/* Try to find a hardware resource for this event */
> +	idx = switch_pmu__reserve_event_counter(pmu, event, sz);
> +	if (idx < 0) {
> +		err = idx;
> +		goto out;
> +	}
> +
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (sz == 0) {
> +		pmu->counters[idx] = (struct switch_pmu_counter) {
> +			.event = event,
> +			.start = switch_pmu_event_32bit_counter_start,
> +			.stop = switch_pmu_event_32bit_counter_stop,
> +			.wrap = switch_pmu_event_32bit_counter_wrap,
> +			.update = switch_pmu__32bit_event_counter_update,
> +		};
> +
> +	} else {
> +		pmu->counters[idx] = (struct switch_pmu_counter) {
> +			.event = event,
> +			.start = switch_pmu_event_64bit_counter_start,
> +			.stop = switch_pmu_event_64bit_counter_stop,
> +			.update = switch_pmu__64bit_event_counter_update,
> +			.wrap = NULL
> +		};
> +		pmu->counters[idx + 1] = pmu->counters[idx];

Could we not hide the 32/64bit handling under a wrapper which accepts
the perf_event, rather than per switch_counter call backs ? See chained
perf counter support for arm64.

> +	}
> +
> +	if (flags & PERF_EF_START)
> +		pmu->counters[idx].start(pmu->counters[idx].event);
> +
> +out:
> +	return err;
> +}
> +
> +static
> +void switch_pmu__event_start(struct perf_event *event, int flags)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +

same as above, you could store idx and use it below. But may be thats
not needed at all.

> +	pmu->counters[hwc->idx].start(pmu->counters[hwc->idx].event);
> +}
> +
> +static
> +void switch_pmu__event_stop(struct perf_event *event, int flags)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct switch_pmu_counter *c = &pmu->counters[hwc->idx];
> +
> +
> +	if (!(hwc->state & PERF_HES_STOPPED)) {
> +		if (c->stop)
> +			c->stop(c->event, flags);
> +
> +		if (flags & PERF_EF_UPDATE)
> +			c->update(c->event);
> +		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;

Here we set the flag to UPTODATE unconditionally, irrespective of
whether we updated the event or not, which is wrong.

> +	}
> +}
> +
> +static
> +void switch_pmu__event_del(struct perf_event *event, int flags)
> +{
> +
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct switch_pmu_counter *c = &pmu->counters[hwc->idx];
> +	struct switch_pmu_counter *cl = &pmu->counters[hwc->idx + 1];

You could be accessing beyond the array if the idx is the last counter
allocated for a 32bit counter. This is wrong and should be done only
when we know that sz is not null.

> +	int sz;
> +
> +	sz = get_ec_event_lc(event);
> +
> +	if (c->stop)
> +		c->stop(c->event, flags | PERF_EF_UPDATE);
> +	c->update(c->event);
> +	c->event = NULL;
> +	bitmap_release_region(pmu->used_mask, hwc->idx, sz);
> +
> +	/* Null set the upper counter when the long counter was enabled*/
> +	if (sz)
> +		cl->event = NULL;
> +}
> +
> +
> +static
> +void switch_pmu__event_read(struct perf_event *event)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;

nit: You could get to idx and use it below.

	int idx = event->hw.idx;

> +
> +	pmu->counters[hwc->idx].update(pmu->counters[hwc->idx].event);
> +}
> +
> +static
> +int dummy_event_idx(struct perf_event *event)
> +{
> +	return 0;
> +}
> +

You could simply ignore the field and remove the function.

> +static
> +bool switch_pmu__ec_handle_irq(struct switch_pmu *pmu)
> +{
> +	bool handled = false;
> +	u32 ovs = switch_pmu__ec_read_ovsr(pmu);
> +	int idx;
> +
> +	switch_pmu__ec_write_ovsr(pmu, ovs);
> +
> +	if (!switch_pmu__any_event_counter_overflowed(ovs))
> +		return handled;
> +
> +	for (idx = 0; idx < BANDWIDTH_NUM_EVENT_COUNTERS; ++idx) {
> +		struct switch_pmu_counter *counter;
> +
> +		if (!switch_pmu__ec_has_overflowed(ovs, idx))
> +			continue;
> +		counter = &pmu->counters[idx + FIRST_EVENT_COUNTER];
> +		if (!counter->event)
> +			continue;
> +		counter->wrap(counter->event);

Do all counters have "wrap" callback ? What happens if part of the 64bit
counter has overflown along with another 32bit counter which generated
the interrupt. We could potentially crash.

> +		handled = true;
> +	}
> +
> +	return handled;
> +}
> +
> +
> +static
> +irqreturn_t switch_pmu__handle_irq(int irq_num, void *data)
> +{
> +	bool handled = false;
> +	struct switch_pmu *pmu = data;
> +
> +	if (switch_pmu__any_event_counter_active(pmu))
> +		handled = switch_pmu__ec_handle_irq(pmu);

nit: I personally think the above function could be folded into this
one.

> +
> +	/*
> +	 * Handle the pending perf events.
> +	 *
> +	 * Note: this call *must* be run with interrupts disabled. For
> +	 * platforms that can have the PMU interrupts raised as an NMI, this
> +	 * will not work.
> +	 */
> +
> +	irq_work_run();
> +
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +/*
> + * Fixed attribute groups exposed for perf in the format group.
> + *
> + * The config format for perf events associated with event counters is:
> + * - config: bits 0-3:event selector, bits 16-22:source selector
> + * - config1: bits 0-21,24-30:filter config, bits 32-45,48-54:filter enable

I don't see the definitions for "config1" or the filtering anywhwere.

> + *
> + */
> +
> +/* Event counters */
> +
> +#define DDRBW_ATTR(_name, _str)					\
> +	(&((struct perf_pmu_events_attr[]){				\
> +	   {.attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),\
> +	.id = 0,						\
> +	.event_str = _str }					\
> +	})[0].attr.attr)
> +
> +
> +static struct attribute *qcom_bandwidth_pmu_formats[] = {
> +	DDRBW_ATTR(ecsourcesel, "config:16-22"),
> +	DDRBW_ATTR(eceventsel, "config:0-3"),

Nit: You could name them ec_source, ec_event.

> +	DDRBW_ATTR(lc, "config:32"),

nit: lc could be renamed to something more intuitive. long may be ?
In any case, you need to document these.


> +	NULL,
> +};
> +
> +static struct attribute_group qcom_bandwidth_pmu_format_group = {
> +	.name = "format",
> +	.attrs = qcom_bandwidth_pmu_formats,
> +};
> +
> +static ssize_t qcom_bandwidth_pmu_cpumask_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct switch_pmu *pmu = to_switch_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, &pmu->cpu);
> +}
> +
> +static struct device_attribute qcom_bandwidth_pmu_cpumask_attr =
> +	__ATTR(cpumask, 0444, qcom_bandwidth_pmu_cpumask_show, NULL);
> +
> +static struct attribute *qcom_bandwidth_pmu_cpumask_attrs[] = {
> +	&qcom_bandwidth_pmu_cpumask_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group qcom_bandwidth_pmu_cpumask_attr_group = {
> +	.attrs = qcom_bandwidth_pmu_cpumask_attrs,
> +};
> +
> +
> +static struct attribute *qcom_ddrbw_pmu_events[] = {
> +	DDRBW_ATTR(ddr-read-beats, "ecsourcesel=0x14, eceventsel=0"),
> +	DDRBW_ATTR(ddr-read-beats.unit, "Bytes"),
> +	DDRBW_ATTR(ddr-read-beats.scale, "32"),
> +	DDRBW_ATTR(ddr-write-beats, "ecsourcesel=0x15, eceventsel=0"),
> +	DDRBW_ATTR(ddr-write-beats.unit, "Bytes"),
> +	DDRBW_ATTR(ddr-write-beats.scale, "32"),
> +	NULL
> +};
> +
> +static struct attribute_group qcom_bandwidth_pmu_events_group = {
> +	.name = "events",
> +	.attrs = qcom_ddrbw_pmu_events,
> +};
> +
> +static const struct attribute_group **init_attribute_groups(void)
> +{
> +	static const struct attribute_group *result[4];
> +
> +	result[0] = &qcom_bandwidth_pmu_format_group;
> +	result[1] = &qcom_bandwidth_pmu_cpumask_attr_group;
> +	result[2] = &qcom_bandwidth_pmu_events_group;
> +	result[3] = NULL;
> +	return result;
> +}



> +
> +static const struct attribute_group **attr_groups;

Could we not do this instead and remove the function ^ ?

static const struct attribute_group *attr_groups[] = {
		&qcom_bandwidth_pmu_format_group,
		&qcom_bandwidth_pmu_cpumask_attr_group,
		&qcom_bandwidth_pmu_events_group,
		NULL,
};

> +
> +/*
> + * Device probing and initialization.
> + */
> +
> +static int qcom_bandwidth_pmu_offline_cpu(unsigned int cpu,
> +	struct hlist_node *node)
> +{
> +	struct switch_pmu *pmu = hlist_entry_safe(node,
> +		struct switch_pmu, node);
> +	unsigned int target;
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &pmu->cpu))
> +		return 0;
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
>   perf_pmu_migrate_context(&pmu->perf_pmu, cpu, target); 
> +	cpumask_set_cpu(target, &pmu->cpu);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id qcom_bandwidth_pmu_acpi_match[] = {
> +	{ "QCOM80C1", },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, qcom_bandwidth_pmu_acpi_match);
> +
> +static int qcom_bandwidth_pmu_probe(struct platform_device *pdev)
> +{
> +	int result, irq, err;
> +	struct resource *regs_rc;
> +	struct switch_pmu *pmu;
> +	unsigned long uid;
> +	struct acpi_device *device;
> +	char *name;
> +
> +	regs_rc = platform_get_resource(pdev, IORESOURCE_MEM, RES_BW);
> +
> +	name = devm_kzalloc(&pdev->dev, DDRBW_PMU_NAME_LEN, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	*pmu = (struct switch_pmu) {
> +		.perf_pmu = {
> +			/* Tag this as a SW context to disable multiplexing */
> +			.task_ctx_nr	= perf_invalid_context,
> +
> +			.pmu_enable	= switch_pmu__nop,
> +			.pmu_disable	= switch_pmu__nop,
> +			.event_init	= switch_pmu__event_init,
> +			.add		= switch_pmu__event_add,
> +			.del		= switch_pmu__event_del,
> +			.start		= switch_pmu__event_start,
> +			.stop		= switch_pmu__event_stop,
> +			.read		= switch_pmu__event_read,
> +
> +			.event_idx	= dummy_event_idx,

As mentioned above, removing the field is good enough than keeping a
dummy function.

> +
> +			.attr_groups	= attr_groups

You must fill the module field of the struct pmu to prevent the
module from being unloaded.

> +		},
> +		.counters = {
> +			[0 ... BANDWIDTH_NUM_TOTAL_COUNTERS - 1] {}
> +		}

Is this really needed, given that we are doing kzalloc ?

> +	};
> +
> +	raw_spin_lock_init(&pmu->ecsel_lock);
> +


> +	/* Add this instance to the list used by the offline callback */
> +	cpuhp_state_add_instance_nocalls(cpuhp_state_num, &pmu->node);

You need to check the status of the call and take appropriate actions.

> +
> +	platform_set_drvdata(pdev, pmu);
> +
> +	return result;
> +}
> +
> +static int qcom_bandwidth_pmu_remove(struct platform_device *pdev)
> +{
> +	struct switch_pmu *pmu = platform_get_drvdata(pdev);
> +
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &pmu->node);
> +	perf_pmu_unregister(&pmu->perf_pmu);
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_bandwidth_pmu_driver = {
> +	.driver = {
> +		.name = "qcom-bandwidth-pmu-v1",

Why do we need "v1" in the driver ?

> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(qcom_bandwidth_pmu_acpi_match),
> +	},
> +	.probe = qcom_bandwidth_pmu_probe,
> +	.remove = qcom_bandwidth_pmu_remove,
> +};
> +
> +static int __init register_qcom_bandwidth_pmu_driver(void)
> +{
> +	if (attr_groups == NULL)
> +		attr_groups = init_attribute_groups();

^^ This can be removed as mentioned above.

> +
> +	/* Install a hook to update the context CPU in case it goes offline */
> +	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +		"perf/qcom/msw:online", NULL, qcom_bandwidth_pmu_offline_cpu);
> +	if (cpuhp_state_num < 0)
> +		return cpuhp_state_num;
> +
> +	return platform_driver_register(&qcom_bandwidth_pmu_driver);
> +}
> +
> +static void __exit unregister_qcom_bandwidth_pmu_driver(void)
> +{
> +	cpuhp_remove_multi_state(cpuhp_state_num);
> +	platform_driver_unregister(&qcom_bandwidth_pmu_driver);
> +}
> +
> +module_init(register_qcom_bandwidth_pmu_driver);
> +module_exit(unregister_qcom_bandwidth_pmu_driver);
> +MODULE_LICENSE("GPL v2");

You may add a module description.

> diff --git a/drivers/perf/qcom_bandwidth_perf_events.h b/drivers/perf/qcom_bandwidth_perf_events.h
> new file mode 100644
> index 0000000..120a10b
> --- /dev/null
> +++ b/drivers/perf/qcom_bandwidth_perf_events.h
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _QCOM_BANDWIDTH_PERF_EVENTS_H_
> +#define _QCOM_BANDWIDTH_PERF_EVENTS_H_
> +
> +#include<linux/bitops.h>
> +
> +/*
> + * General constants
> + */
> +
> +
> +#define BANDWIDTH_NUM_EVENT_COUNTERS    12
> +#define BANDWIDTH_NUM_TOTAL_COUNTERS    BANDWIDTH_NUM_EVENT_COUNTERS
> +#define BANDWIDTH_LAR_KEY               0xC5ACCE55
> +
> +/*
> + * Register offsets
> + */
> +
> +/* ID and Coresight registers */
> +
> +#define BANDWIDTH_LAR           0xFB0
> +
> +
> +/* Event counter registers */
> +
> +/*
> + * Because of interleaving, some gaps in the map exists
> + * (7th bit cannot be used).
> + * To accommodate this mapping,
> + * we have different offsets for different sets of counters.

Please keep the lines wrapped and please do not mix offset
definitions with function definitions.

> + */
> +
> +
> +static inline u32 qcom_bandwidth_ec_source_sel(u8 __cntr)
> +{
> +	if (__cntr >= 0 && __cntr <= 2)
> +		return (0x240 + ((__cntr) & 0xF) * 24);
> +	else if (__cntr >= 3 && __cntr <= 7/;=)
> +		return (0x2C0 + ((__cntr) & 0xF) * 24);
> +	else if (__cntr >= 8 && __cntr <= 13)
> +		return (0x340 + ((__cntr) & 0xF) * 24);
> +	else
> +		return (0x3C0 + ((__cntr) & 0xF) * 24);
> +}
> +


> +
> +#define BANDWIDTH_EC_GLOBAL_CONTROL             0xA00
> +#define BANDWIDTH_EC_ENABLE_SET                 0xA10
> +#define BANDWIDTH_EC_ENABLE_CLEAR               0xA18
> +#define BANDWIDTH_EC_INTERRUPT_ENABLE_SET       0xA20
> +#define BANDWIDTH_EC_INTERRUPT_ENABLE_CLEAR     0xA28
> +#define BANDWIDTH_EC_TRIGGER_THRESHOLD_LO       0xA30
> +#define BANDWIDTH_EC_TRIGGER_THRESHOLD_HI       0xC30
> +#define BANDWIDTH_EC_GANG                       0xE30
> +#define BANDWIDTH_EC_GANG_CONFIG0               0xE38
> +#define BANDWIDTH_EC_GANG_CONFIG1               0xE40
> +#define BANDWIDTH_EC_GANG_CONFIG2               0xE48
> +#define BANDWIDTH_EC_OVF_STATUS                 0xF00
> +#define BANDWIDTH_EC_COUNTER_SEL                0xF08
> +#define BANDWIDTH_EC_COUNT                      0xF10
> +#define BANDWIDTH_EC_SWINC                      0x1320
> +#define BANDWIDTH_EC_IRQ_CONTROL                0x1358
> +
> +/* IRQ/resource position in ACPI */
> +#define IRQ_BW                  2
> +#define RES_BW                  4
> +#define DDRBW_PMU_NAME_FORMAT   "bwddr_0_%ld"
> +#define DDRBW_PMU_NAME_LEN      11
> +#define DDRBW_MAX_RETRIES       3
> +#define DDR_BW_READ_FAIL        0
> +/*
> + * Bit field definitions, defined as (<size>, <shift>)
> + * Please note that fields that take up the whole register
> + * are not included here, as those can be set/read directly.
> + */
> +
> +/* BANDWIDTH_EC_SOURCE_SEL */
> +#define ECSOURCESEL                     (7, 16)
> +#define ECEVENTSEL                      (4,  0)
> +
> +
> +
> +/* BANDWIDTH_EC_GLOBAL_CONTROL/MONACO_TC_GLOBAL_CONTROL */
> +

What is MONACO ?

> +#define GLOBAL_TRIGOVRD                 (1, 4)
> +#define CAPTURE                         (1, 3)
> +#define RETRIEVAL_MODE                  (1, 2)
> +#define GLOBAL_RESET                    (1, 1)
> +#define GLOBAL_ENABLE                   (1, 0)
> +
> +/* MONACO_EC_ROLLOVER_CONTROL */

Could we keep the macro names below in sync with that in the comment
as they make more sense (and remove the comments) ?

> +
> +#define ECSATURATEEN(__cntr)            (1, ((__cntr) & 0xF))
> +
> +/* MONACO_EC_ENABLE_SET */
> +
> +#define ECENSET(__cntr)                 (1, ((__cntr) & 0xF))
> +
> +/* MONACO_EC_ENABLE_CLEAR */
> +
> +#define ECENCLEAR(__cntr)               (1, ((__cntr) & 0xF))
> +
> +/* MONACO_EC_INTERRUPT_ENABLE_SET */
> +
> +#define ECINTENSET(__cntr)              (1, ((__cntr) & 0xF))
> +
> +/* MONACO_EC_INTERRUPT_ENABLE_CLEAR */
> +
> +#define ECINTENCLR(__cntr)              (1, ((__cntr) & 0xF))
> +
> +/* MONACO_EC_GANG */
> +
> +#define ECGANGEN(__pair)                (1, (((__pair) & 0x7) * 2 + 1))
> +
> +/* MONACO_EC_OVF_STATUS */
> +
> +#define ECOVF(__cntr)                   (1, ((__cntr) & 0xF))
> +
> +/* MONACO_EC_COUNTER_SEL */
> +
> +#define ECSEL                           (4, 0)
> +
> +/* MONACO_EC_SWINC */
> +
> +#define ECSWINC(__cntr)                 (1, ((__cntr) & 0xF))
> +
> +
> +/* MONACO_LSR */
> +
> +#define NTT                             (1,  2)
> +#define SLK                             (1,  1)
> +#define SLI                             (1,  0)

^^^ Where are they used ?

> +
> +/*
> + * Bit field manipulation macros.
> + * These use the bitfield definitions above to set or get the given field.
> + */
> +
> +#define __SIZE(__sz, __sh) __sz
> +#define __SHIFT(__sz, __sh) __sh
> +#define __SETI(__b, __s, __v) ((u32)(((__v) & GENMASK((__b - 1), 0)) << (__s)))
> +#define __CLRI(__b, __s, __v) ((u32)((__v) & ~(GENMASK((__b - 1) + __s, __s))))
> +#define __GETI(__b, __s, __v) ((u32)(((__v) >> (__s)) & GENMASK((__b - 1), 0)))
> +
> +/* Return a value with the given bitfield set to the given value */
> +#define SET(__f, __v) __SETI(__SIZE __f, __SHIFT __f, (__v))
> +
> +/* Return a value with the given bitfield set to zero */
> +#define CLR(__f, __v) __CLRI(__SIZE __f, __SHIFT __f, (__v))
> +
> +/* Retrieve the given bitfield from the given value */
> +#define GET(__f, __v) __GETI(__SIZE __f, __SHIFT __f, (__v))



Suzuki
