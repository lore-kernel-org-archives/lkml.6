Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeERNKk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:10:40 -0400
Received: from foss.arm.com ([217.140.101.70]:52794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeERNKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:10:37 -0400
Subject: Re: [PATCH 1/6] arm_pmu: Refactor maximum period handling
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
 <1526638943-2110-2-git-send-email-suzuki.poulose@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c657d966-f7c1-a41c-eac2-73248fee6fdc@arm.com>
Date: Fri, 18 May 2018 14:10:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526638943-2110-2-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 18/05/18 11:22, Suzuki K Poulose wrote:
> Each PMU defines their max_period of the counter as the maximum
> value that can be counted. In order to support chaining of the
> counters, change this parameter to indicate the counter width
> to deduce the max_period. This will be useful to compute the
> max_period for chained counters.
> 
> No functional changes.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm/kernel/perf_event_v6.c     |  4 ++--
>   arch/arm/kernel/perf_event_v7.c     |  2 +-
>   arch/arm/kernel/perf_event_xscale.c |  4 ++--
>   arch/arm64/kernel/perf_event.c      |  2 +-
>   drivers/perf/arm_pmu.c              | 16 ++++++++++++----
>   include/linux/perf/arm_pmu.h        |  2 +-
>   6 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 1d7061a..d52a3fa 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -497,7 +497,7 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
>   	cpu_pmu->stop		= armv6pmu_stop;
>   	cpu_pmu->map_event	= armv6_map_event;
>   	cpu_pmu->num_events	= 3;
> -	cpu_pmu->max_period	= (1LLU << 32) - 1;
> +	cpu_pmu->counter_width	= 32;
>   }
>   
>   static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
> @@ -548,7 +548,7 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
>   	cpu_pmu->stop		= armv6pmu_stop;
>   	cpu_pmu->map_event	= armv6mpcore_map_event;
>   	cpu_pmu->num_events	= 3;
> -	cpu_pmu->max_period	= (1LLU << 32) - 1;
> +	cpu_pmu->counter_width  = 32;
>   
>   	return 0;
>   }
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 870b66c..3d8ec6a 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -1171,7 +1171,7 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
>   	cpu_pmu->start		= armv7pmu_start;
>   	cpu_pmu->stop		= armv7pmu_stop;
>   	cpu_pmu->reset		= armv7pmu_reset;
> -	cpu_pmu->max_period	= (1LLU << 32) - 1;
> +	cpu_pmu->counter_width	= 32;
>   };
>   
>   static void armv7_read_num_pmnc_events(void *info)
> diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
> index fcf218d..6eb0e21 100644
> --- a/arch/arm/kernel/perf_event_xscale.c
> +++ b/arch/arm/kernel/perf_event_xscale.c
> @@ -375,7 +375,7 @@ static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
>   	cpu_pmu->stop		= xscale1pmu_stop;
>   	cpu_pmu->map_event	= xscale_map_event;
>   	cpu_pmu->num_events	= 3;
> -	cpu_pmu->max_period	= (1LLU << 32) - 1;
> +	cpu_pmu->counter_width	= 32;
>   
>   	return 0;
>   }
> @@ -745,7 +745,7 @@ static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
>   	cpu_pmu->stop		= xscale2pmu_stop;
>   	cpu_pmu->map_event	= xscale_map_event;
>   	cpu_pmu->num_events	= 5;
> -	cpu_pmu->max_period	= (1LLU << 32) - 1;
> +	cpu_pmu->counter_width	= 32;
>   
>   	return 0;
>   }
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 85a251b..408f92c 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -961,7 +961,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
>   	cpu_pmu->start			= armv8pmu_start,
>   	cpu_pmu->stop			= armv8pmu_stop,
>   	cpu_pmu->reset			= armv8pmu_reset,
> -	cpu_pmu->max_period		= (1LLU << 32) - 1,
> +	cpu_pmu->counter_width		= 32;

Given that none of the 6 instances above differ, this looks suspiciously 
redundant. AFAICS max_period has been there from the very beginning with 
no explicit justification, so I can only assume it was anticipating more 
future variability than actually turned out. With 8 years of hindsight 
now, I think it would be reasonable to assume that counters are 32-bit 
except in certain special cases where they might be 64-bit; since that 
can't be described by a single "counter size" value anyway, and by the 
end of this series we have the means to handle it correctly via flags, I 
propose that we just get rid of this and hard-code 32 in 
arm_pmu_max_period().

>   	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
>   
>   	return 0;
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 1a0d340..e23e1a1 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -28,6 +28,11 @@
>   static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>   static DEFINE_PER_CPU(int, cpu_irq);
>   
> +static inline u64 arm_pmu_max_period(struct arm_pmu *pmu)
> +{
> +	return (((u64)1) << (pmu->counter_width)) - 1;

Nit: "1ULL << ..."

Otherwise, looks fine to me.

Robin.

> +}
> +
>   static int
>   armpmu_map_cache_event(const unsigned (*cache_map)
>   				      [PERF_COUNT_HW_CACHE_MAX]
> @@ -114,8 +119,10 @@ int armpmu_event_set_period(struct perf_event *event)
>   	struct hw_perf_event *hwc = &event->hw;
>   	s64 left = local64_read(&hwc->period_left);
>   	s64 period = hwc->sample_period;
> +	u64 max_period;
>   	int ret = 0;
>   
> +	max_period = arm_pmu_max_period(armpmu);
>   	if (unlikely(left <= -period)) {
>   		left = period;
>   		local64_set(&hwc->period_left, left);
> @@ -136,8 +143,8 @@ int armpmu_event_set_period(struct perf_event *event)
>   	 * effect we are reducing max_period to account for
>   	 * interrupt latency (and we are being very conservative).
>   	 */
> -	if (left > (armpmu->max_period >> 1))
> -		left = armpmu->max_period >> 1;
> +	if (left > (max_period >> 1))
> +		left = (max_period >> 1);
>   
>   	local64_set(&hwc->prev_count, (u64)-left);
>   
> @@ -153,6 +160,7 @@ u64 armpmu_event_update(struct perf_event *event)
>   	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>   	struct hw_perf_event *hwc = &event->hw;
>   	u64 delta, prev_raw_count, new_raw_count;
> +	u64 max_period = arm_pmu_max_period(armpmu);
>   
>   again:
>   	prev_raw_count = local64_read(&hwc->prev_count);
> @@ -162,7 +170,7 @@ u64 armpmu_event_update(struct perf_event *event)
>   			     new_raw_count) != prev_raw_count)
>   		goto again;
>   
> -	delta = (new_raw_count - prev_raw_count) & armpmu->max_period;
> +	delta = (new_raw_count - prev_raw_count) & max_period;
>   
>   	local64_add(delta, &event->count);
>   	local64_sub(delta, &hwc->period_left);
> @@ -402,7 +410,7 @@ __hw_perf_event_init(struct perf_event *event)
>   		 * is far less likely to overtake the previous one unless
>   		 * you have some serious IRQ latency issues.
>   		 */
> -		hwc->sample_period  = armpmu->max_period >> 1;
> +		hwc->sample_period  = arm_pmu_max_period(armpmu) >> 1;
>   		hwc->last_period    = hwc->sample_period;
>   		local64_set(&hwc->period_left, hwc->sample_period);
>   	}
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 40036a5..c8c31cf 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -94,7 +94,7 @@ struct arm_pmu {
>   	void		(*reset)(void *);
>   	int		(*map_event)(struct perf_event *event);
>   	int		num_events;
> -	u64		max_period;
> +	u8		counter_width;
>   	bool		secure_access; /* 32-bit ARM only */
>   #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
>   	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
> 
