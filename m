Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbeDPI7E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:59:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:53724 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754101AbeDPI7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:59:02 -0400
X-Google-Smtp-Source: AIpwx48vVX3UszwB5vKIDZjNNc1DhjB4x4VyHLzfMdFbdASen8m2mGHNpHYqzmxWOMVhQDNx5jIF6tHohuQoKX3jojEphjtkxSYT
MIME-Version: 1.0
Date: Mon, 16 Apr 2018 01:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e894e30569f36ee8@google.com>
Subject: INFO: rcu detected stall in select_collect
From: syzbot <syzbot+5c73ae1814a4a5f3f31b@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
48023102b7078a6674516b1fe0d639669336049d (Fri Apr 13 23:55:41 2018 +0000)
Merge branch 'overlayfs-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=5c73ae1814a4a5f3f31b

So far this crash happened 4 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6222684371288064
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8852471259444315113
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5c73ae1814a4a5f3f31b@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched detected stalls on CPUs/tasks:
	(detected by 0, t=125007 jiffies, g=10417, c=10416, q=290)
All QSes seen, last rcu_sched kthread activity 125014  
(4294860146-4294735132), jiffies_till_next_fqs=3, root ->qsmask 0x0
syz-executor6   R  running task    21784  4569   4561 0x00000008
Call Trace:
  <IRQ>
  sched_show_task.cold.87+0x27a/0x301 kernel/sched/core.c:5325
  print_other_cpu_stall.cold.79+0x92f/0x9d2 kernel/rcu/tree.c:1481
  check_cpu_stall.isra.61+0x706/0xf50 kernel/rcu/tree.c:1599
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
RIP: 0010:__sanitizer_cov_trace_pc+0x14/0x50 kernel/kcov.c:94
RSP: 0018:ffff88018d8bf8d8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
RAX: ffff88018d8b4580 RBX: 1ffff10031b17f20 RCX: ffffffff81c1f494
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88018d8bf8d8 R08: ffff88018d8b4580 R09: ffffed003b527e70
R10: ffffed003b527e70 R11: ffff8801da93f383 R12: ffff88018d8bfbf0
R13: ffff8801da93f300 R14: ffff88018d8bfbf8 R15: ffff88018d8bf9a0
  select_collect+0x267/0x5f0 fs/dcache.c:1451
  d_walk+0x3c3/0xc80 fs/dcache.c:1276
  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
  vfs_rmdir+0x202/0x470 fs/namei.c:3850
  do_rmdir+0x523/0x610 fs/namei.c:3911
  SYSC_rmdir fs/namei.c:3929 [inline]
  SyS_rmdir+0x1a/0x20 fs/namei.c:3927
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455087
RSP: 002b:00007ffe0e80b288 EFLAGS: 00000206 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000455087
RDX: 0000000000000000 RSI: 00007ffe0e80d030 RDI: 00007ffe0e80d030
RBP: 00007ffe0e80d030 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000006 R11: 0000000000000206 R12: 0000000000fa5940
R13: 0000000000000000 R14: 0000000000000117 R15: 0000000000010850
rcu_sched kthread starved for 125603 jiffies! g10417 c10416 f0x2  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=1
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23896     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411


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
