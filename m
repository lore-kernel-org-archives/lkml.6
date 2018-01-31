Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeAaAoC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:44:02 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:38630 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeAaAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:44:00 -0500
X-Google-Smtp-Source: AH8x225BnFI4VR41Bj4EB8xO3GwNyv0JE8rUGTPBm4LL32uWDzw7ST5dHpYBkJ7zy5FCafDvsrai6A==
Date: Tue, 30 Jan 2018 16:43:57 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+e52a2ae091b628f72765583c9faedc961c83b7e7@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: suspicious RCU usage at ./include/linux/inetdevice.h:LINE
Message-ID: <20180131004357.qpbxrfkgev4kljpg@gmail.com>
References: <001a114a958cf58255055cfdccb2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114a958cf58255055cfdccb2@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2017 at 03:53:38AM -0700, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> ce43f4fd6f103681c7485c2b1967179647e73555
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> 
> 
> 
> 
> =============================
> WARNING: suspicious RCU usage
> 4.14.0-rc5+ #140 Not tainted
> -----------------------------
> ./include/linux/inetdevice.h:230 suspicious rcu_dereference_protected()
> usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor2/23859:
>  #0:  (rcu_read_lock){....}, at: [<ffffffff840283f0>]
> inet_rtm_getroute+0xaa0/0x2d70 net/ipv4/route.c:2738
> 
> stack backtrace:
> CPU: 0 PID: 23859 Comm: syz-executor2 Not tainted 4.14.0-rc5+ #140
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4665
>  __in_dev_get_rtnl include/linux/inetdevice.h:230 [inline]
>  fib_dump_info+0x1136/0x13d0 net/ipv4/fib_semantics.c:1377
>  inet_rtm_getroute+0xf97/0x2d70 net/ipv4/route.c:2785
>  rtnetlink_rcv_msg+0x51c/0x1090 net/core/rtnetlink.c:4237
>  netlink_rcv_skb+0x216/0x440 net/netlink/af_netlink.c:2409
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4261
>  netlink_unicast_kernel net/netlink/af_netlink.c:1273 [inline]
>  netlink_unicast+0x4e8/0x6f0 net/netlink/af_netlink.c:1299
>  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1862
>  sock_sendmsg_nosec net/socket.c:633 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:643
>  sock_write_iter+0x31a/0x5d0 net/socket.c:912
>  call_write_iter include/linux/fs.h:1770 [inline]
>  new_sync_write fs/read_write.c:468 [inline]
>  __vfs_write+0x684/0x970 fs/read_write.c:481
>  vfs_write+0x189/0x510 fs/read_write.c:543
>  SYSC_write fs/read_write.c:588 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:580
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x452719
> RSP: 002b:00007fd087b03be8 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 0000000000452719
> RDX: 0000000000000024 RSI: 0000000020226000 RDI: 0000000000000014
> RBP: 0000000000000082 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
> R13: 0000000000a6f7ff R14: 00007fd087b049c0 R15: 0000000000000000

No longer seeing this crash.  I assume it was fixed by the following commit
(thanks Florian!), so telling syzbot:

#syz fix: fib: fib_dump_info can no longer use __in_dev_get_rtnl
