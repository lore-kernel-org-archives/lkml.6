Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3777EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7E127F48
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7E127F48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754930AbeF2N1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:27:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34224 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753287AbeF2N1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:27:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71B0E80D;
        Fri, 29 Jun 2018 06:27:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB893F318;
        Fri, 29 Jun 2018 06:27:30 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:27:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 4/7] arm_pmu: Tidy up clear_event_idx call backs
Message-ID: <20180629132724.ztcfelcnb2dt2u35@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-5-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529403342-17899-5-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:15:39AM +0100, Suzuki K Poulose wrote:
> The armpmu uses get_event_idx callback to allocate an event
> counter for a given event, which marks the selected counter
> as "used". Now, when we delete the counter, the arm_pmu goes
> ahead and clears the "used" bit and then invokes the "clear_event_idx"
> call back, which kind of splits the job between the core code
> and the backend. Tidy this up by relying on the clear_event_idx
> to do the book keeping, if available. Otherwise, let the core
> driver do the default "clear" bit operation. This will be useful
> for adding the chained event support, where we leave the event
> idx maintenance to the backend.
> 
> Also, when an event is removed from the PMU, reset the hw.idx
> to indicate that a counter is not allocated for this event,
> to help the backends do better checks. This will be also used
> for the chain counter support.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

TBH, I think it might be better to make clear_event_idx() mandatory,
such that each backend provides both clear / set, next to each other in
the code.

It's a bit more code, but it would restore orthogonality to the API.

Mark.

> ---
> Changes since v2:
>  - Reset the event counter after an event is removed.
> ---
>  arch/arm/kernel/perf_event_v7.c |  2 ++
>  drivers/perf/arm_pmu.c          | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index fd7ce01..765d265 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -1637,6 +1637,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  	bool venum_event = EVENT_VENUM(hwc->config_base);
>  	bool krait_event = EVENT_CPU(hwc->config_base);
>  
> +	clear_bit(hwc->idx, cpuc->used_mask);
>  	if (venum_event || krait_event) {
>  		bit = krait_event_to_bit(event, region, group);
>  		clear_bit(bit, cpuc->used_mask);
> @@ -1966,6 +1967,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  	bool venum_event = EVENT_VENUM(hwc->config_base);
>  	bool scorpion_event = EVENT_CPU(hwc->config_base);
>  
> +	clear_bit(hwc->idx, cpuc->used_mask);
>  	if (venum_event || scorpion_event) {
>  		bit = scorpion_event_to_bit(event, region, group);
>  		clear_bit(bit, cpuc->used_mask);
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index e3766a8..6e10e8c 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -227,6 +227,16 @@ static void armpmu_start(struct perf_event *event, int flags)
>  	armpmu->enable(event);
>  }
>  
> +static void armpmu_clear_event_idx(struct arm_pmu *armpmu,
> +				   struct pmu_hw_events *hw_events,
> +				   struct perf_event *event)
> +{
> +	if (armpmu->clear_event_idx)
> +		armpmu->clear_event_idx(hw_events, event);
> +	else
> +		clear_bit(event->hw.idx, hw_events->used_mask);
> +}
> +
>  static void
>  armpmu_del(struct perf_event *event, int flags)
>  {
> @@ -237,11 +247,10 @@ armpmu_del(struct perf_event *event, int flags)
>  
>  	armpmu_stop(event, PERF_EF_UPDATE);
>  	hw_events->events[idx] = NULL;
> -	clear_bit(idx, hw_events->used_mask);
> -	if (armpmu->clear_event_idx)
> -		armpmu->clear_event_idx(hw_events, event);
> -
> +	armpmu_clear_event_idx(armpmu, hw_events, event);
>  	perf_event_update_userpage(event);
> +	/* Clear the allocated counter */
> +	hwc->idx = -1;
>  }
>  
>  static int
> -- 
> 2.7.4
> 
