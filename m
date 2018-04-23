Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbeDWPBy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:01:54 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:36122 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755433AbeDWPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:01:49 -0400
Date: Mon, 23 Apr 2018 17:01:42 +0200
From: Guillaume Nault <g.nault@alphalink.fr>
To: syzbot <syzbot+cd06c321e7147d03a65e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, mostrows@earthlink.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in strnlen
Message-ID: <20180423150142.GC1440@alphalink.fr>
References: <00000000000003f2d5056a7fbf92@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000003f2d5056a7fbf92@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:23:01AM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on https://github.com/google/kmsan.git/master
> commit
> a7f95e9c8a95e9fbb388c3999b61a17667cd3bbe (Sat Apr 21 13:50:22 2018 +0000)
> kmsan: disable assembly checksums
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=cd06c321e7147d03a65e
> 
> So far this crash happened 5 times on
> https://github.com/google/kmsan.git/master.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5785171018121216
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5117671628603392
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6310764688179200
> Kernel config: https://syzkaller.appspot.com/x/.config?id=328654897048964367
> compiler: clang version 7.0.0 (trunk 329391)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cd06c321e7147d03a65e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> ==================================================================
> BUG: KMSAN: uninit-value in strnlen+0xc4/0x110 lib/string.c:499
> CPU: 1 PID: 4507 Comm: syzkaller579712 Not tainted 4.16.0+ #85
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>  strnlen+0xc4/0x110 lib/string.c:499
>  dev_name_hash net/core/dev.c:209 [inline]
>  dev_get_by_name_rcu net/core/dev.c:764 [inline]
>  dev_get_by_name+0x6e/0x350 net/core/dev.c:791
>  pppoe_connect+0xcb7/0x2360 drivers/net/ppp/pppoe.c:665
>  SYSC_connect+0x41a/0x510 net/socket.c:1639
>  SyS_connect+0x54/0x80 net/socket.c:1620
>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> RIP: 0033:0x43fcf9
> RSP: 002b:00007ffca4bd4978 EFLAGS: 00000213 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fcf9
> RDX: 0000000000000007 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401620
> R13: 00000000004016b0 R14: 0000000000000000 R15: 0000000000000000
> 
> Local variable description: ----address@SYSC_connect
> Variable was created at:
>  SYSC_connect+0x6f/0x510 net/socket.c:1622
>  SyS_connect+0x54/0x80 net/socket.c:1620
> ==================================================================
> 
That's a consequence of not validating sockaddr_len. The sockaddr_pppox
structure was incomplete.

#syz dup: KMSAN: uninit-value in pppoe_connect
