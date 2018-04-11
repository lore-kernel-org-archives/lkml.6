Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeDKOF7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:05:59 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:42895 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:05:57 -0400
X-Google-Smtp-Source: AIpwx49MlI3BAA5tOqwRMf7ONXSGz6hdlPhGfIPySNu56vbQZa8jphXPRQI+p59Gg4eP33Mt2cK3yVyQK/s3blbHH+M=
MIME-Version: 1.0
In-Reply-To: <94eb2c056114525fed05699315f1@google.com>
References: <94eb2c056114525fed05699315f1@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 16:05:35 +0200
Message-ID: <CACT4Y+Z3Ktnio1B0TAZpx8HOEfd2evwyQqbMeWGvEkzh0yfhKQ@mail.gmail.com>
Subject: Re: WARNING: possible recursive locking detected
To: syzbot <syzbot+3c43eecd7745a5ce1640@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 4:02 PM, syzbot
<syzbot+3c43eecd7745a5ce1640@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
> Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=3c43eecd7745a5ce1640
>
> So far this crash happened 3 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5103706542440448
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5641659786199040
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5099510896263168
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3c43eecd7745a5ce1640@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

#syz dup: possible deadlock in rtnl_lock (5)

> IPVS: sync thread started: state = BACKUP, mcast_ifn = lo, syncid = 0, id =
> 0
> IPVS: stopping backup sync thread 4546 ...
>
> ============================================
> IPVS: stopping backup sync thread 4559 ...
> WARNING: possible recursive locking detected
> 4.16.0+ #19 Not tainted
> --------------------------------------------
> syzkaller046099/4543 is trying to acquire lock:
> 000000008d06d497 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> but task is already holding lock:
> IPVS: stopping backup sync thread 4557 ...
> 000000008d06d497 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(rtnl_mutex);
>   lock(rtnl_mutex);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 2 locks held by syzkaller046099/4543:
>  #0: 000000008d06d497 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>  #1: 000000008326bc5c (ipvs->sync_mutex){+.+.}, at:
> do_ip_vs_set_ctl+0x562/0x1d30 net/netfilter/ipvs/ip_vs_ctl.c:2388
>
> stack backtrace:
> CPU: 1 PID: 4543 Comm: syzkaller046099 Not tainted 4.16.0+ #19
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_deadlock_bug kernel/locking/lockdep.c:1761 [inline]
>  check_deadlock kernel/locking/lockdep.c:1805 [inline]
>  validate_chain kernel/locking/lockdep.c:2401 [inline]
>  __lock_acquire.cold.62+0x18c/0x55b kernel/locking/lockdep.c:3431
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>  __mutex_lock+0x16d/0x17f0 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  ip_mc_drop_socket+0x8f/0x270 net/ipv4/igmp.c:2643
>  inet_release+0x4e/0x1f0 net/ipv4/af_inet.c:413
>  sock_release+0x96/0x1b0 net/socket.c:594
>  start_sync_thread+0xdc3/0x2d40 net/netfilter/ipvs/ip_vs_sync.c:1924
>  do_ip_vs_set_ctl+0x59c/0x1d30 net/netfilter/ipvs/ip_vs_ctl.c:2389
>  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>  nf_setsockopt+0x7d/0xd0 net/netfilter/nf_sockopt.c:115
>  ip_setsockopt+0xd8/0xf0 net/ipv4/ip_sockglue.c:1253
>  udp_setsockopt+0x62/0xa0 net/ipv4/udp.c:2413
>  ipv6_setsockopt+0x149/0x170 net/ipv6/ipv6_sockglue.c:917
>  udpv6_setsockopt+0x62/0xa0 net/ipv6/udp.c:1424
>  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3039
>  __sys_setsockopt+0x1bd/0x390 net/socket.c:1903
>  SYSC_setsockopt net/socket.c:1914 [inline]
>  SyS_setsockopt+0x34/0x50 net/socket.c:1911
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x447c19
> RSP: 002b:00007fb627a93db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000700024 RCX: 0000000000447c19
> RDX: 000000000000048b RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 0000000000700020 R08: 0000000000000018 R09: 0000000000000000
> R10: 0000000020000100 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000080fe4f R14: 00007fb627a949c0 R15: 0000000000002710
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c056114525fed05699315f1%40google.com.
> For more options, visit https://groups.google.com/d/optout.
