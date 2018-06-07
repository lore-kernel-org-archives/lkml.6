Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JP2yFOTfGFuKAQAAmS7hNA
	; Thu, 07 Jun 2018 07:34:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9D88B6089E; Thu,  7 Jun 2018 07:34:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0A84C6063F;
	Thu,  7 Jun 2018 07:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A84C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeFGHec (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:34:32 -0400
Received: from foss.arm.com ([217.140.101.70]:47652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752459AbeFGHeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:34:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8510780D;
        Thu,  7 Jun 2018 00:34:31 -0700 (PDT)
Received: from [10.37.9.91] (unknown [10.37.9.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 547CE3F59D;
        Thu,  7 Jun 2018 00:34:30 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] arm_pmu: Add support for 64bit event counters
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-4-git-send-email-suzuki.poulose@arm.com>
 <20180606164838.zeuygsp4teq64zor@lakrids.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9d76ba06-921f-142b-5ab2-c30985558205@arm.com>
Date: Thu, 7 Jun 2018 08:34:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606164838.zeuygsp4teq64zor@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 05:48 PM, Mark Rutland wrote:
> On Tue, May 29, 2018 at 11:55:54AM +0100, Suzuki K Poulose wrote:
>> Each PMU has a set of 32bit event counters. But in some
>> special cases, the events could be counted using counters
>> which are effectively 64bit wide.
>>
>> e.g, Arm V8 PMUv3 has a 64 bit cycle counter which can count
>> only the CPU cycles. Also, the PMU can chain the event counters
>> to effectively count as a 64bit counter.
>>
>> Add support for tracking the events that uses 64bit counters.
>> This only affects the periods set for each counter in the core
>> driver.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v1:
>>   - Rename ARMPMU_EVT_LONG => ARMPMU_EVT_64BIT
>> ---
>>   drivers/perf/arm_pmu.c       | 14 ++++++++------
>>   include/linux/perf/arm_pmu.h |  6 ++++++
>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 8962d26..ff858e6 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -28,9 +28,10 @@
>>   static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>>   static DEFINE_PER_CPU(int, cpu_irq);
>>   
>> -static inline u64 arm_pmu_max_period(void)
>> +static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>>   {
>> -	return (1ULL << 32) - 1;
>> +	return (event->hw.flags & ARMPMU_EVT_64BIT) ?
>> +		~0ULL : (1ULL << 32) - 1;
>>   }
> 
> Could we please have:
> 
> static inline u64 arm_pmu_event_max_period(struct perf_event *event)
> {
> 	if (event->hw.flags & ARMPMU_EVT_64BIT)
> 		return GENMASK_ULL(63, 0);
> 	else
> 		return GENMASK_ULL(31, 0);
> }
> 
> ... since that's obviously balanced, with both values generated in the
> same way.
> 

Sure, will do

Suzuki
