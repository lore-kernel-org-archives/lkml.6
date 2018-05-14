Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeENGJw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 02:09:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34331 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeENGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 02:09:50 -0400
X-Google-Smtp-Source: AB8JxZr8BNf3aSR/He5UQeTpkWa+E+lr2N4LivvOm3Vb2b9TOsg220rvRz3hjH3PHd6V3R0XTm+P9g==
Date: Sun, 13 May 2018 23:11:55 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-ppp@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com>,
        viro@zeniv.linux.org.uk
Subject: Re: KASAN: use-after-free Read in remove_wait_queue (2)
Message-ID: <20180514061155.GL677@sol.localdomain>
References: <f403043d0f18f879cc056648a875@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f403043d0f18f879cc056648a875@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ppp list and maintainer]

On Wed, Feb 28, 2018 at 08:59:02AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> f3afe530d644488a074291da04a69a296ab63046 (Tue Feb 27 22:02:39 2018 +0000)
> Merge branch 'fixes-v4.16-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
> 
> So far this crash happened 3 times on upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1519800493.311:7): avc:  denied  { map } for
> pid=4238 comm="syzkaller305740" path="/root/syzkaller305740266" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3d4d/0x3e00
> kernel/locking/lockdep.c:3310
> Read of size 8 at addr ffff8801afa039c0 by task syzkaller305740/4238
> 
> CPU: 1 PID: 4238 Comm: syzkaller305740 Not tainted 4.16.0-rc3+ #332
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23b/0x360 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __lock_acquire+0x3d4d/0x3e00 kernel/locking/lockdep.c:3310
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  remove_wait_queue+0x81/0x350 kernel/sched/wait.c:50
>  ep_remove_wait_queue fs/eventpoll.c:596 [inline]
>  ep_unregister_pollwait.isra.7+0x18c/0x590 fs/eventpoll.c:614
>  ep_free+0x13f/0x320 fs/eventpoll.c:832
>  ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:864
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  SYSC_exit_group kernel/exit.c:979 [inline]
>  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x43e958
> RSP: 002b:00007ffe63a11468 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043e958
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004be300 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006cc160 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 4238:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>  __do_kmalloc_node mm/slab.c:3669 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3676
>  kmalloc_node include/linux/slab.h:554 [inline]
>  kvmalloc_node+0x99/0xd0 mm/util.c:419
>  kvmalloc include/linux/mm.h:541 [inline]
>  kvzalloc include/linux/mm.h:549 [inline]
>  alloc_netdev_mqs+0x16d/0xfb0 net/core/dev.c:8299
>  ppp_create_interface drivers/net/ppp/ppp_generic.c:3018 [inline]
>  ppp_unattached_ioctl drivers/net/ppp/ppp_generic.c:866 [inline]
>  ppp_ioctl+0x1715/0x2a50 drivers/net/ppp/ppp_generic.c:602
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> Freed by task 4238:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>  __cache_free mm/slab.c:3485 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3800
>  kvfree+0x36/0x60 mm/util.c:438
>  netdev_freemem+0x4c/0x60 net/core/dev.c:8253
>  netdev_release+0x10a/0x160 net/core/net-sysfs.c:1502
>  device_release+0x7c/0x210 drivers/base/core.c:814
>  kobject_cleanup lib/kobject.c:646 [inline]
>  kobject_release lib/kobject.c:675 [inline]
>  kref_put include/linux/kref.h:70 [inline]
>  kobject_put+0x14c/0x250 lib/kobject.c:692
>  put_device+0x20/0x30 drivers/base/core.c:1931
>  free_netdev+0x2f5/0x400 net/core/dev.c:8410
>  ppp_destroy_interface+0x2bc/0x390 drivers/net/ppp/ppp_generic.c:3100
>  ppp_release+0x12b/0x1a0 drivers/net/ppp/ppp_generic.c:415
>  ppp_ioctl+0x3b1/0x2a50 drivers/net/ppp/ppp_generic.c:628
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> The buggy address belongs to the object at ffff8801afa02e40
>  which belongs to the cache kmalloc-4096 of size 4096
> The buggy address is located 2944 bytes inside of
>  4096-byte region [ffff8801afa02e40, ffff8801afa03e40)
> The buggy address belongs to the page:
> page:ffffea0006be8080 count:1 mapcount:0 mapping:ffff8801afa02e40 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffff8801afa02e40 0000000000000000 0000000100000001
> raw: ffffea0006bee220 ffffea0006bee7a0 ffff8801dac00dc0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801afa03880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801afa03900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8801afa03980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                            ^
>  ffff8801afa03a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801afa03a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

This is a bug in ppp_generic.c; it still happens on Linus' tree and it's easily
reproducible, see program below.  The bug is that the PPPIOCDETACH ioctl doesn't
consider that the file can still be attached to epoll instances even when
->f_count == 1.  Also, the reproducer doesn't test this but I think ppp_poll(),
ppp_read(), and ppp_write() can all race with PPPIOCDETACH, causing
use-after-frees as well.  Any chance that PPPIOCDETACH can simply be removed,
given that it's apparently been "deprecated" for 16 years?  Does anyone use it?

	#include <fcntl.h>
	#include <linux/ppp-ioctl.h>
	#include <sys/epoll.h>
	#include <sys/ioctl.h>

	int main()
	{
		int pppfd, epfd, unit = 0;
		struct epoll_event event = { 0 };

		pppfd = open("/dev/ppp", O_RDONLY);
		ioctl(pppfd, PPPIOCNEWUNIT, &unit);
		epfd = epoll_create(0x2000);
		epoll_ctl(epfd, EPOLL_CTL_ADD, pppfd, &event);
		ioctl(pppfd, PPPIOCDETACH, &unit);
	}

- Eric
