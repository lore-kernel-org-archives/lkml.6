Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161531AbeBNRmu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:42:50 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36738 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161212AbeBNRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:42:46 -0500
X-Google-Smtp-Source: AH8x224dfg5dJKkrgpfzTuQl7GvTjlYIF4CbeJYNzurpN2bolT1mMFodxW0ab7rJ85gt5HLlgoaiEubS5KuvutQ34T4=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ai9tCO6bHJ5G7EhBbcxtrd2ZkKXbi+xDEpjwh9EwXQXw@mail.gmail.com>
References: <001a114aca7419fa410561f23992@google.com> <CAPDqMeo+CbhE6LpXi7DQ1zp-jNXue8ETdcJ9zjLGT+r=HM+y5Q@mail.gmail.com>
 <CACT4Y+ai9tCO6bHJ5G7EhBbcxtrd2ZkKXbi+xDEpjwh9EwXQXw@mail.gmail.com>
From: Tom Herbert <tom@quantonium.net>
Date: Wed, 14 Feb 2018 09:42:44 -0800
Message-ID: <CAPDqMerPQV-scrb5WRxv18miCT9gCGf7mZqJc6w8WRHa9GjCWA@mail.gmail.com>
Subject: Re: BUG: free active (active state 0) object type: work_struct hint: strp_work
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+3c6c745b0d2f341bbf50@syzkaller.appspotmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:15 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Jan 4, 2018 at 8:36 PM, Tom Herbert <tom@quantonium.net> wrote:
> > On Thu, Jan 4, 2018 at 4:10 AM, syzbot
> > <syzbot+3c6c745b0d2f341bbf50@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzkaller hit the following crash on
> >> 6bb8824732f69de0f233ae6b1a8158e149627b38
> >> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> >> compiler: gcc (GCC) 7.1.1 20170620
> >> .config is attached
> >> Raw console output is attached.
> >> Unfortunately, I don't have any reproducer for this bug yet.
> >>
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+3c6c745b0d2f341bbf50@syzkaller.appspotmail.com
> >> It will help syzbot understand when the bug is fixed. See footer for
> >> details.
> >> If you forward the report, please keep this part and the footer.
> >>
> >> Use struct sctp_assoc_value instead
> >> sctp: [Deprecated]: syz-executor4 (pid 12483) Use of int in maxseg socket
> >> option.
> >> Use struct sctp_assoc_value instead
> >> ------------[ cut here ]------------
> >> ODEBUG: free active (active state 0) object type: work_struct hint:
> >> strp_work+0x0/0xf0 net/strparser/strparser.c:381
> >> WARNING: CPU: 1 PID: 3502 at lib/debugobjects.c:291
> >> debug_print_object+0x166/0x220 lib/debugobjects.c:288
> >> Kernel panic - not syncing: panic_on_warn set ...
> >>
> >> CPU: 1 PID: 3502 Comm: kworker/u4:4 Not tainted 4.15.0-rc5+ #170
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Workqueue: kkcmd kcm_tx_work
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:17 [inline]
> >>  dump_stack+0x194/0x257 lib/dump_stack.c:53
> >>  panic+0x1e4/0x41c kernel/panic.c:183
> >>  __warn+0x1dc/0x200 kernel/panic.c:547
> >>  report_bug+0x211/0x2d0 lib/bug.c:184
> >>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
> >>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
> >>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
> >>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
> >>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1061
> >> RIP: 0010:debug_print_object+0x166/0x220 lib/debugobjects.c:288
> >> RSP: 0018:ffff8801c0ee7068 EFLAGS: 00010086
> >> RAX: dffffc0000000008 RBX: 0000000000000003 RCX: ffffffff8159bc3e
> >> RDX: 0000000000000000 RSI: 1ffff100381dcdc8 RDI: ffff8801db317dd0
> >> RBP: ffff8801c0ee70a8 R08: 0000000000000000 R09: 1ffff100381dcd9a
> >> R10: ffffed00381dce3c R11: ffffffff86137ad8 R12: 0000000000000001
> >> R13: ffffffff86113480 R14: ffffffff8560dc40 R15: ffffffff8146e5f0
> >>  __debug_check_no_obj_freed lib/debugobjects.c:745 [inline]
> >>  debug_check_no_obj_freed+0x662/0xf1f lib/debugobjects.c:774
> >>  kmem_cache_free+0x253/0x2a0 mm/slab.c:3745
> >
> > I believe we just need to defer kmem_cache_free to call_rcu.
>
>
> Hi Tom,
>
> Was this ever submitted? I don't any such change in net/kcm/kcmsock.c.


Hi Dmitry,

I am looking at it. Not yet convinced that call_rcu is right fix.

Tom
