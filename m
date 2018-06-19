Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3186C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7819920874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7819920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937731AbeFSK5g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:57:36 -0400
Received: from foss.arm.com ([217.140.101.70]:47596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937606AbeFSK5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:57:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89AAF1435;
        Tue, 19 Jun 2018 03:57:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F8463F25D;
        Tue, 19 Jun 2018 03:57:33 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:57:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 3/7] arm_pmu: Add support for 64bit event counters
Message-ID: <20180619105730.wvp2t3krqbvyeayu@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529403342-17899-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:15:38AM +0100, Suzuki K Poulose wrote:
> Each PMU has a set of 32bit event counters. But in some
> special cases, the events could be counted using counters
> which are effectively 64bit wide.
> 
> e.g, Arm V8 PMUv3 has a 64 bit cycle counter which can count
> only the CPU cycles. Also, the PMU can chain the event counters
> to effectively count as a 64bit counter.
> 
> Add support for tracking the events that uses 64bit counters.
> This only affects the periods set for each counter in the core
> driver.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - None
> ---
>  drivers/perf/arm_pmu.c       | 15 +++++++++------
>  include/linux/perf/arm_pmu.h |  6 ++++++
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 6ddc00d..e3766a8 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -28,9 +28,11 @@
>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>  static DEFINE_PER_CPU(int, cpu_irq);
>  
> -static inline u64 arm_pmu_max_period(void)
> +static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>  {
> -	return (1ULL << 32) - 1;
> +	return (event->hw.flags & ARMPMU_EVT_64BIT) ?
> +		GENMASK_ULL(63, 0) :
> +		GENMASK_ULL(31, 0);

Please make this:

	if (event->hw.flags & ARMPMU_EVT_64BIT)
		return GENMASK_ULL(63, 0);
	else
		return GENMASK_ULL(31, 0);

... which I think is more legible than a ternary spread across multiple
lines.

The rest looks fine, so with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  }
>  
>  static int
> @@ -122,7 +124,7 @@ int armpmu_event_set_period(struct perf_event *event)
>  	u64 max_period;
>  	int ret = 0;
>  
> -	max_period = arm_pmu_max_period();
> +	max_period = arm_pmu_event_max_period(event);
>  	if (unlikely(left <= -period)) {
>  		left = period;
>  		local64_set(&hwc->period_left, left);
> @@ -148,7 +150,7 @@ int armpmu_event_set_period(struct perf_event *event)
>  
>  	local64_set(&hwc->prev_count, (u64)-left);
>  
> -	armpmu->write_counter(event, (u64)(-left) & 0xffffffff);
> +	armpmu->write_counter(event, (u64)(-left) & max_period);
>  
>  	perf_event_update_userpage(event);
>  
> @@ -160,7 +162,7 @@ u64 armpmu_event_update(struct perf_event *event)
>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
>  	u64 delta, prev_raw_count, new_raw_count;
> -	u64 max_period = arm_pmu_max_period();
> +	u64 max_period = arm_pmu_event_max_period(event);
>  
>  again:
>  	prev_raw_count = local64_read(&hwc->prev_count);
> @@ -368,6 +370,7 @@ __hw_perf_event_init(struct perf_event *event)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int mapping;
>  
> +	hwc->flags = 0;
>  	mapping = armpmu->map_event(event);
>  
>  	if (mapping < 0) {
> @@ -410,7 +413,7 @@ __hw_perf_event_init(struct perf_event *event)
>  		 * is far less likely to overtake the previous one unless
>  		 * you have some serious IRQ latency issues.
>  		 */
> -		hwc->sample_period  = arm_pmu_max_period() >> 1;
> +		hwc->sample_period  = arm_pmu_event_max_period(event) >> 1;
>  		hwc->last_period    = hwc->sample_period;
>  		local64_set(&hwc->period_left, hwc->sample_period);
>  	}
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index f7126a2..10f92e1 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -25,6 +25,12 @@
>   */
>  #define ARMPMU_MAX_HWEVENTS		32
>  
> +/*
> + * ARM PMU hw_event flags
> + */
> +/* Event uses a 64bit counter */
> +#define ARMPMU_EVT_64BIT		1
> +
>  #define HW_OP_UNSUPPORTED		0xFFFF
>  #define C(_x)				PERF_COUNT_HW_CACHE_##_x
>  #define CACHE_OP_UNSUPPORTED		0xFFFF
> -- 
> 2.7.4
> 
