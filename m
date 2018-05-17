Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeEQLM1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:12:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47842 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752349AbeEQLMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:12:23 -0400
Subject: Re: [PATCH v5 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <20180516045518.6876-1-ganapatrao.kulkarni@cavium.com>
 <20180516045518.6876-3-ganapatrao.kulkarni@cavium.com>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Vadim.Lomovtsev@cavium.com" <Vadim.Lomovtsev@cavium.com>,
        "Jan.Glauber@cavium.com" <Jan.Glauber@cavium.com>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <8f2f9e2c-50c1-bf93-525f-ebf93c69bcd7@huawei.com>
Date: Thu, 17 May 2018 12:12:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180516045518.6876-3-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2018 05:55, Ganapatrao Kulkarni wrote:
> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> Controller(DMC) and Level 3 Cache(L3C).
>

Hi,

Just some coding comments below:

> ThunderX2 has 8 independent DMC PMUs to capture performance events
> corresponding to 8 channels of DDR4 Memory Controller and 16 independent
> L3C PMUs to capture events corresponding to 16 tiles of L3 cache.
> Each PMU supports up to 4 counters. All counters lack overflow interrupt
> and are sampled periodically.
>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/perf/Kconfig         |   8 +
>  drivers/perf/Makefile        |   1 +
>  drivers/perf/thunderx2_pmu.c | 965 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h   |   1 +
>  4 files changed, 975 insertions(+)
>  create mode 100644 drivers/perf/thunderx2_pmu.c
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 28bb5a0..eafd0fc 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -85,6 +85,14 @@ config QCOM_L3_PMU
>  	   Adds the L3 cache PMU into the perf events subsystem for
>  	   monitoring L3 cache events.
>
> +config THUNDERX2_PMU
> +        bool "Cavium ThunderX2 SoC PMU UNCORE"
> +        depends on ARCH_THUNDER2 && PERF_EVENTS && ACPI

Is the explicit dependency for PERF_EVENTS required, since we're under 
the PERF_EVENTS menu?

And IIRC for other perf drivers we required a dependency on ARM64 - is 
that required here also? I see arm_smccc_smc() calls in the code...

> +	help
> +	  Provides support for ThunderX2 UNCORE events.
> +	  The SoC has PMU support in its L3 cache controller (L3C) and
> +	  in the DDR4 Memory Controller (DMC).
> +
>  config XGENE_PMU
>          depends on ARCH_XGENE
>          bool "APM X-Gene SoC PMU"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index b3902bd..909f27f 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>  obj-$(CONFIG_HISI_PMU) += hisilicon/
>  obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> +obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> new file mode 100644
> index 0000000..0401443
> --- /dev/null
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -0,0 +1,965 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CAVIUM THUNDERX2 SoC PMU UNCORE
> + *
> + * Copyright (C) 2018 Cavium Inc.
> + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Isn't this the same as the SPDX?

> +
> +#include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/* L3c and DMC has 16 and 8 channels per socket respectively.

L3C, right?

> + * Each Channel supports UNCORE PMU device and consists of
> + * 4 independent programmable counters. Counters are 32 bit
> + * and does not support overflow interrupt, they needs to be

/s/needs/need/, /s/does/do/

> + * sampled before overflow(i.e, at every 2 seconds).

how can you ensure that this value is low enough?

"I saw this comment in previous patch:
 > Given that all channels compete for access to the muxed register
 > interface, I suspect we need to try more often than once every 2
 > seconds...

2 seconds seems to be sufficient. So far testing looks good."

Can you provide any more analytical reasoning than this?

> + */
> +
> +#define UNCORE_MAX_COUNTERS		4
> +#define UNCORE_L3_MAX_TILES		16
> +#define UNCORE_DMC_MAX_CHANNELS		8
> +
> +#define UNCORE_HRTIMER_INTERVAL		(2 * NSEC_PER_SEC)
> +#define GET_EVENTID(ev)			((ev->hw.config) & 0x1ff)
> +#define GET_COUNTERID(ev)		((ev->hw.idx) & 0xf)
> +#define GET_CHANNELID(pmu_uncore)	(pmu_uncore->channel)
> +#define DMC_EVENT_CFG(idx, val)		((val) << (((idx) * 8) + 1))
> +
> +#define DMC_COUNTER_CTL			0x234
> +#define DMC_COUNTER_DATA		0x240
> +#define L3C_COUNTER_CTL			0xA8
> +#define L3C_COUNTER_DATA		0xAC

I feel it's generally better to keep register offsets in numeric order 
(if indeed, that is what they are)

> +
> +#define THUNDERX2_SMC_CALL_ID		0xC200FF00
> +#define THUNDERX2_SMC_SET_CHANNEL	0xB010
> +
> +enum thunderx2_uncore_l3_events {
> +	L3_EVENT_NONE,
> +	L3_EVENT_NBU_CANCEL,
> +	L3_EVENT_DIB_RETRY,
> +	L3_EVENT_DOB_RETRY,
> +	L3_EVENT_DIB_CREDIT_RETRY,
> +	L3_EVENT_DOB_CREDIT_RETRY,
> +	L3_EVENT_FORCE_RETRY,
> +	L3_EVENT_IDX_CONFLICT_RETRY,
> +	L3_EVENT_EVICT_CONFLICT_RETRY,
> +	L3_EVENT_BANK_CONFLICT_RETRY,
> +	L3_EVENT_FILL_ENTRY_RETRY,
> +	L3_EVENT_EVICT_NOT_READY_RETRY,
> +	L3_EVENT_L3_RETRY,
> +	L3_EVENT_READ_REQ,
> +	L3_EVENT_WRITE_BACK_REQ,
> +	L3_EVENT_INVALIDATE_NWRITE_REQ,
> +	L3_EVENT_INV_REQ,
> +	L3_EVENT_SELF_REQ,
> +	L3_EVENT_REQ,
> +	L3_EVENT_EVICT_REQ,
> +	L3_EVENT_INVALIDATE_NWRITE_HIT,
> +	L3_EVENT_INVALIDATE_HIT,
> +	L3_EVENT_SELF_HIT,
> +	L3_EVENT_READ_HIT,
> +	L3_EVENT_MAX,

',' required?

> +};
> +
> +enum thunderx2_uncore_dmc_events {
> +	DMC_EVENT_NONE,
> +	DMC_EVENT_COUNT_CYCLES,
> +	DMC_EVENT_RES2,
> +	DMC_EVENT_RES3,
> +	DMC_EVENT_RES4,
> +	DMC_EVENT_RES5,
> +	DMC_EVENT_RES6,
> +	DMC_EVENT_RES7,
> +	DMC_EVENT_RES8,
> +	DMC_EVENT_READ_64B_TXNS,
> +	DMC_EVENT_READ_BELOW_64B_TXNS,
> +	DMC_EVENT_WRITE_TXNS,
> +	DMC_EVENT_TXN_CYCLES,
> +	DMC_EVENT_DATA_TRANSFERS,
> +	DMC_EVENT_CANCELLED_READ_TXNS,
> +	DMC_EVENT_CONSUMED_READ_TXNS,
> +	DMC_EVENT_MAX,

ditto

> +};
> +
> +enum thunderx2_uncore_type {
> +	PMU_TYPE_L3C,
> +	PMU_TYPE_DMC,
> +	PMU_TYPE_INVALID,
> +};
> +
> +/*
> + * pmu on each socket has 2 uncore devices(dmc and l3),
> + * each uncore device has up to 16 channels, each channel can sample
> + * events independently with counters up to 4.
> + *
> + * struct thunderx2_pmu_uncore_channel created per channel.
> + * struct thunderx2_pmu_uncore_dev per uncore device.

this comment is a bit obvious

> + */
> +struct thunderx2_pmu_uncore_channel {
> +	struct pmu pmu;
> +	struct hlist_node	node;
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	int channel;
> +	int cpu;
> +	DECLARE_BITMAP(active_counters, UNCORE_MAX_COUNTERS);
> +	struct perf_event *events[UNCORE_MAX_COUNTERS];
> +	struct hrtimer hrtimer;
> +	/* to sync counter alloc/release */
> +	raw_spinlock_t lock;
> +};
> +
> +struct thunderx2_pmu_uncore_dev {
> +	char *name;
> +	struct device *dev;
> +	enum thunderx2_uncore_type type;
> +	void __iomem *base;
> +	int node;
> +	u32    max_counters;
> +	u32    max_channels;
> +	u32    max_events;
> +	u64 hrtimer_interval;
> +	/* this lock synchronizes across channels */
> +	raw_spinlock_t lock;
> +	const struct attribute_group **attr_groups;
> +	void	(*init_cntr_base)(struct perf_event *event,
> +			struct thunderx2_pmu_uncore_dev *uncore_dev);
> +	void	(*select_channel)(struct perf_event *event);
> +	void	(*stop_event)(struct perf_event *event);
> +	void	(*start_event)(struct perf_event *event, int flags);
> +};
> +
> +static inline struct thunderx2_pmu_uncore_channel *

is inline keyword required or even used generally? Since static, can't 
the compiler figure this out?

> +pmu_to_thunderx2_pmu_uncore(struct pmu *pmu)
> +{
> +	return container_of(pmu, struct thunderx2_pmu_uncore_channel, pmu);
> +}
> +
> +/*
> + * sysfs format attributes
> + */

can't this comment fit on a single line?

> +static ssize_t thunderx2_pmu_format_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	return sprintf(buf, "%s\n", (char *) eattr->var);
> +}
> +
> +#define FORMAT_ATTR(_name, _config) \
> +	(&((struct dev_ext_attribute[]) { \
> +	   { \
> +	   .attr = __ATTR(_name, 0444, thunderx2_pmu_format_show, NULL), \
> +	   .var = (void *) _config, \
> +	   } \
> +	})[0].attr.attr)
> +
> +static struct attribute *l3c_pmu_format_attrs[] = {
> +	FORMAT_ATTR(event,	"config:0-4"),
> +	NULL,
> +};
> +
> +static struct attribute *dmc_pmu_format_attrs[] = {
> +	FORMAT_ATTR(event,	"config:0-4"),
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

[ ... ]

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
> +static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
> +{
> +	int counter;
> +
> +	raw_spin_lock(&pmu_uncore->lock);
> +	counter = find_first_zero_bit(pmu_uncore->active_counters,
> +				pmu_uncore->uncore_dev->max_counters);
> +	if (counter == pmu_uncore->uncore_dev->max_counters) {
> +		raw_spin_unlock(&pmu_uncore->lock);
> +		return -ENOSPC;
> +	}
> +	set_bit(counter, pmu_uncore->active_counters);
> +	raw_spin_unlock(&pmu_uncore->lock);
> +	return counter;
> +}
> +
> +static void free_counter(
> +		struct thunderx2_pmu_uncore_channel *pmu_uncore, int counter)

strange formatting

> +{
> +	raw_spin_lock(&pmu_uncore->lock);
> +	clear_bit(counter, pmu_uncore->active_counters);
> +	raw_spin_unlock(&pmu_uncore->lock);
> +}
> +

[ ... ]

> +static void uncore_stop_event_l3c(struct perf_event *event)
> +{
> +	reg_writel(0, event->hw.config_base);
> +}
> +
> +static void uncore_start_event_dmc(struct perf_event *event, int flags)
> +{
> +	u32 val;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = GET_COUNTERID(event);
> +	int event_type = GET_EVENTID(event);
> +
> +	/* enable and start counters.
> +	 * 8 bits for each counter, bits[05:01] of a counter to set event type.
> +	 */
> +	val = reg_readl(hwc->config_base);
> +	val &= ~DMC_EVENT_CFG(idx, 0x1f);
> +	val |= DMC_EVENT_CFG(idx, event_type);
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
> +static void init_cntr_base_l3c(struct perf_event *event,
> +		struct thunderx2_pmu_uncore_dev *uncore_dev)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* counter ctrl/data reg offset at 8 */
> +	hwc->config_base = (unsigned long)uncore_dev->base
> +		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
> +	hwc->event_base =  (unsigned long)uncore_dev->base
> +		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));

Is there a better way to hold this, since we're casting back to a void * 
when writing to the register?

> +}
> +
> +static void init_cntr_base_dmc(struct perf_event *event,
> +		struct thunderx2_pmu_uncore_dev *uncore_dev)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hwc->config_base = (unsigned long)uncore_dev->base
> +		+ DMC_COUNTER_CTL;
> +	/* counter data reg offset at 0xc */
> +	hwc->event_base = (unsigned long)uncore_dev->base
> +		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
> +}
> +
> +static void thunderx2_uncore_update(struct perf_event *event)
> +{
> +	s64 prev, new = 0;
> +	u64 delta;
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	enum thunderx2_uncore_type type;
> +
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	type = pmu_uncore->uncore_dev->type;
> +
> +	pmu_uncore->uncore_dev->select_channel(event);
> +
> +	new = reg_readl(hwc->event_base);
> +	prev = local64_xchg(&hwc->prev_count, new);
> +
> +	/* handles rollover of 32 bit counter */
> +	delta = (u32)(((1UL << 32) - prev) + new);
> +	local64_add(delta, &event->count);
> +}
> +
> +enum thunderx2_uncore_type get_uncore_device_type(struct acpi_device *adev)
> +{
> +	int i = 0;
> +	struct acpi_uncore_device {
> +		__u8 id[ACPI_ID_LEN];
> +		enum thunderx2_uncore_type type;
> +	} devices[] = {
> +		{"CAV901D", PMU_TYPE_L3C},
> +		{"CAV901F", PMU_TYPE_DMC},
> +		{"", PMU_TYPE_INVALID},


for sentinels, ',' should not be required

> +	};
> +
> +	while (devices[i].type != PMU_TYPE_INVALID) {
> +		if (!strcmp(acpi_device_hid(adev), devices[i].id))
> +			return devices[i].type;

Can't you use acpi_match_device()?

> +		i++;
> +	}
> +	return PMU_TYPE_INVALID;
> +}
> +
> +/*
> + * We must NOT create groups containing events from multiple hardware PMUs,
> + * although mixing different software and hardware PMUs is allowed.
> + */
> +static bool thunderx2_uncore_validate_event_group(struct perf_event *event)

[ ... ]

> +
> +static int thunderx2_pmu_uncore_add(struct thunderx2_pmu_uncore_dev *uncore_dev,
> +		int channel)
> +{
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	int ret, cpu;
> +
> +	pmu_uncore = devm_kzalloc(uncore_dev->dev, sizeof(*pmu_uncore),
> +			GFP_KERNEL);
> +	if (!pmu_uncore)
> +		return -ENOMEM;
> +
> +	cpu = cpumask_any_and(cpumask_of_node(uncore_dev->node),
> +			cpu_online_mask);
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	pmu_uncore->cpu = cpu;
> +	pmu_uncore->channel = channel;
> +	pmu_uncore->uncore_dev = uncore_dev;
> +
> +	hrtimer_init(&pmu_uncore->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	pmu_uncore->hrtimer.function = thunderx2_uncore_hrtimer_callback;
> +
> +	ret = thunderx2_pmu_uncore_register(pmu_uncore);
> +	if (ret) {
> +		dev_err(uncore_dev->dev, "%s PMU: Failed to init driver\n",
> +				uncore_dev->name);
> +		return -ENODEV;
> +	}
> +
> +	/* register hotplug callback for the pmu */
> +	ret = cpuhp_state_add_instance(
> +			CPUHP_AP_PERF_ARM_THUNDERX2_UNCORE_ONLINE,
> +			&pmu_uncore->node);
> +	if (ret) {
> +		dev_err(uncore_dev->dev, "Error %d registering hotplug", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(uncore_dev->dev, "%s PMU UNCORE registered\n",
> +			pmu_uncore->pmu.name);

strange alignment, and many more times in the code

> +	return ret;
> +}
> +
> +static struct thunderx2_pmu_uncore_dev *init_pmu_uncore_dev(
> +		struct device *dev, acpi_handle handle,
> +		struct acpi_device *adev, u32 type)
> +{
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	void __iomem *base;
> +	struct resource res;
> +	struct resource_entry *rentry;
> +	struct list_head list;
> +	int ret;
> +
> +	INIT_LIST_HEAD(&list);
> +	ret = acpi_dev_get_resources(adev, &list, NULL, NULL);
> +	if (ret <= 0) {
> +		dev_err(dev, "failed to parse _CRS method, error %d\n", ret);
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(rentry, &list, node) {
> +		if (resource_type(rentry->res) == IORESOURCE_MEM) {
> +			res = *rentry->res;
> +			break;
> +		}
> +	}

what I am missing that you can not use 
platform_get_resource(,IORESOURCE_MEM,)?


And I also wonder if you need all the device-related arguments for the code

> +
> +	if (!rentry->res)
> +		return NULL;
> +
> +	acpi_dev_free_resource_list(&list);
> +	base = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
> +		return NULL;
> +	}
> +
> +	uncore_dev = devm_kzalloc(dev, sizeof(*uncore_dev), GFP_KERNEL);
> +	if (!uncore_dev)
> +		return NULL;
> +
> +	uncore_dev->dev = dev;
> +	uncore_dev->type = type;
> +	uncore_dev->base = base;
> +	uncore_dev->node = dev_to_node(dev);
> +
> +	raw_spin_lock_init(&uncore_dev->lock);
> +
> +	switch (uncore_dev->type) {

if we can re-arrange, isn't it better to do the steps which can fail 
before the steps which can't?

> +	case PMU_TYPE_L3C:
> +		uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
> +		uncore_dev->max_channels = UNCORE_L3_MAX_TILES;
> +		uncore_dev->max_events = L3_EVENT_MAX;
> +		uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
> +		uncore_dev->attr_groups = l3c_pmu_attr_groups;
> +		uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
> +				"uncore_l3c_%d", uncore_dev->node);
> +		uncore_dev->init_cntr_base = init_cntr_base_l3c;
> +		uncore_dev->start_event = uncore_start_event_l3c;
> +		uncore_dev->stop_event = uncore_stop_event_l3c;
> +		uncore_dev->select_channel = uncore_select_channel;

it's possible to bring the common code outside the swicth statement, but 
probably not worth it

> +		break;
> +	case PMU_TYPE_DMC:
> +		uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
> +		uncore_dev->max_channels = UNCORE_DMC_MAX_CHANNELS;
> +		uncore_dev->max_events = DMC_EVENT_MAX;
> +		uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
> +		uncore_dev->attr_groups = dmc_pmu_attr_groups;
> +		uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
> +				"uncore_dmc_%d", uncore_dev->node);
> +		uncore_dev->init_cntr_base = init_cntr_base_dmc;
> +		uncore_dev->start_event = uncore_start_event_dmc;
> +		uncore_dev->stop_event = uncore_stop_event_dmc;
> +		uncore_dev->select_channel = uncore_select_channel;
> +		break;
> +	case PMU_TYPE_INVALID:
> +		devm_kfree(dev, uncore_dev);

do you really need this?

> +		uncore_dev = NULL;
> +		break;

return NULL

And don't we require a default statement?

> +	}
> +
> +	return uncore_dev;
> +}
> +
> +static acpi_status thunderx2_pmu_uncore_dev_add(acpi_handle handle, u32 level,
> +				    void *data, void **return_value)
> +{
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	struct acpi_device *adev;
> +	enum thunderx2_uncore_type type;
> +	int channel;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return AE_OK;
> +	if (acpi_bus_get_status(adev) || !adev->status.present)
> +		return AE_OK;
> +
> +	type = get_uncore_device_type(adev);
> +	if (type == PMU_TYPE_INVALID)
> +		return AE_OK;
> +
> +	uncore_dev = init_pmu_uncore_dev((struct device *)data, handle,

no need to cast void *

> +			adev, type);
> +
> +	if (!uncore_dev)
> +		return AE_ERROR;
> +
> +	for (channel = 0; channel < uncore_dev->max_channels; channel++) {
> +		if (thunderx2_pmu_uncore_add(uncore_dev, channel)) {
> +			/* Can't add the PMU device, abort */
> +			return AE_ERROR;
> +		}
> +	}
> +	return AE_OK;
> +}
> +
> +static int thunderx2_uncore_pmu_offline_cpu(unsigned int cpu,
> +		struct hlist_node *node)
> +{
> +	int new_cpu;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +
> +	pmu_uncore = hlist_entry_safe(node,
> +			struct thunderx2_pmu_uncore_channel, node);
> +	if (cpu != pmu_uncore->cpu)
> +		return 0;
> +
> +	new_cpu = cpumask_any_and(
> +			cpumask_of_node(pmu_uncore->uncore_dev->node),
> +			cpu_online_mask);
> +	if (new_cpu >= nr_cpu_ids)
> +		return 0;
> +
> +	pmu_uncore->cpu = new_cpu;
> +	perf_pmu_migrate_context(&pmu_uncore->pmu, cpu, new_cpu);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id thunderx2_uncore_acpi_match[] = {
> +	{"CAV901C", 0},
> +	{},

no ',' required

> +};
> +MODULE_DEVICE_TABLE(acpi, thunderx2_uncore_acpi_match);
> +
> +static int thunderx2_uncore_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	set_dev_node(dev, acpi_get_node(ACPI_HANDLE(dev)));

Is this already done when the platform device is created in ACPI 
enumeration? I assume the child devices have enumerated at this point.

> +
> +	/* Make sure firmware supports DMC/L3C set channel smc call */
> +	if (test_uncore_select_channel_early(dev))
> +		return -ENODEV;
> +
> +	if (!has_acpi_companion(dev))
> +		return -ENODEV;
> +
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	/* Walk through the tree for all PMU UNCORE devices */
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     thunderx2_pmu_uncore_dev_add,
> +				     NULL, dev, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "failed to probe PMU devices\n");
> +		return_ACPI_STATUS(status);
> +	}
> +
> +	dev_info(dev, "node%d: pmu uncore registered\n", dev_to_node(dev));
> +	return 0;
> +}
> +
> +static struct platform_driver thunderx2_uncore_driver = {
> +	.probe = thunderx2_uncore_probe,

why no remove?

> +	.driver = {
> +		.name		= "thunderx2-uncore-pmu",
> +		.acpi_match_table = ACPI_PTR(thunderx2_uncore_acpi_match),
> +	},
> +};
> +
> +static int __init register_thunderx2_uncore_driver(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_THUNDERX2_UNCORE_ONLINE,
> +				      "perf/tx2/uncore:online",
> +				      NULL,
> +				      thunderx2_uncore_pmu_offline_cpu);
> +	if (ret)
> +		return ret;
> +
> +	return platform_driver_register(&thunderx2_uncore_driver);
> +
> +}
> +device_initcall(register_thunderx2_uncore_driver);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 8796ba3..eb0c896 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -161,6 +161,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>  	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
> +	CPUHP_AP_PERF_ARM_THUNDERX2_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
>
