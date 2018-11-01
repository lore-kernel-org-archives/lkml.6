Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B61DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D8B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeKBBlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:41:49 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41545 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKBBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:41:47 -0400
Received: by mail-io1-f69.google.com with SMTP id k3-v6so7991143ioq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nqySzHUb1QXn/Y56IacaIFLD7vHTCVR7fcokiQelzFY=;
        b=B7P95Q+h+nDBXbnzMKkjKW0uwGH7fYG0NfqgMP6xDJExB+VSHsdnGKg0xxTAP/SF85
         DmMVDjo1RgVDYymO4YNZWXzzG2KkmKtOGVAkNjG5UNibm7urY32P3LRHZoJ+0V6axE2Y
         SEM8aqdmhoyUd/n2P76LB9ZGs0fdEmg9LGpMYRJsjGkN6jvtKIf83nMvz2q1NX2vlb1o
         JQfcTSR+3N7kjb4Ld9GrVPgvSQuje+v0dXHoTLE4/tlcJi9sUBmj59yY5RArnxWQgXbh
         5O0YIaHkcjDg7V66cIpPpZJSJzwNCQi1bG53yio5Pzb9UHt8LMdoCdagkhIwkH0VHVB9
         AlMw==
X-Gm-Message-State: AGRZ1gLKTEfVB5pLInQnAwhMbd+RwjCytGx+HxbajmDK64Ll9fyYe5mE
        e2dKAP7CXh7FMbxwChJL22v7PHIaOBj2oi6oNTwUrnG7I5r9
X-Google-Smtp-Source: AJdET5eiYwQYl0cz8Jc37ypeM01qZW7BAKr2Ax/Wd+XPNiJ7y+tEhr7FBirWLb8vDsrlAnxdMYmaunOFMgvLmCGRE4nhigYWlG+J
MIME-Version: 1.0
X-Received: by 2002:a24:906:: with SMTP id 6-v6mr5824501itm.4.1541090283384;
 Thu, 01 Nov 2018 09:38:03 -0700 (PDT)
Date:   Thu, 01 Nov 2018 09:38:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8adc105799d0aef@google.com>
Subject: possible deadlock in down_trylock (2)
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

Hello,

syzbot found the following crash on:

HEAD commit:    27b31e68bc9f bpf: tcp_bpf_recvmsg should return EAGAIN whe..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=17443183400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
dashboard link: https://syzkaller.appspot.com/bug?extid=6e438330a01285fbb87a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163fd06d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e438330a01285fbb87a@syzkaller.appspotmail.com

RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f208e04c6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007

======================================================
WARNING: possible circular locking dependency detected
4.19.0+ #73 Not tainted
------------------------------------------------------
syz-executor3/7244 is trying to acquire lock:
00000000e4a4dfcd ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000002036bf76 (&base->lock){..-.}, at: lock_timer_base+0xbb/0x2b0  
kernel/time/timer.c:938

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
        _do_fork+0x33b/0x11d0 kernel/fork.c:2238
        kernel_thread+0x34/0x40 kernel/fork.c:2272
        rest_init+0x28/0x372 init/main.c:408
        arch_call_rest_init+0xe/0x1b
        start_kernel+0xa1f/0xa5a init/main.c:744
        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1126 [inline]
        task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:9768
        sched_fork+0x443/0xba0 kernel/sched/core.c:2359
        copy_process+0x25b8/0x87a0 kernel/fork.c:1886
        _do_fork+0x1cb/0x11d0 kernel/fork.c:2213
        kernel_thread+0x34/0x40 kernel/fork.c:2272
        rest_init+0x28/0x372 init/main.c:408
        arch_call_rest_init+0xe/0x1b
        start_kernel+0xa1f/0xa5a init/main.c:744
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
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:237
        console_unlock+0x811/0x1190 kernel/printk/printk.c:2433
        vprintk_emit+0x391/0x990 kernel/printk/printk.c:1923
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1965
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1998
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
        __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:220
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2248
        console_trylock_spinning kernel/printk/printk.c:1654 [inline]
        vprintk_emit+0x372/0x990 kernel/printk/printk.c:1922
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1965
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1998
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

1 lock held by syz-executor3/7244:
  #0: 000000002036bf76 (&base->lock){..-.}, at: lock_timer_base+0xbb/0x2b0  
kernel/time/timer.c:938

stack backtrace:
CPU: 0 PID: 7244 Comm: syz-executor3 Not tainted 4.19.0+ #73
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
  __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:220
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2248
  console_trylock_spinning kernel/printk/printk.c:1654 [inline]
  vprintk_emit+0x372/0x990 kernel/printk/printk.c:1922
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1965
  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
  printk+0xa7/0xcf kernel/printk/printk.c:1998
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
  ?
Lost 44 message(s)!
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
CPU: 0 PID: 7259 Comm: syz-executor2 Not tainted 4.19.0+ #73
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f943721bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f943721bc90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f943721c6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
CPU: 0 PID: 7388 Comm: syz-executor2 Not tainted 4.19.0+ #73
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f943721bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f943721bc90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f943721c6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
CPU: 1 PID: 7424 Comm: syz-executor2 Not tainted 4.19.0+ #73
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  perf_release+0x37/0x50 kernel/events/core.c:4648
  __fput+0x385/0xa30 fs/file_table.c:278
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f943721bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
RAX: 0000000000000000 RBX: 00007f943721bc90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f943721c6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
CPU: 1 PID: 7432 Comm: syz-executor4 Not tainted 4.19.0+ #73
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff243023c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007ff243023c90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff2430246d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
CPU: 0 PID: 7435 Comm: syz-executor3 Not tainted 4.19.0+ #73
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f208e02ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f208e02ac90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f208e02b6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
FAULT_INJECTION: forcing a failure.
name fail_page_alloc, interval 1, probability 0, space 0, times 1
CPU: 0 PID: 7443 Comm: syz-executor0 Not tainted 4.19.0+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  should_fail_alloc_page mm/page_alloc.c:3069 [inline]
  prepare_alloc_pages mm/page_alloc.c:4332 [inline]
  __alloc_pages_nodemask+0x34b/0xde0 mm/page_alloc.c:4370
  alloc_pages_current+0x173/0x350 mm/mempolicy.c:2107
  alloc_pages include/linux/gfp.h:509 [inline]
  __get_free_pages+0xc/0x40 mm/page_alloc.c:4420
  tlb_next_batch mm/mmu_gather.c:29 [inline]
  __tlb_remove_page_size+0x2e5/0x500 mm/mmu_gather.c:133
  __tlb_remove_page include/asm-generic/tlb.h:187 [inline]
  zap_pte_range mm/memory.c:1094 [inline]
  zap_pmd_range mm/memory.c:1193 [inline]
  zap_pud_range mm/memory.c:1222 [inline]
  zap_p4d_range mm/memory.c:1243 [inline]
  unmap_page_range+0x11fb/0x2930 mm/memory.c:1264
  unmap_single_vma+0x19b/0x310 mm/memory.c:1309
  unmap_vmas+0x125/0x200 mm/memory.c:1339
  exit_mmap+0x2be/0x590 mm/mmap.c:3145
  __mmput kernel/fork.c:1044 [inline]
  mmput+0x247/0x610 kernel/fork.c:1065
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe74/0x26d0 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2d42c7fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f2d42c7fc90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2d42c806d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
CPU: 0 PID: 7675 Comm: syz-executor3 Not tainted 4.19.0+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f208e04bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f208e04bc90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f208e04c6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
CPU: 1 PID: 7694 Comm: syz-executor2 Not tainted 4.19.0+ #73
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f943721bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f943721bc90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f943721c6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
CPU: 1 PID: 7737 Comm: syz-executor0 Not tainted 4.19.0+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2d42ca0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f2d42ca0c90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2d42ca16d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
CPU: 1 PID: 7783 Comm: syz-executor1 Not tainted 4.19.0+ #73
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
kobject: 'loop3' (000000007775120b): kobject_uevent_env
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
  perf_release+0x37/0x50 kernel/events/core.c:4648
  __fput+0x385/0xa30 fs/file_table.c:278
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f11fb8f1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f11fb8f1c90 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f11fb8f26d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000002753bcc3): kobject_uevent_env
kobject: 'loop0' (000000002753bcc3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000ca5f18ac): kobject_uevent_env
kobject: 'loop5' (00000000ca5f18ac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (0000000047f33a84): kobject_uevent_env
kobject: 'loop4' (0000000047f33a84): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007775120b): kobject_uevent_env
kobject: 'loop3' (000000007775120b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003ed2dd85): kobject_uevent_env
kobject: 'loop2' (000000003ed2dd85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000ed884b05): kobject_uevent_env
kobject: 'loop1' (00000000ed884b05): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 7854 Comm: syz-executor1 Not tainted 4.19.0+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_array_alloc kernel/bpf/core.c:1587 [inline]
  bpf_prog_array_copy+0x345/0x420 kernel/bpf/core.c:1726
  perf_event_detach_bpf_prog+0x147/0x420 kernel/trace/bpf_trace.c:1015
  perf_event_free_bpf_prog kernel/events/core.c:8644 [inline]
  _free_event+0xf39/0x1660 kernel/events/core.c:4441
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
