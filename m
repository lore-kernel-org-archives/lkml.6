Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeBBT1T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:27:19 -0500
Received: from foss.arm.com ([217.140.101.70]:35694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751959AbeBBT1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:27:11 -0500
Date: Fri, 2 Feb 2018 19:27:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org, efault@gmx.de, tglx@linutronix.de,
        mingo@kernel.org, alexander.levin@verizon.com
Subject: Runqueue spinlock recursion on arm64 v4.15
Message-ID: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While fuzzing arm64 v4.15 with Syzkaller, I intermittently hit spinlock
recursion splats, around one or two a day. This looks like the same
issue Sasha hit on x86 a number of months back [1].

I've been seeing this for a few releases, but haven't had any luck
tracking it down, or generating a minimized reproducer.

I've dumped my kernel config, Syzkaller logs and reports to my
kernel.org webspace [2].

The most common case looks like:

--------
BUG: spinlock recursion on CPU#1, syz-executor1/1521
 lock: 0xffff80001a764080, .magic: dead4ead, .owner: syz-executor1/1521, .owner_cpu: 0
CPU: 1 PID: 1521 Comm: syz-executor1 Not tainted 4.15.0 #3
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x330 arch/arm64/kernel/time.c:52
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:151
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0xd0/0x120 lib/dump_stack.c:53
 spin_dump+0x150/0x1f0 kernel/locking/spinlock_debug.c:67
 spin_bug kernel/locking/spinlock_debug.c:75 [inline]
 debug_spin_lock_before kernel/locking/spinlock_debug.c:84 [inline]
 do_raw_spin_lock+0x1e4/0x250 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_lock+0x44/0x50 kernel/locking/spinlock.c:144
 __task_rq_lock+0xc0/0x288 kernel/sched/core.c:103
 wake_up_new_task+0x384/0x798 kernel/sched/core.c:2465
 _do_fork+0x1b4/0xa78 kernel/fork.c:2069
 SYSC_clone kernel/fork.c:2154 [inline]
 SyS_clone+0x48/0x60 kernel/fork.c:2132
 el0_svc_naked+0x20/0x24
--------

... though I see this in other paths, e.g. one identical to Sasha's
report:

--------
BUG: spinlock recursion on CPU#0, kworker/u9:4/7741
 lock: 0xffff80001a783080, .magic: dead4ead, .owner: kworker/u9:4/7741, .owner_cpu: 1
CPU: 0 PID: 7741 Comm: kworker/u9:4 Not tainted 4.15.0 #3
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound call_usermodehelper_exec_work
Call trace:
 dump_backtrace+0x0/0x330 arch/arm64/kernel/time.c:52
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:151
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0xd0/0x120 lib/dump_stack.c:53
 spin_dump+0x150/0x1f0 kernel/locking/spinlock_debug.c:67
 spin_bug kernel/locking/spinlock_debug.c:75 [inline]
 debug_spin_lock_before kernel/locking/spinlock_debug.c:84 [inline]
 do_raw_spin_lock+0x1e4/0x250 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_lock+0x44/0x50 kernel/locking/spinlock.c:144
 rq_lock kernel/sched/sched.h:1766 [inline]
 ttwu_queue kernel/sched/core.c:1863 [inline]
 try_to_wake_up+0x6c0/0xa58 kernel/sched/core.c:2078
 default_wake_function+0x30/0x50 kernel/sched/core.c:3628
 __wake_up_common+0x128/0x470 kernel/sched/wait.c:97
 __wake_up_locked+0x18/0x20 kernel/sched/wait.c:158
 complete+0x68/0x90 kernel/sched/completion.c:39
 umh_complete+0x40/0xa8 kernel/umh.c:55
 call_usermodehelper_exec_sync kernel/umh.c:152 [inline]
 call_usermodehelper_exec_work+0x160/0x240 kernel/umh.c:175
 process_one_work+0x590/0xe90 kernel/workqueue.c:2113
 worker_thread+0x3b0/0xd30 kernel/workqueue.c:2247
 kthread+0x2a4/0x378 kernel/kthread.c:238
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:994
--------

... in some cases, owner_cpu is -1, so I guess we're racing with an
unlock. I only ever see this on the runqueue locks in wake up functions.

I'm at a loss as to how we can see a stale owner value that matches
current. If current held the lock in the past, it would have stored -1
to owner first, and at least this should be visible.

Any ideas?

My best guess so far is that this is happening when a task_struct gets
freed and reallocated, and we're somehow missing a release-acquire
relationship. i.e. task A releases the lock on cpu X, dies, then A's
task_struct gets reallocated for task B cpu Y, without all of A's stores
on cpu X having been made visible to B on cpu Y.

>From a scan of the kmem_cache code, that seems unlikely, though. AFAICT
free and allocation have to occur on the same CPU, so that ordering
should be given by the combination of local CPU order and whatever
barriers switch_to() has...

Maybe it's possible to detect that by hacking a task generation number
into each task struct, and embedding this into the lock's owner field. I
can try hacking that up next week.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20170604070911.5sx66m5xnoh2amyd@sasha-lappy
[2] https://www.kernel.org/pub/linux/kernel/people/mark/bugs/20180202-rq-spinlock-recursion/
