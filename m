Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5E9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3F24BBA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E3F24BBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeGCNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:00:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48770 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbeGCNAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:00:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7330C80D;
        Tue,  3 Jul 2018 06:00:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FEF13F5BA;
        Tue,  3 Jul 2018 06:00:30 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:00:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, julien.thierry@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v4 7/7] arm64: perf: Add support for chaining event
 counters
Message-ID: <20180703130027.4nfd7pxml4ziyl5l@lakrids.cambridge.arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
 <1530568788-26458-8-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530568788-26458-8-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:59:48PM +0100, Suzuki K Poulose wrote:
> Add support for 64bit event by using chained event counters
> and 64bit cycle counters.
> 
> PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
> forming a 64-bit counter. The low/even counter is programmed to count
> the event of interest, and the high/odd counter is programmed to count
> the CHAIN event, taken when the low/even counter overflows.
> 
> For CPU cycles, when 64bit mode is requested, the cycle counter
> is used in 64bit mode. If the cycle counter is not available,
> falls back to chaining.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v3:
>  - Rename format name from "bits64 => long"
>  - Address other comments on style.
> ---
>  arch/arm64/kernel/perf_event.c | 185 +++++++++++++++++++++++++++++++++++------
>  drivers/perf/arm_pmu.c         |  13 ++-
>  2 files changed, 164 insertions(+), 34 deletions(-)

> +static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
> +				   struct arm_pmu *cpu_pmu)
> +{
> +	int idx;
> +
> +	/*
> +	 * Chaining requires two consecutive event counters, where
> +	 * the lower idx must be even.
> +	 */
> +	for (idx = ARMV8_IDX_COUNTER0 + 1; idx < cpu_pmu->num_events; idx += 2) {
> +		if (!test_and_set_bit(idx, cpuc->used_mask)) {
> +			/* Check if the preceding even counter is available */
> +			if (!test_and_set_bit(idx - 1, cpuc->used_mask))
> +				return idx;
> +			/* Release the Odd counter */
> +			clear_bit(idx, cpuc->used_mask);
> +		}
> +	}
> +	return -EAGAIN;
> +}

This means that we'll sometimes fail to pack events, but I guess that
most of the time the rotation logic will save us.

We might need to defer counter allocation in future if that's a real
problem.

> @@ -665,14 +665,13 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
>  	int idx;
>  
>  	for (idx = 0; idx < armpmu->num_events; idx++) {
> -		/*
> -		 * If the counter is not used skip it, there is no
> -		 * need of stopping/restarting it.
> -		 */
> -		if (!test_bit(idx, hw_events->used_mask))
> -			continue;
> -
>  		event = hw_events->events[idx];
> +		/*
> +		 * If there is no event at this idx (e.g, an idx used
> +		 * by a chained event in Arm v8 PMUv3), skip it.
> +		 */
> +		if (!event)
> +			continue;

I think we can drop the comment here.

Other than the above and the xscale fixup, this looks good to me.

Have you thrown the perf fuzzer at this?

Thanks,
Mark.
