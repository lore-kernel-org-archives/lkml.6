Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeBAVxB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:53:01 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:51976 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeBAVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:52:53 -0500
X-Google-Smtp-Source: AH8x226DXQKzTjR7zgdmqCfewQLdYOcNBfo77ACnuPChNtsbQw/dE9I2MNKt99cXT6Hv6hdkkF5Acw==
Date: Thu, 1 Feb 2018 13:52:49 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Jon Maloy <jon.maloy@ericsson.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+aae58876fb5a1fad0a4b@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>,
        Ying Xue <ying.xue@windriver.com>
Subject: Re: KASAN: use-after-free Read in tipc_group_size
Message-ID: <20180201215249.6axvmcejdew4no55@gmail.com>
References: <001a1144982043d4af05624506fc@google.com>
 <CAM_iQpVAmixCT5D6GEn7rGpRL0DN8Vm5HoKzntgZuDiecbeUPg@mail.gmail.com>
 <HE1PR07MB17245B232686FE521527DB269A130@HE1PR07MB1724.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR07MB17245B232686FE521527DB269A130@HE1PR07MB1724.eurprd07.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2018 at 08:11:35PM +0000, Jon Maloy wrote:
> 
> 
> > -----Original Message-----
> > From: Cong Wang [mailto:xiyou.wangcong@gmail.com]
> > Sent: Monday, January 08, 2018 13:44
> > To: syzbot <syzbot+aae58876fb5a1fad0a4b@syzkaller.appspotmail.com>
> > Cc: David Miller <davem@davemloft.net>; Jon Maloy
> > <jon.maloy@ericsson.com>; LKML <linux-kernel@vger.kernel.org>; Linux
> > Kernel Network Developers <netdev@vger.kernel.org>; syzkaller-
> > bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net; Ying Xue
> > <ying.xue@windriver.com>
> > Subject: Re: KASAN: use-after-free Read in tipc_group_size
> > 
> > On Mon, Jan 8, 2018 at 6:58 AM, syzbot
> > <syzbot+aae58876fb5a1fad0a4b@syzkaller.appspotmail.com> wrote:
> > > Hello,
> > >
> > > syzkaller hit the following crash on
> > > b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d
> > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/maste
> > > r
> > > compiler: gcc (GCC) 7.1.1 20170620
> > > .config is attached
> > > Raw console output is attached.
> > > C reproducer is attached
> > > syzkaller reproducer is attached. See https://goo.gl/kgGztJ for
> > > information about syzkaller reproducers
> > >
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+aae58876fb5a1fad0a4b@syzkaller.appspotmail.com
> > > It will help syzbot understand when the bug is fixed. See footer for
> > > details.
> > > If you forward the report, please keep this part and the footer.
> > >
> > >
> > ==========================================================
> > ========
> > > BUG: KASAN: use-after-free in tipc_group_size+0x40/0x50
> > > net/tipc/group.c:158 Read of size 2 at addr ffff8801c08ba280 by task
> > > syzkaller447710/3513
> > >
> > > CPU: 0 PID: 3513 Comm: syzkaller447710 Not tainted 4.15.0-rc7+ #252
> > > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > > BIOS Google 01/01/2011 Call Trace:
> > >  __dump_stack lib/dump_stack.c:17 [inline]
> > >  dump_stack+0x194/0x257 lib/dump_stack.c:53
> > >  print_address_description+0x73/0x250 mm/kasan/report.c:252
> > > kasan_report_error mm/kasan/report.c:351 [inline]
> > >  kasan_report+0x25b/0x340 mm/kasan/report.c:409
> > >  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:428
> > >  tipc_group_size+0x40/0x50 net/tipc/group.c:158
> > >  tipc_poll+0x374/0x4f0 net/tipc/socket.c:739
> > 
> > Seems we have to lock the sock for tipc_group_size() in tipc_poll().
> 
> Not quite. I think it is that we initialize 'grp' on the stack before we call sock_poll_wait() and access it after it returns.
> This is anyway fixed in patch #9 of the series I just sent to net-next, where the poll() handling for group members is redesigned.
> 
> ///jon
> 

Last occurred on Jan 16.  Seems to have been fixed by commit 60c2530696320:

#syz fix: tipc: fix race between poll() and setsockopt()

- Eric
