Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E98C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C1E206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C1E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeIJMds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:33:48 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:38450 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:33:47 -0400
Received: by mail-it0-f72.google.com with SMTP id h5-v6so37790890itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MmWUibl0abC/x5sPbzV7if6/HPV6N7eTGNIfhk1dbls=;
        b=U1Q8MSjEWC307sFbXS3DeI0IpzXtURPu8YqN8v6KZr6VJa51xVxCsL6S7n/vMQvqiz
         BvvmnZFMKomZmvyikMo8xpq64c9Ds6hi8qEW/oV0b8eyVoflGS3II+KQfsih5MIlybvX
         JLRiQAisaCObKkedSMod68Byx+eUlVT/UeWvpq7/WzcRWUE09N4woXg/Qxn/vYgd8vTI
         CfpQrphhmkEvCtl2QAG2e0kVl/LSPuUTZEVtOA1RLgOhA0ndTrO5O+6NHVrExy5+YM9G
         sINVsT2f7UjYpx5lNOaHeFqAqNaXewvNwk7SIu2arNWLx02tORNkLdUfvQdGQhuSTf9e
         9/Kw==
X-Gm-Message-State: APzg51DBZ9hvazEoqKHHUQ/8w5Gy/i0ZwJHS6yB9aqslB/3TuFDu3uMQ
        NFi1PlzSol6dNDmdcekGdaFp5P6Ou4Yp0Vcd16FXGoxijLsy
X-Google-Smtp-Source: ANB0VdaHd99RW7/o/3OcvO3Cj3fngB4Av3drsklKA74Axg3jIJ1Q8dR4DGr0En9RDBxhsw1co6Z3qWeON2jghrXKH+ElllaDyHOu
MIME-Version: 1.0
X-Received: by 2002:a6b:c94f:: with SMTP id z76-v6mr1088107iof.13.1536565265015;
 Mon, 10 Sep 2018 00:41:05 -0700 (PDT)
Date:   Mon, 10 Sep 2018 00:41:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbb35d05757f7a3a@google.com>
Subject: possible deadlock in aio_poll
From:   syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1587e266400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1df0420c523b45a953
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1753bdca400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
4.19.0-rc2+ #229 Not tainted
-----------------------------------------------------
syz-executor2/9399 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
00000000126506e0 (&ctx->fd_wqh){+.+.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
00000000126506e0 (&ctx->fd_wqh){+.+.}, at: aio_poll+0x760/0x1420  
fs/aio.c:1747

and this task is already holding:
000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at:  
aio_poll+0x738/0x1420 fs/aio.c:1746
which would create a new lock dependency:
  (&(&ctx->ctx_lock)->rlock){..-.} -> (&ctx->fd_wqh){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
  (&(&ctx->ctx_lock)->rlock){..-.}

... which became SOFTIRQ-irq-safe at:
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
   start_secondary+0x523/0x750 arch/x86/kernel/smpboot.c:271
   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

to a SOFTIRQ-irq-unsafe lock:
  (&ctx->fd_wqh){+.+.}

... which became SOFTIRQ-irq-unsafe at:
...
   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
   userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
   do_loop_readv_writev fs/read_write.c:700 [inline]
   do_iter_read+0x4a3/0x650 fs/read_write.c:924
   vfs_readv+0x175/0x1c0 fs/read_write.c:986
   do_readv+0x11a/0x310 fs/read_write.c:1019
   __do_sys_readv fs/read_write.c:1106 [inline]
   __se_sys_readv fs/read_write.c:1103 [inline]
   __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
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

1 lock held by syz-executor2/9399:
  #0: 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
  #0: 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at:  
aio_poll+0x738/0x1420 fs/aio.c:1746

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&(&ctx->ctx_lock)->rlock){..-.} ops: 387 {
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
                     start_secondary+0x523/0x750  
arch/x86/kernel/smpboot.c:271
                     secondary_startup_64+0xa4/0xb0  
arch/x86/kernel/head_64.S:242
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128  
[inline]
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
                    rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
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
                    start_secondary+0x523/0x750 arch/x86/kernel/smpboot.c:271
                    secondary_startup_64+0xa4/0xb0  
arch/x86/kernel/head_64.S:242
  }
  ... key      at: [<ffffffff8b3dc960>] __key.50120+0x0/0x40
  ... acquired at:
    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
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


the dependencies between the lock to be acquired
  and SOFTIRQ-irq-unsafe lock:
-> (&ctx->fd_wqh){+.+.} ops: 2209 {
    HARDIRQ-ON-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
                     userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
                     do_loop_readv_writev fs/read_write.c:700 [inline]
                     do_iter_read+0x4a3/0x650 fs/read_write.c:924
                     vfs_readv+0x175/0x1c0 fs/read_write.c:986
                     do_readv+0x11a/0x310 fs/read_write.c:1019
                     __do_sys_readv fs/read_write.c:1106 [inline]
                     __se_sys_readv fs/read_write.c:1103 [inline]
                     __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
                     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    SOFTIRQ-ON-W at:
                     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
                     userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
                     do_loop_readv_writev fs/read_write.c:700 [inline]
                     do_iter_read+0x4a3/0x650 fs/read_write.c:924
                     vfs_readv+0x175/0x1c0 fs/read_write.c:986
                     do_readv+0x11a/0x310 fs/read_write.c:1019
                     __do_sys_readv fs/read_write.c:1106 [inline]
                     __se_sys_readv fs/read_write.c:1103 [inline]
                     __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
                     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
                    spin_lock include/linux/spinlock.h:329 [inline]
                    userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
                    userfaultfd_read+0x1e2/0x2c0 fs/userfaultfd.c:1191
                    do_loop_readv_writev fs/read_write.c:700 [inline]
                    do_iter_read+0x4a3/0x650 fs/read_write.c:924
                    vfs_readv+0x175/0x1c0 fs/read_write.c:986
                    do_readv+0x11a/0x310 fs/read_write.c:1019
                    __do_sys_readv fs/read_write.c:1106 [inline]
                    __se_sys_readv fs/read_write.c:1103 [inline]
                    __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
                    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8b3dc6e0>] __key.43670+0x0/0x40
  ... acquired at:
    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
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


stack backtrace:
CPU: 0 PID: 9399 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #229
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_bad_irq_dependency kernel/locking/lockdep.c:1569 [inline]
  check_usage.cold.58+0x6d5/0xad1 kernel/locking/lockdep.c:1601
  check_irq_usage kernel/locking/lockdep.c:1657 [inline]
  check_prev_add_irq kernel/locking/lockdep_states.h:8 [inline]
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1975 [inline]
  validate_chain kernel/locking/lockdep.c:2416 [inline]
  __lock_acquire+0x2400/0x4ec0 kernel/locking/lockdep.c:3412
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
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
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa4bd11bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007fa4bd11c6d4 RCX: 0000000000457099
RDX: 0000000020000b00 RSI: 0000000000000001 RDI: 00007fa4bd13e000
RBP: 00000000009301e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cd990 R14: 00000000004c40a7 R15: 0000000000000002
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000fd2f09a6): kobject_uevent_env
kobject: 'loop1' (00000000fd2f09a6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop6' (00000000790743e9): kobject_uevent_env
kobject: 'loop6' (00000000790743e9): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop7' (00000000b52cfd8a): kobject_uevent_env
kobject: 'loop7' (00000000b52cfd8a): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop2' (000000002d051810): kobject_uevent_env
kobject: 'loop2' (000000002d051810): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000044e01f3d): kobject_uevent_env
kobject: 'loop5' (0000000044e01f3d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003f6c580a): kobject_uevent_env
kobject: 'loop4' (000000003f6c580a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000001d0a0601): kobject_uevent_env
kobject: 'loop3' (000000001d0a0601): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000005501af28): kobject_uevent_env
kobject: 'loop0' (000000005501af28): fill_kobj_path: path  
= '/devices/virtual/block/loop0'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
