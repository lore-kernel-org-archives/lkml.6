Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeEICri (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:47:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34833 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbeEICrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:47:36 -0400
X-Google-Smtp-Source: AB8JxZopb1x6Q7eaztSH9UTzWft0uw9npwIRid2Vym8aqA85oVUgbeC//cfYC9z9qkYQ2eRjQcrm/Q==
Date: Tue, 8 May 2018 19:49:30 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+40396d275b34b0dd5dad@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Cong Wang <xiyou.wangcong@gmail.com>, Tom Herbert <tom@quantonium.net>,
        Eric Dumazet <edumazet@google.com>, Eric Biggers <ebiggers@google.com>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in work_is_static_object
Message-ID: <20180509024930.GB711@sol.localdomain>
References: <001a1144d6e8ef29870562424c44@google.com>
 <CACT4Y+bwGfUgdJzsgCYd+yqcv8BQ242+3pRNNY_R3SVKGV+24Q@mail.gmail.com>
 <CACT4Y+b2SHbAixYaGN-Q3zTBDskafTR6aXSMu=qXtEb4iwco+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b2SHbAixYaGN-Q3zTBDskafTR6aXSMu=qXtEb4iwco+A@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2018 at 12:58:11PM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Mon, Jan 8, 2018 at 12:55 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Jan 8, 2018 at 12:43 PM, syzbot
> > <syzbot+40396d275b34b0dd5dad@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzkaller hit the following crash on
> >> f66faae2f80a45feafc04ce63ef744ac4b6e8c05
> >> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> >> compiler: gcc (GCC) 7.1.1 20170620
> >> .config is attached
> >> Raw console output is attached.
> >> Unfortunately, I don't have any reproducer for this bug yet.
> >>
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+40396d275b34b0dd5dad@syzkaller.appspotmail.com
> >> It will help syzbot understand when the bug is fixed. See footer for
> >> details.
> >> If you forward the report, please keep this part and the footer.
> >
> >
> > This looks like an issue in kcm sockets, so +kcm maintainers.
> 
> FTR, guilty file extraction was fixed to ignore kernel/workqueue.c:
> https://github.com/google/syzkaller/commit/1014e5506e35965f3bad13fabb08666134d0b273
> Presumably for bugs in workqueue usually the caller is guilty.
> 
> 
> >> device ip6_vti0 entered promiscuous mode
> >> ==================================================================
> >> BUG: KASAN: use-after-free in constant_test_bit
> >> arch/x86/include/asm/bitops.h:325 [inline]
> >> BUG: KASAN: use-after-free in work_is_static_object+0x39/0x40
> >> kernel/workqueue.c:443
> >> Read of size 8 at addr ffff8801beca5788 by task syz-executor2/12922
> >>
> >> CPU: 0 PID: 12922 Comm: syz-executor2 Not tainted 4.15.0-rc5+ #178
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:17 [inline]
> >>  dump_stack+0x194/0x257 lib/dump_stack.c:53
> >>  print_address_description+0x73/0x250 mm/kasan/report.c:252
> >>  kasan_report_error mm/kasan/report.c:351 [inline]
> >>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
> >>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
> >>  constant_test_bit arch/x86/include/asm/bitops.h:325 [inline]
> >>  work_is_static_object+0x39/0x40 kernel/workqueue.c:443
> >>  debug_object_activate+0x36f/0x730 lib/debugobjects.c:470
> >>  debug_work_activate kernel/workqueue.c:492 [inline]
> >>  __queue_work+0x163/0x1230 kernel/workqueue.c:1381
> >>  queue_work_on+0x16a/0x1c0 kernel/workqueue.c:1487
> >>  queue_work include/linux/workqueue.h:488 [inline]
> >>  strp_check_rcv+0x25/0x30 net/strparser/strparser.c:552
> >>  kcm_attach net/kcm/kcmsock.c:1439 [inline]
> >>  kcm_attach_ioctl net/kcm/kcmsock.c:1460 [inline]
> >>  kcm_ioctl+0x82f/0x1690 net/kcm/kcmsock.c:1665
> >>  sock_do_ioctl+0x65/0xb0 net/socket.c:956
> >>  sock_ioctl+0x2c2/0x440 net/socket.c:1053
> >>  vfs_ioctl fs/ioctl.c:46 [inline]
> >>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
> >>  SYSC_ioctl fs/ioctl.c:701 [inline]
> >>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> >>  entry_SYSCALL_64_fastpath+0x23/0x9a
> >> RIP: 0033:0x452ac9
> >> RSP: 002b:00007f1bbd860c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
> >> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452ac9
> >> RDX: 0000000020954ff8 RSI: 00000000000089e0 RDI: 0000000000000017
> >> RBP: 000000000000057b R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f6428
> >> R13: 00000000ffffffff R14: 00007f1bbd8616d4 R15: 0000000000000000
> >>
> >> Allocated by task 12922:
> >>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
> >>  set_track mm/kasan/kasan.c:459 [inline]
> >>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
> >>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
> >>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3544
> >>  kmem_cache_zalloc include/linux/slab.h:678 [inline]
> >>  kcm_attach net/kcm/kcmsock.c:1394 [inline]
> >>  kcm_attach_ioctl net/kcm/kcmsock.c:1460 [inline]
> >>  kcm_ioctl+0x2d2/0x1690 net/kcm/kcmsock.c:1665
> >>  sock_do_ioctl+0x65/0xb0 net/socket.c:956
> >>  sock_ioctl+0x2c2/0x440 net/socket.c:1053
> >>  vfs_ioctl fs/ioctl.c:46 [inline]
> >>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
> >>  SYSC_ioctl fs/ioctl.c:701 [inline]
> >>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> >>  entry_SYSCALL_64_fastpath+0x23/0x9a
> >>
> >> Freed by task 12929:
> >>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
> >>  set_track mm/kasan/kasan.c:459 [inline]
> >>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
> >>  __cache_free mm/slab.c:3488 [inline]
> >>  kmem_cache_free+0x83/0x2a0 mm/slab.c:3746
> >>  kcm_unattach+0xe53/0x1510 net/kcm/kcmsock.c:1563
> >>  kcm_unattach_ioctl net/kcm/kcmsock.c:1608 [inline]
> >>  kcm_ioctl+0xe54/0x1690 net/kcm/kcmsock.c:1675
> >>  sock_do_ioctl+0x65/0xb0 net/socket.c:956
> >>  sock_ioctl+0x2c2/0x440 net/socket.c:1053
> >>  vfs_ioctl fs/ioctl.c:46 [inline]
> >>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
> >>  SYSC_ioctl fs/ioctl.c:701 [inline]
> >>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> >>  entry_SYSCALL_64_fastpath+0x23/0x9a
> >>
> >> The buggy address belongs to the object at ffff8801beca56c0
> >>  which belongs to the cache kcm_psock_cache of size 544
> >> The buggy address is located 200 bytes inside of
> >>  544-byte region [ffff8801beca56c0, ffff8801beca58e0)
> >> The buggy address belongs to the page:
> >> page:000000005180a80a count:1 mapcount:0 mapping:0000000058aa9a5c index:0x0
> >> compound_mapcount: 0
> >> flags: 0x2fffc0000008100(slab|head)
> >> raw: 02fffc0000008100 ffff8801beca40c0 0000000000000000 000000010000000b
> >> raw: ffff8801d31e8a48 ffff8801d31e8a48 ffff8801d3f6a380 0000000000000000
> >> page dumped because: kasan: bad access detected
> >>
> >> Memory state around the buggy address:
> >>  ffff8801beca5680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> >>  ffff8801beca5700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>>
> >>> ffff8801beca5780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>
> >>                       ^
> >>  ffff8801beca5800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>  ffff8801beca5880: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >> ==================================================================
> >>
> >>
> >> ---
> >> This bug is generated by a dumb bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for details.
> >> Direct all questions to syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this bug report.
> >> If you forgot to add the Reported-by tag, once the fix for this bug is
> >> merged
> >> into any tree, please reply to this email with:
> >> #syz fix: exact-commit-title

This only happened 3 times, with no reproducer, and last occurred 105 days ago
(Jan 23, on commit 2310035fa03f6).  It looks *very* similar to
"KASAN: use-after-free Read in get_work_pool"
(https://syzkaller.appspot.com/bug?extid=ea75c0ffcd353d32515f064aaebefc5279e6161e)
which was fixed by commit 2cc683e88c0c99
("kcm: lock lower socket in kcm_attach"),
so I'll make an educated guess and say this one was fixed by that too...

#syz fix: kcm: lock lower socket in kcm_attach

- Eric
