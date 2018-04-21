Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDURtY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:49:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39904 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeDURtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:49:22 -0400
X-Google-Smtp-Source: AIpwx4/ZhBh8c+LH/6cldSliNdGu/hzS+KXb6nnllvf7GnkyvF+FZTBP+FlHkbyLLqtP4yCjCF59cg==
Date: Sat, 21 Apr 2018 10:50:35 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <syzbot+20eb18b1ffc36152b5608d41ab3bf6bd18c23aa7@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: KASAN: use-after-free Read in perf_trace_lock_acquire (2)
Message-ID: <20180421175035.GB1098@sol.localdomain>
References: <001a113f890e54dcd0055e90b9bf@google.com>
 <001a113ecb5e7f5e580563fb501d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113ecb5e7f5e580563fb501d@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:52:02AM -0800, syzbot wrote:
> syzbot has found reproducer for the following crash on upstream commit
> 6304672b7f0a5c010002e63a075160856dc4f88d (Tue Jan 30 03:08:02 2018 +0000)
> Merge branch 'x86-pti-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> So far this crash happened 172 times on linux-next, mmots, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> syzbot+20eb18b1ffc36152b5608d41ab3bf6bd18c23aa7@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> ==================================================================
> BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x5b7/0x980
> include/trace/events/lock.h:13
> Read of size 8 at addr ffff8801b48e50b8 by task syzkaller241108/8081
> 
> CPU: 1 PID: 8081 Comm: syzkaller241108 Not tainted 4.15.0+ #286
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>  perf_trace_lock_acquire+0x5b7/0x980 include/trace/events/lock.h:13
>  trace_lock_acquire include/trace/events/lock.h:13 [inline]
>  lock_acquire+0x394/0x580 kernel/locking/lockdep.c:3914
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  remove_wait_queue+0x81/0x350 kernel/sched/wait.c:50
>  vhost_poll_stop drivers/vhost/vhost.c:230 [inline]
>  vhost_dev_stop+0x15c/0x2a0 drivers/vhost/vhost.c:566
>  vhost_net_release+0x6e/0x190 drivers/vhost/net.c:998
>  __fput+0x327/0x7e0 fs/file_table.c:210
>  ____fput+0x15/0x20 fs/file_table.c:244
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73f/0x16c0 kernel/signal.c:2335
>  do_signal+0x90/0x1eb0 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x490/0x550 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x9e/0xa0
> RIP: 0033:0x44bff9
> RSP: 002b:00007ff890dd4da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 0000000000700054 RCX: 000000000044bff9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000700054
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000700050
> R13: 6f68762f7665642f R14: 00007ff890dd59c0 R15: 0000000000000007
> 
> Allocated by task 8054:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3610
>  kmalloc include/linux/slab.h:499 [inline]
>  eventfd_file_create.part.3+0x96/0x250 fs/eventfd.c:441
>  eventfd_file_create fs/eventfd.c:483 [inline]
>  SYSC_eventfd2 fs/eventfd.c:468 [inline]
>  SyS_eventfd2 fs/eventfd.c:458 [inline]
>  SYSC_eventfd fs/eventfd.c:485 [inline]
>  SyS_eventfd+0x2c/0x80 fs/eventfd.c:483
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> 
> Freed by task 8081:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3488 [inline]
>  kfree+0xd6/0x260 mm/slab.c:3803
>  eventfd_free_ctx fs/eventfd.c:72 [inline]
>  eventfd_free fs/eventfd.c:79 [inline]
>  kref_put include/linux/kref.h:70 [inline]
>  eventfd_ctx_put+0x26/0x30 fs/eventfd.c:104
>  eventfd_release+0x52/0x60 fs/eventfd.c:113
>  __fput+0x327/0x7e0 fs/file_table.c:210
>  ____fput+0x15/0x20 fs/file_table.c:244
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73f/0x16c0 kernel/signal.c:2335
>  do_signal+0x90/0x1eb0 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x490/0x550 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x9e/0xa0
> 
> The buggy address belongs to the object at ffff8801b48e5080
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 56 bytes inside of
>  96-byte region [ffff8801b48e5080, ffff8801b48e50e0)
> The buggy address belongs to the page:
> page:ffffea0006d23940 count:1 mapcount:0 mapping:ffff8801b48e5000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801b48e5000 0000000000000000 0000000100000020
> raw: ffffea0006a220e0 ffffea0006cc4320 ffff8801db0004c0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801b48e4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801b48e5000: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> > ffff8801b48e5080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                         ^
>  ffff8801b48e5100: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801b48e5180: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ==================================================================

No longer occurring, seems this was yet another report of the vhost bug fixed by
commit 4cd879515d68:

#syz fix: vhost_net: stop device during reset owner

- Eric
