Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65664ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E622086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1u+da1Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E622086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbeGQPfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:35:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43664 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbeGQPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xukDW9g+x+JE5sTurwzSx8e/tRij4uBDgfD9bhsMJhg=; b=1u+da1QuCoNB3qzUoUWAGAH83
        uPaKcrbwKZR+mFn39STBN69Czr7riKV/I/YuJ9/3K2jnXPznC/EcKLT3yL8wlHsqIRlQgxceX258l
        SDrJ3FTR2m9WIvRhY5x+ZGarqhL4kHB0a4Njhkyn0vBWlrC4A7cDBgpqxaC0jarj+TavbVwtOrSsX
        X913q0dxkbF1iR0EbHd5Lgp1FAYyKdLC2ynyBAGT8N7zFloDq6F4U6lqygFfiA6VhmVl9M4MFulzI
        mpUP4+l+7YyLPvyE7Unqc+cj+pRsNGzBnt9SrnAs/eCpgDI3GJ7cHX87PIOususYbsU7yxgbv8Gl0
        R/b6hhuHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffRU1-00019Y-DO; Tue, 17 Jul 2018 15:01:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AEF620275F36; Tue, 17 Jul 2018 17:01:42 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:01:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180717150142.GG2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> +static bool psi_update_stats(struct psi_group *group)
> +{
> +	u64 some[NR_PSI_RESOURCES] = { 0, };
> +	u64 full[NR_PSI_RESOURCES] = { 0, };
> +	unsigned long nonidle_total = 0;
> +	unsigned long missed_periods;
> +	unsigned long expires;
> +	int cpu;
> +	int r;
> +
> +	mutex_lock(&group->stat_lock);
> +
> +	/*
> +	 * Collect the per-cpu time buckets and average them into a
> +	 * single time sample that is normalized to wallclock time.
> +	 *
> +	 * For averaging, each CPU is weighted by its non-idle time in
> +	 * the sampling period. This eliminates artifacts from uneven
> +	 * loading, or even entirely idle CPUs.
> +	 *
> +	 * We could pin the online CPUs here, but the noise introduced
> +	 * by missing up to one sample period from CPUs that are going
> +	 * away shouldn't matter in practice - just like the noise of
> +	 * previously offlined CPUs returning with a non-zero sample.

But why!? cpuu_read_lock() is neither expensive nor complicated. So why
try and avoid it?

> +	 */
> +	for_each_online_cpu(cpu) {
> +		struct psi_group_cpu *groupc = per_cpu_ptr(group->cpus, cpu);
> +		unsigned long nonidle;
> +
> +		if (!groupc->nonidle_time)
> +			continue;
> +
> +		nonidle = nsecs_to_jiffies(groupc->nonidle_time);
> +		groupc->nonidle_time = 0;
> +		nonidle_total += nonidle;
> +
> +		for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +			struct psi_resource *res = &groupc->res[r];
> +
> +			some[r] += (res->times[0] + res->times[1]) * nonidle;
> +			full[r] += res->times[1] * nonidle;
> +
> +			/* It's racy, but we can tolerate some error */
> +			res->times[0] = 0;
> +			res->times[1] = 0;
> +		}
> +	}
> +
> +	/*
> +	 * Integrate the sample into the running statistics that are
> +	 * reported to userspace: the cumulative stall times and the
> +	 * decaying averages.
> +	 *
> +	 * Pressure percentages are sampled at PSI_FREQ. We might be
> +	 * called more often when the user polls more frequently than
> +	 * that; we might be called less often when there is no task
> +	 * activity, thus no data, and clock ticks are sporadic. The
> +	 * below handles both.
> +	 */
> +
> +	/* total= */
> +	for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +		do_div(some[r], max(nonidle_total, 1UL));
> +		do_div(full[r], max(nonidle_total, 1UL));
> +
> +		group->some[r] += some[r];
> +		group->full[r] += full[r];

		group->some[r] = div64_ul(some[r], max(nonidle_total, 1UL));
		group->full[r] = div64_ul(full[r], max(nonidle_total, 1UL));

Is easier to read imo.

> +	}
> +
> +	/* avgX= */
> +	expires = group->period_expires;
> +	if (time_before(jiffies, expires))
> +		goto out;
> +
> +	missed_periods = (jiffies - expires) / PSI_FREQ;
> +	group->period_expires = expires + ((1 + missed_periods) * PSI_FREQ);
> +
> +	for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +		u64 some, full;
> +
> +		some = group->some[r] - group->last_some[r];
> +		full = group->full[r] - group->last_full[r];
> +
> +		calc_avgs(group->avg_some[r], some, missed_periods);
> +		calc_avgs(group->avg_full[r], full, missed_periods);
> +
> +		group->last_some[r] = group->some[r];
> +		group->last_full[r] = group->full[r];
> +	}
> +out:
> +	mutex_unlock(&group->stat_lock);
> +	return nonidle_total;
> +}
