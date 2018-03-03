Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeCCP0n (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:26:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43006 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeCCP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:26:42 -0500
Date: Sat, 3 Mar 2018 16:26:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, kernel-team@fb.com
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
Message-ID: <20180303152631.GF25201@hirez.programming.kicks-ass.net>
References: <20180301195321.2608515-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301195321.2608515-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:53:21AM -0800, Song Liu wrote:
> When there are more perf_event's than hardware PMCs, perf rotate events
> so that all events get chance to run. Currently, the rotation works as:
>   sched_out flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
>   rotate_left flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
>   try sched_in flexible_groups in cpuctx->ctx;
>   try sched_in flexible_groups in cpuctx->task_ctx.
> 
> This approach has some potential issues:
>   1. if different rotations of flexible_groups in cpuctx->ctx occupy
>      all hardware PMC, flexible_groups in cpuctx->task_ctx cannot run
>      at all.
>   2. if pinned_groups occupy all hardware PMC, the rotation triggers per
>      perf_event_mux_interval_ms. But it couldn't schedule any events.
>   3. since flexible_groups in cpuctx->ctx and cpuctx->task_ctx are
>      rotated separately, there are N x M possible combinations. It is
>      difficult to remember all the rotation combinations and reuse these
>      combinations. As a result, it is necessary to try sched_in the
>      flexible_groups on each rotation.
> 
> This patch tries to do the rotation differently. Each perf_event in the
> cpuctx (ctx and task_ctx) is assigned a rotation_id. The rotation_id's
> are assigned during the first few rotations after any changes in
> perf_events attached to the cpuctx. Once all the rotation_id's are
> assigned for all events in the cpuctx, perf_rotate_context() simply
> picks the next rotation to use, so there is no more "try to sched_in"
> for future rotations.

I'm not following.

> Special rotation_id's are introduced to handle the issues above.
> flexible_groups that conflicts with pinned_groups are marked as
> ALWAYS_OFF, so they are not rotated (fixes issue 2). flexible_groups
> in cpuctx->ctx and cpuctx->task_ctx are rotated together, so they all get
> equal chance to run (improves issue 1).

I can't say I particularly care about 2, that's a really daft situation
to get into. And changing 1 needs careful consideration.

> With this approach, we only do complex scheduling of flexible_groups
> once. This enables us to do more complex schduling, for example, Sharing
> PMU counters across compatible events:
>    https://lkml.org/lkml/2017/12/1/410.
> 
> There are also some potential downsides of this approach.
> 
> First, it gives all flexible_groups exactly same chance to run, so it
> may waste some PMC cycles. For examples, if 5 groups, ABCDE, are assigned
> to two rotations: rotation-0: ABCD and rotation-1: E, this approach will
> NOT try any of ABCD in rotation-1.

Yeah, that doesn't look acceptable. In fact, people already complained
about the current scheme not being optimal, what you propose is _far_
worse.

> Second, flexible_groups in cpuctx->ctx and cpuctx->task_ctx now have
> exact same priority and equal chance to run. I am not sure whether this
> will change the behavior in some use cases.
> 
> Please kindly let me know whether this approach makes sense.

What you've not said is, and what is not at all clear, is if your scheme
preserved fairness.


In any case, there's a ton of conflict against the patches here:

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/testing

And with those the idea was to move to a virtual time based scheduler
(basically schedule those flexible events that have the biggest lag --
that also solves 1).
