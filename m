Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E08C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BC521764
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/b8Hnvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BC521764
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHCSyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:54:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=us6WDSBVfFK9MXOUFs3re4B3d5LTNqnZtZ8/cNrTON0=; b=o/b8HnvqHg/3a8NSDjpfeR3LB
        /uBc0NQBp0ceNu55U83fcxvbvX7cBRgZzMAJF1xLPFzGPB86WdPEyQjU4lc8vOGheZdOeF4YLaIJB
        JTPgOoS7GxtP76Z4pCjQpaOOrrlYlYQkxWxtMboBpVCflApu2EaRBdy1KB7j6KzbYjEw4+rEf7V8/
        gMq528JYuxk9zJdHZEB0BgMjJHOEbjhd1fj0WhqspwqI68AyY8MYLiV/jPm5vkhOqzhEOSYlSxB8P
        /L3uei7haPxqrWVytdNq3f8IGAABe4YzYSDyDZy6Rq5BX7+UKNijeydqOoAnmddo9riTO9vVCdrve
        6Kcajhf8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fldNc-0007HU-TO; Fri, 03 Aug 2018 16:56:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89ECC20267E51; Fri,  3 Aug 2018 18:56:41 +0200 (CEST)
Date:   Fri, 3 Aug 2018 18:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180803165641.GA2476@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801151958.32590-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> +static bool test_state(unsigned int *tasks, int cpu, enum psi_states state)
> +{
> +	switch (state) {
> +	case PSI_IO_SOME:
> +		return tasks[NR_IOWAIT];
> +	case PSI_IO_FULL:
> +		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
> +	case PSI_MEM_SOME:
> +		return tasks[NR_MEMSTALL];
> +	case PSI_MEM_FULL:
> +		/*
> +		 * Since we care about lost potential, things are
> +		 * fully blocked on memory when there are no other
> +		 * working tasks, but also when the CPU is actively
> +		 * being used by a reclaimer and nothing productive
> +		 * could run even if it were runnable.
> +		 */
> +		return tasks[NR_MEMSTALL] &&
> +			(!tasks[NR_RUNNING] ||
> +			 cpu_curr(cpu)->flags & PF_MEMSTALL);

I don't think you can do this, there is nothing that guarantees
cpu_curr() still exists.

> +	case PSI_CPU_SOME:
> +		return tasks[NR_RUNNING] > 1;
> +	case PSI_NONIDLE:
> +		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
> +			tasks[NR_RUNNING];
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool psi_update_stats(struct psi_group *group)
> +{
> +	u64 deltas[NR_PSI_STATES - 1] = { 0, };
> +	unsigned long missed_periods = 0;
> +	unsigned long nonidle_total = 0;
> +	u64 now, expires, period;
> +	int cpu;
> +	int s;
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
> +	 * We don't need to synchronize against CPU hotplugging. If we
> +	 * see a CPU that's online and has samples, we incorporate it.
> +	 */
> +	for_each_online_cpu(cpu) {
> +		struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +		u32 uninitialized_var(nonidle);

urgh.. I can see why the compiler got confused. Dodgy :-)

> +
> +		BUILD_BUG_ON(PSI_NONIDLE != NR_PSI_STATES - 1);
> +
> +		for (s = PSI_NONIDLE; s >= 0; s--) {
> +			u32 time, delta;
> +
> +			time = READ_ONCE(groupc->times[s]);
> +			/*
> +			 * In addition to already concluded states, we
> +			 * also incorporate currently active states on
> +			 * the CPU, since states may last for many
> +			 * sampling periods.
> +			 *
> +			 * This way we keep our delta sampling buckets
> +			 * small (u32) and our reported pressure close
> +			 * to what's actually happening.
> +			 */
> +			if (test_state(groupc->tasks, cpu, s)) {
> +				/*
> +				 * We can race with a state change and
> +				 * need to make sure the state_start
> +				 * update is ordered against the
> +				 * updates to the live state and the
> +				 * time buckets (groupc->times).
> +				 *
> +				 * 1. If we observe task state that
> +				 * needs to be recorded, make sure we
> +				 * see state_start from when that
> +				 * state went into effect or we'll
> +				 * count time from the previous state.
> +				 *
> +				 * 2. If the time delta has already
> +				 * been added to the bucket, make sure
> +				 * we don't see it in state_start or
> +				 * we'll count it twice.
> +				 *
> +				 * If the time delta is out of
> +				 * state_start but not in the time
> +				 * bucket yet, we'll miss it entirely
> +				 * and handle it in the next period.
> +				 */
> +				smp_rmb();
> +				time += cpu_clock(cpu) - groupc->state_start;
> +			}

The alternative is adding an update to scheduler_tick(), that would
ensure you're never more than nr_cpu_ids * TICK_NSEC behind.

> +			delta = time - groupc->times_prev[s];
> +			groupc->times_prev[s] = time;
> +
> +			if (s == PSI_NONIDLE) {
> +				nonidle = nsecs_to_jiffies(delta);
> +				nonidle_total += nonidle;
> +			} else {
> +				deltas[s] += (u64)delta * nonidle;
> +			}
> +		}
> +	}
