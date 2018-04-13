Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeDMHgD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:36:03 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:38896 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753597AbeDMHgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:36:01 -0400
X-Google-Smtp-Source: AIpwx4+DGqqz/vACJ1W1QXhVnVXHhF0aiC5fkbaPZATd/r3G28bdW961UHwICpSU9lR8ErYwI9rTeGrq0xRBy9R91FPeKrEli3kA
MIME-Version: 1.0
Date: Fri, 13 Apr 2018 00:36:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <089e082bb5107aa0f80569b5ec2b@google.com>
Subject: INFO: rcu detected stall in _raw_spin_unlock
From: syzbot <syzbot+de49a4f1661f0fa54bc3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
c17b0aadb7d8f87de56a4a374a8131519c0f7422 (Thu Apr 12 16:15:48 2018 +0000)
Merge tag 'asm-generic' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=de49a4f1661f0fa54bc3

So far this crash happened 10 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5619415949246464
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de49a4f1661f0fa54bc3@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	1-...!: (124999 ticks this GP) idle=38a/1/4611686018427387906  
softirq=93096/93096 fqs=10
	 (t=125000 jiffies g=50926 c=50925 q=111)
rcu_sched kthread starved for 124957 jiffies! g50926 c50925 f0x0  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23224     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
NMI backtrace for cpu 1
CPU: 1 PID: 4528 Comm: syz-executor6 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1376
  print_cpu_stall kernel/rcu/tree.c:1525 [inline]
  check_cpu_stall.isra.61.cold.80+0x36c/0x59a kernel/rcu/tree.c:1593
  __rcu_pending kernel/rcu/tree.c:3356 [inline]
  rcu_pending kernel/rcu/tree.c:3401 [inline]
  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:173
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1283
  __run_hrtimer kernel/time/hrtimer.c:1386 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1448
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1506
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:lock_release+0x4ed/0xa10 kernel/locking/lockdep.c:3929
RSP: 0018:ffff880197d67880 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffffed0032facf15 RCX: 1ffff10032fab1e5
RDX: 1ffffffff11630ed RSI: 0000000000000005 RDI: 0000000000000282
RBP: ffff880197d679b0 R08: 1ffff10032facf19 R09: ffff880197d67708
R10: 0000000000000003 R11: 0000000000000004 R12: ffff880197d58700
R13: ffff8801b232b238 R14: ffff880197d58700 R15: ffff880197d678c8
  __raw_spin_unlock include/linux/spinlock_api_smp.h:150 [inline]
  _raw_spin_unlock+0x1a/0x30 kernel/locking/spinlock.c:176
  spin_unlock include/linux/spinlock.h:350 [inline]
  d_walk+0x451/0xc80 fs/dcache.c:1298
  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
  vfs_rmdir+0x202/0x470 fs/namei.c:3850
  do_rmdir+0x523/0x610 fs/namei.c:3911
  SYSC_rmdir fs/namei.c:3929 [inline]
  SyS_rmdir+0x1a/0x20 fs/namei.c:3927
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454fe7
RSP: 002b:00007ffcd2c8f458 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000454fe7
RDX: 0000000000000000 RSI: 00007ffcd2c91200 RDI: 00007ffcd2c91200
RBP: 00007ffcd2c91200 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000000a R11: 0000000000000202 R12: 0000000000c63940
R13: 0000000000000000 R14: 00000000000005bc R15: 000000000004f52f


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
