Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KJdHEAWpGluOQwAAmS7hNA
	; Fri, 08 Jun 2018 16:05:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E19C5607E4; Fri,  8 Jun 2018 16:05:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 403C260590;
	Fri,  8 Jun 2018 16:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 403C260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFHQFO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:05:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeFHQFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:05:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F71F1435;
        Fri,  8 Jun 2018 09:05:12 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2343F5A0;
        Fri,  8 Jun 2018 09:05:11 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
 <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
 <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
 <20180608152419.kamu7ptmgsoah5m3@lakrids.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <38fbe2a8-26a3-84dc-bd88-de30af50e7c2@arm.com>
Date: Fri, 8 Jun 2018 17:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608152419.kamu7ptmgsoah5m3@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 16:24, Mark Rutland wrote:
> On Fri, Jun 08, 2018 at 03:46:57PM +0100, Suzuki K Poulose wrote:
>> On 06/06/2018 07:01 PM, Mark Rutland wrote:
>>>> Thus we need special allocation schemes
>>>> to make the full use of available counters. So, we allocate the
>>>> counters from either ends. i.e, chained counters are allocated
>>>> from the lower end in pairs of two and the normal counters are
>>>> allocated from the higher number. Also makes necessary changes to
>>>> handle the chained events as a single event with 2 counters.
>>>
>>> Why do we need to allocate in this way?
>>>
>>> I can see this might make allocating a pair of counters more likely in
>>> some cases, but there are still others where it wouldn't be possible
>>> (and we'd rely on the rotation logic to repack the counters for us).
>>
>> It makes the efficient use of the counters in all cases and allows
>> counting maximum number of events with any given set, keeping the precedence
>> on the order of their "inserts".
>> e.g, if the number of counters happened to be "odd" (not sure if it is even
>> possible).
> 
> Unfortunately, that doesn't always work.
> 
> Say you have a system with 8 counters, and you open 8 (32-bit) events.

I was talking about the following (imaginary) case :

We have 7 counters, and you have 5 32bit counters and 1 64bit counter.
Without the above scheme, you would place first 5 events on the first
5 counters and then you can't place the 64bit counter, as you are now
left with a low/odd counter and a high/even counter.

> 
> Then you close the events in counters 0, 2, 4, and 6. The live events
> aren't moved, and stay where they are, in counters 1, 3, 5, and 7.
> 
> Now, say you open a 64-bit event. When we try to add it, we try to
> allocate an index for two consecutive counters, and find that we can't,
> despite 4 counters being free.
> 
> We return -EAGAIN to the core perf code, whereupon it removes any other
> events in that group (none in this case).
> 
> Then we wait for the rotation logic to pull all of the events out and
> schedule them back in, re-packing them, which should (eventually) work
> regardless of how we allocate counters.
> 
> ... we might need to re-pack events to solve that. :/

I agree, removing and putting them back in is not going to work unless
we re-pack or delay allocating the counters until we start the PMU.

> 
> [...]
> 
>>>> +static inline void armv8pmu_write_chain_counter(int idx, u64 value)
>>>> +{
>>>> +	armv8pmu_write_evcntr(idx, value >> 32);
>>>> +	isb();
>>>> +	armv8pmu_write_evcntr(idx - 1, value);
>>>> +}
>>>
>>> Can we use upper_32_bits() and lower_32_bits() here?
>>>
>>> As a more general thing, I think we need to clean up the way we
>>> read/write counters, because I don't think that it's right that we poke
>>> them while they're running -- that means you get some arbitrary skew on
>>> counter groups.
>>>
>>> It looks like the only case we do that is the IRQ handler, so we should
>>> be able to stop/start the PMU there.
>>
>> Since we don't stop the "counting" of events usually when an IRQ is
>> triggered, the skew will be finally balanced when the events are stopped
>> in a the group. So, I think, stopping the PMU may not be really a good
>> thing after all. Just my thought.
> 
> That's not quite right -- if one event in a group overflows, we'll
> reprogram it *while* other events are counting, losing some events in
> the process.

Oh yes, you're right. I can fix it.


> 
> Stopping the PMU for the duration of the IRQ handler ensures that events
> in a group are always in-sync with one another.

Suzuki
