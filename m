Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCMHvr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:51:47 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:56306 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeCMHvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:51:45 -0400
Date: Tue, 13 Mar 2018 08:51:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: syzbot <syzbot+6a7e7ed886bde43469c4@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in kmalloc_slab (4)
Message-ID: <20180313075143.b3ymdpt3nj3vnz77@gauss3.secunet.de>
References: <001a114214fac20a80056746440a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <001a114214fac20a80056746440a@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: E0452A12-C246-4F71-8675-3FB682695E52
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 12:33:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on net-next commit
> f44b1886a5f876c87b5889df463ad7b97834ba37 (Fri Mar 9 18:10:06 2018 +0000)
> Merge branch 's390-qeth-next'
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6a7e7ed886bde43469c4@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> WARNING: CPU: 1 PID: 27333 at mm/slab_common.c:1012 kmalloc_slab+0x5d/0x70
> mm/slab_common.c:1012
> Kernel panic - not syncing: panic_on_warn set ...
> 
> syz-executor0: vmalloc: allocation failure: 17045651456 bytes,
> mode:0x14080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> CPU: 1 PID: 27333 Comm: syz-executor2 Not tainted 4.16.0-rc4+ #260
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
> syz-executor0 cpuset=
>  __warn+0x1dc/0x200 kernel/panic.c:547
> /
>  mems_allowed=0
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:kmalloc_slab+0x5d/0x70 mm/slab_common.c:1012
> RSP: 0018:ffff8801ccfc72f0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000010000018 RCX: ffffffff84ec4fc8
> RDX: 0000000000000ba7 RSI: 0000000000000000 RDI: 0000000010000018
> RBP: ffff8801ccfc72f0 R08: 0000000000000000 R09: 1ffff100399f8e21
> R10: ffff8801ccfc7040 R11: 0000000000000001 R12: 0000000000000018
> R13: ffff8801ccfc7598 R14: 00000000014080c0 R15: ffff8801aebaad80
>  __do_kmalloc mm/slab.c:3700 [inline]
>  __kmalloc+0x25/0x760 mm/slab.c:3714
>  kmalloc include/linux/slab.h:517 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  xfrm_alloc_replay_state_esn net/xfrm/xfrm_user.c:442 [inline]

This is likely fixed with:

commit d97ca5d714a5334aecadadf696875da40f1fbf3e
xfrm_user: uncoditionally validate esn replay attribute struct

The patch is included in the ipsec pull request for the net
tree I've sent this morning.
