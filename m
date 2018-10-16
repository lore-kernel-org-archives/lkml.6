Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2BA21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IiyxgTxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2BA21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJQB70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:59:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34908 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yvRNrCSdTLqOXCM5XMPwZCjPpjGvsObaKQ8lLycjv30=; b=IiyxgTxiKKHzzcLF4bsaIOb3b
        3izi0pCKYMA+QjjO+/H0nGJpZU9GJTqXFz/Oi+IxltVR5uhok7Qu/9d1dxP6txX2UqA0kzhp58dj4
        VbwXpijvnUWq6E5XaZfyaEX3tBVgbIJ9sCZKn6s6bSpU4szFEZBQNQmXGO9o3R/as8D6ZBYoQGa4x
        05fHaULBvXMQY54iDlkw1SQ2LqNLwE5BP9G4jEpcJKn9nqE4UchzFWm42+zDTBW7akznCpqozA+7o
        Nti43V/5Z+du9GhvVN3TKe4qB5kUxKn/w+Qm/xVRIcuQkYGpBeUm0hcUntF7zX+sFdAR8eASE+Yq3
        CiofIh1eA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCTkd-0004Lw-R9; Tue, 16 Oct 2018 18:07:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B90082029900B; Tue, 16 Oct 2018 20:07:24 +0200 (CEST)
Date:   Tue, 16 Oct 2018 20:07:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, megha.dey@intel.com,
        frederic@kernel.org, nd@arm.com
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181016180724.GC3121@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <20181016162645.ymtuk6qqz65sg7bt@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016162645.ymtuk6qqz65sg7bt@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:26:45PM +0100, Mark Rutland wrote:
> On Wed, Oct 10, 2018 at 12:45:59PM +0200, Peter Zijlstra wrote:

> > +struct perf_event_pmu_context {
> > +	struct pmu			*pmu;
> > +	struct perf_event_context 	*ctx;
> > +
> > +	struct list_head		pmu_ctx_entry;
> > +
> > +	struct list_head		pinned_active;
> > +	struct list_head		flexible_active;
> > +
> > +	unsigned int			embedded : 1;
> 
> Is this just for lifetime management (i.e. not attempting to free the
> embedded epc)?

IIRC, yes.

> Do we need a flag? Can't we have the pmu hold a ref on its embedded epc,
> and init that at pmu init time?

IIRC, we do two things when we hit 0, we remove the pmu_ctx_entry and we
free. I thing we still want to do the first, but want to avoid the
second.

> > @@ -723,20 +761,21 @@ struct perf_event_context {
> >  	 */
> >  	struct mutex			mutex;
> >  
> > -	struct list_head		active_ctx_list;
> > +	struct list_head		pmu_ctx_list;
> > +
> >  	struct perf_event_groups	pinned_groups;
> >  	struct perf_event_groups	flexible_groups;
> >  	struct list_head		event_list;
> 
> I think that the groups lists and event list should be in the
> perf_event_pmu_context.
>
> That would make scheduling and rotating events a per-pmu thing, as we
> want, without complicating the RB tree logic or requiring additional
> hooks.

I didn't think that RB tree logic was particularly complicated.

> That may make the move_group case more complicated, though.
> 
> ... and maybe I've missed some other headache with that?

move_group not I think, the locking is per perf_event_context, and
changing perf_event::ctx is tricky, but outside of that not so much.

> > -	struct list_head		pinned_active;
> > -	struct list_head		flexible_active;
> > -
> >  	int				nr_events;
> >  	int				nr_active;
> >  	int				is_active;
> > +
> > +	int				nr_task_data;
> >  	int				nr_stat;
> >  	int				nr_freq;
> >  	int				rotate_disable;
> 
> Likewise these all seem to be PMU-specific (though I guess we care about
> them in the ctx-switch fast paths?).

nr_active and nr_events were also useful on a ctx wide basis IIRC, thw
nr_{stat,freq} thing are boolean gates, not sure we win much by breaking
that up into per-pmu.

The rotate_disable, yes, that should be per PMU I suppose.

> > @@ -1528,6 +1498,11 @@ perf_event_groups_less(struct perf_event
> >  	if (left->cpu > right->cpu)
> >  		return false;
> >  
> > +	if (left->pmu_ctx->pmu < right->pmu_ctx->pmu)
> > +		return true;
> > +	if (left->pmu_ctx->pmu > right->pmu_ctx->pmu)
> > +		return false;
> > +
> >  	if (left->group_index < right->group_index)
> >  		return true;
> >  	if (left->group_index > right->group_index)
> > @@ -1610,7 +1585,7 @@ del_event_from_groups(struct perf_event
> >   * Get the leftmost event in the @cpu subtree.
> >   */
> >  static struct perf_event *
> > -perf_event_groups_first(struct perf_event_groups *groups, int cpu)
> > +perf_event_groups_first(struct perf_event_groups *groups, int cpu, struct pmu *pmu)
> >  {
> >  	struct perf_event *node_event = NULL, *match = NULL;
> >  	struct rb_node *node = groups->tree.rb_node;
> > @@ -1623,8 +1598,19 @@ perf_event_groups_first(struct perf_even
> >  		} else if (cpu > node_event->cpu) {
> >  			node = node->rb_right;
> >  		} else {
> > -			match = node_event;
> > -			node = node->rb_left;
> > +			if (pmu) {
> > +				if (pmu < node_event->pmu_ctx->pmu) {
> > +					node = node->rb_left;
> > +				} else if (pmu > node_event->pmu_ctx->pmu) {
> > +					node = node->rb_right;
> > +				} else  {
> > +					match = node_event;
> > +					node = node->rb_left;
> > +				}
> > +			} else {
> > +				match = node_event;
> > +				node = node->rb_left;
> > +			}
> >  		}
> >  	}
> >  
> > @@ -1635,13 +1621,17 @@ perf_event_groups_first(struct perf_even
> >   * Like rb_entry_next_safe() for the @cpu subtree.
> >   */
> >  static struct perf_event *
> > -perf_event_groups_next(struct perf_event *event)
> > +perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
> >  {
> >  	struct perf_event *next;
> >  
> >  	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
> > -	if (next && next->cpu == event->cpu)
> > +	if (next && next->cpu == event->cpu) {
> > +		if (pmu && next->pmu_ctx->pmu != pmu)
> > +			return NULL;
> > +
> >  		return next;
> > +	}
> >  
> >  	return NULL;
> >  }
> 
> This would be much nicer with a per-pmu event_list.

So I was thinking we'd want to easily find the events for a particular
PMU, stuffing them into the perf_event_pmu_context makes that much
harder.

(also, there's an XXX in perf_tp_event() where this capability makes
sense)

In fact, I was planning on making it more complicated still :-) So that
we can optimize the case where merge_sched_in() has saturated a PMU, to
then quickly find the next PMU without having to iterate all
intermediate events.

See the below patch..

Also, a threaded RB tree might speed up the whole iteration. We could
finally bite the bullet and implement that in the generic RB tree code,
or just fake it (again) by adding an additional list.


> > +	// XXX premature; what if this is allowed, but we get moved to a PMU
> > +	// that doesn't have this.
> >  	if (is_sampling_event(event)) {
> >  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
> >  			err = -EOPNOTSUPP;
> 
> Ugh, could that happen for SW events moved into a HW context?

I _think_ all SW events support sampling. And since we do not allow
changing anything but SW events, this might just work.


---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1585,7 +1585,7 @@ del_event_from_groups(struct perf_event
  * Get the leftmost event in the @cpu subtree.
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu, struct pmu *pmu)
+perf_event_groups_first(struct perf_event_groups *groups, int cpu, struct pmu *pmu, bool next)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
@@ -1601,7 +1601,8 @@ perf_event_groups_first(struct perf_even
 			if (pmu) {
 				if (pmu < node_event->pmu_ctx->pmu) {
 					node = node->rb_left;
-				} else if (pmu > node_event->pmu_ctx->pmu) {
+				} else if (pmu > node_event->pmu_ctx->pmu ||
+					   (next && pmu == node_event->pmu_ctx->pmu)) {
 					node = node->rb_right;
 				} else  {
 					match = node_event;
@@ -3274,10 +3275,12 @@ visit_groups_merge(struct perf_event_gro
 		   int (*func)(struct perf_event *, void *), void *data)
 {
 	struct perf_event **evt, *evt1, *evt2;
+	bool next = false;
 	int ret;
 
-	evt1 = perf_event_groups_first(groups, -1, pmu);
-	evt2 = perf_event_groups_first(groups, cpu, pmu);
+again:
+	evt1 = perf_event_groups_first(groups, -1, pmu, next);
+	evt2 = perf_event_groups_first(groups, cpu, pmu, next);
 
 	while (evt1 || evt2) {
 		if (evt1 && evt2) {
@@ -3292,9 +3295,15 @@ visit_groups_merge(struct perf_event_gro
 		}
 
 		ret = func(*evt, data);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
+		if (ret > 0) {
+			pmu = (*evt)->pmu_ctx->pmu;
+			next = true;
+			goto again;
+		}
+
 		*evt = perf_event_groups_next(*evt, pmu);
 	}
 
@@ -3386,7 +3395,7 @@ ctx_flexible_sched_in(struct perf_event_
 {
 	struct sched_in_data sid = {
 		.ctx = ctx,
-		.busy = pmu ? -EBUSY : 0,
+		.busy = pmu ? -EBUSY : 1,
 	};
 
 	visit_groups_merge(&ctx->flexible_groups, smp_processor_id(), pmu,
