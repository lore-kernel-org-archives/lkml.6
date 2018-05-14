Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeENEZE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:25:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36860 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeENEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:25:02 -0400
X-Google-Smtp-Source: AB8JxZrhwxDnNHnXDZ7H2PJCsGfvyoqDxnz69r3SH+ap3zVquqZpqVLKbuMyISHz+saXLVJDK2kogA==
Date: Sun, 13 May 2018 21:27:07 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+b743957adcee51f5e0e3@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dvyukov@google.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Subject: Re: WARNING: suspicious RCU usage in tipc_bearer_find
Message-ID: <20180514042707.GK677@sol.localdomain>
References: <94eb2c1984003ba8ef0564cc8333@google.com>
 <94eb2c06cb284308e30564ccf9b9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c06cb284308e30564ccf9b9@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 12:00:01PM -0800, syzbot wrote:
> syzbot has found reproducer for the following crash on net-next commit
> 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
> Merge tag 'usercopy-v4.16-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> 
> So far this crash happened 13 times on net-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b743957adcee51f5e0e3@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> 
> audit: type=1400 audit(1518206230.395:8): avc:  denied  { create } for
> pid=4164 comm="syzkaller756462"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> =============================
> audit: type=1400 audit(1518206230.396:9): avc:  denied  { write } for
> pid=4164 comm="syzkaller756462"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> WARNING: suspicious RCU usage
> 4.15.0+ #221 Not tainted
> -----------------------------
> net/tipc/bearer.c:177 suspicious rcu_dereference_protected() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syzkaller756462/4164:
>  #0:  (cb_lock){++++}, at: [<000000003bb01113>] genl_rcv+0x19/0x40
> net/netlink/genetlink.c:634
>  #1:  (genl_mutex){+.+.}, at: [<000000002e321e71>] genl_lock
> net/netlink/genetlink.c:33 [inline]
>  #1:  (genl_mutex){+.+.}, at: [<000000002e321e71>] genl_rcv_msg+0x115/0x140
> net/netlink/genetlink.c:622
> 
> stack backtrace:
> CPU: 0 PID: 4164 Comm: syzkaller756462 Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4592
>  tipc_bearer_find+0x2b4/0x3b0 net/tipc/bearer.c:177
>  tipc_nl_compat_link_set+0x329/0x9f0 net/tipc/netlink_compat.c:729
>  __tipc_nl_compat_doit net/tipc/netlink_compat.c:288 [inline]
>  tipc_nl_compat_doit+0x15b/0x670 net/tipc/netlink_compat.c:335
>  tipc_nl_compat_handle net/tipc/netlink_compat.c:1119 [inline]
>  tipc_nl_compat_recv+0x1135/0x18f0 net/tipc/netlink_compat.c:1201
>  genl_family_rcv_msg+0x7b7/0xfb0 net/netlink/genetlink.c:599
>  genl_rcv_msg+0xb2/0x140 net/netlink/genetlink.c:624
>  netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2442
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
>  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
>  netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1334
>  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1897
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:640
>  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
>  SYSC_sendmsg net/socket.c:2091 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x43fd69
> RSP: 002b:00007fff09979378 EFLAGS: 00000203 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fd69
> RDX: 0000000000000000 RSI: 0000000020003000 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000203 R12: 0000000000401690
> R13: 0000000000401720 R14: 0000000000000000 R15: 0000000
> 

This was fixed by commit ed4ffdfec26df:

#syz fix: tipc: Fix missing RTNL lock protection during setting link properties

- Eric
