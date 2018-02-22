Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeBVQhU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:37:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933187AbeBVQhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:37:19 -0500
Date: Thu, 22 Feb 2018 17:37:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <20180222163715.GA1485@redhat.com>
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22, Prashant Bhole wrote:
>
> Hi,
> I encountered following BUG caught by KASAN with recent kernels when trying
> out [BCC project] bcc/testing/python/test_usdt2.py
> Tried with v4.12, it was reproducible.
>
> --- KASAN log ---
> BUG: KASAN: use-after-free in uprobe_perf_close+0x118/0x1a0
> Read of size 4 at addr ffff8800bb2db4cc by task test_usdt2.py/1265
>
> CPU: 2 PID: 1265 Comm: test_usdt2.py Not tainted 4.16.0-rc2-next-20180220+
> #38
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26
> 04/01/2014
> Call Trace:
>  dump_stack+0x5c/0x80
>  print_address_description+0x73/0x290
>  kasan_report+0x257/0x380
>  ? uprobe_perf_close+0x118/0x1a0
>  uprobe_perf_close+0x118/0x1a0

...

> Freed by task 1265:
>  __kasan_slab_free+0x135/0x180
>  kmem_cache_free+0xaf/0x230
>  rcu_process_callbacks+0x559/0xd90
>  __do_softirq+0x125/0x3a2

Hmm. this looks strange, I do not see no __put_task_struct/free_task in this
trace... OK, nevermind.

> After debugging, found that uprobe_perf_close() is called after task has
> been terminated and uprobe_perf_close() tries to access task_struct of the
> terminated process.

Oh. You can't imagine how much I forgot this code ;) I will recheck, but at
first glance you are right. We can't rely on _free_event()->put_ctx() which
does put_task_struct() after event->destroy(), the exiting task does
put_task_struct(current) itself and sets child_ctx->task = TASK_TOMBSTONE in
perf_event_exit_task_context().

In short, nothing protects event->hw.target. But uprobe_perf_open() should be
safe, perf_init_event() is called when the caller has the additional reference.

I am wondering if this was wrong from the very beginning or it was broken later,
but I won't even try to check.

>  static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event
> *event)
>  {
> +    int err = 0;
>      bool done;
> 
>      write_lock(&tu->filter.rwlock);
> @@ -1054,9 +1055,12 @@ static int uprobe_perf_close(struct trace_uprobe *tu,
> struct perf_event *event)
>      write_unlock(&tu->filter.rwlock);
> 
>      if (!done)
> -        return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> +        err =  uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> 
> -    return 0;
> +    if (event->hw.target)
> +        put_task_struct(event->hw.target);
> +
> +    return err;
>  }

No need to delay put_task_struct(), you can call it right after "done = ..."
in the "if (event->hw.target)" block and simplify this change.

However. Probably this is the simplest fix, but it doesn't look nice. We do not
really need task_struct, we need its ->mm. PF_EXITING check can be removed, this
is a minor optimization.

perhaps we can add _something_ like

	struct mm_struct *uprobe_event_mm(event)
	{
		// needs rcu_read_lock/READ_ONCE/etc
		if (event->ctx &&
		    event->ctx->task && event->ctx->task != TASK_TOMBSTONE)
			return event->ctx->task->mm;

		return NULL;
	}

and use it instead of event->hw.target->mm ... Not sure.


And. What about other users of event->hw.target? Say, task_bp_pinned(). It doesn't
dereference this pointer, How can we trust the result of "iter->hw.target == tsk"
if hw.target can be freed and then re-alloced?


This all makes me think that we should change (fix) kernel/events/core.c...

Oleg.
