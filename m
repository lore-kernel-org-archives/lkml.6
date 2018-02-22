Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933586AbeBVRuC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:50:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933441AbeBVRt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:49:59 -0500
Date: Thu, 22 Feb 2018 18:49:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <20180222174956.GB2802@redhat.com>
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
 <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22, Peter Zijlstra wrote:
>
> On Thu, Feb 22, 2018 at 05:37:15PM +0100, Oleg Nesterov wrote:
> > On 02/22, Prashant Bhole wrote:
>
> > > After debugging, found that uprobe_perf_close() is called after task has
> > > been terminated and uprobe_perf_close() tries to access task_struct of the
> > > terminated process.
> >
> > Oh. You can't imagine how much I forgot this code ;) I will recheck, but at
> > first glance you are right. We can't rely on _free_event()->put_ctx() which
> > does put_task_struct() after event->destroy(), the exiting task does
> > put_task_struct(current) itself and sets child_ctx->task = TASK_TOMBSTONE in
> > perf_event_exit_task_context().
> >
> > In short, nothing protects event->hw.target. But uprobe_perf_open() should be
> > safe, perf_init_event() is called when the caller has the additional reference.
> >
> > I am wondering if this was wrong from the very beginning or it was broken later,
> > but I won't even try to check.
>
> b2fe8ba674e8 ("uprobes/perf: Avoid uprobe_apply() whenever possible")
>
> Seems to have added that PF_EXITING test that dereferences the target
> pointer.

Hehe ;) no, I think we should blame another commit 63b6da39bb38e8f1a1ef3180d32a39d6
("perf: Fix perf_event_exit_task() race").

I can be easily wrong, but after perf_event_exit_task_context()->put_task_struct()
added by this commit nothing protects event->hw.target.

And just in case, we can simply remove that PF_EXITING test in uprobe_perf_close(),
this is a minor optimization. But __uprobe_perf_filter() needs a stable ->target too.

Oleg.
