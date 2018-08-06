Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C8BC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F92F21A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rgo6NDFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F92F21A5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbeHFUpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:45:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeHFUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Hr34ZfK2fmSygFg8oCpqRORaZEOP+k4GZxZN9or6KY=; b=Rgo6NDFiY8R2NzrNBqG7/V2YN
        6VrtCfLmQ7ChLDcXKYyG3nVALbWE1ZtzVM4expFnvU4c7ow0r+Z69jwlXbelyyq1LxebALSdmjcYq
        07v4PHp/tQwIJigr1J8k3NyAkZM5TxKPmc6brHndX1LQwj3NoAFAkvdLnyCEdxj3t3xenO8IyFlJU
        l55L2ODMAwY7CtSmveLPsggoB3MNhom0B6WUB4QTsFxoN3DA39UWg2jiNh3rTL6bVc51FhL9Nj7dJ
        WLrblGhbtoHRfdUIiNTcy6+16clBxiqqTaMW2dZUiFAtfu1DZW79yK+6bpGcm+khGMMDx8hFs5n64
        DpX0SX6uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmkLd-0003AM-0x; Mon, 06 Aug 2018 18:35:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62AD020589AA1; Mon,  6 Aug 2018 20:35:15 +0200 (CEST)
Date:   Mon, 6 Aug 2018 20:35:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI handler
Message-ID: <20180806183515.GR2494@hirez.programming.kicks-ass.net>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <1533576223-11588-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533576223-11588-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:23:42AM -0700, kan.liang@linux.intel.com wrote:
> @@ -2044,6 +2056,14 @@ static void intel_pmu_disable_event(struct perf_event *event)
>  	if (unlikely(event->attr.precise_ip))
>  		intel_pmu_pebs_disable(event);
>  
> +	/*
> +	 * We could disable freezing here, but doesn't hurt if it's on.
> +	 * perf remembers the state, and someone else will likely
> +	 * reinitialize.
> +	 *
> +	 * This avoids an extra MSR write in many situations.
> +	 */
> +
>  	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
>  		intel_pmu_disable_fixed(hwc);
>  		return;
> @@ -2119,6 +2139,11 @@ static void intel_pmu_enable_event(struct perf_event *event)
>  	if (event->attr.exclude_guest)
>  		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
>  
> +	if (x86_pmu.counter_freezing && !cpuc->frozen_enabled) {
> +		enable_counter_freeze();
> +		cpuc->frozen_enabled = 1;
> +	}
> +
>  	if (unlikely(event_is_checkpointed(event)))
>  		cpuc->intel_cp_status |= (1ull << hwc->idx);
>  

Why here? That doesn't really make sense; should this not be in
intel_pmu_cpu_starting() or something?

> +static bool disable_counter_freezing;
> +module_param(disable_counter_freezing, bool, 0444);
> +MODULE_PARM_DESC(disable_counter_freezing, "Disable counter freezing feature."
> +		"The PMI handler will fall back to generic handler."
> +		"Default is false (enable counter freezing feature).");

Why?

> +	/*
> +	 * Ack the PMU late after the APIC.  This avoids bogus

That doesn't make sense. PMU and APIC do not have order.

> +	 * freezing on Skylake CPUs.  The acking unfreezes the PMU
> +	 */
> +	if (status) {
> +		intel_pmu_ack_status(status);
> +	} else {
> +		/*
> +		 * CPU may issues two PMIs very close to each other.
> +		 * When the PMI handler services the first one, the
> +		 * GLOBAL_STATUS is already updated to reflect both.
> +		 * When it IRETs, the second PMI is immediately
> +		 * handled and it sees clear status. At the meantime,
> +		 * there may be a third PMI, because the freezing bit
> +		 * isn't set since the ack in first PMI handlers.
> +		 * Double check if there is more work to be done.
> +		 */

Urgh... fun fun fun.

> +		status = intel_pmu_get_status();
> +		if (status)
> +			goto again;
> +	}
> +
> +	if (bts)
> +		intel_bts_enable_local();
> +	cpuc->enabled = pmu_enabled;
> +	return handled;
> +}

> @@ -3432,6 +3538,11 @@ static void intel_pmu_cpu_dying(int cpu)
>  	free_excl_cntrs(cpu);
>  
>  	fini_debug_store_on_cpu(cpu);
> +
> +	if (cpuc->frozen_enabled) {
> +		cpuc->frozen_enabled = 0;
> +		disable_counter_freeze();
> +	}
>  }

See, you have the dying thing, so why not the matching starting thing.

> @@ -4442,6 +4555,15 @@ __init int intel_pmu_init(void)
>  		pr_cont("full-width counters, ");
>  	}
>  
> +	/*
> +	 * For arch perfmon 4 use counter freezing to avoid
> +	 * several MSR accesses in the PMI.
> +	 */
> +	if (x86_pmu.counter_freezing) {
> +		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
> +		pr_cont("counter freezing, ");
> +	}

Lets not print the counter freezing, we already print v4, right?


> @@ -561,6 +566,7 @@ struct x86_pmu {
>  	struct x86_pmu_quirk *quirks;
>  	int		perfctr_second_write;
>  	bool		late_ack;
> +	bool		counter_freezing;

Please make the both of them int or something.

>  	u64		(*limit_period)(struct perf_event *event, u64 l);
>  
>  	/*
