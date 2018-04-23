Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeDWCCJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:02:09 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:41328 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeDWCCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:02:04 -0400
X-Google-Smtp-Source: AIpwx49jxVZxzpNzESRlnEAQ+C33E8bhrFBHnwg5TCZFZS5qR90UlQqhrXYiEjRE0TKTy5dFuD1TlxyvaMYp6aWYdEfymtbkZAK1
MIME-Version: 1.0
Date: Sun, 22 Apr 2018 19:02:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008eb847056a7a6c62@google.com>
Subject: WARNING: inconsistent lock state
From: syzbot <syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gs051095@gmail.com, lauraa@codeaurora.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
285848b0f4074f04ab606f1e5dca296482033d54 (Sun Apr 22 04:20:48 2018 +0000)
Merge tag 'random_for_linus_stable' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=9de458f6a5e713ee8c1a

So far this crash happened 5 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6519507346522112
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5629774336622592
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6244468109869056
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)

================================
WARNING: inconsistent lock state
4.17.0-rc1+ #12 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
         (ptrval) (fs_reclaim){?.+.}, at:  
fs_reclaim_acquire.part.82+0x0/0x30 mm/page_alloc.c:463
{HARDIRQ-ON-W} state was registered at:
   lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
   fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
   fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
   slab_pre_alloc_hook mm/slab.h:418 [inline]
   slab_alloc_node mm/slab.c:3299 [inline]
   kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
   kmalloc_node include/linux/slab.h:550 [inline]
   kzalloc_node include/linux/slab.h:712 [inline]
   alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
   init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
   init_rescuer kernel/workqueue.c:3997 [inline]
   workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
   kernel_init_freeable+0x2ad/0x58e init/main.c:1115
   kernel_init+0x11/0x1b3 init/main.c:1053
   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
irq event stamp: 393358
hardirqs last  enabled at (393355): [<ffffffff876e8d1d>]  
default_idle+0x8d/0x440 arch/x86/kernel/process.c:354
hardirqs last disabled at (393356): [<ffffffff87800905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (393358): [<ffffffff81471abc>]  
_local_bh_enable+0x1c/0x30 kernel/softirq.c:155
softirqs last disabled at (393357): [<ffffffff81474e40>]  
irq_enter+0xa0/0xd0 kernel/softirq.c:351

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(fs_reclaim);
   <Interrupt>
     lock(fs_reclaim);

  *** DEADLOCK ***

no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.17.0-rc1+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_usage_bug.cold.59+0x320/0x41a kernel/locking/lockdep.c:2542
  valid_state kernel/locking/lockdep.c:2555 [inline]
  mark_lock_irq kernel/locking/lockdep.c:2749 [inline]
  mark_lock+0x1034/0x19e0 kernel/locking/lockdep.c:3147
  mark_irqflags kernel/locking/lockdep.c:3022 [inline]
  __lock_acquire+0x1595/0x5140 kernel/locking/lockdep.c:3388
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
  fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
  slab_pre_alloc_hook mm/slab.h:418 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x45/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  numa_crng_init drivers/char/random.c:798 [inline]
  crng_reseed+0x427/0x920 drivers/char/random.c:923
  credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
  add_interrupt_randomness+0x494/0x860 drivers/char/random.c:1254
  handle_irq_event_percpu+0xf9/0x1c0 kernel/irq/handle.c:191
  handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
  handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
  generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
  handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
  do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
RSP: 0018:ffffffff88c07bc0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffda
RAX: dffffc0000000000 RBX: 1ffffffff1180f7b RCX: 0000000000000000
RDX: 1ffffffff11a3130 RSI: 0000000000000001 RDI: ffffffff88d18980
RBP: ffffffff88c07bc0 R08: ffffed003b5c46c3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88c07c78 R14: ffffffff897be9e0 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x440 arch/x86/kernel/process.c:354
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:345
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x395/0x560 kernel/sched/idle.c:262
  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:441
  start_kernel+0x906/0x92d init/main.c:737
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/0
INFO: lockdep is turned off.
irq event stamp: 393358
hardirqs last  enabled at (393355): [<ffffffff876e8d1d>]  
default_idle+0x8d/0x440 arch/x86/kernel/process.c:354
hardirqs last disabled at (393356): [<ffffffff87800905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (393358): [<ffffffff81471abc>]  
_local_bh_enable+0x1c/0x30 kernel/softirq.c:155
softirqs last disabled at (393357): [<ffffffff81474e40>]  
irq_enter+0xa0/0xd0 kernel/softirq.c:351
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.17.0-rc1+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  ___might_sleep.cold.87+0x11f/0x13a kernel/sched/core.c:6188
  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x2b9/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  numa_crng_init drivers/char/random.c:798 [inline]
  crng_reseed+0x427/0x920 drivers/char/random.c:923
  credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
  add_interrupt_randomness+0x494/0x860 drivers/char/random.c:1254
  handle_irq_event_percpu+0xf9/0x1c0 kernel/irq/handle.c:191
  handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
  handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
  generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
  handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
  do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
RSP: 0018:ffffffff88c07bc0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffda
RAX: dffffc0000000000 RBX: 1ffffffff1180f7b RCX: 0000000000000000
RDX: 1ffffffff11a3130 RSI: 0000000000000001 RDI: ffffffff88d18980
RBP: ffffffff88c07bc0 R08: ffffed003b5c46c3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88c07c78 R14: ffffffff897be9e0 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x440 arch/x86/kernel/process.c:354
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:345
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x395/0x560 kernel/sched/idle.c:262
  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:441
  start_kernel+0x906/0x92d init/main.c:737
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
random: crng init done


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
