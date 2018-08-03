Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404B421777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IC0ceDxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404B421777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeHCTTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:19:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeHCTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/7zcp47e6Ydd4cZN9LQW18xrO4SGF+ktz9zrchZXPTw=; b=IC0ceDxaj3PSNtMTXsAaOk1M9
        QEtga76/juR42zvAw8YxOerG0K+uYK2ow40CGzi1YhW5SewN0LagB8Dfwz2LWm9Btlztd4040Zpl6
        u0/ODDUHaxsv2ONZgj7/zbIBDGXO1qRD5kDu5ruoTk/wjutwUf0TfDR3kxkYUjYrrFVGfQObFkuFs
        WSVr6hJyDuwr3bq6lDxduvs9KjgJq2oX76ZRgr8aiwsQg75b2NvkOHRn30bcFRwPnZQCUh1tkPUs0
        MdNVE0Edk8oQuZyCVZHkWoqr7+K1hAYuXDzvw1kTkP2wUeiYZve62Gb2b7CUiY31wKu+X/8iGWQKM
        JtR6kOARA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fldll-0008BK-El; Fri, 03 Aug 2018 17:21:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8E7A20267E51; Fri,  3 Aug 2018 19:21:39 +0200 (CEST)
Date:   Fri, 3 Aug 2018 19:21:39 +0200
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
Message-ID: <20180803172139.GE2494@hirez.programming.kicks-ass.net>
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

As is, groupc->state_start needs a READ_ONCE() above and a WRITE_ONCE()
below. But like stated earlier, doing an update in scheduler_tick() is
probably easier.

> +static void psi_group_change(struct psi_group *group, int cpu, u64 now,
> +			     unsigned int clear, unsigned int set)
> +{
> +	struct psi_group_cpu *groupc;
> +	unsigned int t, m;
> +	u32 delta;
> +
> +	groupc = per_cpu_ptr(group->pcpu, cpu);
> +
> +	/*
> +	 * First we assess the aggregate resource states these CPU's
> +	 * tasks have been in since the last change, and account any
> +	 * SOME and FULL time that may have resulted in.
> +	 *
> +	 * Then we update the task counts according to the state
> +	 * change requested through the @clear and @set bits.
> +	 */
> +
> +	delta = now - groupc->state_start;
> +	groupc->state_start = now;
> +
> +	/*
> +	 * Update state_start before recording time in the sampling
> +	 * buckets and changing task counts, to prevent a racing
> +	 * aggregation from counting the delta twice or attributing it
> +	 * to an old state.
> +	 */
> +	smp_wmb();
> +
> +	if (test_state(groupc->tasks, cpu, PSI_IO_SOME)) {
> +		groupc->times[PSI_IO_SOME] += delta;
> +		if (test_state(groupc->tasks, cpu, PSI_IO_FULL))
> +			groupc->times[PSI_IO_FULL] += delta;
> +	}
> +	if (test_state(groupc->tasks, cpu, PSI_MEM_SOME)) {
> +		groupc->times[PSI_MEM_SOME] += delta;
> +		if (test_state(groupc->tasks, cpu, PSI_MEM_FULL))
> +			groupc->times[PSI_MEM_FULL] += delta;
> +	}

Might we worth checking the compiler does the right thing here and
optimizes this branch fest into something sensible.

> +	if (test_state(groupc->tasks, cpu, PSI_CPU_SOME))
> +		groupc->times[PSI_CPU_SOME] += delta;
> +	if (test_state(groupc->tasks, cpu, PSI_NONIDLE))
> +		groupc->times[PSI_NONIDLE] += delta;

