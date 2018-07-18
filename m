Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434DBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E532B20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iolCabrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E532B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeGRObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:31:50 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40142 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbeGRObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:31:50 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so4045497qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fKRmFfiEiZawB24hwn9VgULRzC8ly5fwSmN5hO/0hnw=;
        b=iolCabrzZ6IAESM5i/NqGGjIZOFoWftAGvno24p4cp2dcg6SEwDBOR0UbIY8mkuMiM
         6tdq+jSmUfD/mGI0oJk/+rPVp/34yGUrenHYrUAL/XgX0i0HQEqASZL45j3iXGzaIzkd
         s2K6SzOt+UnIv2phYgQ801kc5u5hrwMxrbt2F535LELTbI8Ou24+vR4a7hvP2SPszzMt
         7SA9d0nxdZ+gO4/VlExRfPpsWrlTon1GYtbOa4PrAroFjZ0Yw1GMcjNRMzt19jKjLB8+
         0ygHeVIu/Q6liif+phbUpp8WpxiIaNUPbEPuqnWl0/38xYuC7ne282mTok3xIc1kHZ8p
         /WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fKRmFfiEiZawB24hwn9VgULRzC8ly5fwSmN5hO/0hnw=;
        b=pF864h66Mso5gc4iPj65+oC62vUqWvhgEFJjh4SklIg1P74PMZoR18rb5ldBw+w6ml
         HHZ2ZvG9ynPCTDe2HRd4JblbfQkZeqYzwsX30drVuoa5qt7eA1Rlqw/lWsVyq1GWFRJ1
         b1lx9mUDzbxnDBFZQj0aYdJROZsoXSpHwe0rwmIuXOMZEJqo++nxFpX/udmC8TwXn88n
         LS7XS1sRhcXWfDiHv7vN71yrhvBQ4bCNulZ4pWocEyQeyOHB4CfHmxCS44g3ZTzzzsl2
         Gyddkgca3zys6W99/1QeV65CpPLcYJAcFX20nw0zqJUZNEnkfJwgWO5mXcDn//upIWk1
         jFfQ==
X-Gm-Message-State: AOUpUlHhsgNVBDMx1ksgszXCZcfAypS35pDX9/Zm+qJ0u+qSV1EIjSuG
        GSSqaB8/GST7lUzktttlTXjwmA==
X-Google-Smtp-Source: AAOMgpeUTEj7KUgeUoFwIox8ImspIia1RUG+g1W0W2qhAXrbayvZulrdHmin2ra7//9tGqCfGxmgZg==
X-Received: by 2002:ac8:302e:: with SMTP id f43-v6mr5706477qte.217.1531922026773;
        Wed, 18 Jul 2018 06:53:46 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id r4-v6sm1748630qtm.10.2018.07.18.06.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 06:53:45 -0700 (PDT)
Date:   Wed, 18 Jul 2018 09:56:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180718135633.GA5161@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718124627.GD2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718124627.GD2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

thanks for the feedback so far, I'll get to the other emails
later. I'm currently running A/B tests against our production traffic
to get uptodate numbers in particular on the optimizations you
suggested for the cacheline packing, time_state(), ffs() etc.

On Wed, Jul 18, 2018 at 02:46:27PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> 
> > +static inline void psi_enqueue(struct task_struct *p, u64 now, bool wakeup)
> > +{
> > +	int clear = 0, set = TSK_RUNNING;
> > +
> > +	if (psi_disabled)
> > +		return;
> > +
> > +	if (!wakeup || p->sched_psi_wake_requeue) {
> > +		if (p->flags & PF_MEMSTALL)
> > +			set |= TSK_MEMSTALL;
> > +		if (p->sched_psi_wake_requeue)
> > +			p->sched_psi_wake_requeue = 0;
> > +	} else {
> > +		if (p->in_iowait)
> > +			clear |= TSK_IOWAIT;
> > +	}
> > +
> > +	psi_task_change(p, now, clear, set);
> > +}
> > +
> > +static inline void psi_dequeue(struct task_struct *p, u64 now, bool sleep)
> > +{
> > +	int clear = TSK_RUNNING, set = 0;
> > +
> > +	if (psi_disabled)
> > +		return;
> > +
> > +	if (!sleep) {
> > +		if (p->flags & PF_MEMSTALL)
> > +			clear |= TSK_MEMSTALL;
> > +	} else {
> > +		if (p->in_iowait)
> > +			set |= TSK_IOWAIT;
> > +	}
> > +
> > +	psi_task_change(p, now, clear, set);
> > +}
> 
> > +/**
> > + * psi_memstall_enter - mark the beginning of a memory stall section
> > + * @flags: flags to handle nested sections
> > + *
> > + * Marks the calling task as being stalled due to a lack of memory,
> > + * such as waiting for a refault or performing reclaim.
> > + */
> > +void psi_memstall_enter(unsigned long *flags)
> > +{
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +
> > +	if (psi_disabled)
> > +		return;
> > +
> > +	*flags = current->flags & PF_MEMSTALL;
> > +	if (*flags)
> > +		return;
> > +	/*
> > +	 * PF_MEMSTALL setting & accounting needs to be atomic wrt
> > +	 * changes to the task's scheduling state, otherwise we can
> > +	 * race with CPU migration.
> > +	 */
> > +	rq = this_rq_lock_irq(&rf);
> > +
> > +	update_rq_clock(rq);
> > +
> > +	current->flags |= PF_MEMSTALL;
> > +	psi_task_change(current, rq_clock(rq), 0, TSK_MEMSTALL);
> > +
> > +	rq_unlock_irq(rq, &rf);
> > +}
> 
> I'm confused by this whole MEMSTALL thing... I thought the idea was to
> account the time we were _blocked_ because of memstall, but you seem to
> count the time we're _running_ with PF_MEMSTALL.

Under heavy memory pressure, a lot of active CPU time is spent
scanning and rotating through the LRU lists, which we do want to
capture in the pressure metric. What we really want to know is the
time in which CPU potential goes to waste due to a lack of
resources. That's the CPU going idle due to a memstall, but it's also
a CPU doing *work* which only occurs due to a lack of memory. We want
to know about both to judge how productive system and workload are.

> And esp. the wait_on_page_bit_common caller seems performance sensitive,
> and the above function is quite expensive.

Right, but we don't call it on every invocation, only when waiting for
the IO to read back a page that was recently deactivated and evicted:

	if (bit_nr == PG_locked &&
	    !PageUptodate(page) && PageWorkingset(page)) {
		if (!PageSwapBacked(page))
			delayacct_thrashing_start();
		psi_memstall_enter(&pflags);
		thrashing = true;
	}

That means the page cache workingset/file active list is thrashing, in
which case the IO itself is our biggest concern, not necessarily a few
additional cycles before going to sleep to wait on its completion.
