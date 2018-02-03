Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeBCLZl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:25:41 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43294 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBCLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:25:35 -0500
X-Google-Smtp-Source: AH8x2241qoQ9N9C8M+CWDGid/Cr/uBYzMUp+QMj2Bq//KbpXGnidA8ihAz8X1y0YdMTzbc3ewwRzFpr4EJI4Xys4Xxs=
MIME-Version: 1.0
In-Reply-To: <001a113ecb5eccaeca05642b2cf0@google.com>
References: <001a113ecb5eccaeca05642b2cf0@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 3 Feb 2018 12:25:33 +0100
Message-ID: <CADvbK_ccH5XSQHsmA05gxCL=7EpfQfOLD+NR5eSpYzSiidt2Xg@mail.gmail.com>
Subject: Re: possible deadlock in rtnl_lock (2)
To: syzbot <syzbot+61e4972c2b1d5e08a5c2@syzkaller.appspotmail.com>
Cc: christian.brauner@ubuntu.com, Daniel Borkmann <daniel@iogearbox.net>,
        davem <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        mschiffer@universe-factory.net, network dev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Vlad Yasevich <vyasevich@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 7:58 PM, syzbot
<syzbot+61e4972c2b1d5e08a5c2@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 255442c93843f52b6891b21d0b485bf2c97f93c3 (Thu Feb 1 03:25:25 2018 +0000)
> Merge tag 'docs-4.16' of git://git.lwn.net/linux
>
> So far this crash happened 1587 times on net-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+61e4972c2b1d5e08a5c2@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.15.0+ #290 Not tainted
> ------------------------------------------------------
> syzkaller681093/4124 is trying to acquire lock:
>  (rtnl_mutex){+.+.}, at: [<00000000c3d62391>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> but task is already holding lock:
>  (sk_lock-AF_INET){+.+.}, at: [<0000000051813e83>] lock_sock
> include/net/sock.h:1461 [inline]
>  (sk_lock-AF_INET){+.+.}, at: [<0000000051813e83>] ip_setsockopt+0x8c/0xb0
> net/ipv4/ip_sockglue.c:1259
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (sk_lock-AF_INET){+.+.}:
>        lock_sock_nested+0xc2/0x110 net/core/sock.c:2780
>        lock_sock include/net/sock.h:1461 [inline]
>        do_ip_getsockopt+0x1b3/0x2170 net/ipv4/ip_sockglue.c:1335
>        ip_getsockopt+0x90/0x220 net/ipv4/ip_sockglue.c:1566
>        tcp_getsockopt+0x82/0xd0 net/ipv4/tcp.c:3359
>        sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2937
>        SYSC_getsockopt net/socket.c:1880 [inline]
>        SyS_getsockopt+0x178/0x340 net/socket.c:1862
>        entry_SYSCALL_64_fastpath+0x29/0xa0
>
> -> #0 (rtnl_mutex){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>        register_netdevice_notifier+0xad/0x860 net/core/dev.c:1607
>        tee_tg_check+0x1a0/0x280 net/netfilter/xt_TEE.c:106
>        xt_check_target+0x22c/0x7d0 net/netfilter/x_tables.c:845
>        check_target net/ipv4/netfilter/ip_tables.c:513 [inline]
>        find_check_entry.isra.8+0x8c8/0xcb0
> net/ipv4/netfilter/ip_tables.c:554
>        translate_table+0xed1/0x1610 net/ipv4/netfilter/ip_tables.c:725
>        do_replace net/ipv4/netfilter/ip_tables.c:1141 [inline]
>        do_ipt_set_ctl+0x370/0x5f0 net/ipv4/netfilter/ip_tables.c:1675
>        nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>        nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
>        ip_setsockopt+0xa1/0xb0 net/ipv4/ip_sockglue.c:1260
>        sctp_setsockopt+0x2b6/0x61d0 net/sctp/socket.c:4104
>        sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2978
>        SYSC_setsockopt net/socket.c:1849 [inline]
>        SyS_setsockopt+0x189/0x360 net/socket.c:1828
>        entry_SYSCALL_64_fastpath+0x29/0xa0
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(sk_lock-AF_INET);
>                                lock(rtnl_mutex);
>                                lock(sk_lock-AF_INET);
>   lock(rtnl_mutex);
>
>  *** DEADLOCK ***
>
> 1 lock held by syzkaller681093/4124:
>  #0:  (sk_lock-AF_INET){+.+.}, at: [<0000000051813e83>] lock_sock
> include/net/sock.h:1461 [inline]
>  #0:  (sk_lock-AF_INET){+.+.}, at: [<0000000051813e83>]
> ip_setsockopt+0x8c/0xb0 net/ipv4/ip_sockglue.c:1259
>
> stack backtrace:
> CPU: 0 PID: 4124 Comm: syzkaller681093 Not tainted 4.15.0+ #290
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>  __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  register_netdevice_notifier+0xad/0x860 net/core/dev.c:1607
>  tee_tg_check+0x1a0/0x280 net/netfilter/xt_TEE.c:106
>  xt_check_target+0x22c/0x7d0 net/netfilter/x_tables.c:845
>  check_target net/ipv4/netfilter/ip_tables.c:513 [inline]
>  find_check_entry.isra.8+0x8c8/0xcb0 net/ipv4/netfilter/ip_tables.c:554
>  translate_table+0xed1/0x1610 net/ipv4/netfilter/ip_tables.c:725
>  do_replace net/ipv4/netfilter/ip_tables.c:1141 [inline]
>  do_ipt_set_ctl+0x370/0x5f0 net/ipv4/netfilter/ip_tables.c:1675
>  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>  nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
>  ip_setsockopt+0xa1/0xb0 net/ipv4/ip_sockglue.c:1260
>  sctp_setsockopt+0x2b6/0x61d0 net/sctp/socket.c:4104
>  sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2978
>  SYSC_setsockopt net/socket.c:1849 [inline]
>  SyS_setsockopt+0x189/0x360 net/socket.c:1828
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x445bd9
> RSP: 002b:00007fffdfb6a998 EFLAGS: 00000203 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 0000000000445bd9
> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 00007fffdfb6aa48 R08: 0000000000000318 R09: 0000000000000000
> R10: 000000002
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
I guess Paolo had already fixed it in this commit:

commit 3f34cfae1238848fd53f25e5c8fd59da57901f4b
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Jan 30 19:01:40 2018 +0100

    netfilter: on sockopt() acquire sock lock only in the required scope

Pls check if it's already in this kernel.
