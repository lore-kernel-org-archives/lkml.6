Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF9BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD67E20828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeL3Pqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 10:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbeL3Pqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 10:46:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50095C0495BA;
        Sun, 30 Dec 2018 15:46:53 +0000 (UTC)
Received: from sky.random (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85C541055009;
        Sun, 30 Dec 2018 15:46:50 +0000 (UTC)
Date:   Sun, 30 Dec 2018 10:46:48 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: KASAN: use-after-free Read in handle_userfault (2)
Message-ID: <20181230154648.GB9832@redhat.com>
References: <000000000000665f2e057cd00db6@google.com>
 <CACT4Y+Y-Yv0a1DzqsTHRSP52DdKLy0J2fAfsVfZUSNNnAOUnzg@mail.gmail.com>
 <CACT4Y+bxTz6d11v89gpDSEPyB+sJssNGPmEsC9-LVsGbxEpcuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bxTz6d11v89gpDSEPyB+sJssNGPmEsC9-LVsGbxEpcuA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 30 Dec 2018 15:46:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Dec 30, 2018 at 08:48:05AM +0100, Dmitry Vyukov wrote:
> On Wed, Dec 12, 2018 at 10:58 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Dec 12, 2018 at 10:45 AM syzbot
> > <syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    14cf8c1d5b90 Add linux-next specific files for 20181210
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=133296db400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c9133d0a4284c012
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=cbc64b24b2b2d54c07a9
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > This is a corrupted/intermixed kernel output, the bug actually
> > happened somewhere in net/core/neighbour.c.
> > syzkaller has a bunch of code to try to deal to corrupted kernel
> > output, but it's not always possible as a parallel thread printing
> > something can inject an unrelated frame just in the right place, and
> > then it's indistinguishable from a crash happened there.
> >
> > The question is: what's the significance of that
> > "FAULT_FLAG_ALLOW_RETRY missing 70"?
> > Is it something to fix in kernel? Can the check be removed? Should it

This is a rate limited warning not compiled in production kernels.

#ifdef CONFIG_DEBUG_VM
		if (printk_ratelimit()) {
			printk(KERN_WARNING
			       "FAULT_FLAG_ALLOW_RETRY missing %x\n",
			       vmf->flags);
			dump_stack();
		}
#endif

It helps to tell if it's an userland bug or a kernel missing feature
like some get_user_pages that can't drop mmap_sem in a path where we
may need userfaultfd to be functional.

Those get_user_pages locations are deterministic, so for example when
qemu started explicitly calling get_mempolicy(MPOL_F_NODE|MPOL_F_ADDR)
we had to change the get_user_pages there to make uffd functional for
such syscall. An example of where this debug aid paid off relatively
recently is commit 3b9aadf7278d16d7bed4d5d808501065f70898d8.

> > be moved somewhere earlier when flags are passed to kernel and cause
> > EINVAL? Can it be at least converted to a single-line pr_warn?

I don't see the problem with the VM_FAULT_SIGBUS retval.

The reason of the full dump_stack is because pr_warn would tell us
nothing about the location of the get_user_pages that needs
conversion. It's pretty much like when you get an -EINVAL in userland
and there's a zillon places that returns -EINVAL and you've no clue
which one you hit. The debug_stack is about pinpointing the exact
location after the fact, to evaluate what to do about it.

> > +Sasha go as far as suggesting that any "Call Trace:" in kernel output
> > means a kernel bugs. This is one of few places in kernel that dumps
> > stacks left and right without a kernel bug (?).

Yes this is a case where the Call Trace in the logs doesn't guarantee
there was a kernel bug, this is why it's rate limited and only
compiled in non production builds.

I haven't looked at the reproducer source, but looking only at the
trace I can tell this happened because a region has been registered in
uffd while a page fault was already undergoing a VM_FAULT_RETRY
cycle.

We could remove the dump_stack if FAULT_FLAG_TRIED is set, but
removing it for all cases would make it harder to solve other kernel
issues like described above.

However with Peter Xu recent work FAULT_FLAG_TRIED will go away as
part of the userfaultfd WP support (FAULT_FLAG_TRIED is the reason of
this specific false positive) so you won't be able to trigger this
path through undefined state userland race conditions anymore after
that.

So I'd propose Peter's FAULT_FLAG_TRIED removal as the best path
forward because it's will solve 3 problems: 1) this rate limited false
positive FAULT_FLAG_TRIED dump_stack with malicious app, 2) signal
case not returning VM_FAULT_RETRY despite we dropped mmap_sem to sleep
until we got waken up by a signal, 3) it'll allow the uffd write
protection to work.

https://lkml.kernel.org/r/20181121062103.18835-1-peterx@redhat.com

Until FAULT_FLAG_TRIED is dropped, it's up to the manager in the non
cooperative case and up to the app itself in the normal more common
cooperative case, to ensure there aren't page faults already happening
in the region while the region is registered in uffd. It's totally
trivial for the app to do so until we relax this requirement in a
fully backwards compatible way.

The reason FAULT_FLAG_TRIED must be dropped for the write-protection
feature is that the uffd per-page granular write protection ioctl must
be allowed to run at any time on any region, potentially while there
are already VM_FAULT_RETRY faults being retried. So the kernel common
code must be allowed to return VM_FAULT_RETRY twice or more in a row
from the point of view of the arch page fault code.

To remove the dump_stack completely (not only for the case of a
malicious userland app) we could add a debug facility in debugfs where
we could dump stack traces in a circular buffer, so we could ask the
root user to cat the file and send us the extra call trace debug data
associated to the single pr_warn in the log. It'd actually be nice if
all kind of -EINVAL could dump their stack there too in fact
(supposedly they're not fast paths).

> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com
> > >
> > > RDX: 00000000000003ff RSI: 0000000020012fe0 RDI: 00007f5dbe489850
> > > RBP: 000000000072bf00 R08: 00000000000003ff R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5dbe48a6d4
> > > R13: 00000000004c578a R14: 00000000004d9d90 R15: 00000000ffffffff
> > > ==================================================================
> > > BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100
> > > lib/list_debug.c:51
> > > CPU: 1 PID: 20306 Comm: syz-executor2 Not tainted 4.20.0-rc6-next-20181210+
> > > #164
> > > Read of size 8 at addr ffff8881c5e72bb0 by task kworker/0:1/12
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > >
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> > >   handle_userfault.cold.30+0x47/0x62 fs/userfaultfd.c:431
> > >   do_anonymous_page mm/memory.c:2938 [inline]
> > >   handle_pte_fault mm/memory.c:3780 [inline]
> > >   __handle_mm_fault+0x4d26/0x5b70 mm/memory.c:3906
> > >   handle_mm_fault+0x54f/0xc70 mm/memory.c:3943
> > >   do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
> > >   __do_page_fault+0x5f6/0xd70 arch/x86/mm/fault.c:1541
> > >   do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1572
> > >   page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
> > > RIP: 0033:0x4510a0
> > > Code: 0f 84 c4 0f 00 00 48 89 f1 48 89 f8 48 83 e1 3f 48 83 f9 20 0f 86 7b
> > > 02 00 00 48 83 e6 f0 48 83 e1 0f 66 0f ef c0 66 0f ef c9 <66> 0f 74 0e 66
> > > 0f d7 d1 48 d3 ea 49 c7 c2 11 00 00 00 49 29 ca 4d
> > > RSP: 002b:00007fab1fbba7a8 EFLAGS: 00010202
> > > RAX: 00007fab1fbba850 RBX: 0000000000000003 RCX: 000000000000000e
> > > RDX: 00000000000003ff RSI: 0000000020012fe0 RDI: 00007fab1fbba850
> > > RBP: 000000000072bf00 R08: 00000000000003ff R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fab1fbbb6d4
> > > R13: 00000000004c578a R14: 00000000004d9d90 R15: 00000000ffffffff
> > > CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 4.20.0-rc6-next-20181210+ #164
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Workqueue: events_power_efficient neigh_periodic_work
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> > >   print_address_description.cold.4+0x9/0x1ff mm/kasan/report.c:187
> > >   kasan_report.cold.5+0x1b/0x39 mm/kasan/report.c:317
> > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> > >   __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
> > >   __list_del_entry include/linux/list.h:117 [inline]
> > >   list_del_init include/linux/list.h:159 [inline]
> > >   neigh_mark_dead+0x13b/0x410 net/core/neighbour.c:125

The real crash seems to be completely unrelated to userfaultfd, the
list_del_init is in neigh_mark_dead.

	if (!list_empty(&n->gc_list)) {
		list_del_init(&n->gc_list);

Thanks,
Andrea
