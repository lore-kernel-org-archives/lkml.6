Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2698CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D8020835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D8020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJKQjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:39:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34576 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJKQjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:39:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546FDED1;
        Thu, 11 Oct 2018 02:13:25 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85C223F5BC;
        Thu, 11 Oct 2018 02:13:23 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
 <c77e9601-71ca-ff09-f21d-b2493ca7c40b@arm.com>
 <CAKTKpr41udk9dGyLVZjO5pj_J7sf_sU_Td3t2R60UMxJatDDXA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3e9ab774-71db-d81d-5f0a-15fe942dfdb0@arm.com>
Date:   Thu, 11 Oct 2018 10:13:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKTKpr41udk9dGyLVZjO5pj_J7sf_sU_Td3t2R60UMxJatDDXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapatrao,

On 11/10/18 07:39, Ganapatrao Kulkarni wrote:
>>> +
>>> +/*
>>> + * We must NOT create groups containing events from multiple hardware PMUs,
>>> + * although mixing different software and hardware PMUs is allowed.
>>> + */
>>> +static bool thunderx2_uncore_validate_event_group(struct perf_event *event)
>>> +{
>>> +     struct pmu *pmu = event->pmu;
>>> +     struct perf_event *leader = event->group_leader;
>>> +     struct perf_event *sibling;
>>> +     int counters = 0;
>>> +
>>> +     if (leader->pmu != event->pmu && !is_software_event(leader))
>>> +             return false;
>>> +
>>> +     for_each_sibling_event(sibling, event->group_leader) {
>>> +             if (is_software_event(sibling))
>>> +                     continue;
>>> +             if (sibling->pmu != pmu)
>>> +                     return false;
>>> +             counters++;
>>> +     }
>>
>> The above loop will not account for :
>> 1) The leader event
>> 2) The event that we are about to add.
>>
>> So you need to allocate counters for both the above to make sure we can
>> accommodate the events.
> 
> Is leader also part of sibling list?

No.

>>> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
>>> +{
>>> +     struct hw_perf_event *hwc = &event->hw;
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>>> +     unsigned long irqflags;
>>> +
>>> +     hwc->state = 0;
>>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>>> +     uncore_dev = pmu_uncore->uncore_dev;
>>> +
>>> +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
>>> +     uncore_dev->select_channel(event);
>>> +     uncore_dev->start_event(event, flags);
>>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
>>> +
>>> +     perf_event_update_userpage(event);
>>> +
>>> +     if (!find_last_bit(pmu_uncore->active_counters,
>>> +                             pmu_uncore->uncore_dev->max_counters)) {
>>
>> Are we guaranteed that the counter0 is always allocated ? What if the
>> event is deleted and there are other events active ? A better check
>> would be :
>>          if (find_last_bit(...) != pmu_uncore->uncore_dev->max_counters)
>>
> IIUC, find_last_bit will return  zero if none of the counters are
> active and we want to start timer for first active counter.
> 

Well, if that was the case, how do you know if the bit zero is the only
bit set ?

AFAICS, lib/find_bit.c has :

unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
{
         if (size) {
                 unsigned long val = BITMAP_LAST_WORD_MASK(size);
                 unsigned long idx = (size-1) / BITS_PER_LONG;

                 do {
                         val &= addr[idx];
                         if (val)
                                 return idx * BITS_PER_LONG + __fls(val);

                         val = ~0ul;
                 } while (idx--);
         }
         return size;
}


It returns "size" when it can't find a set bit.


>>> +             thunderx2_uncore_update(event);
>>> +             hwc->state |= PERF_HES_UPTODATE;
>>> +     }
>>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
>>> +}
>>> +
>>> +static int thunderx2_uncore_add(struct perf_event *event, int flags)
>>> +{
>>> +     struct hw_perf_event *hwc = &event->hw;
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>>> +
>>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>>> +     uncore_dev = pmu_uncore->uncore_dev;
>>> +
>>> +     /* Allocate a free counter */
>>> +     hwc->idx  = alloc_counter(pmu_uncore);
>>> +     if (hwc->idx < 0)
>>> +             return -EAGAIN;
>>> +
>>> +     pmu_uncore->events[hwc->idx] = event;
>>> +     /* set counter control and data registers base address */
>>> +     uncore_dev->init_cntr_base(event, uncore_dev);
>>> +
>>> +     hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>>> +     if (flags & PERF_EF_START)
>>> +             thunderx2_uncore_start(event, flags);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void thunderx2_uncore_del(struct perf_event *event, int flags)
>>> +{
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
>>> +                     pmu_to_thunderx2_pmu_uncore(event->pmu);
>>> +     struct hw_perf_event *hwc = &event->hw;
>>> +
>>> +     thunderx2_uncore_stop(event, PERF_EF_UPDATE);
>>> +
>>> +     /* clear the assigned counter */
>>> +     free_counter(pmu_uncore, GET_COUNTERID(event));
>>> +
>>> +     perf_event_update_userpage(event);
>>> +     pmu_uncore->events[hwc->idx] = NULL;
>>> +     hwc->idx = -1;
>>> +}
>>> +
>>> +static void thunderx2_uncore_read(struct perf_event *event)
>>> +{
>>> +     unsigned long irqflags;
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
>>> +                     pmu_to_thunderx2_pmu_uncore(event->pmu);
>>> +
>>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
>>> +     thunderx2_uncore_update(event);
>>> +     raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
>>> +}
>>> +
>>> +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
>>> +             struct hrtimer *hrt)
>>> +{
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +     unsigned long irqflags;
>>> +     int idx;
>>> +     bool restart_timer = false;
>>> +
>>> +     pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
>>> +                     hrtimer);
>>> +
>>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
>>> +     for_each_set_bit(idx, pmu_uncore->active_counters,
>>> +                     pmu_uncore->uncore_dev->max_counters) {
>>> +             struct perf_event *event = pmu_uncore->events[idx];
>>
>> Do we need to check if the "event" is not NULL ? Couldn't this race with
>> an event_del() operation ?
> 
> i dont think so, i have not come across any such race condition during
> my testing.

Thinking about it further, we may not hit it, as the PMU is "disable"d,
before "add/del", which implies that the IRQ won't be triggered.

Btw, in general, not hitting a race condition doesn't prove there cannot
be a race ;)

>>> +static int thunderx2_pmu_uncore_register(
>>> +             struct thunderx2_pmu_uncore_channel *pmu_uncore)
>>> +{
>>> +     struct device *dev = pmu_uncore->uncore_dev->dev;
>>> +     char *name = pmu_uncore->uncore_dev->name;
>>> +     int channel = pmu_uncore->channel;
>>> +
>>> +     /* Perf event registration */
>>> +     pmu_uncore->pmu = (struct pmu) {
>>> +             .attr_groups    = pmu_uncore->uncore_dev->attr_groups,
>>> +             .task_ctx_nr    = perf_invalid_context,
>>> +             .event_init     = thunderx2_uncore_event_init,
>>> +             .add            = thunderx2_uncore_add,
>>> +             .del            = thunderx2_uncore_del,
>>> +             .start          = thunderx2_uncore_start,
>>> +             .stop           = thunderx2_uncore_stop,
>>> +             .read           = thunderx2_uncore_read,
>>
>> You must fill in the module field of the PMU to prevent this module from
>> being unloaded while it is in use.
> 
> thanks, i will add it.
>>
>>> +     };
>>> +
>>> +     pmu_uncore->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                     "%s_%d", name, channel);
>>> +
>>> +     return perf_pmu_register(&pmu_uncore->pmu, pmu_uncore->pmu.name, -1);
>>> +}
>>> +
>>> +static int thunderx2_pmu_uncore_add(struct thunderx2_pmu_uncore_dev *uncore_dev,
>>> +             int channel)
>>> +{
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +     int ret, cpu;
>>> +
>>> +     pmu_uncore = devm_kzalloc(uncore_dev->dev, sizeof(*pmu_uncore),
>>> +                     GFP_KERNEL);
>>> +     if (!pmu_uncore)
>>> +             return -ENOMEM;
>>> +
>>> +     cpu = cpumask_any_and(cpumask_of_node(uncore_dev->node),
>>> +                     cpu_online_mask);
>>> +     if (cpu >= nr_cpu_ids)
>>> +             return -EINVAL;
>>
>> Do we need to fail this here ? We could always add this back when a CPU
>> comes online (e.g, maxcpus=n). We do have cpu-hotplug call backs anyway.
> 
> we want to fail, since we dont have any cpu to serve.
> 

I understand that. We can bring up CPUs later from userspace. e.g, on a
system like ThunderX, to speed up the booting, one could add "maxcpus=8"
which forces the kernel to only bring up the first 8 CPUs and the rest
are brought up by the userspace. So, one of the DMC/L3 doesn't have a
supported CPU booted up during the driver probe, you will not bring
the PMU up and hence won't be able to use them even after the CPUs are
brought up later. You can take a look at the arm_dsu_pmu, where we
handle a similar situation via dsu_pmu_cpu_online().


>>> +static struct platform_driver thunderx2_uncore_driver = {
>>> +     .probe = thunderx2_uncore_probe,
>>> +     .driver = {
>>> +             .name           = "thunderx2-uncore-pmu",
>>> +             .acpi_match_table = ACPI_PTR(thunderx2_uncore_acpi_match),
>>> +     },
>>> +};
>>
>> Don't we need to unregister the pmu's when we remove the module ?
> 
> it is built in module at present, no unload is supported.
> Anyway i am adding in next version , since i am going for loadable module.

Ok


Suzuki
