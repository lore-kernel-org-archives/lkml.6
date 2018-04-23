Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbeDWNb1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:31:27 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38317 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbeDWNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:31:21 -0400
X-Google-Smtp-Source: AIpwx49LEIfHZPprQ9j/IquaAPJ4H2jRAPwlGQWyZhCd5H6rVqLhDEA4BJEAHgtQSEAkXzoR9dBsdg==
Subject: Re: WARNING: suspicious RCU usage in rt6_check_expired
To: syzbot <syzbot+2422c9e35796659d2273@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, David Ahern <dsahern@gmail.com>
References: <0000000000009f23ab056a7fc243@google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a0eb8d30-0f76-fad2-e9fa-5de92f59b2ff@gmail.com>
Date: Mon, 23 Apr 2018 06:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0000000000009f23ab056a7fc243@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2018 01:24 AM, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on net-next commit
> 0638eb573cde5888c0886c7f35da604e5db209a6 (Sat Apr 21 20:06:14 2018 +0000)
> Merge branch 'ipv6-Another-followup-to-the-fib6_info-change'
> syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=2422c9e35796659d2273
> 
> So far this crash happened 3 times on net-next.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output: https://syzkaller.appspot.com/x/log.txt?id=6081013801287680
> Kernel config: https://syzkaller.appspot.com/x/.config?id=-8412024688694752032
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2422c9e35796659d2273@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for details.
> If you forward the report, please keep this part and the footer.
> 
> netlink: 'syz-executor4': attribute type 6 has an invalid length.
> netlink: 'syz-executor4': attribute type 1 has an invalid length.
> netlink: 'syz-executor4': attribute type 6 has an invalid length.
> 
> =============================
> WARNING: suspicious RCU usage
> 4.16.0+ #11 Not tainted
> -----------------------------
> net/ipv6/route.c:410 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor7/25958:
>  #0: 00000000d1963139 (sk_lock-AF_INET6){+.+.}, at: lock_sock include/net/sock.h:1469 [inline]
>  #0: 00000000d1963139 (sk_lock-AF_INET6){+.+.}, at: sock_setsockopt+0x19c/0x1fe0 net/core/sock.c:717
> 
> stack backtrace:
> CPU: 1 PID: 25958 Comm: syz-executor7 Not tainted 4.16.0+ #11
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4592
>  rt6_check_expired+0x38b/0x3e0 net/ipv6/route.c:410
>  ip6_negative_advice+0x67/0xc0 net/ipv6/route.c:2204
>  dst_negative_advice include/net/sock.h:1786 [inline]
>  sock_setsockopt+0x138f/0x1fe0 net/core/sock.c:1051
>  __sys_setsockopt+0x2df/0x390 net/socket.c:1899
>  SYSC_setsockopt net/socket.c:1914 [inline]
>  SyS_setsockopt+0x34/0x50 net/socket.c:1911
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x455389
> RSP: 002b:00007f7556e30c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00007f7556e316d4 RCX: 0000000000455389
> RDX: 0000000000000035 RSI: 0000000000000001 RDI: 0000000000000013
> RBP: 000000000072bf58 R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000020000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000005ff R14: 00000000006fc088 R15: 0000000000000001
> netlink: 'syz-executor4': attribute type 4 has an invalid length.
> netlink: 'syz-executor4': attribute type 4 has an invalid length.
> IPVS: set_ctl: invalid protocol: 59 127.0.0.1:20000 lc
> IPVS: set_ctl: invalid protocol: 127 224.0.0.1:20000 rr
> IPVS: sync thread started: state = BACKUP, mcast_ifn = ip6tnl0, syncid = 4, id = 0
> IPVS: set_ctl: invalid protocol: 127 224.0.0.1:20000 rr
> netlink: 72 bytes leftover after parsing attributes in process `syz-executor2'.
> netlink: 72 bytes leftover after parsing attributes in process `syz-executor2'.
> dccp_xmit_packet: Payload too large (65423) for featneg.
> IPVS: set_ctl: invalid protocol: 29 1.0.0.0:2 wlc
> IPVS: set_ctl: invalid protocol: 29 1.0.0.0:2 wlc
> netlink: 32 bytes leftover after parsing attributes in process `syz-executor7'.
> netlink: 12 bytes leftover after parsing attributes in process `syz-executor1'.
> netlink: 12 bytes leftover after parsing attributes in process `syz-executor1'.
> netlink: 'syz-executor1': attribute type 29 has an invalid length.
> netlink: 8 bytes leftover after parsing attributes in process `syz-executor1'.
> IPVS: set_ctl: invalid protocol: 108 224.0.0.1:20004 lblc
> netlink: 'syz-executor1': attribute type 29 has an invalid length.
> netlink: 8 bytes leftover after parsing attributes in process `syz-executor1'.
> IPVS: set_ctl: invalid protocol: 108 224.0.0.1:20004 lblc
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug report.
> Note: all commands must start from beginning of the line in the email body.

Added in commit a68886a691804d3f6d479ebf6825480fbafb6a00
("net/ipv6: Make from in rt6_info rcu protected")
