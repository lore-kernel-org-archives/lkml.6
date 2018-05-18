Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeERNWR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:22:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbeERNWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:22:09 -0400
Subject: Re: [PATCH 3/6] arm_pmu: Add support for long event counters
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
 <1526638943-2110-4-git-send-email-suzuki.poulose@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <72bfd236-65de-6477-7f76-2f10d8bceb99@arm.com>
Date: Fri, 18 May 2018 14:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526638943-2110-4-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 11:22, Suzuki K Poulose wrote:
> Each PMU has a set of fixed width event counters. But in some
> special cases, the events could be counted using a counter which
> effectively has twice the normal width of a coutner.
> e.g, Arm V8 PMUv3 has a 64 bit cycle counter which can count
> only the CPU cylces. Also, the PMU can chain the event counters
> to effectively count as a 64bit counter.

Nit: a few typos in that paragraph.

> Add support for tracking the events that uses double the normal
> counter size. This only affects the periods set for each counter.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/perf/arm_pmu.c       | 25 ++++++++++++++++++++++---
>   include/linux/perf/arm_pmu.h |  6 ++++++
>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index e23e1a1..1adabb5 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -33,6 +33,21 @@ static inline u64 arm_pmu_max_period(struct arm_pmu *pmu)
>   	return (((u64)1) << (pmu->counter_width)) - 1;
>   }
>   
> +static inline u64 arm_pmu_get_event_max_period(struct arm_pmu *pmu,

The "get_" here seems a bit at odds with arm_pmu_max_period() - I'd be 
inlined to go for slightly more consistent naming (with a slight 
personal preference towards removing it here rather than adding it there)

> +					       struct perf_event *event)
> +{
> +	u64 period = arm_pmu_max_period(pmu);
> +
> +	/*
> +	 * To prevent shift-counter-overflow warning, create the
> +	 * mask, by shift + OR sequence.
> +	 */
> +	if (event->hw.flags & ARMPMU_EVT_LONG)
> +		period = (period << pmu->counter_width) | period;
> +
> +	return period;
> +}
> +
>   static int
>   armpmu_map_cache_event(const unsigned (*cache_map)
>   				      [PERF_COUNT_HW_CACHE_MAX]
> @@ -122,7 +137,7 @@ int armpmu_event_set_period(struct perf_event *event)
>   	u64 max_period;
>   	int ret = 0;
>   
> -	max_period = arm_pmu_max_period(armpmu);
> +	max_period = arm_pmu_get_event_max_period(armpmu, event);
>   	if (unlikely(left <= -period)) {
>   		left = period;
>   		local64_set(&hwc->period_left, left);
> @@ -148,7 +163,7 @@ int armpmu_event_set_period(struct perf_event *event)
>   
>   	local64_set(&hwc->prev_count, (u64)-left);
>   
> -	armpmu->write_counter(event, (u64)(-left) & 0xffffffff);
> +	armpmu->write_counter(event, (u64)(-left) & max_period);
>   
>   	perf_event_update_userpage(event);
>   
> @@ -160,7 +175,7 @@ u64 armpmu_event_update(struct perf_event *event)
>   	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>   	struct hw_perf_event *hwc = &event->hw;
>   	u64 delta, prev_raw_count, new_raw_count;
> -	u64 max_period = arm_pmu_max_period(armpmu);
> +	u64 max_period = arm_pmu_get_event_max_period(armpmu, event);
>   
>   again:
>   	prev_raw_count = local64_read(&hwc->prev_count);
> @@ -368,6 +383,7 @@ __hw_perf_event_init(struct perf_event *event)
>   	struct hw_perf_event *hwc = &event->hw;
>   	int mapping;
>   
> +	hwc->flags = 0;
>   	mapping = armpmu->map_event(event);
>   
>   	if (mapping < 0) {
> @@ -670,6 +686,9 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
>   			continue;
>   
>   		event = hw_events->events[idx];
> +		/* Chained events could use multiple counters */
> +		if (!event)
> +			continue;

This hunk looks a little out of place; does it perhaps belong to patch #6?

Robin.

>   
>   		switch (cmd) {
>   		case CPU_PM_ENTER:
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 705e8c3..ed7e3f7 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -25,6 +25,12 @@
>    */
>   #define ARMPMU_MAX_HWEVENTS		32
>   
> +/*
> + * ARM PMU hw_event flags
> + */
> +/* Event uses a counter with double the normal width */
> +#define ARMPMU_EVT_LONG			1
> +
>   #define HW_OP_UNSUPPORTED		0xFFFF
>   #define C(_x)				PERF_COUNT_HW_CACHE_##_x
>   #define CACHE_OP_UNSUPPORTED		0xFFFF
> 
