Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B418C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288062083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PdkYGGrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288062083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIGO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:57:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIGO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pZ6Lf6co6zgsKl8qdefhOF/uzplfkLJbhgYvWNOjvMs=; b=PdkYGGrWQhNYXtQ8c/Q1sOccx
        UxcLOrecn3hZRTv7pCdau2CMvCeH/UdXz/xHMMmtJfJDdfnPWXQ+aL4IweO2BVixzWG66/uSfvOZq
        ec+UegvY7OU/1pGU1yT+X1Xu1O55SmO56IQ94TiiIEewCcW+oP5M7bqOgvota/8CCapVeqh8lq/cI
        USyfdEaPsetupGTbmrZ1Q/x0z0SVCE77Kk8vDdEnJzpkxZPZS3cj45tS5DftP1qb08TPrcn139g4t
        uVSes+63f2BOUEfSgOaSdf9Ps7utw4SaSIqPCyeue/z/VfQV7cX0Bx89Ky6PaNgTzOu4r6zl1gLDu
        PC5P40Xww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyDoa-00053X-Un; Fri, 07 Sep 2018 10:16:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4BE8201F9C46; Fri,  7 Sep 2018 12:16:34 +0200 (CEST)
Date:   Fri, 7 Sep 2018 12:16:34 +0200
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
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180907101634.GO24106@hirez.programming.kicks-ass.net>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828172258.3185-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:22:57PM -0400, Johannes Weiner wrote:
> +enum psi_states {
> +	PSI_IO_SOME,
> +	PSI_IO_FULL,
> +	PSI_MEM_SOME,
> +	PSI_MEM_FULL,
> +	PSI_CPU_SOME,
> +	/* Only per-CPU, to weigh the CPU in the global average: */
> +	PSI_NONIDLE,
> +	NR_PSI_STATES,
> +};

> +static u32 get_recent_time(struct psi_group *group, int cpu,
> +			   enum psi_states state)
> +{
> +	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +	unsigned int seq;
> +	u32 time, delta;
> +
> +	do {
> +		seq = read_seqcount_begin(&groupc->seq);
> +
> +		time = groupc->times[state];
> +		/*
> +		 * In addition to already concluded states, we also
> +		 * incorporate currently active states on the CPU,
> +		 * since states may last for many sampling periods.
> +		 *
> +		 * This way we keep our delta sampling buckets small
> +		 * (u32) and our reported pressure close to what's
> +		 * actually happening.
> +		 */
> +		if (test_state(groupc->tasks, state))
> +			time += cpu_clock(cpu) - groupc->state_start;
> +	} while (read_seqcount_retry(&groupc->seq, seq));
> +
> +	delta = time - groupc->times_prev[state];
> +	groupc->times_prev[state] = time;
> +
> +	return delta;
> +}

> +static bool update_stats(struct psi_group *group)
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
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		u32 nonidle;
> +
> +		nonidle = get_recent_time(group, cpu, PSI_NONIDLE);
> +		nonidle = nsecs_to_jiffies(nonidle);
> +		nonidle_total += nonidle;
> +
> +		for (s = 0; s < PSI_NONIDLE; s++) {
> +			u32 delta;
> +
> +			delta = get_recent_time(group, cpu, s);
> +			deltas[s] += (u64)delta * nonidle;
> +		}
> +	}

This does the whole seqcount thing 6x, which is a bit of a waste.

struct snapshot {
	u32 times[NR_PSI_STATES];
};

static inline struct snapshot get_times_snapshot(struct psi_group *pg, int cpu)
{
	struct pci_group_cpu *pgc = per_cpu_ptr(pg->pcpu, cpu);
	struct snapshot s;
	unsigned int seq;
	u32 delta;
	int i;

	do {
		seq = read_seqcount_begin(&pgc->seq);

		delta = cpu_clock(cpu) - pgc->state_start;
		for (i = 0; i < NR_PSI_STATES; i++) {
			s.times[i] = gpc->times[i];
			if (test_state(pgc->tasks, i))
				s.times[i] += delta;
		}

	} while (read_seqcount_retry(&pgc->seq, seq);

	return s;
}


	for_each_possible_cpu(cpu) {
		struct snapshot s = get_times_snapshot(pg, cpu);

		nonidle = nsecs_to_jiffies(s.times[PSI_NONIDLE]);
		nonidle_total += nonidle;

		for (i = 0; i < PSI_NONIDLE; i++)
			deltas[s] += (u64)s.times[i] * nonidle;

		/* ... */

	}


It's a bit cumbersome, but that's because of C.
