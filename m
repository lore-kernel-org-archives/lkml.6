Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4FDC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F8627EC5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F8627EC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935030AbeF2N3c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:29:32 -0400
Received: from foss.arm.com ([217.140.101.70]:34254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932375AbeF2N30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:29:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEEE980D;
        Fri, 29 Jun 2018 06:29:26 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CDFF3F318;
        Fri, 29 Jun 2018 06:29:25 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:29:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 5/7] arm64: perf: Clean up armv8pmu_select_counter
Message-ID: <20180629132922.la6lntd54kut5c4y@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529403342-17899-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:15:40AM +0100, Suzuki K Poulose wrote:
> armv8pmu_select_counter always returns the passed idx. So
> let us make that void and get rid of the pointless checks.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/perf_event.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 66a2ffd..9ce3729 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -503,13 +503,17 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
>  	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
>  }
>  
> -static inline int armv8pmu_select_counter(int idx)
> +static inline void armv8pmu_select_counter(int idx)
>  {
>  	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>  	write_sysreg(counter, pmselr_el0);
>  	isb();
> +}
>  
> -	return idx;
> +static inline u32 armv8pmu_read_evcntr(int idx)
> +{
> +	armv8pmu_select_counter(idx);
> +	return read_sysreg(pmxevcntr_el0);
>  }
>  
>  static inline u64 armv8pmu_read_counter(struct perf_event *event)
> @@ -524,12 +528,18 @@ static inline u64 armv8pmu_read_counter(struct perf_event *event)
>  			smp_processor_id(), idx);
>  	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
>  		value = read_sysreg(pmccntr_el0);
> -	else if (armv8pmu_select_counter(idx) == idx)
> -		value = read_sysreg(pmxevcntr_el0);
> +	else
> +		value = armv8pmu_read_evcntr(idx);
>  
>  	return value;
>  }
>  
> +static inline void armv8pmu_write_evcntr(int idx, u32 value)
> +{
> +	armv8pmu_select_counter(idx);
> +	write_sysreg(value, pmxevcntr_el0);
> +}
> +
>  static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  {
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> @@ -547,16 +557,15 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  		 */
>  		value |= 0xffffffff00000000ULL;
>  		write_sysreg(value, pmccntr_el0);
> -	} else if (armv8pmu_select_counter(idx) == idx)
> -		write_sysreg(value, pmxevcntr_el0);
> +	} else
> +		armv8pmu_write_evcntr(idx, value);
>  }
>  
>  static inline void armv8pmu_write_evtype(int idx, u32 val)
>  {
> -	if (armv8pmu_select_counter(idx) == idx) {
> -		val &= ARMV8_PMU_EVTYPE_MASK;
> -		write_sysreg(val, pmxevtyper_el0);
> -	}
> +	armv8pmu_select_counter(idx);
> +	val &= ARMV8_PMU_EVTYPE_MASK;
> +	write_sysreg(val, pmxevtyper_el0);
>  }
>  
>  static inline int armv8pmu_enable_counter(int idx)
> -- 
> 2.7.4
> 
