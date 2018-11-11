Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4772C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630CC214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630CC214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeKLETT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:19:19 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42063 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeKLETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:19:19 -0500
Received: by mail-io1-f69.google.com with SMTP id r3-v6so7889160iog.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 10:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RnjtZaRXGDyyUejUX3XtL6ndr26AcJ6YkQNpnWdMr9A=;
        b=dOl3ZLqijzKAGdMeYAk+EWuQUrWf6cTlBJfbUCvc7G7GYbnQ7RUEjrsuALn5lNwIns
         aTGu7IU8HO50KLclxvCI22lNSF24HqGww15Y06Y+SFkJfyqAbs8EsMfuq7QihIHQCQHv
         roLAHdhtYLAM4NZUs3tAdGLDWvV7ByjQuIKNBhQthw2UAlkedGxtX38hdFuh66eSC3jd
         NSen0QvDy7A0E05aMVl5tiaCyW89fSfEKx+bsU6O2PZNzVcYzfm/ncsq5+0TxKd6Ccxd
         W1f1L5izMgBntVegFI9NYQ6ja3GqvbiWTjAHbJA08k/TBZa0kzHNBcm8bZosSVmtsIVn
         Aqhw==
X-Gm-Message-State: AGRZ1gJQD6S5m4rtJtLX0M8cWDjq8rpYgSjHC/3jO5j5Bk94cUSnf8NV
        sOxrK2iTsRQmvlp1NuBXHGF3bFVmT6pfPOBFt5JKibMFpLkV
X-Google-Smtp-Source: AJdET5e9hrLjxaK7bLwCfVe98PhxV09vpWwg9anZwWdKDuRDGzUIQ3Jy9GYebCxbKjx7SUQUjnSfVN7Lx0irzrqNLSmRlzmcIS4J
MIME-Version: 1.0
X-Received: by 2002:a24:c7:: with SMTP id 190-v6mr7867168ita.19.1541961002870;
 Sun, 11 Nov 2018 10:30:02 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:30:02 -0800
In-Reply-To: <000000000000e8adc105799d0aef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d57f4d057a67c5f9@google.com>
Subject: Re: possible deadlock in down_trylock (2)
From:   syzbot <syzbot+6e438330a01285fbb87a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com, guro@fb.com,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        marcos.souza.org@gmail.com, mhocko@kernel.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    407be8d03e20 Merge branch 'narrow-loads'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1601cb0b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcbea7daf3ea3e3e
dashboard link: https://syzkaller.appspot.com/bug?extid=6e438330a01285fbb87a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1214e015400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f40893400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e438330a01285fbb87a@syzkaller.appspotmail.com

RBP: 00000000006e59e0 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: ffffffffffffffff R14: 00007f931b2a89c0 R15: 0000000000000000

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc1+ #141 Not tainted
------------------------------------------------------
syz-executor239/7444 is trying to acquire lock:
0000000024bdb1f8 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000009cd56431 (&base->lock){..-.}, at: __mod_timer  
kernel/time/timer.c:1034 [inline]
000000009cd56431 (&base->lock){..-.}, at: mod_timer  
kernel/time/timer.c:1102 [inline]
000000009cd56431 (&base->lock){..-.}, at: add_timer+0x3e4/0x15a0  
kernel/time/timer.c:1138

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&base->lock){..-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        lock_timer_base+0xbb/0x2b0 kernel/time/timer.c:938
        __mod_timer kernel/time/timer.c:1010 [inline]
        mod_timer kernel/time/timer.c:1102 [inline]
        add_timer+0x87f/0x15a0 kernel/time/timer.c:1138
        __queue_delayed_work+0x249/0x380 kernel/workqueue.c:1533
        queue_delayed_work_on+0x1a2/0x1f0 kernel/workqueue.c:1558
        queue_delayed_work include/linux/workqueue.h:527 [inline]
        schedule_delayed_work include/linux/workqueue.h:628 [inline]
        psi_group_change kernel/sched/psi.c:473 [inline]
        psi_task_change+0x3f1/0x5f0 kernel/sched/psi.c:522
        psi_enqueue kernel/sched/stats.h:82 [inline]
        enqueue_task kernel/sched/core.c:727 [inline]
        activate_task+0x1b4/0x470 kernel/sched/core.c:751
        wake_up_new_task+0x523/0xcf0 kernel/sched/core.c:2423
        _do_fork+0x33b/0x11d0 kernel/fork.c:2241
        kernel_thread+0x34/0x40 kernel/fork.c:2275
        rest_init+0x28/0x372 init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x9f0/0xa2b init/main.c:745
        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1126 [inline]
        task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:9768
        sched_fork+0x443/0xba0 kernel/sched/core.c:2359
        copy_process+0x25b8/0x87a0 kernel/fork.c:1887
        _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
        kernel_thread+0x34/0x40 kernel/fork.c:2275
        rest_init+0x28/0x372 init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x9f0/0xa2b init/main.c:745
        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xdc/0x1490 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:236
        console_unlock+0x811/0x1190 kernel/printk/printk.c:2432
        vprintk_emit+0x391/0x990 kernel/printk/printk.c:1922
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        check_stack_usage kernel/exit.c:755 [inline]
        do_exit.cold.18+0x57/0x16f kernel/exit.c:916
        do_group_exit+0x177/0x440 kernel/exit.c:970
        __do_sys_exit_group kernel/exit.c:981 [inline]
        __se_sys_exit_group kernel/exit.c:979 [inline]
        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
        console_trylock_spinning kernel/printk/printk.c:1653 [inline]
        vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        fail_dump lib/fault-inject.c:44 [inline]
        should_fail+0xac1/0xd01 lib/fault-inject.c:149
        __should_failslab+0x124/0x180 mm/failslab.c:32
        should_failslab+0x9/0x14 mm/slab_common.c:1578
        slab_pre_alloc_hook mm/slab.h:423 [inline]
        slab_alloc mm/slab.c:3378 [inline]
        kmem_cache_alloc+0x47/0x730 mm/slab.c:3552
        kmem_cache_zalloc include/linux/slab.h:731 [inline]
        fill_pool lib/debugobjects.c:134 [inline]
        __debug_object_init+0xbb8/0x1290 lib/debugobjects.c:380
        debug_object_init lib/debugobjects.c:432 [inline]
        debug_object_activate+0x323/0x600 lib/debugobjects.c:513
        debug_timer_activate kernel/time/timer.c:709 [inline]
        debug_activate kernel/time/timer.c:764 [inline]
        __mod_timer kernel/time/timer.c:1041 [inline]
        mod_timer kernel/time/timer.c:1102 [inline]
        add_timer+0x50e/0x15a0 kernel/time/timer.c:1138
        __queue_delayed_work+0x249/0x380 kernel/workqueue.c:1533
        queue_delayed_work_on+0x1a2/0x1f0 kernel/workqueue.c:1558
        queue_delayed_work include/linux/workqueue.h:527 [inline]
        schedule_delayed_work include/linux/workqueue.h:628 [inline]
        unaccount_event kernel/events/core.c:4311 [inline]
        _free_event+0xf27/0x1660 kernel/events/core.c:4419
        put_event+0x48/0x60 kernel/events/core.c:4532
        perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638
        perf_release+0x37/0x50 kernel/events/core.c:4648
        __fput+0x385/0xa30 fs/file_table.c:278
        ____fput+0x15/0x20 fs/file_table.c:309
        task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
        tracehook_notify_resume include/linux/tracehook.h:188 [inline]
        exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &rq->lock --> &base->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&base->lock);
                                lock(&rq->lock);
                                lock(&base->lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

1 lock held by syz-executor239/7444:
  #0: 000000009cd56431 (&base->lock){..-.}, at: __mod_timer  
kernel/time/timer.c:1034 [inline]
  #0: 000000009cd56431 (&base->lock){..-.}, at: mod_timer  
kernel/time/timer.c:1102 [inline]
  #0: 000000009cd56431 (&base->lock){..-.}, at: add_timer+0x3e4/0x15a0  
kernel/time/timer.c:1138

stack backtrace:
CPU: 1 PID: 7444 Comm: syz-executor239 Not tainted 4.20.0-rc1+ #141
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
  console_trylock_spinning kernel/printk/printk.c:1653 [inline]
  vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
  printk+0xa7/0xcf kernel/printk/printk.c:1997
  fail_dump lib/fault-inject.c:44 [inline]
  should_fail+0xac1/0xd01 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc+0x47/0x730 mm/slab.c:3552
  kmem_cache_zalloc include/linux/slab.h:731 [inline]
  fill_pool lib/debugobjects.c:134 [inline]
  __debug_object_init+0xbb8/0x1290 lib/debugobjects.c:380
  debug_object_init lib/debugobjects.c:432 [inline]
  debug_object_activate+0x323/0x600 lib/debugobjects.c:513
  debug_timer_activate kernel/time/timer.c:709 [inline]
  debug_activate kernel/time/timer.c:764 [inline]
  __mod_timer kernel/time/timer.c:1041 [inline]
  mod_timer kernel/time/timer.c:1102 [inline]
  add_timer+0x50e/0x15a0 kernel/time/timer.c:1138
  __queue_delayed_work+0x249/0x380 kernel/workqueue.c:1533
  queue_delayed_work_on+0x1a2/0x1f0 kernel/workqueue.c:1558
  queue_delayed_work include/linux/workqueue.h:527 [inline]
  schedule_delayed_work include/linux/workqueue.h:628 [inline]
  unaccount_event kernel/events/core.c:4311 [inline]
  _free_event+0xf27/0x1660 kernel/events/core.c:4419
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638
  perf_release+0x37/0x50 kernel/events/core.c:4648
  __fput+0x385/0xa30 fs/file_table.c:278
Lost 29 message(s)!
FAULT_INJECTION: forcing a failure.
name fail_futex, interval 1, probability 0, space 0, times 1
------------[ cut here ]------------
downgrading a read lock
WARNING: CPU: 1 PID: 7460 at kernel/locking/lockdep.c:3556 __lock_downgrade  
kernel/locking/lockdep.c:3556 [inline]
WARNING: CPU: 1 PID: 7460 at kernel/locking/lockdep.c:3556  
lock_downgrade+0x4d7/0x900 kernel/locking/lockdep.c:3819
CPU: 0 PID: 7473 Comm: syz-executor239 Not tainted 4.20.0-rc1+ #141

