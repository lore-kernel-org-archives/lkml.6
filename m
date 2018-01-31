Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeAaUyo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:54:44 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:46736 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeAaUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:54:12 -0500
X-Google-Smtp-Source: AH8x224oAa0lSgZyCsC3DpXYlzqnrl2lrNiTVmLJ/5MwbvZDb1R4zZ963N6ukmtxF+v5ADBKaf/9Pg==
Date: Wed, 31 Jan 2018 12:54:07 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+779c85f1b6798c06885b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, jasowang@redhat.com
Subject: Re: KASAN: use-after-free Read in __wake_up_common
Message-ID: <20180131205407.ju3lztqaluiizaib@gmail.com>
References: <089e082d13a0078057056362d9b0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089e082d13a0078057056362d9b0@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+jasowang@redhat.com

On Mon, Jan 22, 2018 at 11:58:02AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 8dd903d2cf7b6dfe98be7c19f891882583c7266e (Fri Jan 19 23:20:00 2018 +0000)
> Merge tag 'scsi-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> 
> So far this crash happened 211 times on linux-next, mmots, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+779c85f1b6798c06885b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> ==================================================================
> BUG: KASAN: use-after-free in __wake_up_common+0x670/0x780
> kernel/sched/wait.c:90
> Read of size 8 at addr ffff8801bcf80f08 by task syzkaller194205/3724
> 
> CPU: 0 PID: 3724 Comm: syzkaller194205 Not tainted 4.15.0-rc8+ #270
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>  __wake_up_common+0x670/0x780 kernel/sched/wait.c:90
>  __wake_up_common_lock+0x1b4/0x310 kernel/sched/wait.c:125
>  __wake_up+0xe/0x10 kernel/sched/wait.c:149
>  eventfd_release+0x4a/0x60 fs/eventfd.c:112
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
> RIP: 0033:0x449ac9
> RSP: 002b:00007f0696bfbda8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: 0000000000000000 RBX: 00000000006dbc24 RCX: 0000000000449ac9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dbc24
> RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 6f68762f7665642f
> R13: 006563696d2f7475 R14: 706e692f7665642f R15: 0000000000000008
> 
> Allocated by task 3724:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  __do_kmalloc_node mm/slab.c:3672 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3679
>  kmalloc_node include/linux/slab.h:541 [inline]
>  kvmalloc_node+0x64/0xd0 mm/util.c:397
>  kvmalloc include/linux/mm.h:541 [inline]
>  vhost_net_open+0x27/0x670 drivers/vhost/net.c:902
>  misc_open+0x382/0x500 drivers/char/misc.c:154
>  chrdev_open+0x257/0x730 fs/char_dev.c:417
>  do_dentry_open+0x667/0xd40 fs/open.c:752
>  vfs_open+0x107/0x220 fs/open.c:866
>  do_last fs/namei.c:3379 [inline]
>  path_openat+0x1151/0x3530 fs/namei.c:3519
>  do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>  do_sys_open+0x502/0x6d0 fs/open.c:1059
>  SYSC_openat fs/open.c:1086 [inline]
>  SyS_openat+0x30/0x40 fs/open.c:1080
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> 
> Freed by task 3724:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3488 [inline]
>  kfree+0xd6/0x260 mm/slab.c:3803
>  kvfree+0x36/0x60 mm/util.c:416
>  vhost_net_release+0x159/0x190 drivers/vhost/net.c:1012
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
> The buggy address belongs to the object at ffff8801bcf80c80
>  which belongs to the cache kmalloc-65536 of size 65536
> The buggy address is located 648 bytes inside of
>  65536-byte region [ffff8801bcf80c80, ffff8801bcf90c80)
> The buggy address belongs to the page:
> page:ffffea0006f3e000 count:1 mapcount:0 mapping:ffff8801bcf80c80 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffff8801bcf80c80 0000000000000000 0000000100000001
> raw: ffffea0006f26820 ffffea0006f3e820 ffff8801dac02500 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801bcf80e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801bcf80e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8801bcf80f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff8801bcf80f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801bcf81000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

This appears to be a vhost bug, fixed by the following patch queued in net-next:

#syz fix: vhost_net: stop device during reset owner

- Eric
