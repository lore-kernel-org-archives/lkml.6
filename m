Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933371AbeBVREj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:04:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbeBVREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:04:38 -0500
Date: Thu, 22 Feb 2018 18:04:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222163715.GA1485@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 05:37:15PM +0100, Oleg Nesterov wrote:
> On 02/22, Prashant Bhole wrote:

> > After debugging, found that uprobe_perf_close() is called after task has
> > been terminated and uprobe_perf_close() tries to access task_struct of the
> > terminated process.
> 
> Oh. You can't imagine how much I forgot this code ;) I will recheck, but at
> first glance you are right. We can't rely on _free_event()->put_ctx() which
> does put_task_struct() after event->destroy(), the exiting task does
> put_task_struct(current) itself and sets child_ctx->task = TASK_TOMBSTONE in
> perf_event_exit_task_context().
> 
> In short, nothing protects event->hw.target. But uprobe_perf_open() should be
> safe, perf_init_event() is called when the caller has the additional reference.
> 
> I am wondering if this was wrong from the very beginning or it was broken later,
> but I won't even try to check.

b2fe8ba674e8 ("uprobes/perf: Avoid uprobe_apply() whenever possible")

Seems to have added that PF_EXITING test that dereferences the target
pointer.

> And. What about other users of event->hw.target? Say, task_bp_pinned(). It doesn't
> dereference this pointer, How can we trust the result of "iter->hw.target == tsk"
> if hw.target can be freed and then re-alloced?

I _think_ that one is ok because it looks at available slots for the
task at init time, at that point the target task must exist.

> This all makes me think that we should change (fix) kernel/events/core.c...

That's going to be mighty dodgy though, holding a reference on the task
will avoid the task from dying which will avoid the events from being
destroyed which will avoid the task from dying which will... if you get
my drift :-)

And I suspect the proposed patch already suffers that problem.
pmu::destroy really should not be looking at that pointer I'm afraid.
