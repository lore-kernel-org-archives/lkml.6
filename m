Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B661AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7617B218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfADQhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:37:09 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:35334 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:37:06 -0500
Received: by mail-it1-f198.google.com with SMTP id v188so1525189ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yGmd2kVuLQ18e0AlR+S7andwAnIoQYUVRMu0RY0x0O0=;
        b=o2o/sHhKTJwizE4B7fPril4Tuj6sMmfZfxBbl4ZliFNIQVN+zCWmLfNYU2zY0zwOxN
         WrRxp6e/7SFSbyiKtXKCwv28aJ5xhGPpZSLxJzeCJkjtcV5wdg1Vz6PKm+Ikb6PcbJxT
         Lwpk/gPDB6Hjv+c3WzvDwgw06OC5GgGkHww68/P7dNQ4K0E0NdAWcCxC+Fx0exccHvLg
         n9SfXsbObDvOMVvkSUB1SSNannQvsWiCxkYRJzBnbhAim/QdUdBS5FSKGG/iXnVaSuwt
         McwyaAJUpJbgc4PI88M3/B5GOKusKvkWpdFggJWUia7VVUvOzj5OzfLm+NhS7D1EM1sJ
         WZYA==
X-Gm-Message-State: AJcUukenMgvqOoVy/ab2rEHIULySfMHD2SpKAuntIxKRMTsF0gxW23LG
        rQNcZGFHWOL7Er2Ty0faT5vaZU2z9QnKEMC2ETqA3jmHsbbd
X-Google-Smtp-Source: ALg8bN4rJHz+6pVfwkS/sMK30sq/qe2oG09BqpknYQdPd5CLTvNF1y+1YFstXHSG/T4N9FoPQFi6bpl6ktGMjXZqMQNWWI9JmlWW
MIME-Version: 1.0
X-Received: by 2002:a24:ac5f:: with SMTP id m31mr1522047iti.19.1546619823686;
 Fri, 04 Jan 2019 08:37:03 -0800 (PST)
Date:   Fri, 04 Jan 2019 08:37:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000319249057ea47d36@google.com>
Subject: KASAN: stack-out-of-bounds Read in timerqueue_add (2)
From:   syzbot <syzbot+e9d7ff8272314cfce80d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a1d293238c1 Add linux-next specific files for 20181224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c483fd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af046212050aa3ac
dashboard link: https://syzkaller.appspot.com/bug?extid=e9d7ff8272314cfce80d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b21480c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1345f5bf400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9d7ff8272314cfce80d@syzkaller.appspotmail.com

==================================================================
kasan: CONFIG_KASAN_INLINE enabled
BUG: KASAN: stack-out-of-bounds in timerqueue_add+0x2a5/0x320  
lib/timerqueue.c:52
kasan: GPF could be caused by NULL-ptr deref or user memory access
Read of size 8 at addr ffff8880a941f478 by task syz-executor881/7978
general protection fault: 0000 [#1] PREEMPT SMP KASAN

CPU: 1 PID: 3 Comm:  Not tainted 4.20.0-rc7-next-20181224 #1
CPU: 0 PID: 7978 Comm: syz-executor881 Not tainted 4.20.0-rc7-next-20181224  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:191 [inline]
RIP: 0010:get_running_cputimer include/linux/sched/cputime.h:85 [inline]
RIP: 0010:account_group_system_time include/linux/sched/cputime.h:149  
[inline]
RIP: 0010:account_system_index_time+0xe8/0x5f0 kernel/sched/cputime.c:168
Call Trace:
Code: 04 00 00 49 8b 84 24 00 07 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d  
b8 40 01 00 00 48 8d 88 28 01 00 00 48 89 fe 48 c1 ee 03 <0f> b6 14 16 48  
89 fe 83 e6 07 40 38 f2 7f 08 84 d2 0f 85 93 03 00
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
RSP: 0018:ffff8880ae707a80 EFLAGS: 00010006
RAX: 0000000041b58ab3 RBX: 1ffff11015ce0f54 RCX: 0000000041b58bdb
RDX: dffffc0000000000 RSI: 000000000836b17e RDI: 0000000041b58bf3
RBP: ffff8880ae707b48 R08: ffff8880ae71f5f0 R09: fffffbfff1335b3d
R10: fffffbfff1301b45 R11: ffffffff899ad9e3 R12: ffff8880a94c4440
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
R13: 000000000077a391 R14: 0000000000000003 R15: ffff8880ae707b20
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
CR2: 00000000006d7090 CR3: 0000000096f60000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
Call Trace:
  timerqueue_add+0x2a5/0x320 lib/timerqueue.c:52
  <IRQ>
  enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
  __hrtimer_start_range_ns kernel/time/hrtimer.c:1080 [inline]
  hrtimer_start_range_ns+0x62a/0xda0 kernel/time/hrtimer.c:1106
  irqtime_account_process_tick.isra.0+0x3a2/0x490 kernel/sched/cputime.c:380
  account_process_tick+0x27f/0x350 kernel/sched/cputime.c:483
  update_process_times+0x25/0x80 kernel/time/timer.c:1633
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:161
  hrtimer_start_expires include/linux/hrtimer.h:409 [inline]
  do_nanosleep+0x1a2/0x750 kernel/time/hrtimer.c:1676
  tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x3a7/0x1050 kernel/time/hrtimer.c:1451
  hrtimer_nanosleep+0x2e4/0x640 kernel/time/hrtimer.c:1733
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
  __do_sys_nanosleep kernel/time/hrtimer.c:1767 [inline]
  __se_sys_nanosleep kernel/time/hrtimer.c:1754 [inline]
  __x64_sys_nanosleep+0x1e0/0x280 kernel/time/hrtimer.c:1754
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Modules linked in:
RIP: 0033:0x443ae0

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc7-next-20181224 #1 Not tainted
------------------------------------------------------
syz-executor881/7978 is trying to acquire lock:
000000007874c6ae ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000001e99e9d7 (report_lock){....}, at: start_report mm/kasan/report.c:85  
[inline]
000000001e99e9d7 (report_lock){....}, at: kasan_report+0xb1/0x15e  
mm/kasan/report.c:309

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (report_lock){....}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        start_report mm/kasan/report.c:85 [inline]
        kasan_report+0xb1/0x15e mm/kasan/report.c:309
        __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
        timerqueue_add+0x2a5/0x320 lib/timerqueue.c:52
        enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
        __hrtimer_start_range_ns kernel/time/hrtimer.c:1080 [inline]
        hrtimer_start_range_ns+0x62a/0xda0 kernel/time/hrtimer.c:1106
        hrtimer_start_expires include/linux/hrtimer.h:409 [inline]
        do_nanosleep+0x1a2/0x750 kernel/time/hrtimer.c:1676
        hrtimer_nanosleep+0x2e4/0x640 kernel/time/hrtimer.c:1733
        __do_sys_nanosleep kernel/time/hrtimer.c:1767 [inline]
        __se_sys_nanosleep kernel/time/hrtimer.c:1754 [inline]
        __x64_sys_nanosleep+0x1e0/0x280 kernel/time/hrtimer.c:1754
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #4 (hrtimer_bases.lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        lock_hrtimer_base.isra.0+0x75/0x130 kernel/time/hrtimer.c:165
        hrtimer_start_range_ns+0x120/0xda0 kernel/time/hrtimer.c:1104
        hrtimer_start_expires include/linux/hrtimer.h:409 [inline]
        start_rt_bandwidth kernel/sched/rt.c:70 [inline]
        inc_rt_group kernel/sched/rt.c:1147 [inline]
        inc_rt_tasks kernel/sched/rt.c:1191 [inline]
        __enqueue_rt_entity kernel/sched/rt.c:1261 [inline]
        enqueue_rt_entity kernel/sched/rt.c:1305 [inline]
        enqueue_task_rt+0x95b/0x1010 kernel/sched/rt.c:1335
        enqueue_task+0xb9/0x380 kernel/sched/core.c:730
        __sched_setscheduler+0xe32/0x1fe0 kernel/sched/core.c:4336
        _sched_setscheduler+0x218/0x340 kernel/sched/core.c:4373
        sched_setscheduler+0xe/0x10 kernel/sched/core.c:4388
        watchdog_dev_init+0x109/0x1db drivers/watchdog/watchdog_dev.c:1144
        watchdog_init+0x81/0x294 drivers/watchdog/watchdog_core.c:355
        do_one_initcall+0x129/0x937 init/main.c:888
        do_initcall_level init/main.c:956 [inline]
        do_initcalls init/main.c:964 [inline]
        do_basic_setup init/main.c:982 [inline]
        kernel_init_freeable+0x4db/0x5ca init/main.c:1135
        kernel_init+0x12/0x1c5 init/main.c:1055
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #3 (&rt_b->rt_runtime_lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
        __enable_runtime kernel/sched/rt.c:786 [inline]
        rq_online_rt+0xb4/0x390 kernel/sched/rt.c:2178
        set_rq_online.part.0+0xe7/0x140 kernel/sched/core.c:5666
        set_rq_online kernel/sched/core.c:5772 [inline]
        sched_cpu_activate+0x29e/0x430 kernel/sched/core.c:5765
        cpuhp_invoke_callback+0x2f6/0x2110 kernel/cpu.c:168
        cpuhp_thread_fun+0x496/0x8a0 kernel/cpu.c:685
        smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
        kthread+0x357/0x430 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1149 [inline]
        task_fork_fair+0xb5/0x7a0 kernel/sched/fair.c:10083
        sched_fork+0x437/0xb90 kernel/sched/core.c:2359
        copy_process+0x1ff6/0x8720 kernel/fork.c:1887
        _do_fork+0x1a9/0x1170 kernel/fork.c:2216
        kernel_thread+0x34/0x40 kernel/fork.c:2275
        rest_init+0x28/0x37b init/main.c:408
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x882/0x8bd init/main.c:740
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        try_to_wake_up+0xb9/0x1480 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.0+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13e/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xb7/0x1c0 kernel/printk/printk.c:236
        console_unlock+0x743/0x1040 kernel/printk/printk.c:2473
        vprintk_emit+0x370/0x960 kernel/printk/printk.c:1978
        vprintk_default+0x28/0x30 kernel/printk/printk.c:2005
        vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
        printk+0xba/0xed kernel/printk/printk.c:2038
        check_stack_usage kernel/exit.c:755 [inline]
        do_exit.cold+0x57/0x16a kernel/exit.c:916
        do_group_exit+0x177/0x430 kernel/exit.c:970
        __do_sys_exit_group kernel/exit.c:981 [inline]
        __se_sys_exit_group kernel/exit.c:979 [inline]
        __x64_sys_exit_group+0x44/0x50 kernel/exit.c:979
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2289
        console_trylock_spinning kernel/printk/printk.c:1709 [inline]
        vprintk_emit+0x351/0x960 kernel/printk/printk.c:1977
        vprintk_default+0x28/0x30 kernel/printk/printk.c:2005
        vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
        printk+0xba/0xed kernel/printk/printk.c:2038
        start_report mm/kasan/report.c:86 [inline]
        kasan_report+0xc1/0x15e mm/kasan/report.c:309
        __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
        timerqueue_add+0x2a5/0x320 lib/timerqueue.c:52
        enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
        __hrtimer_start_range_ns kernel/time/hrtimer.c:1080 [inline]
        hrtimer_start_range_ns+0x62a/0xda0 kernel/time/hrtimer.c:1106
        hrtimer_start_expires include/linux/hrtimer.h:409 [inline]
        do_nanosleep+0x1a2/0x750 kernel/time/hrtimer.c:1676
        hrtimer_nanosleep+0x2e4/0x640 kernel/time/hrtimer.c:1733
        __do_sys_nanosleep kernel/time/hrtimer.c:1767 [inline]
        __se_sys_nanosleep kernel/time/hrtimer.c:1754 [inline]
        __x64_sys_nanosleep+0x1e0/0x280 kernel/time/hrtimer.c:1754
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> hrtimer_bases.lock --> report_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(report_lock);
                                lock(hrtimer_bases.lock);
                                lock(report_lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

2 locks held by syz-executor881/7978:
  #0: 0000000053a4f5fc (hrtimer_bases.lock){-.-.}, at:  
lock_hrtimer_base.isra.0+0x75/0x130 kernel/time/hrtimer.c:165
  #1: 000000001e99e9d7 (report_lock){....}, at: start_report  
mm/kasan/report.c:85 [inline]
  #1: 000000001e99e9d7 (report_lock){....}, at: kasan_report+0xb1/0x15e  
mm/kasan/report.c:309

stack backtrace:
CPU: 0 PID: 7978 Comm: syz-executor881 Not tainted 4.20.0-rc7-next-20181224  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1224
  check_prev_add kernel/locking/lockdep.c:1866 [inline]
  check_prevs_add kernel/locking/lockdep.c:1979 [inline]
  validate_chain kernel/locking/lockdep.c:2350 [inline]
  __lock_acquire+0x2fed/0x4a10 kernel/locking/lockdep.c:3338
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2289
  console_trylock_spinning kernel/printk/printk.c:1709 [inline]
  vprintk_emit+0x351/0x960 kernel/printk/printk.c:1977
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2005
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
  printk+0xba/0xed kernel/printk/printk.c:2038
  start_report mm/kasan/report.c:86 [inline]
  kasan_report+0xc1/0x15e mm/kasan/report.c:309
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  timerqueue_add+0x2a5/0x320 lib/timerqueue.c:52
  enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
  __hrtimer_start_range_ns kernel/time/hrtimer.c:1080 [inline]
  hrtimer_start_range_ns+0x62a/0xda0 kernel/time/hrtimer.c:1106
  hrtimer_start_expires include/linux/hrtimer.h:409 [inline]
  do_nanosleep+0x1a2/0x750 kernel/time/hrtimer.c:1676
  hrtimer_nanosleep+0x2e4/0x640 kernel/time/hrtimer.c:1733
  __do_sys_nanosleep kernel/time/hrtimer.c:1767 [inline]
  __se_sys_nanosleep kernel/time/hrtimer.c:1754 [inline]
  __x64_sys_nanosleep+0x1e0/0x280 kernel/time/hrtimer.c:1754
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443ae0
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f  
44 00 00 83 3d 11 b5 29 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 74 21 fc ff c3 48 83 ec 08 e8 4a 44 00 00
RSP: 002b:00007ffc84f7ff38 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 0000000000000978 RCX: 0000000000443ae0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc84f7ff40
RBP: 0000000000000978 R08: 0000000000000001 R09: 0000000001e99940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000976
R13: 0000000000127235 R14: 0000000000000000 R15: 0000000000000000
---[ end trace 45e69f5e272f25f9 ]---
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f  
44 00 00 83 3d 11 b5 29 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 74 21 fc ff c3 48 83 ec 08 e8 4a 44 00 00
RIP: 0010:__read_once_size include/linux/compiler.h:191 [inline]
RIP: 0010:get_running_cputimer include/linux/sched/cputime.h:85 [inline]
RIP: 0010:account_group_system_time include/linux/sched/cputime.h:149  
[inline]
RIP: 0010:account_system_index_time+0xe8/0x5f0 kernel/sched/cputime.c:168
RSP: 002b:00007ffc84f7ff38 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
Code: 04 00 00 49 8b 84 24 00 07 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d  
b8 40 01 00 00 48 8d 88 28 01 00 00 48 89 fe 48 c1 ee 03 <0f> b6 14 16 48  
89 fe 83 e6 07 40 38 f2 7f 08 84 d2 0f 85 93 03 00
RAX: ffffffffffffffda RBX: 0000000000000978 RCX: 0000000000443ae0
RSP: 0018:ffff8880ae707a80 EFLAGS: 00010006
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc84f7ff40
RAX: 0000000041b58ab3 RBX: 1ffff11015ce0f54 RCX: 0000000041b58bdb
RBP: 0000000000000978 R08: 0000000000000001 R09: 0000000001e99940
RDX: dffffc0000000000 RSI: 000000000836b17e RDI: 0000000041b58bf3
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000976
RBP: ffff8880ae707b48 R08: ffff8880ae71f5f0 R09: fffffbfff1335b3d
R13: 0000000000127235 R14: 0000000000000000 R15: 0000000000000000
R10: fffffbfff1301b45 R11: ffffffff899ad9e3 R12: ffff8880a94c4440

R13: 000000000077a391 R14: 0000000000000003 R15: ffff8880ae707b20
The buggy address belongs to the page:
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
page:ffffea0002a507c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
flags: 0x1fffc0000000000()
CR2: 00000000006d7090 CR3: 0000000096f60000 CR4: 00000000001406e0
raw: 01fffc0000000000 ffffea0002a507c8 ffffea0002a507c8 0000000000000000
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
page dumped because: kasan: bad access detected


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
