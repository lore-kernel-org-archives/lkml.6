Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA00C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA112087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA112087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJKCBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbeJKCBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:01:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EA74C04F4D6;
        Wed, 10 Oct 2018 18:37:50 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4644D600C4;
        Wed, 10 Oct 2018 18:37:49 +0000 (UTC)
Date:   Wed, 10 Oct 2018 14:37:47 -0400
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch] sched/fair: Avoid throttle_list starvation with low cfs
 quota
Message-ID: <20181010183747.GE7852@pauld.bos.csb>
References: <20181008143639.GA4019@pauld.bos.csb>
 <20181009083244.GA51643@gmail.com>
 <xm26in29wv2y.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26in29wv2y.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 10 Oct 2018 18:37:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:49:25AM -0700 bsegall@google.com wrote:
> Ingo Molnar <mingo@kernel.org> writes:
> 
> > I've Cc:-ed a handful of gents who worked on CFS bandwidth details to widen the discussion. 
> > Patch quoted below.
> >
> > Looks like a real bug that needs to be fixed - and at first sight the quota of 1000 looks very 
> > low - could we improve the arithmetics perhaps?
> >
> > A low quota of 1000 is used because there's many VMs or containers provisioned on the system 
> > that is triggering the bug, right?
> >
> > Thanks,
> >
> > 	Ingo
> >
> > * Phil Auld <pauld@redhat.com> wrote:
> >
> >> From: "Phil Auld" <pauld@redhat.com>
> >> 
> >> sched/fair: Avoid throttle_list starvation with low cfs quota
> >> 
> >> With a very low cpu.cfs_quota_us setting, such as the minimum of 1000, 
> >> distribute_cfs_runtime may not empty the throttled_list before it runs 
> >> out of runtime to distribute. In that case, due to the change from 
> >> c06f04c7048 to put throttled entries at the head of the list, later entries 
> >> on the list will starve.  Essentially, the same X processes will get pulled 
> >> off the list, given CPU time and then, when expired, get put back on the 
> >> head of the list where distribute_cfs_runtime will give runtime to the same 
> >> set of processes leaving the rest.
> >> 
> >> Fix the issue by setting a bit in struct cfs_bandwidth when 
> >> distribute_cfs_runtime is running, so that the code in throttle_cfs_rq can 
> >> decide to put the throttled entry on the tail or the head of the list.  The 
> >> bit is set/cleared by the callers of distribute_cfs_runtime while they hold 
> >> cfs_bandwidth->lock. 
> >> 
> >> Signed-off-by: Phil Auld <pauld@redhat.com>
> >> Fixes: c06f04c70489 ("sched: Fix potential near-infinite distribute_cfs_runtime() loop")
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@kernel.org>
> >> Cc: stable@vger.kernel.org
> 
> Reviewed-by: Ben Segall <bsegall@google.com>
> 
> 
> In theory this does mean the unfairness could still happen if distribute is still
> running, but while a tiny quota makes it more likely, the fact that
> we're not getting through much of the list makes it not really a worry.
> If you wanted to be even more careful there could be some generation
> counter or something, but it doesn't seem necessary.
> 

Thanks for the review.  Yeah, I thought about a few other approaches, not explicitly
what you suggested, but they all complicated things. This one seemed the closest to 
"obviously correct".


Cheers,
Phil


> 
> >> ---
> >> 
> >> This is easy to reproduce with a handful of cpu consumers. I use crash on 
> >> the live system. In some cases you can simply look at the throttled list and 
> >> see the later entries are not changing:
> >> 
> >> crash> list cfs_rq.throttled_list -H 0xffff90b54f6ade40 -s cfs_rq.runtime_remaining | paste - - | awk '{print $1"  "$4}' | pr -t -n3
> >>   1     ffff90b56cb2d200  -976050
> >>   2     ffff90b56cb2cc00  -484925
> >>   3     ffff90b56cb2bc00  -658814
> >>   4     ffff90b56cb2ba00  -275365
> >>   5     ffff90b166a45600  -135138
> >>   6     ffff90b56cb2da00  -282505
> >>   7     ffff90b56cb2e000  -148065
> >>   8     ffff90b56cb2fa00  -872591
> >>   9     ffff90b56cb2c000  -84687
> >>  10     ffff90b56cb2f000  -87237
> >>  11     ffff90b166a40a00  -164582
> >> crash> list cfs_rq.throttled_list -H 0xffff90b54f6ade40 -s cfs_rq.runtime_remaining | paste - - | awk '{print $1"  "$4}' | pr -t -n3
> >>   1     ffff90b56cb2d200  -994147
> >>   2     ffff90b56cb2cc00  -306051
> >>   3     ffff90b56cb2bc00  -961321
> >>   4     ffff90b56cb2ba00  -24490
> >>   5     ffff90b166a45600  -135138
> >>   6     ffff90b56cb2da00  -282505
> >>   7     ffff90b56cb2e000  -148065
> >>   8     ffff90b56cb2fa00  -872591
> >>   9     ffff90b56cb2c000  -84687
> >>  10     ffff90b56cb2f000  -87237
> >>  11     ffff90b166a40a00  -164582
> >> 
> >> Sometimes it is easier to see by finding a process getting starved and looking 
> >> at the sched_info:
> >> 
> >> crash> task ffff8eb765994500 sched_info
> >> PID: 7800   TASK: ffff8eb765994500  CPU: 16  COMMAND: "cputest"
> >>   sched_info = {
> >>     pcount = 8, 
> >>     run_delay = 697094208, 
> >>     last_arrival = 240260125039, 
> >>     last_queued = 240260327513
> >>   }, 
> >> crash> task ffff8eb765994500 sched_info
> >> PID: 7800   TASK: ffff8eb765994500  CPU: 16  COMMAND: "cputest"
> >>   sched_info = {
> >>     pcount = 8, 
> >>     run_delay = 697094208, 
> >>     last_arrival = 240260125039, 
> >>     last_queued = 240260327513
> >>   }, 
> >> 
> >> 
> >>  fair.c  |   22 +++++++++++++++++++---
> >>  sched.h |    2 ++
> >>  2 files changed, 21 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 7fc4a371bdd2..f88e00705b55 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4476,9 +4476,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> >>  
> >>  	/*
> >>  	 * Add to the _head_ of the list, so that an already-started
> >> -	 * distribute_cfs_runtime will not see us
> >> +	 * distribute_cfs_runtime will not see us. If disribute_cfs_runtime is
> >> +	 * not running add to the tail so that later runqueues don't get starved.
> >>  	 */
> >> -	list_add_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
> >> +	if (cfs_b->distribute_running)
> >> +		list_add_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
> >> +	else
> >> +		list_add_tail_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
> >>
> >>  	/*
> >>  	 * If we're the first throttled task, make sure the bandwidth
> >> @@ -4622,14 +4626,16 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
> >>  	 * in us over-using our runtime if it is all used during this loop, but
> >>  	 * only by limited amounts in that extreme case.
> >>  	 */
> >> -	while (throttled && cfs_b->runtime > 0) {
> >> +	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
> >>  		runtime = cfs_b->runtime;
> >> +		cfs_b->distribute_running = 1;
> >>  		raw_spin_unlock(&cfs_b->lock);
> >>  		/* we can't nest cfs_b->lock while distributing bandwidth */
> >>  		runtime = distribute_cfs_runtime(cfs_b, runtime,
> >>  						 runtime_expires);
> >>  		raw_spin_lock(&cfs_b->lock);
> >>  
> >> +		cfs_b->distribute_running = 0;
> >>  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> >>  
> >>  		cfs_b->runtime -= min(runtime, cfs_b->runtime);
> >> @@ -4740,6 +4746,11 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >>  
> >>  	/* confirm we're still not at a refresh boundary */
> >>  	raw_spin_lock(&cfs_b->lock);
> >> +	if (cfs_b->distribute_running) {
> >> +		raw_spin_unlock(&cfs_b->lock);
> >> +		return;
> >> +	}
> >> +
> >>  	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
> >>  		raw_spin_unlock(&cfs_b->lock);
> >>  		return;
> >> @@ -4749,6 +4760,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >>  		runtime = cfs_b->runtime;
> >>  
> >>  	expires = cfs_b->runtime_expires;
> >> +	if (runtime)
> >> +		cfs_b->distribute_running = 1;
> >> +
> >>  	raw_spin_unlock(&cfs_b->lock);
> >>  
> >>  	if (!runtime)
> >> @@ -4759,6 +4773,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >>  	raw_spin_lock(&cfs_b->lock);
> >>  	if (expires == cfs_b->runtime_expires)
> >>  		cfs_b->runtime -= min(runtime, cfs_b->runtime);
> >> +	cfs_b->distribute_running = 0;
> >>  	raw_spin_unlock(&cfs_b->lock);
> >>  }
> >>  
> >> @@ -4867,6 +4882,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >>  	cfs_b->period_timer.function = sched_cfs_period_timer;
> >>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
> >> +	cfs_b->distribute_running = 0;
> >>  }
> >>  
> >>  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index 455fa330de04..9683f458aec7 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -346,6 +346,8 @@ struct cfs_bandwidth {
> >>  	int			nr_periods;
> >>  	int			nr_throttled;
> >>  	u64			throttled_time;
> >> +
> >> +	bool                    distribute_running;
> >>  #endif
> >>  };
> >>  
> >> 
> >> 
> >> -- 

-- 
