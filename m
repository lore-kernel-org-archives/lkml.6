Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F39ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8426E20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8426E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeJ0V7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:59:03 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:42717 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbeJ0V7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:59:02 -0400
Received: by mail-it1-f198.google.com with SMTP id v125-v6so4689416ita.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 06:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YpTX1h4qZu3YPkLbNiAxy1xGSTF+wrcF9pKdN0xZPYo=;
        b=kfnQWUDzrv5nfyJ6gR3+qO+1VOAw3CaY4t1uNAtk9way57Luo/UejNakzO2AraqPyv
         XI/JyVmmUEsoQDCXmlEOBTbI0Vi/wW+rCyDw6bCKhuWDUSPiMaKcmUR4XPW0/UpO1IZy
         mkD+5nLlaA/+h3tymNx0osrpp8PhktY4Wy27nY0mDLU3VDapk5utOdm3WE+Zx9xQJsZi
         aVBC3OE0RynQRIO3J3CXr11k0azyysi9DlVUUf1+FuN3aFJxyFFqx8BEXQgHuPIigsl5
         OfRGW0OIx14fonNG8MIwa7z6hp5VqylA8mNMkKRIVXXf9oco2kuHA3Yl7fvWdHxkC09v
         2/CQ==
X-Gm-Message-State: AGRZ1gLOld15NC+3v1C2UAiugf82JoLrR19M3dwc3qK+HUG13XrX2CkI
        nTS1a+Ex9zYF0swHFVcyiIA66aKYE0FZku2kdS8HEJRqJ8C2
X-Google-Smtp-Source: AJdET5d8O7ei51X96bz05n5MWCINX3PajXG0icwgb+f19ZxsXFBT4sLLbIgGPrwqGzzS9cSgFgnSlRg3amkda0CyHzIfedsa+0GX
MIME-Version: 1.0
X-Received: by 2002:a24:1d0b:: with SMTP id 11-v6mr5472782itj.11.1540646283246;
 Sat, 27 Oct 2018 06:18:03 -0700 (PDT)
Date:   Sat, 27 Oct 2018 06:18:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000700cdc057935aa71@google.com>
Subject: possible deadlock in userfaultfd_release
From:   syzbot <syzbot+53c0b767f7ca0dc0c451@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    345671ea0f92 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1557ea33400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c0a49d2b5210087
dashboard link: https://syzkaller.appspot.com/bug?extid=53c0b767f7ca0dc0c451
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1111f2eb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e874f5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+53c0b767f7ca0dc0c451@syzkaller.appspotmail.com


========================================================
WARNING: possible irq lock inversion dependency detected
4.19.0+ #306 Not tainted
--------------------------------------------------------
syz-executor911/5551 just changed the state of lock:
00000000758a85c4 (&ctx->fault_pending_wqh){+.+.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
00000000758a85c4 (&ctx->fault_pending_wqh){+.+.}, at:  
userfaultfd_release+0x63e/0x8d0 fs/userfaultfd.c:909
but this lock was taken by another, SOFTIRQ-safe lock in the past:
  (&(&ctx->ctx_lock)->rlock){..-.}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
   &(&ctx->ctx_lock)->rlock --> &ctx->fd_wqh --> &ctx->fault_pending_wqh

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ctx->fault_pending_wqh);
                                local_irq_disable();
                                lock(&(&ctx->ctx_lock)->rlock);
                                lock(&ctx->fd_wqh);
   <Interrupt>
     lock(&(&ctx->ctx_lock)->rlock);

  *** DEADLOCK ***

no locks held by syz-executor911/5551.

the shortest dependencies between 2nd lock and 1st lock:
   -> (&(&ctx->ctx_lock)->rlock){..-.} {
      IN-SOFTIRQ-W at:
                         lock_acquire+0x1ed/0x520  
kernel/locking/lockdep.c:3844
                         __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                         _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                         spin_lock_irq include/linux/spinlock.h:354 [inline]
                         free_ioctx_users+0xbc/0x710 fs/aio.c:603
                         percpu_ref_put_many  
include/linux/percpu-refcount.h:285 [inline]
                         percpu_ref_put include/linux/percpu-refcount.h:301  
[inline]
                         percpu_ref_call_confirm_rcu  
lib/percpu-refcount.c:123 [inline]
                         percpu_ref_switch_to_atomic_rcu+0x563/0x730  
lib/percpu-refcount.c:158
                         __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
                         rcu_do_batch kernel/rcu/tree.c:2437 [inline]
                         invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
                         rcu_process_callbacks+0x100a/0x1ac0  
kernel/rcu/tree.c:2697
                         __do_softirq+0x308/0xb7e kernel/softirq.c:292
                         invoke_softirq kernel/softirq.c:373 [inline]
                         irq_exit+0x17f/0x1c0 kernel/softirq.c:413
                         exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                         smp_apic_timer_interrupt+0x1cb/0x760  
arch/x86/kernel/apic/apic.c:1061
                         apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:801
                         native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:57
                         arch_safe_halt arch/x86/include/asm/paravirt.h:151  
[inline]
                         default_idle+0xbf/0x490  
arch/x86/kernel/process.c:498
                         arch_cpu_idle+0x10/0x20  
arch/x86/kernel/process.c:489
                         default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
                         cpuidle_idle_call kernel/sched/idle.c:153 [inline]
                         do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
                         cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
                         rest_init+0x243/0x372 init/main.c:442
                         arch_call_rest_init+0xe/0x1b
                         start_kernel+0xa1f/0xa5a init/main.c:744
                         x86_64_start_reservations+0x2e/0x30  
arch/x86/kernel/head64.c:472
                         x86_64_start_kernel+0x76/0x79  
arch/x86/kernel/head64.c:451
                         secondary_startup_64+0xa4/0xb0  
arch/x86/kernel/head_64.S:243
      INITIAL USE at:
                        lock_acquire+0x1ed/0x520  
kernel/locking/lockdep.c:3844
                        __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                        _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                        spin_lock_irq include/linux/spinlock.h:354 [inline]
                        aio_poll+0x738/0x1420 fs/aio.c:1746
                        io_submit_one+0xa49/0xf80 fs/aio.c:1850
                        __do_sys_io_submit fs/aio.c:1916 [inline]
                        __se_sys_io_submit fs/aio.c:1887 [inline]
                        __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1887
                        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                        entry_SYSCALL_64_after_hwframe+0x49/0xbe
    }
    ... key      at: [<ffffffff8aed8b20>] __key.50665+0x0/0x40
    ... acquired at:
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    aio_poll+0x760/0x1420 fs/aio.c:1747
    io_submit_one+0xa49/0xf80 fs/aio.c:1850
    __do_sys_io_submit fs/aio.c:1916 [inline]
    __se_sys_io_submit fs/aio.c:1887 [inline]
    __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1887
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

  -> (&ctx->fd_wqh){....} {
     INITIAL USE at:
                      lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                      __raw_spin_lock_irqsave  
include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x99/0xd0  
kernel/locking/spinlock.c:152
                      add_wait_queue+0x92/0x2b0 kernel/sched/wait.c:22
                      aio_poll_queue_proc+0xa1/0x100 fs/aio.c:1705
                      poll_wait include/linux/poll.h:47 [inline]
                      userfaultfd_poll+0xff/0x3a0 fs/userfaultfd.c:958
                      vfs_poll include/linux/poll.h:86 [inline]
                      aio_poll+0x6ad/0x1420 fs/aio.c:1740
                      io_submit_one+0xa49/0xf80 fs/aio.c:1850
                      __do_sys_io_submit fs/aio.c:1916 [inline]
                      __se_sys_io_submit fs/aio.c:1887 [inline]
                      __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1887
                      do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                      entry_SYSCALL_64_after_hwframe+0x49/0xbe
   }
   ... key      at: [<ffffffff8aed88a0>] __key.44286+0x0/0x40
   ... acquired at:
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    userfaultfd_ctx_read+0x4f3/0x2180 fs/userfaultfd.c:1033
    userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
    __vfs_read+0x117/0x9b0 fs/read_write.c:416
    vfs_read+0x17f/0x3c0 fs/read_write.c:452
    ksys_read+0x101/0x260 fs/read_write.c:578
    __do_sys_read fs/read_write.c:588 [inline]
    __se_sys_read fs/read_write.c:586 [inline]
    __x64_sys_read+0x73/0xb0 fs/read_write.c:586
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> (&ctx->fault_pending_wqh){+.+.} {
    HARDIRQ-ON-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     userfaultfd_release+0x63e/0x8d0 fs/userfaultfd.c:909
                     __fput+0x385/0xa30 fs/file_table.c:278
                     ____fput+0x15/0x20 fs/file_table.c:309
                     task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
                     exit_task_work include/linux/task_work.h:22 [inline]
                     do_exit+0x1ad6/0x26d0 kernel/exit.c:867
                     do_group_exit+0x177/0x440 kernel/exit.c:970
                     get_signal+0x8b0/0x1980 kernel/signal.c:2517
                     do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
                     exit_to_usermode_loop+0x2e5/0x380  
arch/x86/entry/common.c:162
                     prepare_exit_to_usermode arch/x86/entry/common.c:197  
[inline]
                     syscall_return_slowpath arch/x86/entry/common.c:268  
[inline]
                     do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    SOFTIRQ-ON-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     userfaultfd_release+0x63e/0x8d0 fs/userfaultfd.c:909
                     __fput+0x385/0xa30 fs/file_table.c:278
                     ____fput+0x15/0x20 fs/file_table.c:309
                     task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
                     exit_task_work include/linux/task_work.h:22 [inline]
                     do_exit+0x1ad6/0x26d0 kernel/exit.c:867
                     do_group_exit+0x177/0x440 kernel/exit.c:970
                     get_signal+0x8b0/0x1980 kernel/signal.c:2517
                     do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
                     exit_to_usermode_loop+0x2e5/0x380  
arch/x86/entry/common.c:162
                     prepare_exit_to_usermode arch/x86/entry/common.c:197  
[inline]
                     syscall_return_slowpath arch/x86/entry/common.c:268  
[inline]
                     do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                    spin_lock include/linux/spinlock.h:329 [inline]
                    userfaultfd_ctx_read+0x4f3/0x2180 fs/userfaultfd.c:1033
                    userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
                    __vfs_read+0x117/0x9b0 fs/read_write.c:416
                    vfs_read+0x17f/0x3c0 fs/read_write.c:452
                    ksys_read+0x101/0x260 fs/read_write.c:578
                    __do_sys_read fs/read_write.c:588 [inline]
                    __se_sys_read fs/read_write.c:586 [inline]
                    __x64_sys_read+0x73/0xb0 fs/read_write.c:586
                    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8aed8960>] __key.44283+0x0/0x40
  ... acquired at:
    mark_lock_irq kernel/locking/lockdep.c:2687 [inline]
    mark_lock+0x9b5/0x1cd0 kernel/locking/lockdep.c:3059
    mark_irqflags kernel/locking/lockdep.c:2955 [inline]
    __lock_acquire+0xd15/0x4c20 kernel/locking/lockdep.c:3298
    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    userfaultfd_release+0x63e/0x8d0 fs/userfaultfd.c:909
    __fput+0x385/0xa30 fs/file_table.c:278
    ____fput+0x15/0x20 fs/file_table.c:309
    task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
    exit_task_work include/linux/task_work.h:22 [inline]
    do_exit+0x1ad6/0x26d0 kernel/exit.c:867
    do_group_exit+0x177/0x440 kernel/exit.c:970
    get_signal+0x8b0/0x1980 kernel/signal.c:2517
    do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
    exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
    prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
    syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
    do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


stack backtrace:
CPU: 0 PID: 5551 Comm: syz-executor911 Not tainted 4.19.0+ #306
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_irq_inversion_bug.part.37+0x2c7/0x2d6 kernel/locking/lockdep.c:2553
  print_irq_inversion_bug kernel/locking/lockdep.c:2556 [inline]
  check_usage_backwards.cold.56+0x1d/0x26 kernel/locking/lockdep.c:2602
  mark_lock_irq kernel/locking/lockdep.c:2687 [inline]
  mark_lock+0x9b5/0x1cd0 kernel/locking/lockdep.c:3059
  mark_irqflags kernel/locking/lockdep.c:2955 [inline]
  __lock_acquire+0xd15/0x4c20 kernel/locking/lockdep.c:3298
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  userfaultfd_release+0x63e/0x8d0 fs/userfaultfd.c:909
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad6/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440e99
Code: Bad RIP value.
RSP: 002b:00007ffd69bf8a18 EFLAGS: 00000217 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000000000440e99
RDX: 0000000000000064 RSI: 0000000020009f9c RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
