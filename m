Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25191C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4295213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4295213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeJLAko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:40:44 -0400
Received: from foss.arm.com ([217.140.101.70]:41370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJLAko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:40:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B1D9EBD;
        Thu, 11 Oct 2018 10:12:36 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB31C3F5D3;
        Thu, 11 Oct 2018 10:12:34 -0700 (PDT)
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
 <3e9ab774-71db-d81d-5f0a-15fe942dfdb0@arm.com>
 <CAKTKpr5iFHVbfOq1d1E=bcwxK4=UdExXh=QyyyJ_zE4s_5bz=w@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <57165c0c-1a26-0886-0831-56baeb7cfa19@arm.com>
Date:   Thu, 11 Oct 2018 18:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKTKpr5iFHVbfOq1d1E=bcwxK4=UdExXh=QyyyJ_zE4s_5bz=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganpatrao,

On 11/10/18 17:06, Ganapatrao Kulkarni wrote:
> On Thu, Oct 11, 2018 at 2:43 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Ganapatrao,
>>
>> On 11/10/18 07:39, Ganapatrao Kulkarni wrote:
>>>>> +
>>>>> +/*
>>>>> + * We must NOT create groups containing events from multiple hardware PMUs,
>>>>> + * although mixing different software and hardware PMUs is allowed.
>>>>> + */
>>>>> +static bool thunderx2_uncore_validate_event_group(struct perf_event *event)
>>>>> +{
>>>>> +     struct pmu *pmu = event->pmu;
>>>>> +     struct perf_event *leader = event->group_leader;
>>>>> +     struct perf_event *sibling;
>>>>> +     int counters = 0;
>>>>> +
>>>>> +     if (leader->pmu != event->pmu && !is_software_event(leader))
>>>>> +             return false;
>>>>> +
>>>>> +     for_each_sibling_event(sibling, event->group_leader) {
>>>>> +             if (is_software_event(sibling))
>>>>> +                     continue;
>>>>> +             if (sibling->pmu != pmu)
>>>>> +                     return false;
>>>>> +             counters++;
>>>>> +     }
>>>>
>>>> The above loop will not account for :
>>>> 1) The leader event
>>>> 2) The event that we are about to add.
>>>>
>>>> So you need to allocate counters for both the above to make sure we can
>>>> accommodate the events.
>>>
>>> Is leader also part of sibling list?
>>
>> No.
> 
> not sure, what you are expecting here,


The purpose of the validate_group is to ensure if a group of events can
be scheduled together. That implies, if the new event is added to the
group, do we have enough counters to profile. So, you have :

1 (leader) + number-of-siblings-in-the-group + 1(this_new) events

But you only account for the number-of-siblings.

> this function is inline with other perf driver code added in driver/perf

No, it is not. arm-cci, arm-dsu-pmu, arm-pmu, all do separate accounting
for leader, siblings and the "new event".

>>>> Are we guaranteed that the counter0 is always allocated ? What if the
>>>> event is deleted and there are other events active ? A better check
> 
> timer will be active/restarted, till last bit is cleared( till last
> counter is released).

Ok, so you kick off the timer when you start the first active event,
which is assumed to be on the counter0 and the timeout handler would
restart the counters when at least one event is active, as you don't
have a PMU pmu_{enable/disable} call back. But I am still not convinced
that assuming the "first counter" is always 0. I would rather use:
bitmap_weight() == 1 check.

>>>> would be :
>>>>           if (find_last_bit(...) != pmu_uncore->uncore_dev->max_counters)
>>>>
>>> IIUC, find_last_bit will return  zero if none of the counters are
>>> active and we want to start timer for first active counter.
>>>
>>
>> Well, if that was the case, how do you know if the bit zero is the only
>> bit set ?
>>
>> AFAICS, lib/find_bit.c has :
>>
>> unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>> {
>>           if (size) {
>>                   unsigned long val = BITMAP_LAST_WORD_MASK(size);
>>                   unsigned long idx = (size-1) / BITS_PER_LONG;
>>
>>                   do {
>>                           val &= addr[idx];
>>                           if (val)
>>                                   return idx * BITS_PER_LONG + __fls(val);
>>
>>                           val = ~0ul;
>>                   } while (idx--);
>>           }
>>           return size;
>> }
>>
>>
>> It returns "size" when it can't find a set bit.
> 
> before start, alloc_counter is called to set, it seems we never hit
> case where at-least one bit is not set.
> timer will be started for first bit set and will continue till all
> bits are cleared.
>>
>>

>>>>> +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
>>>>> +             struct hrtimer *hrt)
>>>>> +{
>>>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>>>> +     unsigned long irqflags;
>>>>> +     int idx;
>>>>> +     bool restart_timer = false;
>>>>> +
>>>>> +     pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
>>>>> +                     hrtimer);
>>>>> +
>>>>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
>>>>> +     for_each_set_bit(idx, pmu_uncore->active_counters,
>>>>> +                     pmu_uncore->uncore_dev->max_counters) {
>>>>> +             struct perf_event *event = pmu_uncore->events[idx];
>>>>
>>>> Do we need to check if the "event" is not NULL ? Couldn't this race with
>>>> an event_del() operation ?
>>>
>>> i dont think so, i have not come across any such race condition during
>>> my testing.
>>
>> Thinking about it further, we may not hit it, as the PMU is "disable"d,
>> before "add/del", which implies that the IRQ won't be triggered.

Taking another look, since you don't have pmu_disable/enable callbacks,
the events could still be running. However, you are protected by the
free_counter() which holds the uncore_dev->lock to prevent the race.

>>
>> Btw, in general, not hitting a race condition doesn't prove there cannot
>> be a race ;)
> 
> want to avoid, unnecessary defensive programming.

Of course.

Suzuki
