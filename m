Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeDSQEs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:04:48 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:35942 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeDSQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:04:03 -0400
X-Google-Smtp-Source: AIpwx48gRJcEBTzIw7RsfFbFcg2nR3qyVjgTWaUQLEwP0T8m9PDJDMJoTTLSoQUfv4O9BwB13NWBphmEijPCMWX/E60jIp9Hp6lr
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 09:04:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058660a056a35b8d1@google.com>
Subject: general protection fault in __delayacct_blkio_end
From: syzbot <syzbot+aea12292cfdadf454c38@syzkaller.appspotmail.com>
To: bsingharora@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
0b412605ef5f5c64b31f19e2910b1d5eba9929c3 (Thu Mar 29 01:07:23 2018 +0000)
Merge tag 'drm-fixes-for-v4.16-rc8' of  
git://people.freedesktop.org/~airlied/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=aea12292cfdadf454c38

So far this crash happened 19 times on bpf-next, upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5233013176664064
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aea12292cfdadf454c38@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

RBP: 000000000072bea0 R08: 0000000020000300 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 0000000000000018
R13: 0000000000000051 R14: 00000000006f2838 R15: 0000000000000002
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__delayacct_blkio_end+0x4b/0xb0 kernel/delayacct.c:82
RSP: 0018:ffff8801db206ac8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8173aa71
RDX: 0000000000000007 RSI: 0000000000000004 RDI: 0000000000000038
RBP: ffff8801db206ae0 R08: 1ffff1003b640c9b R09: ffff8801bd5425e4
R10: 0000000000000000 R11: ffff8801db206b70 R12: ffff8801db206cb0
R13: ffff8801bd542d38 R14: ffff8801bd542580 R15: ffff8801bd542a0c
FS:  0000000000000000(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c000 CR3: 0000000007a22003 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  delayacct_blkio_end include/linux/delayacct.h:128 [inline]
  try_to_wake_up+0xb7d/0x15f0 kernel/sched/core.c:2060
  default_wake_function+0x30/0x50 kernel/sched/core.c:3693
  autoremove_wake_function+0x78/0x350 kernel/sched/wait.c:377
  wake_bit_function+0xbc/0x140 kernel/sched/wait_bit.c:33
  __wake_up_common+0x18e/0x780 kernel/sched/wait.c:97
  __wake_up_common_lock+0x1b4/0x310 kernel/sched/wait.c:125
  __wake_up+0xe/0x10 kernel/sched/wait.c:149
  __wake_up_bit+0x1a4/0x2a0 kernel/sched/wait_bit.c:124
  wake_up_bit+0x3d/0x40 kernel/sched/wait_bit.c:147
  journal_end_buffer_io_sync+0x82/0xc0 fs/jbd2/commit.c:44
  end_bio_bh_io_sync+0xc5/0x110 fs/buffer.c:2992
  bio_endio+0x447/0x950 block/bio.c:1775
  req_bio_endio block/blk-core.c:208 [inline]
  blk_update_request+0x265/0xda0 block/blk-core.c:2990
  scsi_end_request+0xc8/0x820 drivers/scsi/scsi_lib.c:660
  scsi_io_completion+0x8ab/0x16b0 drivers/scsi/scsi_lib.c:868
  scsi_finish_command+0x5f6/0x890 drivers/scsi/scsi.c:248
  scsi_softirq_done+0x3ab/0x480 drivers/scsi/scsi_lib.c:1653
  __blk_mq_complete_request+0x564/0x990 block/blk-mq.c:559
  blk_mq_complete_request+0x1f6/0x320 block/blk-mq.c:644
  scsi_mq_done+0xd6/0x3c0 drivers/scsi/scsi_lib.c:1964
  virtscsi_complete_cmd+0x489/0x6f0 drivers/scsi/virtio_scsi.c:207
  virtscsi_vq_done+0xc1/0x150 drivers/scsi/virtio_scsi.c:223
  virtscsi_req_done+0xa7/0xd0 drivers/scsi/virtio_scsi.c:238
  vring_interrupt+0x109/0x150 drivers/virtio/virtio_ring.c:951
  __handle_irq_event_percpu+0x1ad/0x9d0 kernel/irq/handle.c:147
  handle_irq_event_percpu+0x98/0x1b0 kernel/irq/handle.c:187
  handle_irq_event+0xa7/0x140 kernel/irq/handle.c:204
  handle_edge_irq+0x1d5/0x7c0 kernel/irq/chip.c:793
  generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
  handle_irq+0x17a/0x300 arch/x86/kernel/irq_64.c:77
  do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:238
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:636
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
RSP: 0018:ffffffff87a07c38 EFLAGS: 00000282 ORIG_RAX: ffffffffffffffda
RAX: dffffc0000000000 RBX: 1ffffffff0f40f8a RCX: 0000000000000000
RDX: 1ffffffff0f59580 RSI: 0000000000000001 RDI: ffffffff87acac00
RBP: ffffffff87a07c38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff87a07cf0 R14: ffffffff883b4820 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xbf/0x430 arch/x86/kernel/process.c:354
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:345
  default_idle_call+0x36/0x90 kernel/sched/idle.c:98
  cpuidle_idle_call kernel/sched/idle.c:156 [inline]
  do_idle+0x24a/0x3b0 kernel/sched/idle.c:246
  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:351
  rest_init+0xed/0xf0 init/main.c:437
  start_kernel+0x7f1/0x819 init/main.c:717
  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
  x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:239
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 6f 48 8b 9b 70 12 00 00 48  
b8 00 00 00 00 00 fc ff df 48 8d 7b 38 48 89 fa 48 c1 ea 03 <0f> b6 04 02  
84 c0 74 04 3c 03 7e 40 f6 43 38 01 75 2b 4c 8d 63
RIP: __delayacct_blkio_end+0x4b/0xb0 kernel/delayacct.c:82 RSP:  
ffff8801db206ac8

======================================================
WARNING: possible circular locking dependency detected
4.16.0-rc7+ #5 Not tainted
------------------------------------------------------
swapper/0/0 is trying to acquire lock:
  ((console_sem).lock){-...}, at: [<000000002b9ce924>]  
down_trylock+0x13/0x70 kernel/locking/semaphore.c:136

but task is already holding lock:
  (&p->pi_lock){-.-.}, at: [<00000000b2df2a41>] try_to_wake_up+0xbc/0x15f0  
kernel/sched/core.c:1989

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xbc/0x15f0 kernel/sched/core.c:1989
        wake_up_process+0x10/0x20 kernel/sched/core.c:2152
        __up.isra.0+0x1cc/0x2c0 kernel/locking/semaphore.c:262
        up+0x13b/0x1d0 kernel/locking/semaphore.c:187
        __up_console_sem+0xb2/0x1a0 kernel/printk/printk.c:242
        console_unlock+0x5af/0xfb0 kernel/printk/printk.c:2417
        do_con_write+0x106e/0x1f70 drivers/tty/vt/vt.c:2433
        con_write+0x25/0xb0 drivers/tty/vt/vt.c:2782
        process_output_block drivers/tty/n_tty.c:579 [inline]
        n_tty_write+0x5ef/0xec0 drivers/tty/n_tty.c:2308
        do_tty_write drivers/tty/tty_io.c:958 [inline]
        tty_write+0x3fa/0x840 drivers/tty/tty_io.c:1042
        __vfs_write+0xef/0x970 fs/read_write.c:480
        vfs_write+0x189/0x510 fs/read_write.c:544
        SYSC_write fs/read_write.c:589 [inline]
        SyS_write+0xef/0x220 fs/read_write.c:581
        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x42/0xb7

-> #0 ((console_sem).lock){-...}:
        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xa2/0x1e0 kernel/printk/printk.c:225
        console_trylock+0x15/0x70 kernel/printk/printk.c:2229
        console_trylock_spinning kernel/printk/printk.c:1643 [inline]
        vprintk_emit+0x5b5/0xb90 kernel/printk/printk.c:1906
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
        printk+0xaa/0xca kernel/printk/printk.c:1980
        kasan_die_handler+0x31/0x3f arch/x86/mm/kasan_init_64.c:247
        notifier_call_chain+0x136/0x2c0 kernel/notifier.c:93
        __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
        atomic_notifier_call_chain+0x77/0x140 kernel/notifier.c:193
        notify_die+0x18c/0x280 kernel/notifier.c:549
        do_general_protection+0x331/0x3e0 arch/x86/kernel/traps.c:558
        general_protection+0x25/0x50 arch/x86/entry/entry_64.S:1150
        __delayacct_blkio_end+0x4b/0xb0 kernel/delayacct.c:82
        delayacct_blkio_end include/linux/delayacct.h:128 [inline]
        try_to_wake_up+0xb7d/0x15f0 kernel/sched/core.c:2060
        default_wake_function+0x30/0x50 kernel/sched/core.c:3693
        autoremove_wake_function+0x78/0x350 kernel/sched/wait.c:377
        wake_bit_function+0xbc/0x140 kernel/sched/wait_bit.c:33
        __wake_up_common+0x18e/0x780 kernel/sched/wait.c:97
        __wake_up_common_lock+0x1b4/0x310 kernel/sched/wait.c:125
        __wake_up+0xe/0x10 kernel/sched/wait.c:149
        __wake_up_bit+0x1a4/0x2a0 kernel/sched/wait_bit.c:124
        wake_up_bit+0x3d/0x40 kernel/sched/wait_bit.c:147
        journal_end_buffer_io_sync+0x82/0xc0 fs/jbd2/commit.c:44
        end_bio_bh_io_sync+0xc5/0x110 fs/buffer.c:2992
        bio_endio+0x447/0x950 block/bio.c:1775
        req_bio_endio block/blk-core.c:208 [inline]
        blk_update_request+0x265/0xda0 block/blk-core.c:2990
        scsi_end_request+0xc8/0x820 drivers/scsi/scsi_lib.c:660
        scsi_io_completion+0x8ab/0x16b0 drivers/scsi/scsi_lib.c:868
        scsi_finish_command+0x5f6/0x890 drivers/scsi/scsi.c:248
        scsi_softirq_done+0x3ab/0x480 drivers/scsi/scsi_lib.c:1653
        __blk_mq_complete_request+0x564/0x990 block/blk-mq.c:559
        blk_mq_complete_request+0x1f6/0x320 block/blk-mq.c:644
        scsi_mq_done+0xd6/0x3c0 drivers/scsi/scsi_lib.c:1964
        virtscsi_complete_cmd+0x489/0x6f0 drivers/scsi/virtio_scsi.c:207
        virtscsi_vq_done+0xc1/0x150 drivers/scsi/virtio_scsi.c:223
        virtscsi_req_done+0xa7/0xd0 drivers/scsi/virtio_scsi.c:238
        vring_interrupt+0x109/0x150 drivers/virtio/virtio_ring.c:951
        __handle_irq_event_percpu+0x1ad/0x9d0 kernel/irq/handle.c:147
        handle_irq_event_percpu+0x98/0x1b0 kernel/irq/handle.c:187
        handle_irq_event+0xa7/0x140 kernel/irq/handle.c:204
        handle_edge_irq+0x1d5/0x7c0 kernel/irq/chip.c:793
        generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
        handle_irq+0x17a/0x300 arch/x86/kernel/irq_64.c:77
        do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:238
        ret_from_intr+0x0/0x1e
        native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
        arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
        default_idle+0xbf/0x430 arch/x86/kernel/process.c:354
        arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:345
        default_idle_call+0x36/0x90 kernel/sched/idle.c:98
        cpuidle_idle_call kernel/sched/idle.c:156 [inline]
        do_idle+0x24a/0x3b0 kernel/sched/idle.c:246
        cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:351
        rest_init+0xed/0xf0 init/main.c:437
        start_kernel+0x7f1/0x819 init/main.c:717
        x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
        x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:239

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->pi_lock);
                                lock((console_sem).lock);
                                lock(&p->pi_lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

5 locks held by swapper/0/0:
  #0:  (&(&virtscsi_vq->vq_lock)->rlock){-.-.}, at: [<000000005b7284ab>]  
virtscsi_vq_done+0x9d/0x150 drivers/scsi/virtio_scsi.c:219
  #1:  (rcu_read_lock){....}, at: [<00000000f512e426>] hctx_lock+0xd8/0x190  
block/blk-mq.c:578
  #2:  (bit_wait_table + i){-.-.}, at: [<000000003551c654>]  
__wake_up_common_lock+0x190/0x310 kernel/sched/wait.c:124
  #3:  (&p->pi_lock){-.-.}, at: [<00000000b2df2a41>]  
try_to_wake_up+0xbc/0x15f0 kernel/sched/core.c:1989
  #4:  (rcu_read_lock){....}, at: [<00000000ac010327>] rcu_read_unlock  
include/linux/rcupdate.h:682 [inline]
  #4:  (rcu_read_lock){....}, at: [<00000000ac010327>]  
atomic_notifier_call_chain+0x0/0x140 kernel/notifier.c:184

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2417 [inline]
  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xa2/0x1e0 kernel/printk/printk.c:225
  console_trylock+0x15/0x70 kernel/printk/printk.c:2229
  console_trylock_spinning kernel/printk/printk.c:1643 [inline]
  vprintk_emit+0x5b5/0xb90 kernel/printk/printk.c:1906
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
  printk+0xaa/0xca kernel/printk/printk.c:1980
  kasan_die_handler+0x31/0x3f arch/x86/mm/kasan_init_64.c:247
  notifier_call_chain+0x136/0x2c0 kernel/notifier.c:93
  __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
  atomic_notifier_call_chain+0x77/0x140 kernel/notifier.c:193
  notify_die+0x18c/0x280 kernel/notifier.c:549
  do_general_protection+0x331/0x3e0 arch/x86/kernel/traps.c:558
  general_protection+0x25/0x50 arch/x86/entry/entry_64.S:1150
RIP: 0010:__delayacct_blkio_end+0x4b/0xb0 kernel/delayacct.c:82
RSP: 0018:ffff8801db206ac8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8173aa71
RDX: 0000000000000007 RSI: 0000000000000004 RDI: 0000000000000038
RBP: ffff8801db206ae0 R08: 1ffff1003b640c9b R09: ffff8801bd5425e4
R10: 0000000000000000 R11: ffff8801db206b70 R12: ffff8801db206cb0
R13: ffff8801bd542d38 R14: ffff8801bd542580 R15: ffff8801bd542a0c
  delayacct_blkio_end include/linux/delayacct.h:128 [inline]
  try_to_wake_up+0xb7d/0x15f0 kernel/sched/core.c:2060
  default_wake_function+0x30/0x50 kernel/sched/core.c:3693
  autoremove_wake_function+0x78/0x350 kernel/sched/wait.c:377
  wake_bit_function+0xbc/0x140 kernel/sched/wait_bit.c:33
  __wake_up_common+0x18e/0x780 kernel/sched/wait.c:97
  __wake_up_common_lock+0x1b4/0x310 kernel/sched/wait.c:125
  __wake_up+0xe/0x10 kernel/sched/wait.c:149
  __wake_up_bit+0x1a4/0x2a0 kernel/sched/wait_bit.c:124
  wake_up_bit+0x3d/0x40 kernel/sched/wait_bit.c:147
  journal_end_buffer_io_sync+0x82/0xc0 fs/jbd2/commit.c:44
  end_bio_bh_io_sync+0xc5/0x110 fs/buffer.c:2992
  bio_endio+0x447/0x950 block/bio.c:1775
  ? bio_di
Lost 102 message(s)!
---[ end trace c1196def7dfb53aa ]---


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
