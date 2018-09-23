Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681A2C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1164208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1164208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeIWWLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:11:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeIWWLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 804BB308624C;
        Sun, 23 Sep 2018 16:13:46 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DA33CDBD5;
        Sun, 23 Sep 2018 16:13:44 +0000 (UTC)
Date:   Sun, 23 Sep 2018 18:13:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Andrew Vagin <avagin@openvz.org>
Subject: [PATCHv2] perf: Prevent concurent ring buffer access
Message-ID: <20180923161343.GB15054@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913093754.GV24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 23 Sep 2018 16:13:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:37:54AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 13, 2018 at 09:46:07AM +0200, Jiri Olsa wrote:
> > On Thu, Sep 13, 2018 at 09:07:40AM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 12, 2018 at 09:33:17PM +0200, Jiri Olsa wrote:
> > > > Some of the scheduling tracepoints allow the perf_tp_event
> > > > code to write to ring buffer under different cpu than the
> > > > code is running on.
> > > 
> > > ARGH.. that is indeed borken.
> 
> > I was first thinking to just leave it on the current cpu,
> > but not sure current users would be ok with that ;-)
> 
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index abaed4f8bb7f..9b534a2ecf17 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8308,6 +8308,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
> >  				continue;
> >  			if (event->attr.config != entry->type)
> >  				continue;
> > +			if (event->cpu != smp_processor_id())
> > +				continue;
> >  			if (perf_tp_event_match(event, &data, regs))
> >  				perf_swevent_event(event, count, &data, regs);
> >  		}
> 
> That might indeed be the best we can do.
> 
> So the whole TP muck would be responsible for placing only matching
> events on the hlist, which is where our normal CPU filter is I think.
> 
> The above then does the same for @task. Which without this would also be
> getting nr_cpus copies of the event I think.
> 
> It does mean not getting any events if the @task only has a per-task
> buffer, but there's nothing to be done about that. And I'm not even sure
> we can create a useful warning for that :/

ok, sending full patch (v2) with above change

cc-ing Andrew Vagin who added this feature,
because this patch change the way it works

thanks,
jirka


---
Some of the scheduling tracepoints allow the perf_tp_event
code to write to ring buffer under different cpu than the
code is running on.

This results in corrupted ring buffer data demonstrated in
following perf commands:

  # perf record -e 'sched:sched_switch,sched:sched_wakeup' perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.383 [sec]
  [ perf record: Woken up 8 times to write data ]
  0x42b890 [0]: failed to process type: -1765585640
  [ perf record: Captured and wrote 4.825 MB perf.data (29669 samples) ]

  # perf report --stdio
  0x42b890 [0]: failed to process type: -1765585640

The reason for the corruptions are some of the scheduling tracepoints,
that have __perf_task dfined and thus allow to store data to another
cpu ring buffer:

  sched_waking
  sched_wakeup
  sched_wakeup_new
  sched_stat_wait
  sched_stat_sleep
  sched_stat_iowait
  sched_stat_blocked

The perf_tp_event function first store samples for current cpu
related events defined for tracepoint:

    hlist_for_each_entry_rcu(event, head, hlist_entry)
      perf_swevent_event(event, count, &data, regs);

And then iterates events of the 'task' and store the sample
for any task's event that passes tracepoint checks:

  ctx = rcu_dereference(task->perf_event_ctxp[perf_sw_context]);

  list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
    if (event->attr.type != PERF_TYPE_TRACEPOINT)
      continue;
    if (event->attr.config != entry->type)
      continue;

    perf_swevent_event(event, count, &data, regs);
  }

Above code can race with same code running on another cpu,
ending up with 2 cpus trying to store under the same ring
buffer, which is not handled at the moment.

This patch prevents the race, by allowing only events
with the same current cpu to receive the event.

Fixes: e6dab5ffab59 ("perf/trace: Add ability to set a target task for events")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c80549bf82c6..f269f666510c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8308,6 +8308,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (event->cpu != smp_processor_id())
+				continue;
 			if (event->attr.type != PERF_TYPE_TRACEPOINT)
 				continue;
 			if (event->attr.config != entry->type)
-- 
2.17.1

