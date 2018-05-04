Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEDSqS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:46:18 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:45612 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeEDSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:46:15 -0400
X-Google-Smtp-Source: AB8JxZqZEOo1HfqBp42t0DPN25Zg+YUmapqBJgssZiZXAnT4ec6csjJQO01pej/gU5bckS3QWzixbbcvy7PeLqzllmk=
MIME-Version: 1.0
In-Reply-To: <20180426105938.y6unpt36lisb7kbr@lakrids.cambridge.arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com> <20180426105938.y6unpt36lisb7kbr@lakrids.cambridge.arm.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Sat, 5 May 2018 00:16:13 +0530
Message-ID: <CAKTKpr7Q7T9ZCTBi=LQR=XaAoihbBA3OKCO7yFobzNmR8EfyjQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Apr 26, 2018 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Apr 25, 2018 at 02:30:47PM +0530, Ganapatrao Kulkarni wrote:
>> +
>> +/* L3c and DMC has 16 and 8 channels per socket respectively.
>> + * Each Channel supports UNCORE PMU device and consists of
>> + * 4 independent programmable counters. Counters are 32 bit
>> + * and does not support overflow interrupt, they needs to be
>> + * sampled before overflow(i.e, at every 2 seconds).
>> + */
>> +
>> +#define UNCORE_MAX_COUNTERS          4
>> +#define UNCORE_L3_MAX_TILES          16
>> +#define UNCORE_DMC_MAX_CHANNELS              8
>> +
>> +#define UNCORE_HRTIMER_INTERVAL              (2 * NSEC_PER_SEC)
>
> How was a period of two seconds chosen?

It has been suggested from hw team  to sample before  3 to 4 seconds.

>
> What's the maximum clock speed for the L3C and DMC?

L3C at 1.5GHz and DMC at 1.2GHz
>
> Given that all channels compete for access to the muxed register
> interface, I suspect we need to try more often than once every 2
> seconds...

2 seconds seems to be sufficient. So far testing looks good.

>
> [...]
>
>> +struct active_timer {
>> +     struct perf_event *event;
>> +     struct hrtimer hrtimer;
>> +};
>> +
>> +/*
>> + * pmu on each socket has 2 uncore devices(dmc and l3),
>> + * each uncore device has up to 16 channels, each channel can sample
>> + * events independently with counters up to 4.
>> + *
>> + * struct thunderx2_pmu_uncore_channel created per channel.
>> + * struct thunderx2_pmu_uncore_dev per uncore device.
>> + */
>> +struct thunderx2_pmu_uncore_channel {
>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>> +     struct pmu pmu;
>
> Can we put the pmu first in the struct, please?

ok
>
>> +     int counter;
>
> AFAICT, this counter field is never used.

hmm ok, will remove.
>
>> +     int channel;
>> +     DECLARE_BITMAP(counter_mask, UNCORE_MAX_COUNTERS);
>> +     struct active_timer *active_timers;
>
> You should only need a single timer per channel, rather than one per
> event.
>
> I think you can get rid of the active_timer structure, and have:
>
>         struct perf_event *events[UNCORE_MAX_COUNTERS];
>         struct hrtimer timer;
>

thanks, will change as suggested.

>> +     /* to sync counter alloc/release */
>> +     raw_spinlock_t lock;
>> +};
>> +
>> +struct thunderx2_pmu_uncore_dev {
>> +     char *name;
>> +     struct device *dev;
>> +     enum thunderx2_uncore_type type;
>> +     unsigned long base;
>
> This should be:
>
> void __iomem *base;

ok
>
> [...]
>
>> +static ssize_t cpumask_show(struct device *dev,
>> +                             struct device_attribute *attr, char *buf)
>> +{
>> +     struct cpumask cpu_mask;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
>> +             pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
>> +
>> +     /* Pick first online cpu from the node */
>> +     cpumask_clear(&cpu_mask);
>> +     cpumask_set_cpu(cpumask_first(
>> +                     cpumask_of_node(pmu_uncore->uncore_dev->node)),
>> +                     &cpu_mask);
>> +
>> +     return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
>> +}
>
> AFAICT cpumask_of_node() returns a mask that can include offline CPUs.
>
> Regardless, I don't think that you can keep track of the management CPU
> this way. Please keep track of the CPU the PMU should be managed by,
> either with a cpumask or int embedded within the PMU structure.

thanks, will add hotplug callbacks.
>
> At hotplug time, you'll need to update the management CPU, calling
> perf_pmu_migrate_context() when it is offlined.

ok
>
> [...]
>
>> +static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
>> +{
>> +     int counter;
>> +
>> +     raw_spin_lock(&pmu_uncore->lock);
>> +     counter = find_first_zero_bit(pmu_uncore->counter_mask,
>> +                             pmu_uncore->uncore_dev->max_counters);
>> +     if (counter == pmu_uncore->uncore_dev->max_counters) {
>> +             raw_spin_unlock(&pmu_uncore->lock);
>> +             return -ENOSPC;
>> +     }
>> +     set_bit(counter, pmu_uncore->counter_mask);
>> +     raw_spin_unlock(&pmu_uncore->lock);
>> +     return counter;
>> +}
>> +
>> +static void free_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore,
>> +                                     int counter)
>> +{
>> +     raw_spin_lock(&pmu_uncore->lock);
>> +     clear_bit(counter, pmu_uncore->counter_mask);
>> +     raw_spin_unlock(&pmu_uncore->lock);
>> +}
>
> I don't believe that locking is required in either of these, as the perf
> core serializes pmu::add() and pmu::del(), where these get called.

thanks, it seems to be not required.
>
>> +
>> +/*
>> + * DMC and L3 counter interface is muxed across all channels.
>> + * hence we need to select the channel before accessing counter
>> + * data/control registers.
>
> Are there separate interfaces for all-dmc-channels and all-l3c-channels?

separate interface for DMC and L3c.
channels within DMC/L3C are muxed.

>
> ... or is a single interface used by all-dmc-and-l3c-channels?
>
>> + *
>> + *  L3 Tile and DMC channel selection is through SMC call
>> + *  SMC call arguments,
>> + *   x0 = THUNDERX2_SMC_CALL_ID      (Vendor SMC call Id)
>> + *   x1 = THUNDERX2_SMC_SET_CHANNEL  (Id to set DMC/L3C channel)
>> + *   x2 = Node id
>
> How do we map Linux node IDs to the firmware's view of node IDs?
>
> I don't believe the two are necessarily the same -- Linux's node IDs are
> a Linux-specific construct.

both are same, it is numa node id from ACPI/firmware.

>
> It would be much nicer if we could pass something based on the MPIDR,
> which is a known HW construct, or if this implicitly affected the
> current node.

IMO,  node id is sufficient.

>
> It would be vastly more sane for this to not be muxed at all. :/

i am helpless due to crappy hw design!

>
>> + *   x3 = DMC(1)/L3C(0)
>> + *   x4 = channel Id
>> + */
>> +static void uncore_select_channel(struct perf_event *event)
>> +{
>> +     struct arm_smccc_res res;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
>> +             pmu_to_thunderx2_pmu_uncore(event->pmu);
>> +
>> +     arm_smccc_smc(THUNDERX2_SMC_CALL_ID, THUNDERX2_SMC_SET_CHANNEL,
>> +                     pmu_uncore->uncore_dev->node,
>> +                     pmu_uncore->uncore_dev->type,
>> +                     pmu_uncore->channel, 0, 0, 0, &res);
>> +
>> +}
>
> Why aren't we checking the return value of the SMC call?

thanks, i will add.

>
> The muxing and SMC sound quite scary. :/

i too agree!, however i have no other option since the muxing register
is a secure register.
>
>> +
>> +static void uncore_start_event_l3c(struct perf_event *event, int flags)
>> +{
>> +     u32 val;
>> +     struct hw_perf_event *hwc = &event->hw;
>> +
>> +     /* event id encoded in bits [07:03] */
>> +     val = GET_EVENTID(event) << 3;
>> +     reg_writel(val, hwc->config_base);
>> +
>> +     if (flags & PERF_EF_RELOAD) {
>> +             u64 prev_raw_count =
>> +                     local64_read(&event->hw.prev_count);
>> +             reg_writel(prev_raw_count, hwc->event_base);
>> +     }
>> +     local64_set(&event->hw.prev_count,
>> +                     reg_readl(hwc->event_base));
>
> It would be simpler to ignore PERF_EF_RELOAD, and always reprogram the
> prev_count and HW to zero.

ok, will change
>
>> +}
>> +
>> +static void uncore_start_event_dmc(struct perf_event *event, int flags)
>> +{
>> +     u32 val, event_shift = 8;
>> +     struct hw_perf_event *hwc = &event->hw;
>> +
>> +     /* enable and start counters and read current value in prev_count */
>> +     val = reg_readl(hwc->config_base);
>> +
>> +     /* 8 bits for each counter,
>> +      * bits [05:01] of a counter to set event type.
>> +      */
>> +     reg_writel((val & ~(0x1f << (((GET_COUNTERID(event)) *
>> +             event_shift) + 1))) |
>> +             (GET_EVENTID(event) <<
>> +              (((GET_COUNTERID(event)) * event_shift) + 1)),
>> +             hwc->config_base);
>
> This would be far more legible if val were constructed before the
> reg_writel(), especially if there were a helper for the event field
> shifting, e.g.
>
>         #define DMC_EVENT_CFG(idx, val) ((val) << (((idx) * 8) + 1))
>
>         int id = GET_COUNTERID(event);
>         int event = GET_EVENTID(event);
>
>         val = reg_readl(hwc->config_base);
>         val &= ~DMC_EVENT_CFG(id, 0x1f);
>         val |= DMCC_EVENT_CFG(id, event);
>         reg_writel(val, hwc->config_base));
>
> What are bits 7:6 and 1 used for?

not used/reserved bits.

>
>> +
>> +     if (flags & PERF_EF_RELOAD) {
>> +             u64 prev_raw_count =
>> +                     local64_read(&event->hw.prev_count);
>> +             reg_writel(prev_raw_count, hwc->event_base);
>> +     }
>> +     local64_set(&event->hw.prev_count,
>> +                     reg_readl(hwc->event_base));
>
>
> As with the L3C events, it would be simpler to always reprogram the
> prev_count and HW to zero.

ok
>
>> +}
>> +
>> +static void uncore_stop_event_l3c(struct perf_event *event)
>> +{
>> +     reg_writel(0, event->hw.config_base);
>> +}
>> +
>> +static void uncore_stop_event_dmc(struct perf_event *event)
>> +{
>> +     u32 val, event_shift = 8;
>> +     struct hw_perf_event *hwc = &event->hw;
>> +
>> +     val = reg_readl(hwc->config_base);
>> +     reg_writel((val & ~(0xff << ((GET_COUNTERID(event)) * event_shift))),
>> +                     hwc->config_base);
>
>
> This could be simplified with the helper proposed above.

ok
>
>> +}
>> +
>> +static void init_cntr_base_l3c(struct perf_event *event,
>> +             struct thunderx2_pmu_uncore_dev *uncore_dev)
>> +{
>> +
>> +     struct hw_perf_event *hwc = &event->hw;
>> +
>> +     /* counter ctrl/data reg offset at 8 */
>
> Offset 8, or stride 8?

stride 8
>
> What does the register layout look like?
>
>> +     hwc->config_base = uncore_dev->base
>> +             + L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
>> +     hwc->event_base =  uncore_dev->base
>> +             + L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
>> +}
>> +
>> +static void init_cntr_base_dmc(struct perf_event *event,
>> +             struct thunderx2_pmu_uncore_dev *uncore_dev)
>> +{
>> +
>> +     struct hw_perf_event *hwc = &event->hw;
>> +
>> +     hwc->config_base = uncore_dev->base
>> +             + DMC_COUNTER_CTL;
>> +     /* counter data reg offset at 0xc */
>
> A stride of 0xc seems unusual.
>
> What does the register layout look like?

the offsets are at 0x640, 0x64c, 0x658, 0x664,
>
>> +     hwc->event_base =  uncore_dev->base
>> +             + DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
>> +}
>> +
>> +static void thunderx2_uncore_update(struct perf_event *event)
>> +{
>> +     s64 prev, new = 0;
>> +     u64 delta;
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>> +     enum thunderx2_uncore_type type;
>> +
>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>> +     type = pmu_uncore->uncore_dev->type;
>
> AFAICT this variable is not used below.

thanks.
>
>> +
>> +     if (pmu_uncore->uncore_dev->select_channel)
>> +             pmu_uncore->uncore_dev->select_channel(event);
>
> This should always be non-NULL, right?

yes, unwanted check at the moment, will remove.

>
> [...]
>
>> +static bool thunderx2_uncore_validate_event_group(struct perf_event *event)
>> +{
>> +     struct pmu *pmu = event->pmu;
>> +     struct perf_event *leader = event->group_leader;
>> +     struct perf_event *sibling;
>> +     int counters = 0;
>> +
>> +     if (leader->pmu != event->pmu && !is_software_event(leader))
>> +             return false;
>> +
>> +     counters++;
>
> I don't think this is right when event != leader and the leader is a SW
> event. In that case, the leader doesn't take a HW counter.

I think this check to avoid the grouping of  multiple hw PMUs ,
however it is allowed to group sw events along with hw PMUs.

>
>> +
>> +     for_each_sibling_event(sibling, event->group_leader) {
>> +             if (is_software_event(sibling))
>> +                     continue;
>> +             if (sibling->pmu != pmu)
>> +                     return false;
>> +             counters++;
>> +     }
>> +
>> +     /*
>> +      * If the group requires more counters than the HW has,
>> +      * it cannot ever be scheduled.
>> +      */
>> +     return counters <= UNCORE_MAX_COUNTERS;
>> +}
>
> [...]
>
>> +static int thunderx2_uncore_event_init(struct perf_event *event)
>> +{
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>
>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>> +
>> +     if (!pmu_uncore)
>> +             return -ENODEV;
>
> This cannot happen, given pmu_to_thunderx2_pmu_uncore() is a wrapper
> around container_of().

thanks, unnecessary check!
>
>> +
>> +     /* Pick first online cpu from the node */
>> +     event->cpu = cpumask_first(
>> +                     cpumask_of_node(pmu_uncore->uncore_dev->node));
>
> I don't believe this is safe. You must keep track of which CPU is
> managing the PMU, with hotplug callbacks.

ok, will add callbacks.
>
> [...]
>
>> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
>> +{
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>> +     unsigned long irqflags;
>> +     struct active_timer *active_timer;
>> +
>> +     hwc->state = 0;
>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>> +     uncore_dev = pmu_uncore->uncore_dev;
>> +
>> +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
>> +
>> +     if (uncore_dev->select_channel)
>> +             uncore_dev->select_channel(event);
>> +     uncore_dev->start_event(event, flags);
>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
>> +
>> +     perf_event_update_userpage(event);
>> +     active_timer = &pmu_uncore->active_timers[GET_COUNTERID(event)];
>> +     active_timer->event = event;
>> +
>> +     hrtimer_start(&active_timer->hrtimer,
>> +                     ns_to_ktime(uncore_dev->hrtimer_interval),
>> +                     HRTIMER_MODE_REL_PINNED);
>> +}
>
> Please use a single hrtimer, and update *all* of the events when it
> fires.

sure
>
> I *think* that can be done in the pmu::pmu_enable() and
> pmu::pmu_disable() callbacks.

ok
>
> Are there control bits to enable/disable all counters, or can that only
> be done through the event configuration registers?

only through config register.
>
>> +static void thunderx2_uncore_stop(struct perf_event *event, int flags)
>> +{
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>> +     unsigned long irqflags;
>> +
>> +     if (hwc->state & PERF_HES_UPTODATE)
>> +             return;
>> +
>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>> +     uncore_dev = pmu_uncore->uncore_dev;
>> +
>> +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
>> +
>> +     if (uncore_dev->select_channel)
>> +             uncore_dev->select_channel(event);
>
> AFAICT this cannot be NULL.

ok.
>
> [...]
>
>> +static int thunderx2_pmu_uncore_register(
>> +             struct thunderx2_pmu_uncore_channel *pmu_uncore)
>> +{
>> +     struct device *dev = pmu_uncore->uncore_dev->dev;
>> +     char *name = pmu_uncore->uncore_dev->name;
>> +     int channel = pmu_uncore->channel;
>> +
>> +     /* Perf event registration */
>> +     pmu_uncore->pmu = (struct pmu) {
>> +             .attr_groups    = pmu_uncore->uncore_dev->attr_groups,
>> +             .task_ctx_nr    = perf_invalid_context,
>> +             .event_init     = thunderx2_uncore_event_init,
>> +             .add            = thunderx2_uncore_add,
>> +             .del            = thunderx2_uncore_del,
>> +             .start          = thunderx2_uncore_start,
>> +             .stop           = thunderx2_uncore_stop,
>> +             .read           = thunderx2_uncore_read,
>> +     };
>> +
>> +     pmu_uncore->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
>> +                     "%s_%d", name, channel);
>
> Does the channel idx take the NUMA node into account?

name already has node id suffix.
>
> [...]
>
>> +static int thunderx2_pmu_uncore_add(struct thunderx2_pmu_uncore_dev *uncore_dev,
>> +             int channel)
>> +{
>
>> +     /* we can run up to (max_counters * max_channels) events
>> +      * simultaneously, allocate hrtimers per channel.
>> +      */
>> +     pmu_uncore->active_timers = devm_kzalloc(uncore_dev->dev,
>> +                     sizeof(struct active_timer) * uncore_dev->max_counters,
>> +                     GFP_KERNEL);
>
> Please just fold a single hrtimer into the thunderx2_pmu_uncore_channel
> structure, and you can get rid of this allocation...

sure, i will rewrite code to have timer per channel and all active
counters are updated when timer fires.

>
>> +
>> +     for (counter = 0; counter < uncore_dev->max_counters; counter++) {
>> +             hrtimer_init(&pmu_uncore->active_timers[counter].hrtimer,
>> +                             CLOCK_MONOTONIC,
>> +                             HRTIMER_MODE_REL);
>> +             pmu_uncore->active_timers[counter].hrtimer.function =
>> +                             thunderx2_uncore_hrtimer_callback;
>> +     }
>
> ... and simplify this initialization.

ok
>
> [...]
>
>> +static struct thunderx2_pmu_uncore_dev *init_pmu_uncore_dev(
>> +             struct device *dev, acpi_handle handle,
>> +             struct acpi_device *adev, u32 type)
>> +{
>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>> +     unsigned long base;
>
>> +     base = (unsigned long)devm_ioremap_resource(dev, &res);
>> +     if (IS_ERR((void *)base)) {
>> +             dev_err(dev, "PMU type %d: Fail to map resource\n", type);
>> +             return NULL;
>> +     }
>
> Please treat this as a void __iomem *base.

ok
>
> [...]
>
>> +static int thunderx2_uncore_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct arm_smccc_res res;
>> +
>> +     set_dev_node(dev, acpi_get_node(ACPI_HANDLE(dev)));
>> +
>> +     /* Make sure firmware supports DMC/L3C set channel smc call */
>> +     arm_smccc_smc(THUNDERX2_SMC_CALL_ID, THUNDERX2_SMC_SET_CHANNEL,
>> +                     dev_to_node(dev), 0, 0, 0, 0, 0, &res);
>> +     if (res.a0) {
>> +             dev_err(dev, "No Firmware support for PMU UNCORE(%d)\n",
>> +                             dev_to_node(dev));
>> +             return -ENODEV;
>> +     }
>
> Please re-use the uncore_select_channel() wrapper rather than
> open-coding this.

ok.
>
> Which FW supports this interface?

it is through vendor specific ATF runtime services.
>
> Thanks,
> Mark.

thanks,
Ganapat
