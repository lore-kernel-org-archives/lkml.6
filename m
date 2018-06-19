Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578AE2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578AE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966163AbeFSKn2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:43:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965768AbeFSKn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:43:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B401435;
        Tue, 19 Jun 2018 03:43:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5583F25D;
        Tue, 19 Jun 2018 03:43:25 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:43:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 6/7] arm64: perf: Disable PMU while processing counter
 overflows
Message-ID: <20180619104323.huwx5n2z53lmtnux@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529403342-17899-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:15:41AM +0100, Suzuki K Poulose wrote:
> The arm64 PMU updates the event counters and reprograms the
> counters in the overflow IRQ handler without disabling the
> PMU. This could potentially cause skews in for group counters,
> where the overflowed counters may potentially loose some event
> counts, while they are reprogrammed. To prevent this, disable
> the PMU while we process the counter overflows and enable it
> right back when we are done.
> 
> This patch also moves the PMU stop/start routines to avoid a
> forward declaration.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

This makes me realise that we could remove the pmu_lock, but that's not
a new problem, and we can address that separately.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/perf_event.c | 50 +++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 9ce3729..eebc635 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -678,6 +678,28 @@ static void armv8pmu_disable_event(struct perf_event *event)
>  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
> +static void armv8pmu_start(struct arm_pmu *cpu_pmu)
> +{
> +	unsigned long flags;
> +	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +
> +	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +	/* Enable all counters */
> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
> +	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> +}
> +
> +static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
> +{
> +	unsigned long flags;
> +	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +
> +	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +	/* Disable all counters */
> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
> +	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> +}
> +
>  static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  {
>  	u32 pmovsr;
> @@ -702,6 +724,11 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  	 */
>  	regs = get_irq_regs();
>  
> +	/*
> +	 * Stop the PMU while processing the counter overflows
> +	 * to prevent skews in group events.
> +	 */
> +	armv8pmu_stop(cpu_pmu);
>  	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
>  		struct perf_event *event = cpuc->events[idx];
>  		struct hw_perf_event *hwc;
> @@ -726,6 +753,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  		if (perf_event_overflow(event, &data, regs))
>  			cpu_pmu->disable(event);
>  	}
> +	armv8pmu_start(cpu_pmu);
>  
>  	/*
>  	 * Handle the pending perf events.
> @@ -739,28 +767,6 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  	return IRQ_HANDLED;
>  }
>  
> -static void armv8pmu_start(struct arm_pmu *cpu_pmu)
> -{
> -	unsigned long flags;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> -
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> -	/* Enable all counters */
> -	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> -}
> -
> -static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
> -{
> -	unsigned long flags;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> -
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> -	/* Disable all counters */
> -	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> -}
> -
>  static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  				  struct perf_event *event)
>  {
> -- 
> 2.7.4
> 
