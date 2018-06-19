Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5203B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937597AbeFSKwL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:52:11 -0400
Received: from foss.arm.com ([217.140.101.70]:47510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936108AbeFSKwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:52:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C981435;
        Tue, 19 Jun 2018 03:52:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2E153F25D;
        Tue, 19 Jun 2018 03:52:08 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:52:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 2/7] arm_pmu: Change API to support 64bit counter
 values
Message-ID: <20180619105206.6tfbjwaifjw6hrmi@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529403342-17899-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:15:37AM +0100, Suzuki K Poulose wrote:
> Convert the {read/write}_counter APIs to handle 64bit values
> to enable supporting chained event counters.

It might be worth a note that the underlying helpers will still only
write 32-bit values, and we'll only pass those 32-bit values, so this
shouldn't cause any functional change.

> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  - No changes since v2
> ---
>  arch/arm/kernel/perf_event_v6.c     | 4 ++--
>  arch/arm/kernel/perf_event_v7.c     | 4 ++--
>  arch/arm/kernel/perf_event_xscale.c | 8 ++++----
>  arch/arm64/kernel/perf_event.c      | 9 ++++-----
>  include/linux/perf/arm_pmu.h        | 4 ++--
>  5 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index f64a6bf..0729f98 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -233,7 +233,7 @@ armv6_pmcr_counter_has_overflowed(unsigned long pmcr,
>  	return ret;
>  }
>  
> -static inline u32 armv6pmu_read_counter(struct perf_event *event)
> +static inline u64 armv6pmu_read_counter(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
> @@ -251,7 +251,7 @@ static inline u32 armv6pmu_read_counter(struct perf_event *event)
>  	return value;
>  }
>  
> -static inline void armv6pmu_write_counter(struct perf_event *event, u32 value)
> +static inline void armv6pmu_write_counter(struct perf_event *event, u64 value)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index ecca4cd..fd7ce01 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -743,7 +743,7 @@ static inline void armv7_pmnc_select_counter(int idx)
>  	isb();
>  }
>  
> -static inline u32 armv7pmu_read_counter(struct perf_event *event)
> +static inline u64 armv7pmu_read_counter(struct perf_event *event)
>  {
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -763,7 +763,7 @@ static inline u32 armv7pmu_read_counter(struct perf_event *event)
>  	return value;
>  }
>  
> -static inline void armv7pmu_write_counter(struct perf_event *event, u32 value)
> +static inline void armv7pmu_write_counter(struct perf_event *event, u64 value)
>  {
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
> index c4f0294..942230f 100644
> --- a/arch/arm/kernel/perf_event_xscale.c
> +++ b/arch/arm/kernel/perf_event_xscale.c
> @@ -316,7 +316,7 @@ static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
>  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
> -static inline u32 xscale1pmu_read_counter(struct perf_event *event)
> +static inline u64 xscale1pmu_read_counter(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
> @@ -337,7 +337,7 @@ static inline u32 xscale1pmu_read_counter(struct perf_event *event)
>  	return val;
>  }
>  
> -static inline void xscale1pmu_write_counter(struct perf_event *event, u32 val)
> +static inline void xscale1pmu_write_counter(struct perf_event *event, u64 val)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
> @@ -678,7 +678,7 @@ static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
>  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
> -static inline u32 xscale2pmu_read_counter(struct perf_event *event)
> +static inline u64 xscale2pmu_read_counter(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
> @@ -705,7 +705,7 @@ static inline u32 xscale2pmu_read_counter(struct perf_event *event)
>  	return val;
>  }
>  
> -static inline void xscale2pmu_write_counter(struct perf_event *event, u32 val)
> +static inline void xscale2pmu_write_counter(struct perf_event *event, u64 val)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 678ecff..66a2ffd 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -512,7 +512,7 @@ static inline int armv8pmu_select_counter(int idx)
>  	return idx;
>  }
>  
> -static inline u32 armv8pmu_read_counter(struct perf_event *event)
> +static inline u64 armv8pmu_read_counter(struct perf_event *event)
>  {
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -530,7 +530,7 @@ static inline u32 armv8pmu_read_counter(struct perf_event *event)
>  	return value;
>  }
>  
> -static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
> +static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  {
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -545,9 +545,8 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
>  		 * count using the lower 32bits and we want an interrupt when
>  		 * it overflows.
>  		 */
> -		u64 value64 = 0xffffffff00000000ULL | value;
> -
> -		write_sysreg(value64, pmccntr_el0);
> +		value |= 0xffffffff00000000ULL;
> +		write_sysreg(value, pmccntr_el0);
>  	} else if (armv8pmu_select_counter(idx) == idx)
>  		write_sysreg(value, pmxevcntr_el0);
>  }
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 12c30a2..f7126a2 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -87,8 +87,8 @@ struct arm_pmu {
>  					 struct perf_event *event);
>  	int		(*set_event_filter)(struct hw_perf_event *evt,
>  					    struct perf_event_attr *attr);
> -	u32		(*read_counter)(struct perf_event *event);
> -	void		(*write_counter)(struct perf_event *event, u32 val);
> +	u64		(*read_counter)(struct perf_event *event);
> +	void		(*write_counter)(struct perf_event *event, u64 val);
>  	void		(*start)(struct arm_pmu *);
>  	void		(*stop)(struct arm_pmu *);
>  	void		(*reset)(void *);
> -- 
> 2.7.4
> 
