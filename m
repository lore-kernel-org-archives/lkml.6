Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA66C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A18E20864
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A18E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbeGLRGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:06:33 -0400
Received: from foss.arm.com ([217.140.101.70]:53474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732384AbeGLRGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:06:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927B1ED1;
        Thu, 12 Jul 2018 09:56:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7EDB3F589;
        Thu, 12 Jul 2018 09:56:08 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:56:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Will.Deacon@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com,
        gklkml16@gmail.com
Subject: Re: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-ID: <20180712165606.3vqx4ysnvdlfzmtp@lakrids.cambridge.arm.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapat,

On Thu, Jun 21, 2018 at 12:03:38PM +0530, Ganapatrao Kulkarni wrote:
> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> Controller(DMC) and Level 3 Cache(L3C).
> 
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
>  drivers/perf/thunderx2_pmu.c | 949 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h   |   1 +
>  4 files changed, 959 insertions(+)
>  create mode 100644 drivers/perf/thunderx2_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 08ebaf7..ecedb9e 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,6 +87,14 @@ config QCOM_L3_PMU
>  	   Adds the L3 cache PMU into the perf events subsystem for
>  	   monitoring L3 cache events.
>  
> +config THUNDERX2_PMU
> +        bool "Cavium ThunderX2 SoC PMU UNCORE"
> +	depends on ARCH_THUNDER2 && ARM64 && ACPI

Surely this depends on NUMA for the node id?

[...]

> +/*
> + * pmu on each socket has 2 uncore devices(dmc and l3),
> + * each uncore device has up to 16 channels, each channel can sample
> + * events independently with counters up to 4.
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

This lock should not be necessary. The pmu::{add,del} callbacks are
strictly serialised w.r.t. one another per CPU because the core perf
code holds ctx->lock whenever it calls either.

Previously, you mentioned you'd seen scheduling while atomic when this
lock was removed. Could you please provide a backtrace?

[...]

It would be worth a comment here explaining which resources the channel
PMUs share, and why we need this thunderx2_pmu_uncore_dev. IIUC, it's
just that they share a register windows switched by FW?

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

As a general thing, the really long structure/enum/macro names make
things really hard to read.

Could we s/THUNDERX2/TX2/ and s/thunderx2/tx2/ for identifiers please?

Similarly:

* s/thunderx2_pmu_uncore_channel/tx2_pmu/ 

* s/thunderx2_pmu_uncore_dev/tx2_pmu_group/

... and consistently name those "pmu" and "pmu_group" respectively --
that mekas the relationship between the two much clearer for someone who
is not intimately familiar with the hardware.

That makes things far more legible, e.g.

> +static inline struct thunderx2_pmu_uncore_channel *
> +pmu_to_thunderx2_pmu_uncore(struct pmu *pmu)
> +{
> +	return container_of(pmu, struct thunderx2_pmu_uncore_channel, pmu);
> +}

... becomes:

static struct tx2_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
{
	return container_of(pmu, struct tx2_pmu, pmu);
}

[...]

> +/*
> + * sysfs cpumask attributes
> + */
> +static ssize_t cpumask_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct cpumask cpu_mask;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore =
> +		pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
> +
> +	cpumask_clear(&cpu_mask);
> +	cpumask_set_cpu(pmu_uncore->cpu, &cpu_mask);
> +	return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
> +}
> +static DEVICE_ATTR_RO(cpumask);

This can be simplified to:

static ssize_t cpumask_show(struct device *dev, struct device_attribute
			    *attr, char *buf)
{
	struct thunderx2_pmu_uncore_channel *pmu_uncore;
	pmu_uncore = pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));

	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu_uncore->cpu));
}

[...]

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
> +{
> +	raw_spin_lock(&pmu_uncore->lock);
> +	clear_bit(counter, pmu_uncore->active_counters);
> +	raw_spin_unlock(&pmu_uncore->lock);
> +}

As above, I still don't believe that these locks are necessary, unless
we have a bug elsewhere.

[...]

> +/*
> + * DMC and L3 counter interface is muxed across all channels.
> + * hence we need to select the channel before accessing counter
> + * data/control registers.
> + *
> + *  L3 Tile and DMC channel selection is through SMC call
> + *  SMC call arguments,
> + *	x0 = THUNDERX2_SMC_CALL_ID	(Vendor SMC call Id)
> + *	x1 = THUNDERX2_SMC_SET_CHANNEL	(Id to set DMC/L3C channel)
> + *	x2 = Node id
> + *	x3 = DMC(1)/L3C(0)
> + *	x4 = channel Id
> + */

Please document which ID space the node id is in, e.g.

	x2 = FW Node ID (matching SRAT/SLIT IDs)

... so that it's clear that this isn't a Linux logical node id, even if
those happen to be the same today.

[...]

> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	unsigned long irqflags;
> +
> +	hwc->state = 0;
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	uncore_dev = pmu_uncore->uncore_dev;
> +
> +	raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
> +	uncore_dev->select_channel(event);
> +	uncore_dev->start_event(event, flags);
> +	raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> +	perf_event_update_userpage(event);
> +
> +	if (!find_last_bit(pmu_uncore->active_counters,
> +				pmu_uncore->uncore_dev->max_counters)) {

This would be clearer using !bitmap_empty().

> +		hrtimer_start(&pmu_uncore->hrtimer,
> +			ns_to_ktime(uncore_dev->hrtimer_interval),
> +			HRTIMER_MODE_REL_PINNED);
> +	}
> +}

[...]

> +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
> +		struct hrtimer *hrt)

s/hrt/timer/ please

> +{
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	unsigned long irqflags;
> +	int idx;
> +	bool restart_timer = false;
> +
> +	pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
> +			hrtimer);
> +
> +	raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
> +	for_each_set_bit(idx, pmu_uncore->active_counters,
> +			pmu_uncore->uncore_dev->max_counters) {
> +		struct perf_event *event = pmu_uncore->events[idx];
> +
> +		thunderx2_uncore_update(event);
> +		restart_timer = true;
> +	}
> +	raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
> +
> +	if (restart_timer)
> +		hrtimer_forward_now(hrt,
> +			ns_to_ktime(
> +				pmu_uncore->uncore_dev->hrtimer_interval));
> +
> +	return restart_timer ? HRTIMER_RESTART : HRTIMER_NORESTART;
> +}

You don't need to take the lock at all if there are no active events,
and we can avoid all the conditional logic that way. e.g. assuming the
renames I requested above:

static enum hrtimer_restart tx2_hrtimer_callback(struct hrtimer *timer)

{
	struct tx2_pmu *pmu;
	struct tx2_pmu_group *pmu_group;
	unsigned long irqflags;
	int max_counters;
	int idx;

	pmu = container_of(timer, struct tx2_pmu, hrtimer);
	pmu_group = pmu->pmu_group;
	max_counters = pmu_group->max_counters;

	if (cpumask_empty(pmu->active_counters, max_counters))
		return HRTIMER_NORESTART;

	raw_spin_lock_irqsave(&pmu_group->lock, irqflags);
	for_each_set_bit(idx, pmu->active_counters, max_counters) {
		struct perf_event *event = pmu->events[idx];

		tx2_uncore_update(event);
		restart_timer = true;
	}
	raw_spin_unlock_irqrestore(&pmu_group->lock, irqflags);

	hrtimer_forward_now(hrt, ns_to_ktime(pmu_group->hrtimer_interval));

	return HRTIMER_RESTART;
}

[...]

> +	switch (uncore_dev->type) {
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

We should probably s/uncore/tx2/, or s/uncore/thunderx2/ to namespace
this.

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

We'll also need a onlining callback. Consider if all CPUs in a NUMA node
were offlined, then we tried to online an arbitrary CPU from that node.

Thanks,
Mark.
