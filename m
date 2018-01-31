Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeAaBw3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:52:29 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:40163 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeAaBw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:52:27 -0500
X-Google-Smtp-Source: AH8x227ztVrbl8cGU3pUM2axn3x8bTN0X+4mzsDQG6/9eeHjuKUATs19qHDXNmzTw7l/Jw/sEZijpA==
Date: Tue, 30 Jan 2018 17:52:23 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d85bfb332db8f0794212@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __bpf_prog_put
Message-ID: <20180131015223.hvllx2tgfffryzl2@gmail.com>
References: <001a1140bf605479be05627d75c7@google.com>
 <CACT4Y+b-Pti9RT43BOa4+dx3mU4eQ+EuDpJva8okb2d10MJpFQ@mail.gmail.com>
 <a8ff5d6c-594d-13eb-4b96-2becc8936a4e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ff5d6c-594d-13eb-4b96-2becc8936a4e@iogearbox.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2018 at 11:48:28AM +0100, Daniel Borkmann wrote:
> Hi Dmitry,
> 
> On 01/11/2018 11:22 AM, Dmitry Vyukov wrote:
> > On Thu, Jan 11, 2018 at 11:17 AM, syzbot
> > <syzbot+d85bfb332db8f0794212@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzkaller hit the following crash on
> >> 4147d50978df60f34d444c647dde9e5b34a4315e
> >> git://git.cmpxchg.org/linux-mmots.git/master
> >> compiler: gcc (GCC) 7.1.1 20170620
> >> .config is attached
> >> Raw console output is attached.
> >> Unfortunately, I don't have any reproducer for this bug yet.
> >>
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+d85bfb332db8f0794212@syzkaller.appspotmail.com
> >> It will help syzbot understand when the bug is fixed. See footer for
> >> details.
> >> If you forward the report, please keep this part and the footer.
> >>
> >> netlink: 3 bytes leftover after parsing attributes in process
> >> `syz-executor5'.
> >> ==================================================================
> >> BUG: KASAN: use-after-free in __bpf_prog_put+0x5e8/0x640
> >> kernel/bpf/syscall.c:944
> >> netlink: 'syz-executor5': attribute type 5 has an invalid length.
> >> Read of size 8 at addr ffff8801d3619658 by task syz-executor0/12398
> >>
> >> CPU: 1 PID: 12398 Comm: syz-executor0 Not tainted 4.15.0-rc7-mm1+ #53
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:17 [inline]
> >>  dump_stack+0x194/0x257 lib/dump_stack.c:53
> >>  print_address_description+0x73/0x250 mm/kasan/report.c:256
> >>  kasan_report_error mm/kasan/report.c:354 [inline]
> >>  kasan_report+0x23b/0x360 mm/kasan/report.c:412
> >>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >>  __bpf_prog_put+0x5e8/0x640 kernel/bpf/syscall.c:944
> >>  bpf_prog_put+0x1a/0x20 kernel/bpf/syscall.c:961
> >>  prog_fd_array_put_ptr+0x15/0x20 kernel/bpf/arraymap.c:446
> >>  fd_array_map_delete_elem+0xc8/0x110 kernel/bpf/arraymap.c:420
> >>  map_delete_elem kernel/bpf/syscall.c:737 [inline]
> >>  SYSC_bpf kernel/bpf/syscall.c:1814 [inline]
> >>  SyS_bpf+0x22ea/0x4400 kernel/bpf/syscall.c:1782
> >>  entry_SYSCALL_64_fastpath+0x29/0xa0
> >> RIP: 0033:0x452ac9
> >> RSP: 002b:00007fb70df60c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000141
> >> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452ac9
> >> RDX: 0000000000000010 RSI: 0000000020f02ff0 RDI: 0000000000000003
> >> RBP: 00000000000003aa R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f3890
> >> R13: 00000000ffffffff R14: 00007fb70df616d4 R15: 0000000000000000
> >>
> >> Allocated by task 11996:
> >>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
> >>  set_track mm/kasan/kasan.c:459 [inline]
> >>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
> >>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
> >>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3541
> >>  kmem_cache_zalloc include/linux/slab.h:694 [inline]
> >>  get_empty_filp+0xfb/0x4f0 fs/file_table.c:122
> >>  path_openat+0xed/0x3530 fs/namei.c:3514
> >>  do_filp_open+0x25b/0x3b0 fs/namei.c:3572
> >>  do_sys_open+0x502/0x6d0 fs/open.c:1059
> >>  SYSC_open fs/open.c:1077 [inline]
> >>  SyS_open+0x2d/0x40 fs/open.c:1072
> >>  entry_SYSCALL_64_fastpath+0x29/0xa0
> >>
> >> Freed by task 11994:
> >>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
> >>  set_track mm/kasan/kasan.c:459 [inline]
> >>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
> >>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
> >>  __cache_free mm/slab.c:3485 [inline]
> >>  kmem_cache_free+0x86/0x2b0 mm/slab.c:3743
> >>  file_free_rcu+0x5c/0x70 fs/file_table.c:49
> >>  __rcu_reclaim kernel/rcu/rcu.h:172 [inline]
> >>  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
> >>  invoke_rcu_callbacks kernel/rcu/tree.c:2934 [inline]
> >>  __rcu_process_callbacks kernel/rcu/tree.c:2901 [inline]
> >>  rcu_process_callbacks+0xd6c/0x17f0 kernel/rcu/tree.c:2918
> >>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
> >>
> >> The buggy address belongs to the object at ffff8801d36195c0
> >>  which belongs to the cache filp of size 456
> >> The buggy address is located 152 bytes inside of
> >>  456-byte region [ffff8801d36195c0, ffff8801d3619788)
> >> The buggy address belongs to the page:
> >> page:ffffea00074d8640 count:1 mapcount:0 mapping:ffff8801d36190c0 index:0x0
> >> flags: 0x2fffc0000000100(slab)
> >> raw: 02fffc0000000100 ffff8801d36190c0 0000000000000000 0000000100000006
> >> raw: ffffea00074c49a0 ffffea000747a160 ffff8801dae30180 0000000000000000
> >> page dumped because: kasan: bad access detected
> >>
> >> Memory state around the buggy address:
> >>  ffff8801d3619500: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>  ffff8801d3619580: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> >>>
> >>> ffff8801d3619600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>
> >>                                                     ^
> >>  ffff8801d3619680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>  ffff8801d3619700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> ==================================================================
> > 
> > 
> > Is it the same as "general protection fault in __bpf_prog_put"?
> > https://groups.google.com/forum/#!topic/syzkaller-bugs/jUsNMmVgms0
> > 
> > The first stack looks similar, but alloc/free stacks looks unrelated.
> > What's the root cause of this? Is prog->aux an uninitialized pointer?
> > I wonder if initializing memory in kmalloc would help to prevent this
> > bug from duplicating? E.g. if we init memory to 0, it would always
> > cause GPFs, or if we init to an invalid pointer, always cause a bad
> > paging fault. Is it's the case, then I think we should do it to reduce
> > number of failure modes and syzbot reports.
> 
> This one in bpf tree fixes it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=bbeb6e4323dad9b5e0ee9f60c223dd532e2403b1
> 
> Despite this one not having a reproducer, I'm pretty certain it's very
> much related to all the ones coming in yesterday (which the above fixes).
> 
> >> This bug is generated by a dumb bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for details.
> >> Direct all questions to syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this bug report.
> >> If you forgot to add the Reported-by tag, once the fix for this bug is
> >> merged
> >> into any tree, please reply to this email with:
> >> #syz fix: exact-commit-title

This particular crash has not re-occurred following the initial report, so I'll
assume the above analysis is correct and it was indeed fixed by:

#syz fix: bpf, array: fix overflow in max_entries and undefined behavior in index_mask

- Eric
