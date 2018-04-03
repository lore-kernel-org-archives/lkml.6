Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeDCLZi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:25:38 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:44897 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeDCLZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:25:36 -0400
X-Google-Smtp-Source: AIpwx484efCHYwbt6PhCl25WEpCjNaB++Yi3B1QapD5sFxkoG96fhvSXqsal/nQM+qAbTNiaMyuGLqfcaf+zD8XqrVM=
MIME-Version: 1.0
In-Reply-To: <06c79d3f-3f28-7f1e-9431-66c18149c9e6@virtuozzo.com>
References: <0000000000003584570568da18dd@google.com> <06c79d3f-3f28-7f1e-9431-66c18149c9e6@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 3 Apr 2018 13:25:14 +0200
Message-ID: <CACT4Y+Zb4Y1=H8Vtd1d+ULKu-P3ftud=SgFqSAfu9SE6Lu3LMA@mail.gmail.com>
Subject: Re: possible deadlock in skb_queue_tail
To: Kirill Tkhai <ktkhai@virtuozzo.com>, Ingo Molnar <mingo@kernel.org>
Cc: syzbot <syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        David Windsor <dwindsor@gmail.com>, elena.reshetova@intel.com,
        ishkamiel@gmail.com, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, matthew@mjdsystems.ca,
        Mateusz Jurczyk <mjurczyk@google.com>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        xemul@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 11:50 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 02.04.2018 12:20, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on net-next commit
>> 06b19fe9a6df7aaa423cd8404ebe5ac9ec4b2960 (Sun Apr 1 03:37:33 2018 +0000)
>> Merge branch 'chelsio-inline-tls'
>> syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=6b495100f17ca8554ab9
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>> Raw console output: https://syzkaller.appspot.com/x/log.txt?id=6218830443446272
>> Kernel config: https://syzkaller.appspot.com/x/.config?id=3327544840960562528
>> compiler: gcc (GCC) 7.1.1 20170620
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for details.
>> If you forward the report, please keep this part and the footer.
>>
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 4.16.0-rc6+ #290 Not tainted
>> ------------------------------------------------------
>> syz-executor7/20971 is trying to acquire lock:
>>  (&af_unix_sk_receive_queue_lock_key){+.+.}, at: [<00000000271ef0d8>] skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>>
>> but task is already holding lock:
>>  (&(&u->lock)->rlock/1){+.+.}, at: [<000000004e725e14>] unix_state_double_lock+0x7b/0xb0 net/unix/af_unix.c:1088
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (&(&u->lock)->rlock/1){+.+.}:
>>        _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
>>        sk_diag_dump_icons net/unix/diag.c:82 [inline]
>>        sk_diag_fill.isra.4+0xa52/0xfe0 net/unix/diag.c:144
>>        sk_diag_dump net/unix/diag.c:178 [inline]
>>        unix_diag_dump+0x400/0x4f0 net/unix/diag.c:206
>>        netlink_dump+0x492/0xcf0 net/netlink/af_netlink.c:2221
>>        __netlink_dump_start+0x4ec/0x710 net/netlink/af_netlink.c:2318
>>        netlink_dump_start include/linux/netlink.h:214 [inline]
>>        unix_diag_handler_dump+0x3e7/0x750 net/unix/diag.c:307
>>        __sock_diag_cmd net/core/sock_diag.c:230 [inline]
>>        sock_diag_rcv_msg+0x204/0x360 net/core/sock_diag.c:261
>>        netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2443
>>        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
>>        netlink_unicast_kernel net/netlink/af_netlink.c:1307 [inline]
>>        netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1333
>>        netlink_sendmsg+0xa4a/0xe80 net/netlink/af_netlink.c:1896
>>        sock_sendmsg_nosec net/socket.c:629 [inline]
>>        sock_sendmsg+0xca/0x110 net/socket.c:639
>>        sock_write_iter+0x31a/0x5d0 net/socket.c:908
>>        call_write_iter include/linux/fs.h:1782 [inline]
>>        new_sync_write fs/read_write.c:469 [inline]
>>        __vfs_write+0x684/0x970 fs/read_write.c:482
>>        vfs_write+0x189/0x510 fs/read_write.c:544
>>        SYSC_write fs/read_write.c:589 [inline]
>>        SyS_write+0xef/0x220 fs/read_write.c:581
>>        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>        entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> -> #0 (&af_unix_sk_receive_queue_lock_key){+.+.}:
>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>>        skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>>        unix_dgram_sendmsg+0xa30/0x1610 net/unix/af_unix.c:1807
>>        sock_sendmsg_nosec net/socket.c:629 [inline]
>>        sock_sendmsg+0xca/0x110 net/socket.c:639
>>        ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>>        __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>>        SYSC_sendmmsg net/socket.c:2168 [inline]
>>        SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>>        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>        entry_SYSCALL_64_after_hwframe+0x42/0xb7
>
> sk_diag_dump_icons() dumps only sockets in TCP_LISTEN state.
> TCP_LISTEN state may be assigned in only place in net/unix/af_unix.c:
> it's unix_listen(). The function is applied to stream and seqpacket
> socket types.
>
> It can't be stream because of the second stack, and seqpacket also can't,
> as I don't think it's possible for gcc to inline unix_seqpacket_sendmsg()
> in the way, we don't see it in the stack.
>
> So, this is looks like false positive result for me.
>
> Kirill

Do you mean that these &(&u->lock)->rlock/1 referenced in 2 stacks are
always different?

+Ingo for lockdep false positive
Do we need some kind of annotation here?


>> other info that might help us debug this:
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&(&u->lock)->rlock/1);
>>                                lock(&af_unix_sk_receive_queue_lock_key);
>>                                lock(&(&u->lock)->rlock/1);
>>   lock(&af_unix_sk_receive_queue_lock_key);
>>
>>  *** DEADLOCK ***
>>
>> 1 lock held by syz-executor7/20971:
>>  #0:  (&(&u->lock)->rlock/1){+.+.}, at: [<000000004e725e14>] unix_state_double_lock+0x7b/0xb0 net/unix/af_unix.c:1088
>>
>> stack backtrace:
>> CPU: 0 PID: 20971 Comm: syz-executor7 Not tainted 4.16.0-rc6+ #290
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>>  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
>>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
>>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>>  skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>>  unix_dgram_sendmsg+0xa30/0x1610 net/unix/af_unix.c:1807
>>  sock_sendmsg_nosec net/socket.c:629 [inline]
>>  sock_sendmsg+0xca/0x110 net/socket.c:639
>>  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>>  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>>  SYSC_sendmmsg net/socket.c:2168 [inline]
>>  SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>> RIP: 0033:0x455269
>> RSP: 002b:00007f71ffad6c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
>> RAX: ffffffffffffffda RBX: 00007f71ffad76d4 RCX: 0000000000455269
>> RDX: 04924924924924f4 RSI: 0000000020000200 RDI: 0000000000000016
>> RBP: 000000000072bf58 R08: 0000000000000000 R09: 0000000000000000
>> R10: 00000000200000d4 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 00000000000004ca R14: 00000000006f9390 R15: 0000000000000001
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: sync thread started: state = BACKUP, mcast_ifn = bcsh0, syncid = 0, id = 0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>> IPVS: Unknown mcast interface: bcsh0
>>
>>
>> ---
>> This bug is generated by a dumb bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for details.
>> Direct all questions to syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report.
>> If you forgot to add the Reported-by tag, once the fix for this bug is merged
>> into any tree, please reply to this email with:
>> #syz fix: exact-commit-title
>> To mark this as a duplicate of another syzbot report, please reply with:
>> #syz dup: exact-subject-of-another-report
>> If it's a one-off invalid bug report, please reply with:
>> #syz invalid
>> Note: if the crash happens again, it will cause creation of a new bug report.
>> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/06c79d3f-3f28-7f1e-9431-66c18149c9e6%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
