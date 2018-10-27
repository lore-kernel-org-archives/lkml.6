Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952F7C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F752085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F752085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeJ0Oz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 10:55:57 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39291 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbeJ0Oz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 10:55:57 -0400
Received: by mail-io1-f71.google.com with SMTP id o8-v6so3019488iom.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 23:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ynx5FCXQ504ECepikXRcoUbP/JkAjTt30DOHRYhyQmk=;
        b=Rdi7cr7E7j3lvVkDOwJASAQ2RAVUfnB4Z2r00z8ZOsDmWtkEV3QtmxJn2+UsFhPV6T
         rFXr9IKFjrgoX12QFnkLPdg22VSz0bdhm4QYD5P53eHv9AVR/bHBf04FCb1hPN7Lit95
         P/RC6PGA1Ci5XDAf9+ThIcrD8+xfedhCfA5OCq5eKM1c+kfB8t4tN4ITaJ3iX37d6vvY
         Y+/1i569iSeIihhh5RuUgwLDz1QCFeBDss7RWtscZ1gt9oU1Dg8SIn7Aw3whNs0R6s7n
         c8lGSPHYoW2jvn0X0Nw5IEbeIrSZ2YxDUzq5ype1vjFDonlGvlKudrDK+4GOhtNmo8pR
         Y/aQ==
X-Gm-Message-State: AGRZ1gIow2c3/s6Ujo3EeYfUM9T6T7Ng6jS48LhLn78EIbTV9N30Vkgf
        k7wtHebKPvBSW+yRtm0KJGHRkaNOOB7kGF4sthRfiuD5eevs
X-Google-Smtp-Source: AJdET5fM00T9WIQ27O+Agg0NSncrtvet1MB2wm6kdXhXxIZBKuyvvx+CxlnHpoHJVexBKVaQrhkdfNQmfwJqn0A88QhQ75IKQHg6
MIME-Version: 1.0
X-Received: by 2002:a02:9043:: with SMTP id y3-v6mr382693jaf.23.1540620963735;
 Fri, 26 Oct 2018 23:16:03 -0700 (PDT)
Date:   Fri, 26 Oct 2018 23:16:03 -0700
In-Reply-To: <000000000000cbb35d05757f7a3a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046f84d05792fc5f0@google.com>
Subject: Re: possible deadlock in aio_poll
From:   syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org, bcrl@kvack.org,
        hch@infradead.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    18d0eae30e6a Merge tag 'char-misc-4.20-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14728be5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=342f43de913c81b9
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1df0420c523b45a953
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161d6999400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f4cf5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com


=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
4.19.0+ #84 Not tainted
-----------------------------------------------------
syz-executor781/7254 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
00000000e70e96f7 (&ctx->fd_wqh){+.+.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
00000000e70e96f7 (&ctx->fd_wqh){+.+.}, at: aio_poll+0x760/0x1420  
fs/aio.c:1747

and this task is already holding:
000000009957d7d7 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
000000009957d7d7 (&(&ctx->ctx_lock)->rlock){..-.}, at:  
aio_poll+0x738/0x1420 fs/aio.c:1746
which would create a new lock dependency:
  (&(&ctx->ctx_lock)->rlock){..-.} -> (&ctx->fd_wqh){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
  (&(&ctx->ctx_lock)->rlock){..-.}

... which became SOFTIRQ-irq-safe at:
   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
   _raw_spin_lock_irq+0x61/0x80 kernel/locking/spinlock.c:160
   spin_lock_irq include/linux/spinlock.h:354 [inline]
   free_ioctx_users+0xbc/0x710 fs/aio.c:603
   percpu_ref_put_many include/linux/percpu-refcount.h:285 [inline]
   percpu_ref_put include/linux/percpu-refcount.h:301 [inline]
   percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123 [inline]
   percpu_ref_switch_to_atomic_rcu+0x563/0x730 lib/percpu-refcount.c:158
   __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
   rcu_do_batch kernel/rcu/tree.c:2437 [inline]
   invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
   rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
   __do_softirq+0x308/0xb7e kernel/softirq.c:292
   invoke_softirq kernel/softirq.c:373 [inline]
   irq_exit+0x17f/0x1c0 kernel/softirq.c:413
   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
   smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:801
   native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
   arch_safe_halt arch/x86/include/asm/paravirt.h:151 [inline]
   default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
   arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
   default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
   cpuidle_idle_call kernel/sched/idle.c:153 [inline]
   do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
   cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
   start_secondary+0x487/0x5f0 arch/x86/kernel/smpboot.c:271
   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

to a SOFTIRQ-irq-unsafe lock:
  (&ctx->fd_wqh){+.+.}

... which became SOFTIRQ-irq-unsafe at:
...
   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
   userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
   __vfs_read+0x117/0x9b0 fs/read_write.c:416
   vfs_read+0x17f/0x3c0 fs/read_write.c:452
   ksys_read+0x101/0x260 fs/read_write.c:578
   __do_sys_read fs/read_write.c:588 [inline]
   __se_sys_read fs/read_write.c:586 [inline]
   __x64_sys_read+0x73/0xb0 fs/read_write.c:586
   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ctx->fd_wqh);
                                local_irq_disable();
                                lock(&(&ctx->ctx_lock)->rlock);
                                lock(&ctx->fd_wqh);
   <Interrupt>
     lock(&(&ctx->ctx_lock)->rlock);

  *** DEADLOCK ***

1 lock held by syz-executor781/7254:
  #0: 000000009957d7d7 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
  #0: 000000009957d7d7 (&(&ctx->ctx_lock)->rlock){..-.}, at:  
aio_poll+0x738/0x1420 fs/aio.c:1746

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&(&ctx->ctx_lock)->rlock){..-.} {
    IN-SOFTIRQ-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                     __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                     _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                     spin_lock_irq include/linux/spinlock.h:354 [inline]
                     free_ioctx_users+0xbc/0x710 fs/aio.c:603
                     percpu_ref_put_many include/linux/percpu-refcount.h:285  
[inline]
                     percpu_ref_put include/linux/percpu-refcount.h:301  
[inline]
                     percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
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
                     default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
                     arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
                     default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
                     cpuidle_idle_call kernel/sched/idle.c:153 [inline]
                     do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
                     cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
                     start_secondary+0x487/0x5f0  
arch/x86/kernel/smpboot.c:271
                     secondary_startup_64+0xa4/0xb0  
arch/x86/kernel/head_64.S:243
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128  
[inline]
                    _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                    spin_lock_irq include/linux/spinlock.h:354 [inline]
                    free_ioctx_users+0xbc/0x710 fs/aio.c:603
                    percpu_ref_put_many include/linux/percpu-refcount.h:285  
[inline]
                    percpu_ref_put include/linux/percpu-refcount.h:301  
[inline]
                    percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
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
                    default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
                    arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
                    default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
                    cpuidle_idle_call kernel/sched/idle.c:153 [inline]
                    do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
                    cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
                    start_secondary+0x487/0x5f0 arch/x86/kernel/smpboot.c:271
                    secondary_startup_64+0xa4/0xb0  
arch/x86/kernel/head_64.S:243
  }
  ... key      at: [<ffffffff8aed9b20>] __key.50623+0x0/0x40
  ... acquired at:
    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
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


the dependencies between the lock to be acquired
  and SOFTIRQ-irq-unsafe lock:
-> (&ctx->fd_wqh){+.+.} {
    HARDIRQ-ON-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
                     userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
                     __vfs_read+0x117/0x9b0 fs/read_write.c:416
                     vfs_read+0x17f/0x3c0 fs/read_write.c:452
                     ksys_read+0x101/0x260 fs/read_write.c:578
                     __do_sys_read fs/read_write.c:588 [inline]
                     __se_sys_read fs/read_write.c:586 [inline]
                     __x64_sys_read+0x73/0xb0 fs/read_write.c:586
                     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    SOFTIRQ-ON-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
                     userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
                     __vfs_read+0x117/0x9b0 fs/read_write.c:416
                     vfs_read+0x17f/0x3c0 fs/read_write.c:452
                     ksys_read+0x101/0x260 fs/read_write.c:578
                     __do_sys_read fs/read_write.c:588 [inline]
                     __se_sys_read fs/read_write.c:586 [inline]
                     __x64_sys_read+0x73/0xb0 fs/read_write.c:586
                     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                    spin_lock include/linux/spinlock.h:329 [inline]
                    userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
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
  ... key      at: [<ffffffff8aed98a0>] __key.44253+0x0/0x40
  ... acquired at:
    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
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


stack backtrace:
CPU: 0 PID: 7254 Comm: syz-executor781 Not tainted 4.19.0+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_bad_irq_dependency kernel/locking/lockdep.c:1570 [inline]
  check_usage.cold.58+0x6d5/0xad1 kernel/locking/lockdep.c:1602
  check_irq_usage kernel/locking/lockdep.c:1658 [inline]
  check_prev_add_irq kernel/locking/lockdep_states.h:8 [inline]
  check_prev_add kernel/locking/lockdep.c:1868 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x238a/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
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
RIP: 0033:0x447dc9
Code: e8 9c ba 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc840e69da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00000000006e39e8 RCX: 0000000000447dc9
RDX: 0000000020000b00 RSI: 0000000000000001 RDI: 00007fc840e39000
RBP: 00000000006e39e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000006e39ec
R13: 702f74656e2f666c R14: 65732f636f72702f R15: 0000000000000000

