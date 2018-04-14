Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeDNJp1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 05:45:27 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:37134 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeDNJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 05:45:25 -0400
X-Google-Smtp-Source: AIpwx49ahFE7s5W2JorDb+RThRtWkmDfZIw2k/k1Q7jIdncCEbKq+g4V/gvWWwW+OhyR6H5sZClcMwaq9EMltNk+kBA=
MIME-Version: 1.0
In-Reply-To: <0000000000008c36c90569cbd09d@google.com>
References: <0000000000008c36c90569cbd09d@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 14 Apr 2018 11:45:03 +0200
Message-ID: <CACT4Y+ZTBTRyvY6PHQ19XtC1DFtsx0DZYdaw8K-P5C0e79VXDw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in shrink_dentry_list
To: syzbot <syzbot+9275da3e0f734e102b61@syzkaller.appspotmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 11:43 AM, syzbot
<syzbot+9275da3e0f734e102b61@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 16e205cf42da1f497b10a4a24f563e6c0d574eec (Fri Apr 13 03:56:10 2018 +0000)
> Merge tag 'drm-fixes-for-v4.17-rc1' of
> git://people.freedesktop.org/~airlied/linux
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=9275da3e0f734e102b61
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=4692036947017728
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9275da3e0f734e102b61@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


#syz dup: INFO: rcu detected stall in d_walk


> INFO: rcu_sched self-detected stall on CPU
>         1-...!: (124995 ticks this GP) idle=b86/1/4611686018427387906
> softirq=32196/32196 fqs=3
>          (t=125000 jiffies g=16751 c=16750 q=347)
> rcu_sched kthread starved for 124987 jiffies! g16751 c16750 f0x0
> RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=1
> RCU grace-period kthread stack dump:
> rcu_sched       R  running task    23544     9      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2848 [inline]
>  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
>  schedule+0xef/0x430 kernel/sched/core.c:3549
>  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
>  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
> NMI backtrace for cpu 1
> CPU: 1 PID: 4559 Comm: syz-executor6 Not tainted 4.16.0+ #2
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1376
>  print_cpu_stall kernel/rcu/tree.c:1525 [inline]
>  check_cpu_stall.isra.61.cold.80+0x36c/0x59a kernel/rcu/tree.c:1593
>  __rcu_pending kernel/rcu/tree.c:3356 [inline]
>  rcu_pending kernel/rcu/tree.c:3401 [inline]
>  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:173
>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1283
>  __run_hrtimer kernel/time/hrtimer.c:1386 [inline]
>  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1448
>  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1506
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
>  </IRQ>
> RIP: 0010:__sanitizer_cov_trace_pc+0x14/0x50 kernel/kcov.c:94
> RSP: 0018:ffff88018e2e7a80 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: ffff88018e2de680 RBX: ffff88018e2e7bf8 RCX: ffffffff81c2b1d9
> RDX: 0000000000000000 RSI: ffffffff81c26bf3 RDI: ffff88018e2e7bf8
> RBP: ffff88018e2e7a80 R08: ffff88018e2de680 R09: ffffed003b51c378
> R10: ffffed003b51c378 R11: ffff8801da8e1bc3 R12: ffff88018e2e7c30
> R13: dffffc0000000000 R14: 1ffff10031c5cf7e R15: ffffed0031c5cf81
>  shrink_dentry_list+0x5a8/0x7c0 fs/dcache.c:1087
>  shrink_dcache_parent+0xba/0x230 fs/dcache.c:1490
>  vfs_rmdir+0x202/0x470 fs/namei.c:3850
>  do_rmdir+0x523/0x610 fs/namei.c:3911
>  SYSC_rmdir fs/namei.c:3929 [inline]
>  SyS_rmdir+0x1a/0x20 fs/namei.c:3927
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x455087
> RSP: 002b:00007fff8b6b76b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000054
> RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000455087
> RDX: 0000000000000000 RSI: 00007fff8b6b9460 RDI: 00007fff8b6b9460
> RBP: 00007fff8b6b9460 R08: 0000000000000000 R09: 0000000000000001
> R10: 000000000000000a R11: 0000000000000206 R12: 0000000002768940
> R13: 0000000000000000 R14: 00000000000001ec R15: 000000000001984e
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008c36c90569cbd09d%40google.com.
> For more options, visit https://groups.google.com/d/optout.
