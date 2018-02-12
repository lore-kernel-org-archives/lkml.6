Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964830AbeBLP5S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:57:18 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38794 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbeBLP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:57:07 -0500
X-Google-Smtp-Source: AH8x224pd1AD52NtC77qrldAzPeispiG3tZo64yZNCaAA6rty+pqyJNHIXjClLj+wsToLc5k4hug+/c/zoBz5tXWip0=
MIME-Version: 1.0
In-Reply-To: <001a1148bb9ede7df1056505e56b@google.com>
References: <001a1148bb9ede7df1056505e56b@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 16:56:45 +0100
Message-ID: <CACT4Y+YM688uOs0xGYskLzR+G7dvrHW_kZ_Qq97yvnUyHubY1w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in do_raw_spin_unlock (2)
To: syzbot <syzbot+421677102422908e104e@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 4:54 PM, syzbot
<syzbot+421677102422908e104e@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> f1517df8701c9f12dae9ce7f43a5d300a6917619 (Thu Feb 8 23:18:32 2018 +0000)
> Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux
>
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+421677102422908e104e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

This is the same as:

#syz dup: KASAN: use-after-free Read in remove_wait_queue


> ==================================================================
> BUG: KASAN: use-after-free in debug_spin_unlock
> kernel/locking/spinlock_debug.c:100 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_unlock+0x2a4/0x300
> kernel/locking/spinlock_debug.c:134
> Read of size 4 at addr ffff8801af8d1328 by task syzkaller254122/4773
>
> CPU: 0 PID: 4773 Comm: syzkaller254122 Not tainted 4.15.0+ #305
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23b/0x360 mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  debug_spin_unlock kernel/locking/spinlock_debug.c:100 [inline]
>  do_raw_spin_unlock+0x2a4/0x300 kernel/locking/spinlock_debug.c:134
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:159 [inline]
>  _raw_spin_unlock_irqrestore+0x27/0xba kernel/locking/spinlock.c:184
>  spin_unlock_irqrestore include/linux/spinlock.h:365 [inline]
>  remove_wait_queue+0x1b4/0x350 kernel/sched/wait.c:52
>  ep_remove_wait_queue fs/eventpoll.c:595 [inline]
>  ep_unregister_pollwait.isra.7+0x18c/0x590 fs/eventpoll.c:613
>  ep_free+0x13f/0x320 fs/eventpoll.c:830
>  ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:862
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
>  exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ed/0x940 arch/x86/entry/common.c:292
>  entry_SYSCALL_64_after_hwframe+0x26/0x9b
> RIP: 0033:0x44a0f9
> RSP: 002b:00007f03daef9da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000124
> RAX: 0000000000000008 RBX: 00000000006debfc RCX: 000000000044a0f9
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006debf8
> R13: 6e69622f7665642f R14: 6273752f7665642f R15: 000000000000000b
>
> Allocated by task 4761:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>  kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3607
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  binder_get_thread+0x1cf/0x870 drivers/android/binder.c:4279
>  binder_poll+0x8c/0x390 drivers/android/binder.c:4393
>  ep_item_poll.isra.10+0xf2/0x320 fs/eventpoll.c:885
>  ep_insert+0x6a2/0x1ac0 fs/eventpoll.c:1457
>  SYSC_epoll_ctl fs/eventpoll.c:2104 [inline]
>  SyS_epoll_ctl+0x12bf/0x1a80 fs/eventpoll.c:1990
>  do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x26/0x9b
>
> Freed by task 4761:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>  __cache_free mm/slab.c:3485 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3800
>  binder_free_thread drivers/android/binder.c:4306 [inline]
>  binder_thread_dec_tmpref+0x27f/0x310 drivers/android/binder.c:1879
>  binder_thread_release+0x4a1/0x6b0 drivers/android/binder.c:4382
>  binder_ioctl+0xc02/0x1417 drivers/android/binder.c:4599
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x26/0x9b
>
> The buggy address belongs to the object at ffff8801af8d1280
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 168 bytes inside of
>  512-byte region [ffff8801af8d1280, ffff8801af8d1480)
> The buggy address belongs to the page:
> page:ffffea0006be3440 count:1 mapcount:0 mapping:ffff8801af8d1000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801af8d1000 0000000000000000 0000000100000006
> raw: ffffea0006bcd4a0 ffffea0006bb3e60 ffff8801db000940 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801af8d1200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801af8d1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>
>> ffff8801af8d1300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                                   ^
>  ffff8801af8d1380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801af8d1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1148bb9ede7df1056505e56b%40google.com.
> For more options, visit https://groups.google.com/d/optout.
