Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeDQGUN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:20:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750831AbeDQGUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:20:12 -0400
Date: Tue, 17 Apr 2018 08:20:10 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
Message-ID: <20180417062010.GA2052@krava>
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:04:53PM +0000, Stephane Eranian wrote:
> Hi,
> 
> I am trying to understand what the exclude_idle event attribute is supposed
> to accomplish.
> As per the definition in the header file:
> 
>     exclude_idle   :  1, /* don't count when idle */
> 
> Naively, I thought it would simply stop the event when running in the
> context of the idle task (swapper, pid 0) on any CPU. That would seem to
> match the succinct description.
> 
> However, running a simple:
> 
> $ perf record -a -e cycles:I sleep 5
> perf_event_attr:
>     sample_type                      IP|TID|TIME|CPU|PERIOD
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID
>    exclude_idle                     1
> 
> on an idle machine, showed me that this is not what is actually happening:
> $ perf  script
>           swapper     0 [000] 1132634.287442:          1 cycles:I:
>   ffffffff8100b1fb __intel_pmu_enable_all.isra.17 ([kernel.kallsyms])
>           swapper     0 [001] 1132634.287498:          1 cycles:I:
>   ffffffff8100b1fb __intel_pmu_enable_all.isra.17 ([kernel.kallsyms])
> 
> 
> After looking at the code, it all made sense, it seems to current
> implementation is only relevant for sw events. I don't understand why.

AFAICS it's not implemented

Peter suggested some time ago change for cpu-clock (attached)
I still have it in my queue, because it gives funny numbers
sometimes.. and I haven't figured it out so far

the idea so far was to use cpu-clock,cpu-clock:I events to
count and display idle % in perf top/record and stat metrics

jirka


---
>From 7f20b047cf56f8086d79007175592633798656ce Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 23 Nov 2017 16:15:36 +0100
Subject: [PATCH] perf: Add support to monitor idle time on cpu-clock

Adding support to use perf_event_attr::exclude_idle
(the :I modifierr in perf tools)to monitor idle time
on cpu-clock event.

Link: http://lkml.kernel.org/n/tip-jw45kl6ydrhzqx4uxws0qsqb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c     | 22 ++++++++++++++++++----
 kernel/sched/idle_task.c | 17 +++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2989e3b0fe8b..62c0dc75ed11 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9391,19 +9391,33 @@ static void perf_swevent_init_hrtimer(struct perf_event *event)
  * Software event: cpu wall time clock
  */
 
+static u64 cpu_clock_count(struct perf_event *event)
+{
+	u64 now = local_clock();
+
+	if (event->attr.exclude_idle)
+		now -= idle_task(event->oncpu)->se.sum_exec_runtime;
+
+	return now;
+}
+
 static void cpu_clock_event_update(struct perf_event *event)
 {
-	s64 prev;
+	s64 prev, delta;
 	u64 now;
 
-	now = local_clock();
+	now = cpu_clock_count(event);
 	prev = local64_xchg(&event->hw.prev_count, now);
-	local64_add(now - prev, &event->count);
+	delta = now - prev;
+	if (delta > 0)
+		local64_add(delta, &event->count);
 }
 
 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
-	local64_set(&event->hw.prev_count, local_clock());
+	u64 now = cpu_clock_count(event);
+
+	local64_set(&event->hw.prev_count, now);
 	perf_swevent_start_hrtimer(event);
 }
 
diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
index d518664cce4f..e360ce5dd9a2 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -27,9 +27,14 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
+	struct task_struct *idle = rq->idle;
+
 	put_prev_task(rq, prev);
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+
+	idle->se.exec_start = rq_clock_task(rq);
+
 	return rq->idle;
 }
 
@@ -48,6 +53,15 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	struct task_struct *idle = rq->idle;
+	u64 delta, now;
+
+	now = rq_clock_task(rq);
+	delta = now - idle->se.exec_start;
+	if (likely((s64)delta > 0))
+		idle->se.sum_exec_runtime += delta;
+	idle->se.exec_start = now;
+
 	rq_last_tick_reset(rq);
 }
 
@@ -57,6 +71,9 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 
 static void set_curr_task_idle(struct rq *rq)
 {
+	struct task_struct *idle = rq->idle;
+
+	idle->se.exec_start = rq_clock_task(rq);
 }
 
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
-- 
2.13.6
