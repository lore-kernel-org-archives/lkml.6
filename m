Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89E06607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeFFNRU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:17:20 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:52496 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeFFNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:17:03 -0400
X-Google-Smtp-Source: ADUXVKKpocg5oD+uwRYqauMUrzcrpyCTSre4E6ExqD8QYA8RLPa4cUDuWE7sHb+gHExceUiiKYhijlCW1B6+nb5pWvNkwKcc+lnF
MIME-Version: 1.0
Date: Wed, 06 Jun 2018 06:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087008b056df8fbb3@google.com>
Subject: possible deadlock in console_unlock
From: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    af6c5d5e01ad Merge branch 'for-4.18' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173d93ef800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12ff770540994680
dashboard link: https://syzkaller.appspot.com/bug?extid=43e93968b964e369db0b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16e00bb7800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com

RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

======================================================
WARNING: possible circular locking dependency detected
4.17.0+ #111 Not tainted
------------------------------------------------------
syz-executor0/4774 is trying to acquire lock:
         (ptrval) (console_owner){-...}, at: log_next  
kernel/printk/printk.c:496 [inline]
         (ptrval) (console_owner){-...}, at: console_unlock+0x583/0x1100  
kernel/printk/printk.c:2382

but task is already holding lock:
         (ptrval) (&(&port->lock)->rlock){-.-.}, at: pty_write+0xf9/0x1f0  
drivers/tty/pty.c:119

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&(&port->lock)->rlock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        tty_port_tty_get+0x20/0x80 drivers/tty/tty_port.c:288
        tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:47
        tty_port_tty_wakeup+0x5d/0x70 drivers/tty/tty_port.c:390
        uart_write_wakeup+0x44/0x60 drivers/tty/serial/serial_core.c:103
        serial8250_tx_chars+0x4be/0xb60  
drivers/tty/serial/8250/8250_port.c:1808
        serial8250_handle_irq.part.25+0x1ee/0x280  
drivers/tty/serial/8250/8250_port.c:1881
        serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1867  
[inline]
        serial8250_default_handle_irq+0xc8/0x150  
drivers/tty/serial/8250/8250_port.c:1897
        serial8250_interrupt+0xfa/0x1d0  
drivers/tty/serial/8250/8250_core.c:125
        __handle_irq_event_percpu+0x1c0/0xad0 kernel/irq/handle.c:149
        handle_irq_event_percpu+0x98/0x1c0 kernel/irq/handle.c:189
        handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
        handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
        generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
        handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
        do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
        ret_from_intr+0x0/0x1e
        native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
        arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
        default_idle+0xc2/0x440 arch/x86/kernel/process.c:500
        arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
        default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
        cpuidle_idle_call kernel/sched/idle.c:153 [inline]
        do_idle+0x395/0x560 kernel/sched/idle.c:262
        cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
        start_secondary+0x42b/0x5c0 arch/x86/kernel/smpboot.c:265
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&port_lock_key){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        serial8250_console_write+0x8d5/0xb00  
drivers/tty/serial/8250/8250_port.c:3230
        univ8250_console_write+0x5f/0x70  
drivers/tty/serial/8250/8250_core.c:590
        call_console_drivers kernel/printk/printk.c:1718 [inline]
        console_unlock+0xac2/0x1100 kernel/printk/printk.c:2395
        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        register_console+0x7e7/0xc00 kernel/printk/printk.c:2714
        univ8250_console_init+0x3f/0x4b  
drivers/tty/serial/8250/8250_core.c:685
        console_init+0x6d9/0xa38 kernel/printk/printk.c:2798
        start_kernel+0x608/0x92d init/main.c:661
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #0 (console_owner){-...}:
        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
        console_lock_spinning_enable kernel/printk/printk.c:1581 [inline]
        console_unlock+0x5ef/0x1100 kernel/printk/printk.c:2392
        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        fail_dump lib/fault-inject.c:44 [inline]
        should_fail+0x97a/0xbcd lib/fault-inject.c:149
        __should_failslab+0x124/0x180 mm/failslab.c:32
        should_failslab+0x9/0x14 mm/slab_common.c:1522
        slab_pre_alloc_hook mm/slab.h:423 [inline]
        slab_alloc mm/slab.c:3378 [inline]
        __do_kmalloc mm/slab.c:3716 [inline]
        __kmalloc+0x63/0x760 mm/slab.c:3727
        kmalloc include/linux/slab.h:517 [inline]
        tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
        __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
        tty_insert_flip_string_fixed_flag+0x8d/0x1f0  
drivers/tty/tty_buffer.c:313
        tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
        pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
        tty_put_char+0x129/0x150 drivers/tty/tty_io.c:2865
        __process_echoes+0x4d9/0x8d0 drivers/tty/n_tty.c:703
        process_echoes+0xfc/0x170 drivers/tty/n_tty.c:781
        n_tty_set_termios+0xb56/0xe80 drivers/tty/n_tty.c:1837
        tty_set_termios+0x7a0/0xac0 drivers/tty/tty_ioctl.c:341
        set_termios+0x41e/0x7d0 drivers/tty/tty_ioctl.c:414
        tty_mode_ioctl+0x871/0xb50 drivers/tty/tty_ioctl.c:781
        n_tty_ioctl_helper+0x54/0x3b0 drivers/tty/tty_ioctl.c:940
        n_tty_ioctl+0x54/0x320 drivers/tty/n_tty.c:2441
        tty_ioctl+0x5e1/0x1870 drivers/tty/tty_io.c:2655
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:500 [inline]
        do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
        __do_compat_sys_ioctl fs/compat_ioctl.c:1483 [inline]
        __se_compat_sys_ioctl fs/compat_ioctl.c:1407 [inline]
        __ia32_compat_sys_ioctl+0x43e/0x640 fs/compat_ioctl.c:1407
        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

other info that might help us debug this:

Chain exists of:
   console_owner --> &port_lock_key --> &(&port->lock)->rlock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&(&port->lock)->rlock);
                                lock(&port_lock_key);
                                lock(&(&port->lock)->rlock);
   lock(console_owner);

  *** DEADLOCK ***

6 locks held by syz-executor0/4774:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&o_tty->termios_rwsem/1){++++}, at:  
tty_set_termios+0xfd/0xac0 drivers/tty/tty_ioctl.c:328
  #2:         (ptrval) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90  
drivers/tty/tty_ldisc.c:284
  #3:         (ptrval) (&ldata->output_lock){+.+.}, at:  
process_echoes+0xb6/0x170 drivers/tty/n_tty.c:779
  #4:         (ptrval) (&(&port->lock)->rlock){-.-.}, at:  
pty_write+0xf9/0x1f0 drivers/tty/pty.c:119
  #5:         (ptrval) (console_lock){+.+.}, at: console_trylock_spinning  
kernel/printk/printk.c:1643 [inline]
  #5:         (ptrval) (console_lock){+.+.}, at: vprintk_emit+0x694/0xdd0  
kernel/printk/printk.c:1906

stack backtrace:
CPU: 1 PID: 4774 Comm: syz-executor0 Not tainted 4.17.0+ #111
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.56+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3435
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
  console_lock_spinning_enable kernel/printk/printk.c:1581 [inline]
  console_unlock+0x5ef/0x1100 kernel/printk/printk.c:2392
  vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  fail_dump lib/fault-inject.c:44 [inline]
  should_fail+0x97a/0xbcd lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  tty_put_char+0x129/0x150 drivers/tty/tty_io.c:2865
  __process_echoes+0x4d9/0x8d0 drivers/tty/n_tty.c:703
  process_echoes+0xfc/0x170 drivers/tty/n_tty.c:781
  n_tty_set_termios+0xb56/0xe80 drivers/tty/n_tty.c:1837
  tty_set_termios+0x7a0/0xac0 drivers/tty/tty_ioctl.c:341
  set_termios+0x41e/0x7d0 drivers/tty/tty_ioctl.c:414
  tty_mode_ioctl+0x871/0xb50 drivers/tty/tty_ioctl.c:781
  n_tty_ioctl_helper+0x54/0x3b0 drivers/tty/tty_ioctl.c:940
  n_tty_ioctl+0x54/0x320 drivers/tty/n_tty.c:2441
  tty_ioctl+0x5e1/0x1870 drivers/tty/tty_io.c:2655
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
  __do_compat_sys_ioctl fs/compat_ioctl.c:1483 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:1407 [inline]
  __ia32_compat_sys_ioctl+0x43e/0x640 fs/compat_ioctl.c:1407


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
