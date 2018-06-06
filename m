Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2192C60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933560AbeFFQso (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:48:44 -0400
Received: from foss.arm.com ([217.140.101.70]:43076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932390AbeFFQsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:48:43 -0400
Date: Wed, 6 Jun 2018 17:48:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 3/5] arm_pmu: Add support for 64bit event counters
Message-ID: <20180606164838.zeuygsp4teq64zor@lakrids.cambridge.arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527591356-10934-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:55:54AM +0100, Suzuki K Poulose wrote:
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
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>  - Rename ARMPMU_EVT_LONG => ARMPMU_EVT_64BIT
> ---
>  drivers/perf/arm_pmu.c       | 14 ++++++++------
>  include/linux/perf/arm_pmu.h |  6 ++++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 8962d26..ff858e6 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -28,9 +28,10 @@
>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>  static DEFINE_PER_CPU(int, cpu_irq);
>  
> -static inline u64 arm_pmu_max_period(void)
> +static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>  {
> -	return (1ULL << 32) - 1;
> +	return (event->hw.flags & ARMPMU_EVT_64BIT) ?
> +		~0ULL : (1ULL << 32) - 1;
>  }

Could we please have:

static inline u64 arm_pmu_event_max_period(struct perf_event *event)
{
	if (event->hw.flags & ARMPMU_EVT_64BIT)
		return GENMASK_ULL(63, 0);
	else
		return GENMASK_ULL(31, 0);
}

... since that's obviously balanced, with both values generated in the
same way.

Otherwise this looks good to me.

Thanks,
Mark.
