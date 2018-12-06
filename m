Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349B020850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349B020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeLFJZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:25:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbeLFJZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:25:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E01A78;
        Thu,  6 Dec 2018 01:25:03 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F3473F5AF;
        Thu,  6 Dec 2018 01:25:01 -0800 (PST)
Subject: Re: [PATCH v9 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
To:     "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
References: <20181205105853.15154-1-ganapatrao.kulkarni@cavium.com>
 <20181205105853.15154-3-ganapatrao.kulkarni@cavium.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <866da1c3-6901-8aed-26ef-9a1bfc06cadd@arm.com>
Date:   Thu, 6 Dec 2018 09:24:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205105853.15154-3-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganpat,

On 05/12/2018 10:59, Kulkarni, Ganapatrao wrote:
> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> Controller(DMC) and Level 3 Cache(L3C). Each PMU supports up to 4
> counters. All counters lack overflow interrupt and are
> sampled periodically.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>   drivers/perf/Kconfig         |   9 +
>   drivers/perf/Makefile        |   1 +
>   drivers/perf/thunderx2_pmu.c | 861 +++++++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h   |   1 +
>   4 files changed, 872 insertions(+)
>   create mode 100644 drivers/perf/thunderx2_pmu.c

> --- /dev/null
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -0,0 +1,861 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CAVIUM THUNDERX2 SoC PMU UNCORE
> + * Copyright (C) 2018 Cavium Inc.
> + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/* Each ThunderX2(TX2) Socket has a L3C and DMC UNCORE PMU device.
> + * Each UNCORE PMU device consists of 4 independent programmable counters.
> + * Counters are 32 bit and do not support overflow interrupt,
> + * they need to be sampled before overflow(i.e, at every 2 seconds).
> + */
> +
> +#define TX2_PMU_MAX_COUNTERS		4
> +#define TX2_PMU_DMC_CHANNELS		8
> +#define TX2_PMU_L3_TILES		16
> +
> +#define TX2_PMU_HRTIMER_INTERVAL	(2 * NSEC_PER_SEC)
> +#define GET_EVENTID(ev)			((ev->hw.config) & 0x1f)
> +#define GET_COUNTERID(ev)		((ev->hw.idx) & 0x3)
> + /* 1 byte per counter(4 counters).
> +  * Event id is encoded in bits [5:1] of a byte,
> +  */
> +#define DMC_EVENT_CFG(idx, val)		((val) << (((idx) * 8) + 1))
> +
> +#define L3C_COUNTER_CTL			0xA8
> +#define L3C_COUNTER_DATA		0xAC
> +#define DMC_COUNTER_CTL			0x234
> +#define DMC_COUNTER_DATA		0x240
> +
> +/* L3C event IDs */
> +#define L3_EVENT_READ_REQ		0xD
> +#define L3_EVENT_WRITEBACK_REQ		0xE
> +#define L3_EVENT_INV_N_WRITE_REQ	0xF
> +#define L3_EVENT_INV_REQ		0x10
> +#define L3_EVENT_EVICT_REQ		0x13
> +#define L3_EVENT_INV_N_WRITE_HIT	0x14
> +#define L3_EVENT_INV_HIT		0x15
> +#define L3_EVENT_READ_HIT		0x17
> +#define L3_EVENT_MAX			0x18
> +
> +/* DMC event IDs */
> +#define DMC_EVENT_COUNT_CYCLES		0x1
> +#define DMC_EVENT_WRITE_TXNS		0xB
> +#define DMC_EVENT_DATA_TRANSFERS	0xD
> +#define DMC_EVENT_READ_TXNS		0xF
> +#define DMC_EVENT_MAX			0x10
> +
> +enum tx2_uncore_type {
> +	PMU_TYPE_L3C,
> +	PMU_TYPE_DMC,
> +	PMU_TYPE_INVALID,
> +};
> +
> +/*
> + * pmu on each socket has 2 uncore devices(dmc and l3c),
> + * each device has 4 counters.
> + */
> +struct tx2_uncore_pmu {
> +	struct hlist_node hpnode;
> +	struct list_head  entry;
> +	struct pmu pmu;
> +	char *name;
> +	int node;
> +	int cpu;
> +	u32    max_counters;
> +	u32    prorate_factor;
> +	u32    max_events;
> +	u64 hrtimer_interval;

minor nit:

The alignment of the fields are pretty inconsistent. e.g,
u32 is followed by tabs and the rest are not. Please keep it
consistent.

> +	void __iomem *base;
> +	DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
> +	struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> +	struct device *dev;
> +	struct hrtimer hrtimer;
> +	const struct attribute_group **attr_groups;
> +	enum tx2_uncore_type type;
> +	void	(*init_cntr_base)(struct perf_event *event,
> +			struct tx2_uncore_pmu *tx2_pmu);
> +	void	(*stop_event)(struct perf_event *event);
> +	void	(*start_event)(struct perf_event *event, int flags);
> +};
> +
> +static LIST_HEAD(tx2_pmus);
> +
> +static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
> +{
> +	return container_of(pmu, struct tx2_uncore_pmu, pmu);
> +}
> +
> +PMU_FORMAT_ATTR(event,	"config:0-4");
> +
> +static struct attribute *l3c_pmu_format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute *dmc_pmu_format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group l3c_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = l3c_pmu_format_attrs,
> +};
> +
> +static const struct attribute_group dmc_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = dmc_pmu_format_attrs,
> +};
> +
> +/*
> + * sysfs event attributes
> + */
> +static ssize_t tx2_pmu_event_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	return sprintf(buf, "event=0x%lx\n", (unsigned long) eattr->var);
> +}
> +
> +#define TX2_EVENT_ATTR(name, config) \
> +	PMU_EVENT_ATTR(name, tx2_pmu_event_attr_##name, \
> +			config, tx2_pmu_event_show)
> +
> +TX2_EVENT_ATTR(read_request, L3_EVENT_READ_REQ);
> +TX2_EVENT_ATTR(writeback_request, L3_EVENT_WRITEBACK_REQ);
> +TX2_EVENT_ATTR(inv_nwrite_request, L3_EVENT_INV_N_WRITE_REQ);
> +TX2_EVENT_ATTR(inv_request, L3_EVENT_INV_REQ);
> +TX2_EVENT_ATTR(evict_request, L3_EVENT_EVICT_REQ);
> +TX2_EVENT_ATTR(inv_nwrite_hit, L3_EVENT_INV_N_WRITE_HIT);
> +TX2_EVENT_ATTR(inv_hit, L3_EVENT_INV_HIT);
> +TX2_EVENT_ATTR(read_hit, L3_EVENT_READ_HIT);
> +
> +static struct attribute *l3c_pmu_events_attrs[] = {
> +	&tx2_pmu_event_attr_read_request.attr.attr,
> +	&tx2_pmu_event_attr_writeback_request.attr.attr,
> +	&tx2_pmu_event_attr_inv_nwrite_request.attr.attr,
> +	&tx2_pmu_event_attr_inv_request.attr.attr,
> +	&tx2_pmu_event_attr_evict_request.attr.attr,
> +	&tx2_pmu_event_attr_inv_nwrite_hit.attr.attr,
> +	&tx2_pmu_event_attr_inv_hit.attr.attr,
> +	&tx2_pmu_event_attr_read_hit.attr.attr,
> +	NULL,
> +};
> +
> +TX2_EVENT_ATTR(cnt_cycles, DMC_EVENT_COUNT_CYCLES);
> +TX2_EVENT_ATTR(write_txns, DMC_EVENT_WRITE_TXNS);
> +TX2_EVENT_ATTR(data_transfers, DMC_EVENT_DATA_TRANSFERS);
> +TX2_EVENT_ATTR(read_txns, DMC_EVENT_READ_TXNS);
> +
> +static struct attribute *dmc_pmu_events_attrs[] = {
> +	&tx2_pmu_event_attr_cnt_cycles.attr.attr,
> +	&tx2_pmu_event_attr_write_txns.attr.attr,
> +	&tx2_pmu_event_attr_data_transfers.attr.attr,
> +	&tx2_pmu_event_attr_read_txns.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group l3c_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = l3c_pmu_events_attrs,
> +};
> +
> +static const struct attribute_group dmc_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = dmc_pmu_events_attrs,
> +};
> +
> +/*
> + * sysfs cpumask attributes
> + */
> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct tx2_uncore_pmu *tx2_pmu;
> +
> +	tx2_pmu = pmu_to_tx2_pmu(dev_get_drvdata(dev));
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tx2_pmu->cpu));
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *tx2_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group pmu_cpumask_attr_group = {
> +	.attrs = tx2_pmu_cpumask_attrs,
> +};
> +
> +/*
> + * Per PMU device attribute groups
> + */
> +static const struct attribute_group *l3c_pmu_attr_groups[] = {
> +	&l3c_pmu_format_attr_group,
> +	&pmu_cpumask_attr_group,
> +	&l3c_pmu_events_attr_group,
> +	NULL
> +};
> +
> +static const struct attribute_group *dmc_pmu_attr_groups[] = {
> +	&dmc_pmu_format_attr_group,
> +	&pmu_cpumask_attr_group,
> +	&dmc_pmu_events_attr_group,
> +	NULL
> +};
> +
> +static inline u32 reg_readl(unsigned long addr)
> +{
> +	return readl((void __iomem *)addr);
> +}
> +
> +static inline void reg_writel(u32 val, unsigned long addr)
> +{
> +	writel(val, (void __iomem *)addr);
> +}
> +
> +static int alloc_counter(struct tx2_uncore_pmu *tx2_pmu)
> +{
> +	int counter;
> +
> +	counter = find_first_zero_bit(tx2_pmu->active_counters,
> +				tx2_pmu->max_counters);
> +	if (counter == tx2_pmu->max_counters)
> +		return -ENOSPC;
> +
> +	set_bit(counter, tx2_pmu->active_counters);
> +	return counter;
> +}
> +
> +static inline void free_counter(struct tx2_uncore_pmu *tx2_pmu, int counter)
> +{
> +	clear_bit(counter, tx2_pmu->active_counters);
> +}
> +
> +static void init_cntr_base_l3c(struct perf_event *event,
> +		struct tx2_uncore_pmu *tx2_pmu)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* counter ctrl/data reg offset at 8 */
> +	hwc->config_base = (unsigned long)tx2_pmu->base
> +		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
> +	hwc->event_base =  (unsigned long)tx2_pmu->base
> +		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
> +}
> +
> +static void init_cntr_base_dmc(struct perf_event *event,
> +		struct tx2_uncore_pmu *tx2_pmu)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hwc->config_base = (unsigned long)tx2_pmu->base
> +		+ DMC_COUNTER_CTL;
> +	/* counter data reg offset at 0xc */
> +	hwc->event_base = (unsigned long)tx2_pmu->base
> +		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
> +}
> +
> +static void uncore_start_event_l3c(struct perf_event *event, int flags)
> +{
> +	u32 val;
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* event id encoded in bits [07:03] */
> +	val = GET_EVENTID(event) << 3;
> +	reg_writel(val, hwc->config_base);
> +	local64_set(&hwc->prev_count, 0);
> +	reg_writel(0, hwc->event_base);
> +}
> +
> +static inline void uncore_stop_event_l3c(struct perf_event *event)
> +{
> +	reg_writel(0, event->hw.config_base);
> +}
> +
> +static void uncore_start_event_dmc(struct perf_event *event, int flags)
> +{
> +	u32 val;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = GET_COUNTERID(event);
> +	int event_id = GET_EVENTID(event);
> +
> +	/* enable and start counters.
> +	 * 8 bits for each counter, bits[05:01] of a counter to set event type.
> +	 */
> +	val = reg_readl(hwc->config_base);
> +	val &= ~DMC_EVENT_CFG(idx, 0x1f);
> +	val |= DMC_EVENT_CFG(idx, event_id);
> +	reg_writel(val, hwc->config_base);
> +	local64_set(&hwc->prev_count, 0);
> +	reg_writel(0, hwc->event_base);
> +}
> +
> +static void uncore_stop_event_dmc(struct perf_event *event)
> +{
> +	u32 val;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = GET_COUNTERID(event);
> +
> +	/* clear event type(bits[05:01]) to stop counter */
> +	val = reg_readl(hwc->config_base);
> +	val &= ~DMC_EVENT_CFG(idx, 0x1f);
> +	reg_writel(val, hwc->config_base);
> +}
> +
> +static void tx2_uncore_event_update(struct perf_event *event)
> +{
> +	s64 prev, delta, new = 0;
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct tx2_uncore_pmu *tx2_pmu;
> +	enum tx2_uncore_type type;
> +	u32    prorate_factor;
> +
> +	tx2_pmu = pmu_to_tx2_pmu(event->pmu);
> +	type = tx2_pmu->type;
> +	prorate_factor = tx2_pmu->prorate_factor;
> +
> +	new = reg_readl(hwc->event_base);
> +	prev = local64_xchg(&hwc->prev_count, new);
> +
> +	/* handles rollover of 32 bit counter */
> +	delta = (u32)(((1UL << 32) - prev) + new);
> +
> +	/* DMC event data_transfers granularity is 16 Bytes, convert it to 64 */
> +	if (type == PMU_TYPE_DMC &&
> +			GET_EVENTID(event) == DMC_EVENT_DATA_TRANSFERS)
> +		delta = delta/4;
> +
> +	/* L3C and DMC has 16 and 8 interleave channels respectively.
> +	 * The sampled value is for channel 0 and multiplied with
> +	 * prorate_factor to get the count for a device.
> +	 */
> +	local64_add(delta * prorate_factor, &event->count);
> +}
> +
> +enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
> +{
> +	int i = 0;
> +	struct acpi_tx2_pmu_device {
> +		__u8 id[ACPI_ID_LEN];
> +		enum tx2_uncore_type type;
> +	} devices[] = {
> +		{"CAV901D", PMU_TYPE_L3C},
> +		{"CAV901F", PMU_TYPE_DMC},
> +		{"", PMU_TYPE_INVALID}
> +	};
> +
> +	while (devices[i].type != PMU_TYPE_INVALID) {
> +		if (!strcmp(acpi_device_hid(adev), devices[i].id))
> +			break;
> +		i++;
> +	}
> +
> +	return devices[i].type;
> +}
> +
> +static bool tx2_uncore_validate_event(struct pmu *pmu,
> +				  struct perf_event *event, int *counters)
> +{
> +	if (is_software_event(event))
> +		return true;
> +	/* Reject groups spanning multiple HW PMUs. */
> +	if (event->pmu != pmu)
> +		return false;
> +
> +	*counters = *counters + 1;
> +		return true;

nit: alignment.

Otherwise looks good to me.
FWIW, with the above nits fixed:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
