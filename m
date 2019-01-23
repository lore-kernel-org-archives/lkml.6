Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A121C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8D720861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfAWMOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:14:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfAWMOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:14:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7706AEBD;
        Wed, 23 Jan 2019 04:14:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828F23F5C1;
        Wed, 23 Jan 2019 04:14:08 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:14:06 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
Message-ID: <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-3-shameerali.kolothum.thodi@huawei.com>
 <20190122162351.GE8120@e119886-lin.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:02:48AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Andrew,
> 
> Thanks for taking a look at this.
> 
> > > From: Neil Leeder <nleeder@codeaurora.org>
> > >
> > > Adds a new driver to support the SMMUv3 PMU and add it into the
> > > perf events framework.
> > >
> > > Each SMMU node may have multiple PMUs associated with it, each of
> > > which may support different events.
> > >
> > > SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page>
> > where
> > > <phys_addr_page> is the physical page address of the SMMU PMCG
> > > wrapped to 4K boundary. For example, the PMCG at 0xff88840000 is
> > > named smmuv3_pmcg_ff88840
> > >
> > > Filtering by stream id is done by specifying filtering parameters
> > > with the event. options are:
> > >    filter_enable    - 0 = no filtering, 1 = filtering enabled
> > >    filter_span      - 0 = exact match, 1 = pattern match
> > >    filter_stream_id - pattern to filter against
> > >
> > > Example: perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
> > >                        filter_span=1,filter_stream_id=0x42/ -a netperf
> > >
> > > Applies filter pattern 0x42 to transaction events, which means events
> > > matching stream ids 0x42 & 0x43 are counted as only upper StreamID
> > > bits are required to match the given filter. Further filtering
> > > information is available in the SMMU documentation.
> > >
> > > SMMU events are not attributable to a CPU, so task mode and sampling
> > > are not supported.
> > >
> > > Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  drivers/perf/Kconfig          |   9 +
> > >  drivers/perf/Makefile         |   1 +
> > >  drivers/perf/arm_smmuv3_pmu.c | 778
> > ++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 788 insertions(+)
> > >  create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> > >

> > > +
> > > +static inline void smmu_pmu_enable(struct pmu *pmu)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
> > > +
> > > +	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base +
> > SMMU_PMCG_CR);
> > > +	writel(SMMU_PMCG_IRQ_CTRL_IRQEN,
> > > +	       smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
> > 
> > Should the interrupts be enabled before enabling the PMU?
> 
> Yes, it make sense to do so.
> 
> > > +}
> > > +
> > > +static inline void smmu_pmu_disable(struct pmu *pmu)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
> > > +
> > > +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_CR);
> > > +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
> > > +}
> > > +
> > > +static inline void smmu_pmu_counter_set_value(struct smmu_pmu
> > *smmu_pmu,
> > > +					      u32 idx, u64 value)
> > > +{
> > > +	if (smmu_pmu->counter_mask & BIT(32))
> > > +		writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
> > 8));
> > > +	else
> > > +		writel(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
> > 4));
> > 
> > The arm64 IO macros use __force u32 and so it's probably OK to provide a 64
> > bit
> > value to writel. But you could use something like lower_32_bits for clarity.
> 
> Yes, macro uses __force u32. I will change it to make it more clear though.
> 

> > > +
> > > +/*
> > > + * Implementation of abstract pmu functionality required by
> > > + * the core perf events code.
> > > + */
> > > +
> > > +static int smmu_pmu_event_init(struct perf_event *event)
> > > +{
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> > > +	struct device *dev = smmu_pmu->dev;
> > > +	struct perf_event *sibling;
> > > +	u32 event_id;
> > > +
> > > +	if (event->attr.type != event->pmu->type)
> > > +		return -ENOENT;
> > > +
> > > +	if (hwc->sample_period) {
> > > +		dev_dbg(dev, "Sampling not supported\n");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	if (event->cpu < 0) {
> > > +		dev_dbg(dev, "Per-task mode not supported\n");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	/* We cannot filter accurately so we just don't allow it. */
> > > +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> > > +	    event->attr.exclude_hv || event->attr.exclude_idle) {
> > > +		dev_dbg(dev, "Can't exclude execution levels\n");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > 
> > You should also test for attr.exclude_host and attr.exclude_guest, unless
> > it makes sense to stop counting these events when entering guest/host?
> 
> TBH, I haven't considered that scenario yet and don't think we have to stop the 
> counters. I will check that.

I would suggest returning an error if the exclude_guest / exclude_host flags
are set then - this is quite common across PMU drivers.

> 
> > 
> > Also returning -EINVAL may be more desirable than -EOPNOTSUPP. If a user
> > makes use of the perf utility and attempts to filter one of the above
> > exclusion flags - then perf will retry opening the event but without some
> > of the unsupported flags, but it will only do this if you return -EINVAL.
> > 
> > (See line 1927 of tools/perf/util/evsel.c and run the perf stat tool with
> > the verbose flag to see this in action.)
> 
> Ok. I will take a look.
> 

> > > +
> > > +static void smmu_pmu_event_start(struct perf_event *event, int flags)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	int idx = hwc->idx;
> > > +	u32 filter_span, filter_sid;
> > > +	u32 evtyper;
> > > +
> > > +	hwc->state = 0;
> > > +
> > > +	smmu_pmu_set_period(smmu_pmu, hwc);
> > > +
> > > +	smmu_pmu_get_event_filter(event, &filter_span, &filter_sid);
> > > +
> > > +	evtyper = get_event(event) |
> > > +		  filter_span << SMMU_PMCG_SID_SPAN_SHIFT;
> > > +
> > > +	smmu_pmu_set_evtyper(smmu_pmu, idx, evtyper);
> > > +	smmu_pmu_set_smr(smmu_pmu, idx, filter_sid);
> > > +	smmu_pmu_interrupt_enable(smmu_pmu, idx);
> > > +	smmu_pmu_counter_enable(smmu_pmu, idx);
> > > +}
> > > +
> > > +static void smmu_pmu_event_stop(struct perf_event *event, int flags)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	int idx = hwc->idx;
> > > +
> > > +	if (hwc->state & PERF_HES_STOPPED)
> > > +		return;
> > > +
> > > +	smmu_pmu_counter_disable(smmu_pmu, idx);
> > 
> > Is it intentional not to call smmu_pmu_interrupt_disable here?
> 
> Yes, it is. Earlier patch had the interrupt toggling and Robin pointed out that
> it is not really needed as counters are anyway stopped and explicitly disabling
> may not solve the spurious interrupt case as well.
> 

Ah apologies for not seeing that in earlier reviews.

> > > +
> > > +	if (flags & PERF_EF_UPDATE)
> > > +		smmu_pmu_event_update(event);
> > > +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > 
> > Shouldn't we only set PERF_HES_UPTODATE if we've updated the count (e.g.
> > when PERF_EF_UPDATE was set?)
> 
> Hmm..I had a look at couple of other drivers(arm-cci.c/arm_dsu_pmu.c etc) and those 
> ones always call update ignoring PERF_EF_UPDATE and sets PERF_HES_UPTODATE. I
> think the reason being the counter is always reprogrammed on start. Do you think
> changing to that logic is a better way?

If I recall correctly it was not possible to stop some counters on earlier
ARM PMUs, as a result when _stop is called it calls _update (otherwise
you lose the value as the counter continues counting). I wonder if other
PMUs have copied this pattern despite not having that limitation?

As you write the counter value in your _start then I guess you probably
should call _update in your _stop.  Perhaps you can add a comment to explain.

> 
> > This may be a nit, but shouldn't smmu_pmu_event_update come before the
> > test for PERF_HES_STOPPED? I guess in the odd case where stop is called
> > without the PERF_EF_UPDATE flag (to stop the counter) and then called
> > a second time with PERF_EF_UPDATE to update the count.
> 
> Not sure such a scenario exists. I think most of the ones I checked has the logic -its
> already stopped, nothing to do. 
> 
> > > +}
> > > +
> > > +static int smmu_pmu_event_add(struct perf_event *event, int flags)
> > > +{
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	int idx;
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> > > +
> > > +	idx = smmu_pmu_get_event_idx(smmu_pmu, event);
> > > +	if (idx < 0)
> > > +		return idx;
> > > +
> > > +	hwc->idx = idx;
> > > +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > > +	smmu_pmu->events[idx] = event;
> > > +	local64_set(&hwc->prev_count, 0);
> > > +
> > > +	if (flags & PERF_EF_START)
> > > +		smmu_pmu_event_start(event, flags);
> > > +
> > > +	/* Propagate changes to the userspace mapping. */
> > > +	perf_event_update_userpage(event);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void smmu_pmu_event_del(struct perf_event *event, int flags)
> > > +{
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> > > +	int idx = hwc->idx;
> > > +
> > > +	smmu_pmu_event_stop(event, flags | PERF_EF_UPDATE);
> > > +	smmu_pmu->events[idx] = NULL;
> > > +	clear_bit(idx, smmu_pmu->used_counters);
> > > +
> > > +	perf_event_update_userpage(event);
> > > +}
> > > +
> > > +static void smmu_pmu_event_read(struct perf_event *event)
> > > +{
> > > +	smmu_pmu_event_update(event);
> > > +}
> > > +
> > > +/* cpumask */
> > > +
> > > +static ssize_t smmu_pmu_cpumask_show(struct device *dev,
> > > +				     struct device_attribute *attr,
> > > +				     char *buf)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
> > > +
> > > +	return cpumap_print_to_pagebuf(true, buf,
> > cpumask_of(smmu_pmu->on_cpu));
> > > +}
> > > +
> > > +static struct device_attribute smmu_pmu_cpumask_attr =
> > > +		__ATTR(cpumask, 0444, smmu_pmu_cpumask_show, NULL);
> > > +
> > > +static struct attribute *smmu_pmu_cpumask_attrs[] = {
> > > +	&smmu_pmu_cpumask_attr.attr,
> > > +	NULL
> > > +};
> > > +
> > > +static struct attribute_group smmu_pmu_cpumask_group = {
> > > +	.attrs = smmu_pmu_cpumask_attrs,
> > > +};
> > > +
> > > +/* Events */
> > > +
> > > +ssize_t smmu_pmu_event_show(struct device *dev,
> > > +			    struct device_attribute *attr, char *page)
> > > +{
> > > +	struct perf_pmu_events_attr *pmu_attr;
> > > +
> > > +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> > > +
> > > +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> > > +}
> > > +
> > > +#define SMMU_EVENT_ATTR(_name, _id)					  \
> > > +	(&((struct perf_pmu_events_attr[]) {				  \
> > > +		{ .attr = __ATTR(_name, 0444, smmu_pmu_event_show, NULL), \
> > > +		  .id = _id, }						  \
> > > +	})[0].attr.attr)
> > 
> > This is very similar to PMU_EVENT_ATTR, have you considered taking an
> > approach
> > similar to the ARMV8_EVENT_ATTR macro that wraps up PMU_EVENT_ATTR.
> > It may
> > be more readable if we define these attributes consistently across PMUs.
> 
> Ok. I will take a look at that.

Thanks,

Andrew Murray

> 
> Thanks,
> Shameer
> 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > +
> > > +static struct attribute *smmu_pmu_events[] = {
> > > +	SMMU_EVENT_ATTR(cycles, 0),
> > > +	SMMU_EVENT_ATTR(transaction, 1),
> > > +	SMMU_EVENT_ATTR(tlb_miss, 2),
> > > +	SMMU_EVENT_ATTR(config_cache_miss, 3),
> > > +	SMMU_EVENT_ATTR(trans_table_walk_access, 4),
> > > +	SMMU_EVENT_ATTR(config_struct_access, 5),
> > > +	SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6),
> > > +	SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7),
> > > +	NULL
> > > +};
> > > +
> > > +static umode_t smmu_pmu_event_is_visible(struct kobject *kobj,
> > > +					 struct attribute *attr, int unused)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
> > > +	struct perf_pmu_events_attr *pmu_attr;
> > > +
> > > +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
> > > +
> > > +	if (test_bit(pmu_attr->id, smmu_pmu->supported_events))
> > > +		return attr->mode;
> > > +
> > > +	return 0;
> > > +}
> > > +static struct attribute_group smmu_pmu_events_group = {
> > > +	.name = "events",
> > > +	.attrs = smmu_pmu_events,
> > > +	.is_visible = smmu_pmu_event_is_visible,
> > > +};
> > > +
> > > +/* Formats */
> > > +PMU_FORMAT_ATTR(event,		   "config:0-15");
> > > +PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
> > > +PMU_FORMAT_ATTR(filter_span,	   "config1:32");
> > > +PMU_FORMAT_ATTR(filter_enable,	   "config1:33");
> > > +
> > > +static struct attribute *smmu_pmu_formats[] = {
> > > +	&format_attr_event.attr,
> > > +	&format_attr_filter_stream_id.attr,
> > > +	&format_attr_filter_span.attr,
> > > +	&format_attr_filter_enable.attr,
> > > +	NULL
> > > +};
> > > +
> > > +static struct attribute_group smmu_pmu_format_group = {
> > > +	.name = "format",
> > > +	.attrs = smmu_pmu_formats,
> > > +};
> > > +
> > > +static const struct attribute_group *smmu_pmu_attr_grps[] = {
> > > +	&smmu_pmu_cpumask_group,
> > > +	&smmu_pmu_events_group,
> > > +	&smmu_pmu_format_group,
> > > +	NULL
> > > +};
> > > +
> > > +/*
> > > + * Generic device handlers
> > > + */
> > > +
> > > +static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu;
> > > +	unsigned int target;
> > > +
> > > +	smmu_pmu = hlist_entry_safe(node, struct smmu_pmu, node);
> > > +	if (cpu != smmu_pmu->on_cpu)
> > > +		return 0;
> > > +
> > > +	target = cpumask_any_but(cpu_online_mask, cpu);
> > > +	if (target >= nr_cpu_ids)
> > > +		return 0;
> > > +
> > > +	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> > > +	smmu_pmu->on_cpu = target;
> > > +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = data;
> > > +	u64 ovsr;
> > > +	unsigned int idx;
> > > +
> > > +	ovsr = readq(smmu_pmu->reloc_base + SMMU_PMCG_OVSSET0);
> > > +	if (!ovsr)
> > > +		return IRQ_NONE;
> > > +
> > > +	writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
> > > +
> > > +	for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters)
> > {
> > > +		struct perf_event *event = smmu_pmu->events[idx];
> > > +		struct hw_perf_event *hwc;
> > > +
> > > +		if (WARN_ON_ONCE(!event))
> > > +			continue;
> > > +
> > > +		smmu_pmu_event_update(event);
> > > +		hwc = &event->hw;
> > > +
> > > +		smmu_pmu_set_period(smmu_pmu, hwc);
> > > +	}
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
> > > +{
> > > +	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED |
> > IRQF_NO_THREAD;
> > > +	int irq, ret = -ENXIO;
> > > +
> > > +	irq = pmu->irq;
> > > +	if (irq)
> > > +		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
> > > +				       flags, "smmuv3-pmu", pmu);
> > > +	return ret;
> > > +}
> > > +
> > > +static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
> > > +{
> > > +	smmu_pmu_disable(&smmu_pmu->pmu);
> > > +
> > > +	/* Disable counter and interrupt */
> > > +	writeq_relaxed(smmu_pmu->counter_present_mask,
> > > +		       smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
> > > +	writeq_relaxed(smmu_pmu->counter_present_mask,
> > > +		       smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);
> > > +	writeq_relaxed(smmu_pmu->counter_present_mask,
> > > +		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
> > > +}
> > > +
> > > +static int smmu_pmu_probe(struct platform_device *pdev)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu;
> > > +	struct resource *res_0, *res_1;
> > > +	u32 cfgr, reg_size;
> > > +	u64 ceid_64[2];
> > > +	int irq, err;
> > > +	char *name;
> > > +	struct device *dev = &pdev->dev;
> > > +
> > > +	smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu), GFP_KERNEL);
> > > +	if (!smmu_pmu)
> > > +		return -ENOMEM;
> > > +
> > > +	smmu_pmu->dev = dev;
> > > +	platform_set_drvdata(pdev, smmu_pmu);
> > > +
> > > +	smmu_pmu->pmu = (struct pmu) {
> > > +		.task_ctx_nr    = perf_invalid_context,
> > > +		.pmu_enable	= smmu_pmu_enable,
> > > +		.pmu_disable	= smmu_pmu_disable,
> > > +		.event_init	= smmu_pmu_event_init,
> > > +		.add		= smmu_pmu_event_add,
> > > +		.del		= smmu_pmu_event_del,
> > > +		.start		= smmu_pmu_event_start,
> > > +		.stop		= smmu_pmu_event_stop,
> > > +		.read		= smmu_pmu_event_read,
> > > +		.attr_groups	= smmu_pmu_attr_grps,
> > > +	};
> > > +
> > > +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
> > > +	if (IS_ERR(smmu_pmu->reg_base))
> > > +		return PTR_ERR(smmu_pmu->reg_base);
> > > +
> > > +	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
> > > +
> > > +	/* Determine if page 1 is present */
> > > +	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> > > +		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +		smmu_pmu->reloc_base = devm_ioremap_resource(dev, res_1);
> > > +		if (IS_ERR(smmu_pmu->reloc_base))
> > > +			return PTR_ERR(smmu_pmu->reloc_base);
> > > +	} else {
> > > +		smmu_pmu->reloc_base = smmu_pmu->reg_base;
> > > +	}
> > > +
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq > 0)
> > > +		smmu_pmu->irq = irq;
> > > +
> > > +	ceid_64[0] = readq_relaxed(smmu_pmu->reg_base +
> > SMMU_PMCG_CEID0);
> > > +	ceid_64[1] = readq_relaxed(smmu_pmu->reg_base +
> > SMMU_PMCG_CEID1);
> > > +	bitmap_from_arr32(smmu_pmu->supported_events, (u32 *)ceid_64,
> > > +			  SMMU_ARCH_MAX_EVENTS);
> > > +
> > > +	smmu_pmu->num_counters =
> > FIELD_GET(SMMU_PMCG_CFGR_NCTR_MASK, cfgr) + 1;
> > > +	smmu_pmu->counter_present_mask =
> > GENMASK(smmu_pmu->num_counters - 1, 0);
> > > +
> > > +	smmu_pmu->sid_filter_global = !!(cfgr &
> > SMMU_PMCG_CFGR_SID_FILTER_TYPE);
> > > +
> > > +	reg_size = FIELD_GET(SMMU_PMCG_CFGR_SIZE_MASK, cfgr);
> > > +	smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
> > > +
> > > +	smmu_pmu_reset(smmu_pmu);
> > > +
> > > +	err = smmu_pmu_setup_irq(smmu_pmu);
> > > +	if (err) {
> > > +		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
> > > +		return err;
> > > +	}
> > > +
> > > +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > "smmuv3_pmcg_%llx",
> > > +			      (res_0->start) >> SMMU_PA_SHIFT);
> > > +	if (!name) {
> > > +		dev_err(dev, "Create name failed, PMU @%pa\n", &res_0->start);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Pick one CPU to be the preferred one to use */
> > > +	smmu_pmu->on_cpu = get_cpu();
> > > +	WARN_ON(irq_set_affinity(smmu_pmu->irq,
> > cpumask_of(smmu_pmu->on_cpu)));
> > > +
> > > +	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> > > +					       &smmu_pmu->node);
> > > +	if (err) {
> > > +		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> > > +			err, &res_0->start);
> > > +		goto out_cpuhp_err;
> > > +	}
> > > +
> > > +	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> > > +	if (err) {
> > > +		dev_err(dev, "Error %d registering PMU @%pa\n",
> > > +			err, &res_0->start);
> > > +		goto out_unregister;
> > > +	}
> > > +
> > > +	put_cpu();
> > > +	dev_info(dev, "Registered PMU @ %pa using %d counters with %s filter
> > settings\n",
> > > +		 &res_0->start, smmu_pmu->num_counters,
> > > +		 smmu_pmu->sid_filter_global ? "Global(Counter0)" :
> > > +		 "Individual");
> > > +
> > > +	return 0;
> > > +
> > > +out_unregister:
> > > +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
> > &smmu_pmu->node);
> > > +out_cpuhp_err:
> > > +	put_cpu();
> > > +	return err;
> > > +}
> > > +
> > > +static int smmu_pmu_remove(struct platform_device *pdev)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = platform_get_drvdata(pdev);
> > > +
> > > +	perf_pmu_unregister(&smmu_pmu->pmu);
> > > +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
> > &smmu_pmu->node);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void smmu_pmu_shutdown(struct platform_device *pdev)
> > > +{
> > > +	struct smmu_pmu *smmu_pmu = platform_get_drvdata(pdev);
> > > +
> > > +	smmu_pmu_disable(&smmu_pmu->pmu);
> > > +}
> > > +
> > > +static struct platform_driver smmu_pmu_driver = {
> > > +	.driver = {
> > > +		.name = "arm-smmu-v3-pmu",
> > > +	},
> > > +	.probe = smmu_pmu_probe,
> > > +	.remove = smmu_pmu_remove,
> > > +	.shutdown = smmu_pmu_shutdown,
> > > +};
> > > +
> > > +static int __init arm_smmu_pmu_init(void)
> > > +{
> > > +	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > > +				      "perf/arm/pmcg:online",
> > > +				      NULL,
> > > +				      smmu_pmu_offline_cpu);
> > > +	if (cpuhp_state_num < 0)
> > > +		return cpuhp_state_num;
> > > +
> > > +	return platform_driver_register(&smmu_pmu_driver);
> > > +}
> > > +module_init(arm_smmu_pmu_init);
> > > +
> > > +static void __exit arm_smmu_pmu_exit(void)
> > > +{
> > > +	platform_driver_unregister(&smmu_pmu_driver);
> > > +	cpuhp_remove_multi_state(cpuhp_state_num);
> > > +}
> > > +
> > > +module_exit(arm_smmu_pmu_exit);
> > > +
> > > +MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance
> > Monitors Extension");
> > > +MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
> > > +MODULE_AUTHOR("Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.7.4
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
