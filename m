Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B674BC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FE520881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FE520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeIMNCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbeIMNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D9DD90C9F;
        Thu, 13 Sep 2018 07:53:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77E971001F40;
        Thu, 13 Sep 2018 07:53:40 +0000 (UTC)
Date:   Thu, 13 Sep 2018 09:53:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] perf: Prevent recursion in ring buffer
Message-ID: <20180913075339.GC15173@krava>
References: <20180912193317.10339-1-jolsa@kernel.org>
 <20180913074042.GU24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913074042.GU24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 07:53:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 09:40:42AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 09:33:17PM +0200, Jiri Olsa wrote:
> 
> >   # perf record -e 'sched:sched_switch,sched:sched_wakeup' perf bench sched messaging
> 
> > The reason for the corruptions are some of the scheduling tracepoints,
> > that have __perf_task dfined and thus allow to store data to another
> > cpu ring buffer:
> > 
> >   sched_waking
> >   sched_wakeup
> >   sched_wakeup_new
> >   sched_stat_wait
> >   sched_stat_sleep
> >   sched_stat_iowait
> >   sched_stat_blocked
> 
> > And then iterates events of the 'task' and store the sample
> > for any task's event that passes tracepoint checks:
> > 
> >   ctx = rcu_dereference(task->perf_event_ctxp[perf_sw_context]);
> > 
> >   list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> >     if (event->attr.type != PERF_TYPE_TRACEPOINT)
> >       continue;
> >     if (event->attr.config != entry->type)
> >       continue;
> > 
> >     perf_swevent_event(event, count, &data, regs);
> >   }
> > 
> > Above code can race with same code running on another cpu,
> > ending up with 2 cpus trying to store under the same ring
> > buffer, which is not handled at the moment.
> 
> It can yes, however the only way I can see this breaking is if we use
> !inherited events with a strict per-task buffer, but your record command
> doesn't use that.
> 
> Now, your test-case uses inherited events, which would all share the
> buffer, however IIRC inherited events require per-task-per-cpu buffers,

that's what perf record always does when monitoring task.. there's
an event/rb for each cpu and the given task

and all events for the task (sched:*) on given cpu share that single
cpu ring buffer via PERF_EVENT_IOC_SET_OUTPUT

> because there is already no guarantee the various tasks run on the same
> CPU in the first place.
> 
> This means we _should_ write to the @task's local CPU buffer, and that
> would work again.
> 
> Let me try and figure out where this is going wrong.
