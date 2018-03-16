Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbeCPMHT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:07:19 -0400
Received: from foss.arm.com ([217.140.101.70]:55024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPMHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:07:18 -0400
Date: Fri, 16 Mar 2018 12:07:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>, tglx@linutronix.de,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, kan.liang@intel.com, eranian@google.com,
        davidcc@google.com, valery.cherepennikov@intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [PATCH] perf: Fix sibling iteration
Message-ID: <20180316120709.7tg6p5pxpu3zdzfx@lakrids.cambridge.arm.com>
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
 <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
 <20180316103129.GC4064@hirez.programming.kicks-ass.net>
 <20180316103946.GA6960@krava>
 <20180316105017.GD4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316105017.GD4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:50:17AM +0100, Peter Zijlstra wrote:
> On Fri, Mar 16, 2018 at 11:39:46AM +0100, Jiri Olsa wrote:
> > On Fri, Mar 16, 2018 at 11:31:29AM +0100, Peter Zijlstra wrote:

> > > There is at least one more known issue with that patch, but neither Mark
> > > nor me could reproduce so far, so we don't know if we're right about the
> > > cause.
> > 
> > is there more info about that issue? I could try it
> 
> Find below, 0day report didn't go out to lkml. We think moving the
> list_del_init() out from the !RB_NODE_EMPTY() test might fix, but since
> we can't repro so far, its all guesses.

I've managed to reproduce this using the 0day scripts. From the 0day
logs, it looks like it's possible to hit it ~6% of the time.

I added a WARN_ON(RB_NODE_EMPTY(...)), and I see that fire in the exit
path:

[   76.287197]  perf_remove_from_context+0x9a/0xc0
[   76.287552]  perf_event_release_kernel+0x214/0x3e0
[   76.287928]  ? _raw_spin_unlock+0x8/0x10
[   76.288237]  ? locks_remove_file+0x219/0x230
[   76.288572]  perf_release+0xe/0x20
[   76.288842]  __fput+0x1c9/0x340
[   76.289089]  ____fput+0x8/0x10
[   76.289332]  task_work_run+0x9a/0xd0
[   76.289613]  do_exit+0x6cc/0x1220
[   76.289877]  ? __might_sleep+0xcb/0x150
[   76.290183]  do_group_exit+0x96/0x110
[   76.290473]  get_signal+0x8c3/0xb60
[   76.290750]  ? __perf_event_task_sched_in+0x20d/0x250
[   76.291143]  do_signal+0x19/0x950
[   76.291408]  ? finish_task_switch+0x212/0x480
[   76.291750]  ? __switch_to+0x414/0x730
[   76.292051]  ? _raw_spin_unlock_irqrestore+0x45/0x60
[   76.292439]  ? trace_hardirqs_on+0x63/0x100
[   76.292769]  ? prepare_to_wait_event+0x23a/0x250
[   76.293132]  ? do_int80_syscall_32+0x271/0x290
[   76.293478]  exit_to_usermode_loop+0xb9/0x190
[   76.293819]  do_int80_syscall_32+0x271/0x290
[   76.294161]  entry_INT80_32+0x36/0x36

... then we subsequently hit the initial splat, which looks promisingly
like our initial theory.

However, I don't currently understand how we can see a group leader with
an empty RB node in this path. I can only see that being the case for
siblings that we promoted to being leaders, and those should have an
empty list at the point we promote them...

Thanks,
Mark.
