Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAAAC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA002086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA002086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIJNIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:08:55 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:39676 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeIJNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:08:54 -0400
Received: by mail-it0-f72.google.com with SMTP id w196-v6so37857524itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EEsbTmR1Z7eD8INvyq3L7JED67+m1hfknMsgC2NaUhA=;
        b=QofLxzurQVVqsomfM6z+njsbXrrgArmPwsJxEYtGPLX5MEDuB1aY8o6UGexiVKE1d7
         3Obxjt/QMaVBXV+2BEGjHoYcuACI+eP/ypYLvTShp8qCgNej8npH1qfL11Ub/GVlzr4v
         RzfC4PARbVLD/qpvxrYfhn5oEyTkrRjI/9kzC2MczXWUXw5MA1MHCKwWrC/Rz+IKAMJK
         8e8+5WpgSAR9T1KU27EA3Yxcvh5ne1wlPnd2x6CtlbX3T9H+FdaIOWhjyudaIZEc9Ng5
         HPE/KH1F/rONruPjKB6LDhnUAnGiPGnLSyrtPIAg1aoZpBZwI+BMIA4Q4V9GcrCkzuM2
         brjQ==
X-Gm-Message-State: APzg51ClHWZ8tHkyEy29khGW5vBNfUgQM2ILNXy0KJPUGENr/lshSjZt
        js3Swa7S4kdPGp265+Wc9j4hA19LcXvCc9eRN3Ue7DDHPQXm
X-Google-Smtp-Source: ANB0VdaR05vpLGtA1Irq7+eV/4eQonBqIfI7RUt6mG1X0mMJWvs0ASg0F0EPQRVzFSebmrPr1tnwDkoVB3N9dJlAY9IgRUEs9IuX
MIME-Version: 1.0
X-Received: by 2002:a02:9c55:: with SMTP id h21-v6mr16552617jal.21.1536567362524;
 Mon, 10 Sep 2018 01:16:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:16:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d13aae05757ff710@google.com>
Subject: possible deadlock in userfaultfd_ctx_read
From:   syzbot <syzbot+34d5adca60cd32cb87a4@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14279c21400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=34d5adca60cd32cb87a4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+34d5adca60cd32cb87a4@syzkaller.appspotmail.com


========================================================
WARNING: possible irq lock inversion dependency detected
4.19.0-rc2+ #229 Not tainted
--------------------------------------------------------
syz-executor4/10916 just changed the state of lock:
00000000c199c92f (&ctx->fd_wqh){+.+.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
00000000c199c92f (&ctx->fd_wqh){+.+.}, at:  
userfaultfd_ctx_read+0x2e4/0x2180 fs/userfaultfd.c:1029
but this lock was taken by another, SOFTIRQ-safe lock in the past:
  (&(&ctx->ctx_lock)->rlock){..-.}


and interrupts could create inverse lock ordering between them.

device team0 entered promiscuous mode

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

no locks held by syz-executor4/10916.

the shortest dependencies between 2nd lock and 1st lock:
  -> (&(&ctx->ctx_lock)->rlock
device team_slave_0 entered promiscuous mode
){..-.} ops: 12 {
     IN-SOFTIRQ-W at:
                       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                       __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                       _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                       spin_lock_irq include/linux/spinlock.h:354 [inline]
                       free_ioctx_users+0xbc/0x710 fs/aio.c:603
                       percpu_ref_put_many  
include/linux/percpu-refcount.h:284 [inline]
                       percpu_ref_put include/linux/percpu-refcount.h:300  
[inline]
                       percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
                       percpu_ref_switch_to_atomic_rcu+0x62c/0x820  
lib/percpu-refcount.c:158
                       __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
                       rcu_do_batch kernel/rcu/tree.c:2576 [inline]
                       invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
                       __rcu_process_callbacks kernel/rcu/tree.c:2847  
[inline]
                       rcu_process_callbacks+0xf23/0x2670  
kernel/rcu/tree.c:2864
device team_slave_1 entered promiscuous mode
                       __do_softirq+0x30b/0xad8 kernel/softirq.c:292
                       invoke_softirq kernel/softirq.c:372 [inline]
                       irq_exit+0x17f/0x1c0 kernel/softirq.c:412
                       exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                       smp_apic_timer_interrupt+0x1cb/0x760  
arch/x86/kernel/apic/apic.c:1056
                       apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:864
8021q: adding VLAN 0 to HW filter on device team0
                       arch_local_irq_enable  
arch/x86/include/asm/paravirt.h:798 [inline]
                       __raw_spin_unlock_irq  
include/linux/spinlock_api_smp.h:168 [inline]
                       _raw_spin_unlock_irq+0x56/0x80  
kernel/locking/spinlock.c:192
                       spin_unlock_irq include/linux/spinlock.h:379 [inline]
                       process_one_work+0xb6c/0x1b90 kernel/workqueue.c:2126
                       worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
                       kthread+0x35a/0x420 kernel/kthread.c:246
                       ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
kobject: 'ieee80211' (000000009d879d4a): kobject_add_internal:  
parent: 'hwsim3', set: '(null)'
     INITIAL USE at:
                      lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                      __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                      _raw_spin_lock_irq+0x61/0x80  
kernel/locking/spinlock.c:160
                      spin_lock_irq include/linux/spinlock.h:354 [inline]
                      free_ioctx_users+0xbc/0x710 fs/aio.c:603
                      percpu_ref_put_many  
include/linux/percpu-refcount.h:284 [inline]
                      percpu_ref_put include/linux/percpu-refcount.h:300  
[inline]
                      percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
                      percpu_ref_switch_to_atomic_rcu+0x62c/0x820  
lib/percpu-refcount.c:158
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
                      __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
                      rcu_do_batch kernel/rcu/tree.c:2576 [inline]
                      invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
                      __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
                      rcu_process_callbacks+0xf23/0x2670  
kernel/rcu/tree.c:2864
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
                      __do_softirq+0x30b/0xad8 kernel/softirq.c:292
                      invoke_softirq kernel/softirq.c:372 [inline]
                      irq_exit+0x17f/0x1c0 kernel/softirq.c:412
                      exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                      smp_apic_timer_interrupt+0x1cb/0x760  
arch/x86/kernel/apic/apic.c:1056
                      apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:864
                      arch_local_irq_enable  
arch/x86/include/asm/paravirt.h:798 [inline]
                      __raw_spin_unlock_irq  
include/linux/spinlock_api_smp.h:168 [inline]
                      _raw_spin_unlock_irq+0x56/0x80  
kernel/locking/spinlock.c:192
                      spin_unlock_irq include/linux/spinlock.h:379 [inline]
                      process_one_work+0xb6c/0x1b90 kernel/workqueue.c:2126
                      worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
kobject: 'phy3' (00000000fe8d56f6): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
                      kthread+0x35a/0x420 kernel/kthread.c:246
                      ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
   }
   ... key      at: [<ffffffff8b3dc960>] __key.50120+0x0/0x40
   ... acquired at:
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
    spin_lock include/linux/spinlock.h:329 [inline]
    aio_poll+0x760/0x1420 fs/aio.c:1747
    io_submit_one+0xab8/0x1090 fs/aio.c:1850
    __do_sys_io_submit fs/aio.c:1916 [inline]
    __se_sys_io_submit fs/aio.c:1887 [inline]
    __x64_sys_io_submit+0x1b9/0x5d0 fs/aio.c:1887
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe
kobject: 'phy3' (00000000fe8d56f6): kobject_uevent_env

-> (&ctx->fd_wqh){+.+.} ops: 43 {
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
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
                     do_readv+0x11a/0x310 fs/read_write.c:1019
                     __do_sys_readv fs/read_write.c:1106 [inline]
                     __se_sys_readv fs/read_write.c:1103 [inline]
                     __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
                     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    SOFTIRQ-ON-W at:
kobject: 'phy3' (00000000fe8d56f6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/ieee80211/phy3'
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
kobject: 'rfkill5' (00000000398f6806): kobject_add_internal:  
parent: 'phy3', set: 'devices'
                     __do_sys_readv fs/read_write.c:1106 [inline]
                     __se_sys_readv fs/read_write.c:1103 [inline]
                     __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
                     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                    lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
                    __raw_spin_lock_irqsave  
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x99/0xd0  
kernel/locking/spinlock.c:152
                    __wake_up_common_lock+0x19e/0x330 kernel/sched/wait.c:120
                    __wake_up+0xe/0x10 kernel/sched/wait.c:145
                    handle_userfault+0xe6c/0x24c0 fs/userfaultfd.c:488
                    do_anonymous_page mm/memory.c:3164 [inline]
                    handle_pte_fault mm/memory.c:3981 [inline]
                    __handle_mm_fault+0x45ed/0x53e0 mm/memory.c:4107
                    handle_mm_fault+0x54f/0xc70 mm/memory.c:4144
                    __do_page_fault+0x67d/0xed0 arch/x86/mm/fault.c:1395
                    do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1470
                    page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1161
                    copy_user_generic_unrolled+0x86/0xc0  
arch/x86/lib/copy_user_64.S:65
                    copy_from_user include/linux/uaccess.h:147 [inline]
                    snd_timer_user_next_device sound/core/timer.c:1489  
[inline]
                    __snd_timer_user_ioctl+0x10ac/0x2dc0  
sound/core/timer.c:1944
                    snd_timer_user_ioctl+0x5f/0x7d sound/core/timer.c:1999
kobject: 'rfkill5' (00000000398f6806): kobject_uevent_env
                    vfs_ioctl fs/ioctl.c:46 [inline]
                    file_ioctl fs/ioctl.c:501 [inline]
                    do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
                    ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
                    __do_sys_ioctl fs/ioctl.c:709 [inline]
                    __se_sys_ioctl fs/ioctl.c:707 [inline]
                    __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
                    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8b3dc6e0>] __key.43670+0x0/0x40
  ... acquired at:
kobject: 'rfkill5' (00000000398f6806): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/ieee80211/phy3/rfkill5'
    mark_lock_irq kernel/locking/lockdep.c:2756 [inline]
    mark_lock+0xa6b/0x1cb0 kernel/locking/lockdep.c:3128
    mark_irqflags kernel/locking/lockdep.c:3024 [inline]
    __lock_acquire+0x7ba/0x4ec0 kernel/locking/lockdep.c:3369
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


stack backtrace:
CPU: 1 PID: 10916 Comm: syz-executor4 Not tainted 4.19.0-rc2+ #229
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
  print_irq_inversion_bug.part.35+0x2c7/0x2d6 kernel/locking/lockdep.c:2622
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
  print_irq_inversion_bug kernel/locking/lockdep.c:2625 [inline]
  check_usage_backwards.cold.56+0x1d/0x26 kernel/locking/lockdep.c:2671
  mark_lock_irq kernel/locking/lockdep.c:2756 [inline]
  mark_lock+0xa6b/0x1cb0 kernel/locking/lockdep.c:3128
  mark_irqflags kernel/locking/lockdep.c:3024 [inline]
  __lock_acquire+0x7ba/0x4ec0 kernel/locking/lockdep.c:3369
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
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
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fec8289fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 00007fec828a06d4 RCX: 0000000000457099
RDX: 0000000000000002 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4200 R14: 00000000004c8932 R15: 0000000000000001
device team0 left promiscuous mode
device team_slave_0 left promiscuous mode
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
device team_slave_1 left promiscuous mode
ieee80211 phy3: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (000000002043dc49): kobject_add_internal: parent: 'hwsim3',  
set: '(null)'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'wlan1' (000000004e17da59): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'wlan1' (000000004e17da59): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'wlan1' (000000004e17da59): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1'
kobject: 'queues' (000000002bbb0325): kobject_add_internal:  
parent: 'wlan1', set: '<NULL>'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'queues' (000000002bbb0325): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'queues' (000000002bbb0325): kobject_uevent_env: filter function  
caused the event to drop!
handle_userfault: 5 callbacks suppressed
FAULT_FLAG_ALLOW_RETRY missing 30
kobject: 'rx-0' (000000007fd940a0): kobject_add_internal: parent: 'queues',  
set: 'queues'
CPU: 0 PID: 10906 Comm: syz-executor4 Not tainted 4.19.0-rc2+ #229
kobject: 'rx-0' (000000007fd940a0): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
kobject: 'rx-0' (000000007fd940a0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1/queues/rx-0'
  handle_userfault.cold.33+0x47/0x62 fs/userfaultfd.c:432
kobject: 'tx-0' (00000000a3f5c1d2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000a3f5c1d2): kobject_uevent_env
kobject: 'tx-0' (00000000a3f5c1d2): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1/queues/tx-0'
kobject: 'tx-1' (00000000c41ebc24): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000c41ebc24): kobject_uevent_env
kobject: 'tx-1' (00000000c41ebc24): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1/queues/tx-1'
kobject: 'tx-2' (000000002e8034f3): kobject_add_internal: parent: 'queues',  
set: 'queues'
  do_anonymous_page mm/memory.c:3164 [inline]
  handle_pte_fault mm/memory.c:3981 [inline]
  __handle_mm_fault+0x45ed/0x53e0 mm/memory.c:4107
kobject: 'tx-2' (000000002e8034f3): kobject_uevent_env
kobject: 'tx-2' (000000002e8034f3): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1/queues/tx-2'
kobject: 'tx-3' (0000000013888632): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000013888632): kobject_uevent_env
  handle_mm_fault+0x54f/0xc70 mm/memory.c:4144
kobject: 'tx-3' (0000000013888632): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1/queues/tx-3'
  __do_page_fault+0x67d/0xed0 arch/x86/mm/fault.c:1395
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
  do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1470
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1161
RIP: 0010:fault_in_pages_readable include/linux/pagemap.h:601 [inline]
RIP: 0010:iov_iter_fault_in_readable+0x1b4/0x450 lib/iov_iter.c:421
Code: fd 49 39 dc 76 17 eb 3c e8 e9 f8 f0 fd 49 81 c4 00 10 00 00 4c 39 a5  
28 ff ff ff 72 2e e8 d4 f8 f0 fd 0f 1f 00 0f ae e8 31 db <41> 8a 04 24 0f  
1f 00 31 ff 89 de 88 85 58 ff ff ff e8 c6 f9 f0 fd
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
RSP: 0018:ffff88018822f7d0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc90004071000
RDX: 0000000000000192 RSI: ffffffff838dd66c RDI: 0000000000000005
RBP: ffff88018822f8a8 R08: ffff880191ae6440 R09: ffffed0038bfca39
R10: ffffed0038bfca39 R11: ffff8801c5fe51cb R12: 0000000020011fd2
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
R13: 0000000000000030 R14: 0000000000000030 R15: ffff88018822fbc8
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  generic_perform_write+0x216/0x6a0 mm/filemap.c:3129
  __generic_file_write_iter+0x26e/0x630 mm/filemap.c:3264
  generic_file_write_iter+0x436/0x870 mm/filemap.c:3292
  call_write_iter include/linux/fs.h:1807 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fec828c0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fec828c16d4 RCX: 0000000000457099
RDX: 0000000000000030 RSI: 0000000020011fd2 RDI: 0000000000000004
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d8400 R14: 00000000004cae90 R15: 0000000000000000
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'hwsim4' (000000000fe026ce): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'hwsim4' (000000000fe026ce): kobject_uevent_env
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'hwsim4' (000000000fe026ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'hwsim4' (000000000fe026ce): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'hwsim4' (000000000fe026ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4'
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'ieee80211' (0000000078402da2): kobject_add_internal:  
parent: 'hwsim4', set: '(null)'
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'phy4' (00000000b6103269): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'phy4' (00000000b6103269): kobject_uevent_env
kobject: 'phy4' (00000000b6103269): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/ieee80211/phy4'
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'rfkill6' (00000000262a63e7): kobject_add_internal:  
parent: 'phy4', set: 'devices'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'rfkill6' (00000000262a63e7): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'rfkill6' (00000000262a63e7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/ieee80211/phy4/rfkill6'
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
ieee80211 phy4: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000f5306611): kobject_add_internal: parent: 'hwsim4',  
set: '(null)'
kobject: 'wlan2' (0000000074d098d3): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'wlan2' (0000000074d098d3): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'wlan2' (0000000074d098d3): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/net/wlan2'
kobject: 'queues' (00000000182d4d57): kobject_add_internal:  
parent: 'wlan2', set: '<NULL>'
kobject: 'queues' (00000000182d4d57): kobject_uevent_env
kobject: 'queues' (00000000182d4d57): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000009630a40d): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000009630a40d): kobject_uevent_env
kobject: 'rx-0' (000000009630a40d): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/net/wlan2/queues/rx-0'
kobject: 'tx-0' (0000000080dc47da): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000080dc47da): kobject_uevent_env
kobject: 'tx-0' (0000000080dc47da): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/net/wlan2/queues/tx-0'
kobject: 'tx-1' (000000005d054340): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (000000005d054340): kobject_uevent_env
kobject: 'tx-1' (000000005d054340): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/net/wlan2/queues/tx-1'
kobject: 'tx-2' (00000000f5d998af): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000f5d998af): kobject_uevent_env
kobject: 'tx-2' (00000000f5d998af): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/net/wlan2/queues/tx-2'
kobject: 'tx-3' (000000006b4b2d51): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (000000006b4b2d51): kobject_uevent_env
kobject: 'tx-3' (000000006b4b2d51): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim4/net/wlan2/queues/tx-3'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'hwsim5' (00000000d8cd351f): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'hwsim5' (00000000d8cd351f): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'hwsim5' (00000000d8cd351f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5'
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'hwsim5' (00000000d8cd351f): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'hwsim5' (00000000d8cd351f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5'
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'ieee80211' (000000006c27156b): kobject_add_internal:  
parent: 'hwsim5', set: '(null)'
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'phy5' (00000000cceff608): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000e3d33ad6): kobject_uevent_env
kobject: 'phy5' (00000000cceff608): kobject_uevent_env
kobject: 'kvm' (00000000e3d33ad6): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'phy5' (00000000cceff608): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/ieee80211/phy5'
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'kvm' (00000000e3d33ad6): kobject_uevent_env
kobject: 'rfkill7' (0000000099afc38e): kobject_add_internal:  
parent: 'phy5', set: 'devices'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'rfkill7' (0000000099afc38e): kobject_uevent_env
kobject: 'kvm' (00000000e3d33ad6): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'rfkill7' (0000000099afc38e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/ieee80211/phy5/rfkill7'
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
ieee80211 phy5: Selected rate control algorithm 'minstrel_ht'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'net' (00000000b5dfd643): kobject_add_internal: parent: 'hwsim5',  
set: '(null)'
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'wlan3' (000000009d17259a): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000e3d33ad6): kobject_uevent_env
kobject: 'wlan3' (000000009d17259a): kobject_uevent_env
kobject: 'kvm' (00000000e3d33ad6): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'wlan3' (000000009d17259a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/net/wlan3'
kobject: 'kvm' (00000000e3d33ad6): kobject_uevent_env
kobject: 'kvm' (00000000e3d33ad6): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'queues' (0000000000ab3740): kobject_add_internal:  
parent: 'wlan3', set: '<NULL>'
kobject: 'queues' (0000000000ab3740): kobject_uevent_env
kobject: 'queues' (0000000000ab3740): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'rx-0' (000000004c60deba): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'rx-0' (000000004c60deba): kobject_uevent_env
kobject: 'rx-0' (000000004c60deba): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/net/wlan3/queues/rx-0'
kobject: 'tx-0' (00000000f6922d78): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f6922d78): kobject_uevent_env
kobject: 'tx-0' (00000000f6922d78): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/net/wlan3/queues/tx-0'
kobject: 'tx-1' (0000000078c24969): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000078c24969): kobject_uevent_env
kobject: 'tx-1' (0000000078c24969): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/net/wlan3/queues/tx-1'
kobject: 'tx-2' (00000000040a2185): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000040a2185): kobject_uevent_env
kobject: 'tx-2' (00000000040a2185): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/net/wlan3/queues/tx-2'
kobject: 'tx-3' (00000000b837e0b5): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000b837e0b5): kobject_uevent_env
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'tx-3' (00000000b837e0b5): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim5/net/wlan3/queues/tx-3'
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
IPVS: ftp: loaded support on port[0] = 21
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'lo' (0000000011002af8): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'lo' (0000000011002af8): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'lo' (0000000011002af8): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'queues' (0000000061a987e7): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'queues' (0000000061a987e7): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'queues' (0000000061a987e7): kobject_uevent_env: filter function  
caused the event to drop!
syz-executor5 (11258) used greatest stack depth: 14144 bytes left
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'rx-0' (000000001ce6bbca): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000001ce6bbca): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'rx-0' (000000001ce6bbca): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'tx-0' (00000000a2a2987f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'tx-0' (00000000a2a2987f): kobject_uevent_env
kobject: 'tx-0' (00000000a2a2987f): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
kobject: 'tunl0' (00000000199d6d1b): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'tunl0' (00000000199d6d1b): kobject_uevent_env
kobject: 'tunl0' (00000000199d6d1b): fill_kobj_path: path  
= '/devices/virtual/net/tunl0'
kobject: 'queues' (00000000be80bff7): kobject_add_internal:  
parent: 'tunl0', set: '<NULL>'
kobject: 'queues' (00000000be80bff7): kobject_uevent_env
kobject: 'queues' (00000000be80bff7): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002e18802c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000002e18802c): kobject_uevent_env
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'rx-0' (000000002e18802c): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/rx-0'
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'tx-0' (00000000c75d0309): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'tx-0' (00000000c75d0309): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'tx-0' (00000000c75d0309): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/tx-0'
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'tap0' (00000000e31999b1): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'tap0' (00000000e31999b1): kobject_uevent_env
IPVS: ftp: loaded support on port[0] = 21
kobject: 'tap0' (00000000e31999b1): fill_kobj_path: path  
= '/devices/virtual/net/tap0'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'queues' (000000000c03831e): kobject_add_internal: parent: 'tap0',  
set: '<NULL>'
kobject: 'queues' (000000000c03831e): kobject_uevent_env
kobject: 'queues' (000000000c03831e): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000085eb9e5b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000085eb9e5b): kobject_uevent_env
kobject: 'rx-0' (0000000085eb9e5b): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/rx-0'
kobject: 'tx-0' (0000000008b43ff0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000008b43ff0): kobject_uevent_env
kobject: 'tx-0' (0000000008b43ff0): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/tx-0'
kobject: 'rx-0' (0000000085eb9e5b): kobject_cleanup, parent 000000000c03831e
kobject: 'rx-0' (0000000085eb9e5b): auto cleanup 'remove' event
kobject: 'rx-0' (0000000085eb9e5b): kobject_uevent_env
kobject: 'rx-0' (0000000085eb9e5b): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/rx-0'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'rx-0' (0000000085eb9e5b): auto cleanup kobject_del
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0' (0000000085eb9e5b): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000008b43ff0): kobject_cleanup, parent 000000000c03831e
kobject: 'tx-0' (0000000008b43ff0): auto cleanup 'remove' event
kobject: 'tx-0' (0000000008b43ff0): kobject_uevent_env
kobject: 'tx-0' (0000000008b43ff0): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/tx-0'
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'tx-0' (0000000008b43ff0): auto cleanup kobject_del
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'tx-0' (0000000008b43ff0): calling ktype release
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'tx-0': free name
kobject: 'queues' (000000000c03831e): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000000c03831e): calling ktype release
kobject: 'queues' (000000000c03831e): kset_release
kobject: 'queues': free name
kobject: 'tap0' (00000000e31999b1): kobject_uevent_env
kobject: 'tap0' (00000000e31999b1): fill_kobj_path: path  
= '/devices/virtual/net/tap0'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor2'.
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'gre0' (00000000652cf50a): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'gre0' (00000000652cf50a): kobject_uevent_env
kobject: 'gre0' (00000000652cf50a): fill_kobj_path: path  
= '/devices/virtual/net/gre0'
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'queues' (00000000538a67b2): kobject_add_internal: parent: 'gre0',  
set: '<NULL>'
kobject: 'loop0' (000000007ab17aca): kobject_uevent_env
kobject: 'queues' (00000000538a67b2): kobject_uevent_env
kobject: 'loop0' (000000007ab17aca): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'queues' (00000000538a67b2): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'rx-0' (0000000015b3ac84): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'rx-0' (0000000015b3ac84): kobject_uevent_env
kobject: 'loop6' (00000000af055a16): kobject_uevent_env
kobject: 'rx-0' (0000000015b3ac84): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/rx-0'
kobject: 'loop6' (00000000af055a16): fill_kobj_path: path  
= '/devices/virtual/block/loop6'
kobject: 'tx-0' (0000000099f14b45): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000099f14b45): kobject_uevent_env
kobject: 'tx-0' (0000000099f14b45): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/tx-0'
kobject: 'tap0' (00000000f8e874de): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'tap0' (00000000f8e874de): kobject_uevent_env
kobject: 'tap0' (00000000f8e874de): fill_kobj_path: path  
= '/devices/virtual/net/tap0'
kobject: 'queues' (0000000009347272): kobject_add_internal: parent: 'tap0',  
set: '<NULL>'
kobject: 'queues' (0000000009347272): kobject_uevent_env
kobject: 'queues' (0000000009347272): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000046221b62): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000046221b62): kobject_uevent_env
kobject: 'rx-0' (0000000046221b62): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/rx-0'
kobject: 'tx-0' (000000002da2cfb4): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000002da2cfb4): kobject_uevent_env
kobject: 'tx-0' (000000002da2cfb4): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/tx-0'
kobject: 'rx-0' (0000000046221b62): kobject_cleanup, parent 0000000009347272
kobject: 'rx-0' (0000000046221b62): auto cleanup 'remove' event
kobject: 'rx-0' (0000000046221b62): kobject_uevent_env
kobject: 'rx-0' (0000000046221b62): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/rx-0'
kobject: 'rx-0' (0000000046221b62): auto cleanup kobject_del
kobject: 'rx-0' (0000000046221b62): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000002da2cfb4): kobject_cleanup, parent 0000000009347272
kobject: 'tx-0' (000000002da2cfb4): auto cleanup 'remove' event
kobject: 'tx-0' (000000002da2cfb4): kobject_uevent_env
kobject: 'tx-0' (000000002da2cfb4): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/tx-0'
kobject: 'tx-0' (000000002da2cfb4): auto cleanup kobject_del
kobject: 'tx-0' (000000002da2cfb4): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000009347272): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000009347272): calling ktype release
kobject: 'queues' (0000000009347272): kset_release
kobject: 'queues': free name
kobject: 'tap0' (00000000f8e874de): kobject_uevent_env
kobject: 'tap0' (00000000f8e874de): fill_kobj_path: path  
= '/devices/virtual/net/tap0'
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor2'.
kobject: 'gretap0' (000000003c7f36c1): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'tap0' (00000000e31999b1): kobject_cleanup, parent           (null)
kobject: 'gretap0' (000000003c7f36c1): kobject_uevent_env
kobject: 'tap0' (00000000e31999b1): calling ktype release
kobject: 'gretap0' (000000003c7f36c1): fill_kobj_path: path  
= '/devices/virtual/net/gretap0'
kobject: 'queues' (000000007bddfcd2): kobject_add_internal:  
parent: 'gretap0', set: '<NULL>'
kobject: 'queues' (000000007bddfcd2): kobject_uevent_env
kobject: 'queues' (000000007bddfcd2): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'tap0': free name
kobject: 'rx-0' (00000000ba9bb7ca): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop1' (000000000adaf198): kobject_uevent_env
kobject: 'rx-0' (00000000ba9bb7ca): kobject_uevent_env
kobject: 'loop1' (000000000adaf198): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'rx-0' (00000000ba9bb7ca): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/rx-0'
kobject: 'loop4' (000000005c76ecb4): kobject_uevent_env
kobject: 'tx-0' (000000002711b830): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop4' (000000005c76ecb4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'tx-0' (000000002711b830): kobject_uevent_env
kobject: 'tx-0' (000000002711b830): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/tx-0'
kobject: 'tap0' (00000000f8e874de): kobject_cleanup, parent           (null)
kobject: 'erspan0' (000000009ef0e9fb): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'tap0' (00000000f8e874de): calling ktype release
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'erspan0' (000000009ef0e9fb): kobject_uevent_env
kobject: 'tap0': free name
kobject: 'erspan0' (000000009ef0e9fb): fill_kobj_path: path  
= '/devices/virtual/net/erspan0'
kobject: 'loop2' (000000002be7089a): kobject_uevent_env
kobject: 'loop2' (000000002be7089a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'queues' (000000004a16c01d): kobject_add_internal:  
parent: 'erspan0', set: '<NULL>'
kobject: 'queues' (000000004a16c01d): kobject_uevent_env
kobject: 'queues' (000000004a16c01d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000d66928be): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000d66928be): kobject_uevent_env
kobject: 'rx-0' (00000000d66928be): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/rx-0'
kobject: 'tx-0' (00000000ad8d0dd9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000ad8d0dd9): kobject_uevent_env
kobject: 'tx-0' (00000000ad8d0dd9): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/tx-0'
kobject: 'ip_vti0' (0000000095fea4a9): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip_vti0' (0000000095fea4a9): kobject_uevent_env
kobject: 'ip_vti0' (0000000095fea4a9): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0'
kobject: 'queues' (00000000ad64fc8d): kobject_add_internal:  
parent: 'ip_vti0', set: '<NULL>'
kobject: 'queues' (00000000ad64fc8d): kobject_uevent_env
kobject: 'queues' (00000000ad64fc8d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000722f628f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000722f628f): kobject_uevent_env
kobject: 'rx-0' (00000000722f628f): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/rx-0'
kobject: 'tx-0' (00000000dcd05641): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000dcd05641): kobject_uevent_env
kobject: 'tx-0' (00000000dcd05641): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/tx-0'
kobject: 'ip6_vti0' (00000000769f1cd1): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'ip6_vti0' (00000000769f1cd1): kobject_uevent_env
kobject: 'ip6_vti0' (00000000769f1cd1): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0'
kobject: 'queues' (00000000d60df209): kobject_add_internal:  
parent: 'ip6_vti0', set: '<NULL>'
kobject: 'queues' (00000000d60df209): kobject_uevent_env
kobject: 'queues' (00000000d60df209): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000001b7bdfe7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000001b7bdfe7): kobject_uevent_env
kobject: 'rx-0' (000000001b7bdfe7): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/rx-0'
kobject: 'tx-0' (00000000b7525876): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000b7525876): kobject_uevent_env
kobject: 'tx-0' (00000000b7525876): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/tx-0'
kobject: 'sit0' (0000000090950e6b): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'sit0' (0000000090950e6b): kobject_uevent_env
kobject: 'sit0' (0000000090950e6b): fill_kobj_path: path  
= '/devices/virtual/net/sit0'
kobject: 'queues' (00000000cdd66934): kobject_add_internal: parent: 'sit0',  
set: '<NULL>'
kobject: 'queues' (00000000cdd66934): kobject_uevent_env
kobject: 'queues' (00000000cdd66934): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000071030bd5): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000071030bd5): kobject_uevent_env
kobject: 'rx-0' (0000000071030bd5): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/rx-0'
kobject: 'tx-0' (00000000435d977c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000435d977c): kobject_uevent_env
kobject: 'tx-0' (00000000435d977c): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/tx-0'
kobject: 'ip6tnl0' (000000001ab63f80): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6tnl0' (000000001ab63f80): kobject_uevent_env
kobject: 'ip6tnl0' (000000001ab63f80): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0'
kobject: 'queues' (00000000ef0590ca): kobject_add_internal:  
parent: 'ip6tnl0', set: '<NULL>'
kobject: 'queues' (00000000ef0590ca): kobject_uevent_env
kobject: 'queues' (00000000ef0590ca): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000007b7752bd): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000007b7752bd): kobject_uevent_env
kobject: 'rx-0' (000000007b7752bd): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/rx-0'
kobject: 'tx-0' (00000000cdad9ba6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000cdad9ba6): kobject_uevent_env
kobject: 'tx-0' (00000000cdad9ba6): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/tx-0'
kobject: 'ip6gre0' (00000000a43986d3): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6gre0' (00000000a43986d3): kobject_uevent_env
kobject: 'ip6gre0' (00000000a43986d3): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0'
kobject: 'queues' (000000001c4b8a0d): kobject_add_internal:  
parent: 'ip6gre0', set: '<NULL>'
kobject: 'queues' (000000001c4b8a0d): kobject_uevent_env
kobject: 'queues' (000000001c4b8a0d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000d013217f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000d013217f): kobject_uevent_env
kobject: 'rx-0' (00000000d013217f): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/rx-0'
kobject: 'tx-0' (00000000f20fad5b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f20fad5b): kobject_uevent_env
kobject: 'tx-0' (00000000f20fad5b): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/tx-0'
kobject: 'rx-0' (00000000d013217f): kobject_cleanup, parent 000000001c4b8a0d
kobject: 'rx-0' (00000000d013217f): auto cleanup 'remove' event
kobject: 'rx-0' (00000000d013217f): kobject_uevent_env
kobject: 'rx-0' (00000000d013217f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000d013217f): auto cleanup kobject_del
kobject: 'rx-0' (00000000d013217f): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000f20fad5b): kobject_cleanup, parent 000000001c4b8a0d
kobject: 'tx-0' (00000000f20fad5b): auto cleanup 'remove' event
kobject: 'tx-0' (00000000f20fad5b): kobject_uevent_env
kobject: 'tx-0' (00000000f20fad5b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000f20fad5b): auto cleanup kobject_del
kobject: 'tx-0' (00000000f20fad5b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000001c4b8a0d): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000001c4b8a0d): calling ktype release
kobject: 'queues' (000000001c4b8a0d): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000a43986d3): kobject_uevent_env
kobject: 'ip6gre0' (00000000a43986d3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6gre0' (00000000a43986d3): kobject_cleanup, parent            
(null)
kobject: 'ip6gre0' (00000000a43986d3): auto cleanup 'remove' event
kobject: 'ip6gre0' (00000000a43986d3): kobject_uevent_env
kobject: 'ip6gre0' (00000000a43986d3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6gre0' (00000000a43986d3): calling ktype release
kobject: 'ip6gre0': free name
kobject: 'rx-0' (000000007b7752bd): kobject_cleanup, parent 00000000ef0590ca
kobject: 'rx-0' (000000007b7752bd): auto cleanup 'remove' event
kobject: 'rx-0' (000000007b7752bd): kobject_uevent_env
kobject: 'rx-0' (000000007b7752bd): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'rx-0' (000000007b7752bd): auto cleanup kobject_del
kobject: 'rx-0' (000000007b7752bd): calling ktype release
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'rx-0': free name
FS-Cache: Duplicate cookie detected
FS-Cache: O-cookie c=00000000e9ae3388 [p=0000000060e65c62 fl=222 nc=0 na=1]
kobject: 'tx-0' (00000000cdad9ba6): kobject_cleanup, parent 00000000ef0590ca
FS-Cache: O-cookie d=00000000c2c88332 n=00000000f58c6b99
FS-Cache: O-key=[10] '0200020000807f000008'
FS-Cache: N-cookie c=00000000387ca28a [p=0000000060e65c62 fl=2 nc=0 na=1]
kobject: 'tx-0' (00000000cdad9ba6): auto cleanup 'remove' event
FS-Cache: N-cookie d=00000000c2c88332 n=000000001e2e73a2
kobject: 'tx-0' (00000000cdad9ba6): kobject_uevent_env
FS-Cache: N-key=[10] '
kobject: 'tx-0' (00000000cdad9ba6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000cdad9ba6): auto cleanup kobject_del
kobject: 'tx-0' (00000000cdad9ba6): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000ef0590ca): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000ef0590ca): calling ktype release
kobject: 'queues' (00000000ef0590ca): kset_release
kobject: 'queues': free name
kobject: 'ip6tnl0' (000000001ab63f80): kobject_uevent_env
kobject: 'ip6tnl0' (000000001ab63f80): kobject_uevent_env: uevent_suppress  
caused the event to drop!
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor2'.
0200020000807f000008'
kobject: 'tap0' (00000000ab5f2c5e): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'tap0' (00000000ab5f2c5e): kobject_uevent_env
kobject: 'tap0' (00000000ab5f2c5e): fill_kobj_path: path  
= '/devices/virtual/net/tap0'
kobject: 'queues' (00000000b0c2eead): kobject_add_internal: parent: 'tap0',  
set: '<NULL>'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'queues' (00000000b0c2eead): kobject_uevent_env
kobject: 'queues' (00000000b0c2eead): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'rx-0' (000000008d5053db): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'rx-0' (000000008d5053db): kobject_uevent_env
kobject: 'rx-0' (000000008d5053db): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/rx-0'
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'tx-0' (0000000036a18208): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000036a18208): kobject_uevent_env
kobject: 'tx-0' (0000000036a18208): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/tx-0'
kobject: 'loop7' (00000000178553b4): kobject_uevent_env
kobject: 'rx-0' (000000008d5053db): kobject_cleanup, parent 00000000b0c2eead
kobject: 'rx-0' (000000008d5053db): auto cleanup 'remove' event
kobject: 'rx-0' (000000008d5053db): kobject_uevent_env
kobject: 'loop7' (00000000178553b4): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'rx-0' (000000008d5053db): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/rx-0'
kobject: 'rx-0' (000000008d5053db): auto cleanup kobject_del
kobject: 'rx-0' (000000008d5053db): calling ktype release
kobject: 'rx-0': free name
kobject: 'loop3' (00000000d7961e58): kobject_uevent_env
kobject: 'tx-0' (0000000036a18208): kobject_cleanup, parent 00000000b0c2eead
kobject: 'tx-0' (0000000036a18208): auto cleanup 'remove' event
kobject: 'tx-0' (0000000036a18208): kobject_uevent_env
kobject: 'loop3' (00000000d7961e58): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'tx-0' (0000000036a18208): fill_kobj_path: path  
= '/devices/virtual/net/tap0/queues/tx-0'
kobject: 'loop5' (0000000020331bd3): kobject_uevent_env
kobject: 'tx-0' (0000000036a18208): auto cleanup kobject_del
Unknown ioctl 19300
kobject: 'tx-0' (0000000036a18208): calling ktype release
kobject: 'loop5' (0000000020331bd3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
