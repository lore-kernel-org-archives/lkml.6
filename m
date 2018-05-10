Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756602AbeEJFS0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 01:18:26 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:35154 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756407AbeEJFSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 01:18:25 -0400
X-Google-Smtp-Source: AB8JxZqNNTXtVGQWyhodY16EHTlHTEpaqit8ntj4c30JaBMhu9qnB0nbfn0JQ3s4xtTkCEIHIYMPKw+dfNsILINK4EA=
MIME-Version: 1.0
In-Reply-To: <001a1140589435c9b60563c76e3f@google.com>
References: <001a1140589435c9b60563c76e3f@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 10 May 2018 07:18:03 +0200
Message-ID: <CACT4Y+bVG7eoLWndM3McQpf3FN+JxEm9Xyrg0H0gg6UiUFC62A@mail.gmail.com>
Subject: Re: WARNING in event_function_local
To: syzbot <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        abderrahmane.benbachir@polymtl.ca
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2018 at 8:58 PM, syzbot
<syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on bpf-next commit
> 8223967fe0b8eb2448cca5cfe3c64a0838e6f60d (Sat Jan 27 01:06:23 2018 +0000)
> Merge branch 'fix-lpm-map'
>
> So far this crash happened 2 times on bpf-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


This was bisected to:

commit 4ee7c60de83ac01fa4c33c55937357601631e8ad
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Fri Mar 23 10:18:03 2018 -0400

    init, tracing: Add initcall trace events



> WARNING: CPU: 1 PID: 5105 at kernel/events/core.c:331
> event_function_local.constprop.102+0x494/0x560 kernel/events/core.c:331
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 5105 Comm: syzkaller318382 Not tainted 4.15.0-rc8+ #8
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1096
> RIP: 0010:event_function_local.constprop.102+0x494/0x560
> kernel/events/core.c:331
> RSP: 0018:ffff8801db307d00 EFLAGS: 00010006
> RAX: ffff8801d902a180 RBX: ffff8801d60beac0 RCX: ffffffff81862a54
> RDX: 0000000000010000 RSI: ffff8801db3079f0 RDI: ffff8801d60bebc8
> RBP: ffff8801db307da0 R08: 1ffff1003b660edf R09: 000000000000000c
> R10: ffff8801db307bb8 R11: 0000000000000044 R12: ffff8801db330e00
> R13: 1ffff1003b660fa3 R14: ffff8801d90841c0 R15: ffff8801d979ce40
>  perf_event_disable_local kernel/events/core.c:1979 [inline]
>  perf_pending_event+0x1e5/0x240 kernel/events/core.c:5446
>  irq_work_run_list+0x184/0x240 kernel/irq_work.c:155
>  irq_work_run+0x1d/0x50 kernel/irq_work.c:170
>  smp_irq_work_interrupt+0x103/0x640 arch/x86/kernel/irq_work.c:21
>  irq_work_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:968
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:777
> [inline]
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160
> [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x5e/0xba
> kernel/locking/spinlock.c:184
> RSP: 0018:ffff8801d4727670 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff09
> RAX: dffffc0000000000 RBX: 0000000000000282 RCX: 0000000000000000
> RDX: 1ffffffff0d5918d RSI: 0000000000000001 RDI: 0000000000000282
> RBP: ffff8801d4727680 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d9084978
> R13: ffff8801d9084978 R14: ffff8801d90841c0 R15: 0000000000000001
>  try_to_wake_up+0xf9/0x1600 kernel/sched/core.c:2082
>  wake_up_process kernel/sched/core.c:2151 [inline]
>  wake_up_q+0x8a/0xe0 kernel/sched/core.c:469
>  futex_wake+0x572/0x680 kernel/futex.c:1574
>  do_futex+0x11b0/0x22a0 kernel/futex.c:3549
>  SYSC_futex kernel/futex.c:3605 [inline]
>  SyS_futex+0x260/0x390 kernel/futex.c:3573
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x446159
> RSP: 002b:00007ffe873e8f78 EFLAGS: 00000202 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 00007f9b83c81700 RCX: 0000000000446159
> RDX: 0000000000446159 RSI: 0000000000000001 RDI: 00000000006debe4
> RBP: 00007ffe873e8fa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ffe873e8eff R14: 00007f9b83c819c0 R15: 0000000000000004
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.15.0-rc8+ #8 Not tainted
> ------------------------------------------------------
> syzkaller318382/5105 is trying to acquire lock:
>  ((console_sem).lock){-.-.}, at: [<000000003463de8d>] down_trylock+0x13/0x70
> kernel/locking/semaphore.c:136
>
> but task is already holding lock:
>  (&ctx->lock){-.-.}, at: [<00000000c5b20a00>] perf_ctx_lock
> kernel/events/core.c:157 [inline]
>  (&ctx->lock){-.-.}, at: [<00000000c5b20a00>]
> event_function_local.constprop.102+0x20e/0x560 kernel/events/core.c:318
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (&ctx->lock){-.-.}:
>        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
>        perf_event_context_sched_out kernel/events/core.c:2879 [inline]
>        __perf_event_task_sched_out+0x9b6/0x14b0 kernel/events/core.c:2971
>        perf_event_task_sched_out include/linux/perf_event.h:1085 [inline]
>        prepare_task_switch kernel/sched/core.c:2592 [inline]
>        context_switch kernel/sched/core.c:2764 [inline]
>        __schedule+0xd5c/0x2060 kernel/sched/core.c:3375
>        schedule+0xf5/0x430 kernel/sched/core.c:3434
>        freezable_schedule include/linux/freezer.h:172 [inline]
>        futex_wait_queue_me+0x3ed/0x7e0 kernel/futex.c:2548
>        futex_wait+0x34b/0x9a0 kernel/futex.c:2663
>        do_futex+0x11ec/0x22a0 kernel/futex.c:3545
>        SYSC_futex kernel/futex.c:3605 [inline]
>        SyS_futex+0x260/0x390 kernel/futex.c:3573
>        entry_SYSCALL_64_fastpath+0x29/0xa0
>
> -> #2 (&rq->lock){-.-.}:
>        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
>        rq_lock kernel/sched/sched.h:1766 [inline]
>        task_fork_fair+0x7a/0x690 kernel/sched/fair.c:9449
>        sched_fork+0x435/0xc00 kernel/sched/core.c:2404
>        copy_process.part.38+0x174b/0x4b20 kernel/fork.c:1722
>        copy_process kernel/fork.c:1565 [inline]
>        _do_fork+0x1f7/0xfe0 kernel/fork.c:2044
>        kernel_thread+0x34/0x40 kernel/fork.c:2106
>        rest_init+0x22/0xf0 init/main.c:402
>        start_kernel+0x7f1/0x819 init/main.c:716
>        x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>        x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
>
> -> #1 (&p->pi_lock){-.-.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        try_to_wake_up+0xbc/0x1600 kernel/sched/core.c:1988
>        wake_up_process+0x10/0x20 kernel/sched/core.c:2151
>        __up.isra.0+0x1cc/0x2c0 kernel/locking/semaphore.c:262
>        up+0x13b/0x1d0 kernel/locking/semaphore.c:187
>        __up_console_sem+0xb2/0x1a0 kernel/printk/printk.c:245
>        console_unlock+0x538/0xd80 kernel/printk/printk.c:2248
>        vprintk_emit+0x4ad/0x590 kernel/printk/printk.c:1757
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1796
>        vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
>        printk+0xaa/0xca kernel/printk/printk.c:1829
>        regdb_fw_cb+0x1d7/0x220 net/wireless/reg.c:886
>        request_firmware_work_func+0x151/0x2c0
> drivers/base/firmware_class.c:1365
>        process_one_work+0xbbf/0x1b10 kernel/workqueue.c:2113
>        worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>        kthread+0x33c/0x400 kernel/kthread.c:238
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:541
>
> -> #0 ((console_sem).lock){-.-.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3914
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>        __down_trylock_console_sem+0xa2/0x1e0 kernel/printk/printk.c:228
>        console_trylock+0x15/0x100 kernel/printk/printk.c:2065
>        vprintk_emit+0x49b/0x590 kernel/printk/printk.c:1756
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1796
>        vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
>        printk+0xaa/0xca kernel/printk/printk.c:1829
>        __warn+0x9e/0x200 kernel/panic.c:529
>        report_bug+0x211/0x2d0 lib/bug.c:184
>        fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>        fixup_bug arch/x86/kernel/traps.c:247 [inline]
>        do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>        do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>        invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1096
>        event_function_local.constprop.102+0x494/0x560
> kernel/events/core.c:331
>        perf_event_disable_local kernel/events/core.c:1979 [inline]
>        perf_pending_event+0x1e5/0x240 kernel/events/core.c:5446
>        irq_work_run_list+0x184/0x240 kernel/irq_work.c:155
>        irq_work_run+0x1d/0x50 kernel/irq_work.c:170
>        smp_irq_work_interrupt+0x103/0x640 arch/x86/kernel/irq_work.c:21
>        irq_work_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:968
>        arch_local_irq_restore arch/x86/include/asm/paravirt.h:777 [inline]
>        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160
> [inline]
>        _raw_spin_unlock_irqrestore+0x5e/0xba kernel/locking/spinlock.c:184
>        try_to_wake_up+0xf9/0x1600 kernel/sched/core.c:2082
>        wake_up_process kernel/sched/core.c:2151 [inline]
>        wake_up_q+0x8a/0xe0 kernel/sched/core.c:469
>        futex_wake+0x572/0x680 kernel/futex.c:1574
>        do_futex+0x11b0/0x22a0 kernel/futex.c:3549
>        SYSC_futex kernel/futex.c:3605 [inline]
>        SyS_futex+0x260/0x390 kernel/futex.c:3573
>        entry_SYSCALL_64_fastpath+0x29/0xa0
>
> other info that might help us debug this:
>
> Chain exists of:
>   (console_sem).lock --> &rq->lock --> &ctx->lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&ctx->lock);
>                                lock(&rq->lock);
>                                lock(&ctx->lock);
>   lock((console_sem).lock);
>
>  *** DEADLOCK ***
>
> 2 locks held by syzkaller318382/5105:
>  #0:  (&cpuctx_lock){-.-.}, at: [<0000000091388292>] perf_ctx_lock
> kernel/events/core.c:155 [inline]
>  #0:  (&cpuctx_lock){-.-.}, at: [<0000000091388292>]
> event_function_local.constprop.102+0x1f7/0x560 kernel/events/core.c:318
>  #1:  (&ctx->lock){-.-.}, at: [<00000000c5b20a00>] perf_ctx_lock
> kernel/events/core.c:157 [inline]
>  #1:  (&ctx->lock){-.-.}, at: [<00000000c5b20a00>]
> event_function_local.constprop.102+0x20e/0x560 kernel/events/core.c:318
>
> stack backtrace:
> CPU: 1 PID: 5105 Comm: syzkaller318382 Not tainted 4.15.0-rc8+ #8
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_circular_bug.isra.37+0x2cd/0x2dc kernel/locking/lockdep.c:1218
>  check_prev_add kernel/locking/lockdep.c:1858 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1971 [inline]
>  validate_chain kernel/locking/lockdep.c:2412 [inline]
>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3426
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3914
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>  __down_trylock_console_sem+0xa2/0x1e0 kernel/printk/printk.c:228
>  console_trylock+0x15/0x100 kernel/printk/printk.c:2065
>  vprintk_emit+0x49b/0x590 kernel/printk/printk.c:1756
>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1796
>  vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
>  printk+0xaa/0xca kernel/printk/printk.c:1829
>  __warn+0x9e/0x200 kernel/panic.c:529
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1096
> RIP: 0010:event_function_local.constprop.102+0x494/0x560
> kernel/events/core.c:331
> RSP: 0018:ffff8801db307d00 EFLAGS: 00010006
> RAX: ffff8801d902a180 RBX: ffff8801d60beac0 RCX: ffffffff81862a54
> RDX: 0000000000010000 RSI: ffff8801db3079f0 RDI: ffff8801d60bebc8
> RBP: ffff8801db307da0 R08: 1ffff1003b660edf R09: 000000000000000c
> R10: ffff8801db307bb8 R11: 0000000000000044 R12: ffff8801db330e00
> R13: 1ffff1003b660fa3 R14: ffff8801d90841c0 R15: ffff8801d979ce40
>  perf_event_disable_local kernel/events/core.c:1979 [inline]
>  perf_pending_event+0x1e5/0x240 kernel/events/core.c:5446
>  irq_work_run_list+0x184/0x240 kernel/irq_work.c:155
>  irq_work_run+0x1d/0x50 kernel/irq_work.c:170
>  smp_irq_work_interrupt+0x103/0x640 arch/x86/kernel/irq_work.c:21
>  irq_work_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:968
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:777
> [inline]
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160
> [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x5e/0xba
> kernel/locking/spinlock.c:184
> RSP: 0018:ffff8801d4727670 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff09
> RAX: dffffc0000000000 RBX: 0000000000000282 RCX: 0000000000000000
> RDX: 1ffffffff0d5918d RSI: 0000000000000001 RDI: 0000000000000282
> RBP: ffff8801d4727680 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d9084978
> R13: ffff8801d9084978 R14: ffff8801d90841c0 R15: 0000000000000001
>  try_to_wake_up+0xf9/0x1600 kernel/sched/core.c:2082
>  wake_up_process kernel/sched/core.c:2151 [inline]
>  wake_up_q+0x8a/0xe0 kernel/sched/core.c:469
>  futex_wake+0x572/0x680 kernel/futex.c:1574
>  do_futex+0x11b0/0x22a0 kernel/futex.c:3549
>  SyS_futex
> Lost 13 message(s)!
> Shutting down cpus with NMI
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1140589435c9b60563c76e3f%40google.com.
> For more options, visit https://groups.google.com/d/optout.
