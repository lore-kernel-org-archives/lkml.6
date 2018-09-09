Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C62C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A8F20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A8F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIIXbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:31:36 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:51708 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeIIXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:31:36 -0400
Received: by mail-it0-f69.google.com with SMTP id q5-v6so37630635ith.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 11:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1pZkZE/buUCG2WZPd1ODDiefBCNke9KNrTYh5LSGKso=;
        b=Sh5MjHUbDXHoM+O2nrM71fbhM+L1ZoK5iU02Dyc5aHhAmGC9rfuGM56MXJsCBN4HNh
         FL/Fb/OsxBkKltizdEiJD9YkYpTa75UCU1Eqx5MOUwZy/jdxNGJFaoLEeKsDOCnupzZA
         Fz3bmBDIS2nvW6Ez40Ceu3KdL1AF+F5ZgdtCrY+LjNF/azl++KQ4mQb67VcsjeaRhm10
         eh5mn8DtWgihxsYG4ShcC1CDVr8EUHx3EomLQxZ9oCiSncQWCJPvk1j/dKcXTM1EKnMF
         ZMFHggE3faOsM6cMYi6wD/1fnkyclNYrBP31wHzJjlEdpkcP6Y5VVgPiKHMyUfduiSGp
         DMiA==
X-Gm-Message-State: APzg51CG32+ouaWlLTLqWH0i8uGtXumm0A3h+4YYGYyuI3Pzyi8eoxkD
        B8MEnxZ3evVcR6HIVffyZkXAXfZWmVTZVQNJHWQ19KA6zuI9
X-Google-Smtp-Source: ANB0VdbR8sZG8X+wcJ5ItAkNrPODjGNo1otXF3OrfLX0hzGkfcAsukmLO0R+WUz1ihs8UekmnnFyQU2W3DQnl+zkrTfYv2eMMrFH
MIME-Version: 1.0
X-Received: by 2002:a02:1850:: with SMTP id k77-v6mr14853468jad.36.1536518462426;
 Sun, 09 Sep 2018 11:41:02 -0700 (PDT)
Date:   Sun, 09 Sep 2018 11:41:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024df4605757495a8@google.com>
Subject: possible deadlock in free_ioctx_users
From:   syzbot <syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113260ae400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=d86c4426a01f60feddc7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120baa9e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13979cbe400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)

========================================================
WARNING: possible irq lock inversion dependency detected
4.19.0-rc2+ #229 Not tainted
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at:  
free_ioctx_users+0xbc/0x710 fs/aio.c:603
but this lock took another, SOFTIRQ-unsafe lock in the past:
  (&fiq->waitq){+.+.}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&fiq->waitq);
                                local_irq_disable();
                                lock(&(&ctx->ctx_lock)->rlock);
                                lock(&fiq->waitq);
   <Interrupt>
     lock(&(&ctx->ctx_lock)->rlock);

  *** DEADLOCK ***

2 locks held by swapper/0/0:
  #0: 0000000077c9a56b (rcu_callback){....}, at: __rcu_reclaim  
kernel/rcu/rcu.h:226 [inline]
  #0: 0000000077c9a56b (rcu_callback){....}, at: rcu_do_batch  
kernel/rcu/tree.c:2576 [inline]
  #0: 0000000077c9a56b (rcu_callback){....}, at: invoke_rcu_callbacks  
kernel/rcu/tree.c:2880 [inline]
  #0: 0000000077c9a56b (rcu_callback){....}, at: __rcu_process_callbacks  
kernel/rcu/tree.c:2847 [inline]
  #0: 0000000077c9a56b (rcu_callback){....}, at:  
rcu_process_callbacks+0x1012/0x2670 kernel/rcu/tree.c:2864
  #1: 0000000031dcf310 (rcu_read_lock_sched){....}, at:  
percpu_ref_call_confirm_rcu lib/percpu-refcount.c:119 [inline]
  #1: 0000000031dcf310 (rcu_read_lock_sched){....}, at:  
percpu_ref_switch_to_atomic_rcu+0x2b7/0x820 lib/percpu-refcount.c:158

the shortest dependencies between 2nd lock and 1st lock:
  -> (&fiq->waitq){+.+.} ops: 4 {
     HARDIRQ-ON-W at:
                       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                       __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                       _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                       spin_lock include/linux/spinlock.h:329 [inline]
                       flush_bg_queue+0x389/0x650 fs/fuse/dev.c:364
                       fuse_request_send_background_locked+0x2f5/0x5a0  
fs/fuse/dev.c:598
                       fuse_request_send_background+0x135/0x180  
fs/fuse/dev.c:606
                       cuse_send_init fs/fuse/cuse.c:458 [inline]
                       cuse_channel_open+0x6b0/0x963 fs/fuse/cuse.c:518
                       misc_open+0x3ca/0x560 drivers/char/misc.c:141
                       chrdev_open+0x25a/0x710 fs/char_dev.c:417
                       do_dentry_open+0x499/0x1250 fs/open.c:771
                       vfs_open+0xa0/0xd0 fs/open.c:880
                       do_last fs/namei.c:3418 [inline]
                       path_openat+0x12bf/0x5160 fs/namei.c:3534
                       do_filp_open+0x255/0x380 fs/namei.c:3564
                       do_sys_open+0x568/0x700 fs/open.c:1063
                       __do_sys_openat fs/open.c:1090 [inline]
                       __se_sys_openat fs/open.c:1084 [inline]
                       __x64_sys_openat+0x9d/0x100 fs/open.c:1084
                       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                       entry_SYSCALL_64_after_hwframe+0x49/0xbe
     SOFTIRQ-ON-W at:
                       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                       __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                       _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                       spin_lock include/linux/spinlock.h:329 [inline]
                       flush_bg_queue+0x389/0x650 fs/fuse/dev.c:364
                       fuse_request_send_background_locked+0x2f5/0x5a0  
fs/fuse/dev.c:598
                       fuse_request_send_background+0x135/0x180  
fs/fuse/dev.c:606
                       cuse_send_init fs/fuse/cuse.c:458 [inline]
                       cuse_channel_open+0x6b0/0x963 fs/fuse/cuse.c:518
                       misc_open+0x3ca/0x560 drivers/char/misc.c:141
                       chrdev_open+0x25a/0x710 fs/char_dev.c:417
                       do_dentry_open+0x499/0x1250 fs/open.c:771
                       vfs_open+0xa0/0xd0 fs/open.c:880
                       do_last fs/namei.c:3418 [inline]
                       path_openat+0x12bf/0x5160 fs/namei.c:3534
                       do_filp_open+0x255/0x380 fs/namei.c:3564
                       do_sys_open+0x568/0x700 fs/open.c:1063
                       __do_sys_openat fs/open.c:1090 [inline]
                       __se_sys_openat fs/open.c:1084 [inline]
                       __x64_sys_openat+0x9d/0x100 fs/open.c:1084
                       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                       entry_SYSCALL_64_after_hwframe+0x49/0xbe
     INITIAL USE at:
                      lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                      _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                      spin_lock include/linux/spinlock.h:329 [inline]
                      flush_bg_queue+0x389/0x650 fs/fuse/dev.c:364
                      fuse_request_send_background_locked+0x2f5/0x5a0  
fs/fuse/dev.c:598
                      fuse_request_send_background+0x135/0x180  
fs/fuse/dev.c:606
                      cuse_send_init fs/fuse/cuse.c:458 [inline]
                      cuse_channel_open+0x6b0/0x963 fs/fuse/cuse.c:518
                      misc_open+0x3ca/0x560 drivers/char/misc.c:141
                      chrdev_open+0x25a/0x710 fs/char_dev.c:417
                      do_dentry_open+0x499/0x1250 fs/open.c:771
                      vfs_open+0xa0/0xd0 fs/open.c:880
                      do_last fs/namei.c:3418 [inline]
                      path_openat+0x12bf/0x5160 fs/namei.c:3534
                      do_filp_open+0x255/0x380 fs/namei.c:3564
                      do_sys_open+0x568/0x700 fs/open.c:1063
                      __do_sys_openat fs/open.c:1090 [inline]
                      __se_sys_openat fs/open.c:1084 [inline]
                      __x64_sys_openat+0x9d/0x100 fs/open.c:1084
                      do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                      entry_SYSCALL_64_after_hwframe+0x49/0xbe
   }
   ... key      at: [<ffffffff8b4763c0>] __key.42168+0x0/0x40
   ... acquired at:
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    aio_poll+0x760/0x1420 fs/aio.c:1747
    io_submit_one+0xab8/0x1090 fs/aio.c:1850
    __do_sys_io_submit fs/aio.c:1916 [inline]
    __se_sys_io_submit fs/aio.c:1887 [inline]
    __x64_sys_io_submit+0x1b9/0x5d0 fs/aio.c:1887
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> (&(&ctx->ctx_lock)->rlock){..-.} ops: 2 {
    IN-SOFTIRQ-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                     __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                     _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                     spin_lock_irq include/linux/spinlock.h:354 [inline]
                     free_ioctx_users+0xbc/0x710 fs/aio.c:603
                     percpu_ref_put_many include/linux/percpu-refcount.h:284  
[inline]
                     percpu_ref_put include/linux/percpu-refcount.h:300  
[inline]
                     percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
                     percpu_ref_switch_to_atomic_rcu+0x62c/0x820  
lib/percpu-refcount.c:158
                     __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
                     rcu_do_batch kernel/rcu/tree.c:2576 [inline]
                     invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
                     __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
                     rcu_process_callbacks+0xf23/0x2670  
kernel/rcu/tree.c:2864
                     __do_softirq+0x30b/0xad8 kernel/softirq.c:292
                     invoke_softirq kernel/softirq.c:372 [inline]
                     irq_exit+0x17f/0x1c0 kernel/softirq.c:412
                     exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                     smp_apic_timer_interrupt+0x1cb/0x760  
arch/x86/kernel/apic/apic.c:1056
                     apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:864
                     native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:57
                     arch_safe_halt arch/x86/include/asm/paravirt.h:94  
[inline]
                     default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
                     arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
                     default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
                     cpuidle_idle_call kernel/sched/idle.c:153 [inline]
                     do_idle+0x3db/0x5b0 kernel/sched/idle.c:262
                     cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
                     rest_init+0xe2/0xe5 init/main.c:442
                     start_kernel+0x8f4/0x92f init/main.c:739
                     x86_64_start_reservations+0x29/0x2b  
arch/x86/kernel/head64.c:452
                     x86_64_start_kernel+0x76/0x79  
arch/x86/kernel/head64.c:433
                     secondary_startup_64+0xa4/0xb0  
arch/x86/kernel/head_64.S:242
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128  
[inline]
                    _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                    spin_lock_irq include/linux/spinlock.h:354 [inline]
                    aio_poll+0x738/0x1420 fs/aio.c:1746
                    io_submit_one+0xab8/0x1090 fs/aio.c:1850
                    __do_sys_io_submit fs/aio.c:1916 [inline]
                    __se_sys_io_submit fs/aio.c:1887 [inline]
                    __x64_sys_io_submit+0x1b9/0x5d0 fs/aio.c:1887
                    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8b3dc960>] __key.50120+0x0/0x40
  ... acquired at:
    mark_lock_irq kernel/locking/lockdep.c:2756 [inline]
    mark_lock+0xa6b/0x1cb0 kernel/locking/lockdep.c:3128
    mark_irqflags kernel/locking/lockdep.c:3006 [inline]
    __lock_acquire+0x15f8/0x4ec0 kernel/locking/lockdep.c:3369
    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
    _raw_spin_lock_irq+0x61/0x80 kernel/locking/spinlock.c:160
    spin_lock_irq include/linux/spinlock.h:354 [inline]
    free_ioctx_users+0xbc/0x710 fs/aio.c:603
    percpu_ref_put_many include/linux/percpu-refcount.h:284 [inline]
    percpu_ref_put include/linux/percpu-refcount.h:300 [inline]
    percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123 [inline]
    percpu_ref_switch_to_atomic_rcu+0x62c/0x820 lib/percpu-refcount.c:158
    __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
    rcu_do_batch kernel/rcu/tree.c:2576 [inline]
    invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
    __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
    rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
    __do_softirq+0x30b/0xad8 kernel/softirq.c:292
    invoke_softirq kernel/softirq.c:372 [inline]
    irq_exit+0x17f/0x1c0 kernel/softirq.c:412
    exiting_irq arch/x86/include/asm/apic.h:536 [inline]
    smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1056
    apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
    native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
    arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
    default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
    arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
    default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
    cpuidle_idle_call kernel/sched/idle.c:153 [inline]
    do_idle+0x3db/0x5b0 kernel/sched/idle.c:262
    cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
    rest_init+0xe2/0xe5 init/main.c:442
    start_kernel+0x8f4/0x92f init/main.c:739
    x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
    x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
    secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc2+ #229
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_irq_inversion_bug.part.35+0x2c7/0x2d6 kernel/locking/lockdep.c:2622
  print_irq_inversion_bug kernel/locking/lockdep.c:2625 [inline]
  check_usage_forwards.cold.57+0x20/0x29 kernel/locking/lockdep.c:2647
  mark_lock_irq kernel/locking/lockdep.c:2756 [inline]
  mark_lock+0xa6b/0x1cb0 kernel/locking/lockdep.c:3128
  mark_irqflags kernel/locking/lockdep.c:3006 [inline]
  __lock_acquire+0x15f8/0x4ec0 kernel/locking/lockdep.c:3369
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x61/0x80 kernel/locking/spinlock.c:160
  spin_lock_irq include/linux/spinlock.h:354 [inline]
  free_ioctx_users+0xbc/0x710 fs/aio.c:603
  percpu_ref_put_many include/linux/percpu-refcount.h:284 [inline]
  percpu_ref_put include/linux/percpu-refcount.h:300 [inline]
  percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123 [inline]
  percpu_ref_switch_to_atomic_rcu+0x62c/0x820 lib/percpu-refcount.c:158
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:372 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:412
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1056
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 43 b9 02 fa 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 32 b9 02 fa eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffffffff89407bb8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffffffff1280f7b RCX: 0000000000000000
RDX: 1ffffffff12a4538 RSI: 0000000000000001 RDI: ffffffff895229c0
RBP: ffffffff89407bb8 R08: ffffffff89475fc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89407c78
R13: ffffffff8a3149a0 R14: 0000000000000000 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3db/0x5b0 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  rest_init+0xe2/0xe5 init/main.c:442
  start_kernel+0x8f4/0x92f init/main.c:739
  ? early_idt_handler_common+


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
