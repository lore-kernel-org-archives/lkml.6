Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeEOFUC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:20:02 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:38941 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeEOFUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:20:00 -0400
X-Google-Smtp-Source: AB8JxZrGUfizNYYv7KNq1GKwDvL/DAatzLnAlbTnfAYxmJPlO1V3RXNPpjdGsIbcRRE8S12+h0MNRBEF8auUZWQXAx0=
MIME-Version: 1.0
In-Reply-To: <20180514180035.GA20189@outlook.office365.com>
References: <000000000000169606056b793179@google.com> <20180511183358.GA1492@outlook.office365.com>
 <CACT4Y+bt-HwBNA5REeZwoKAymCc-Da5rEU=yeeHodg7zByStQg@mail.gmail.com> <20180514180035.GA20189@outlook.office365.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 15 May 2018 07:19:39 +0200
Message-ID: <CACT4Y+a9v+38=DUpTGu0doaf3xWW02PUzoC7idgwOg+rV2eFTQ@mail.gmail.com>
Subject: Re: possible deadlock in sk_diag_fill
To: Andrei Vagin <avagin@virtuozzo.com>
Cc: syzbot <syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com>,
        avagin <avagin@openvz.org>, David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 8:00 PM, Andrei Vagin <avagin@virtuozzo.com> wrote:
>> >> Hello,
>> >>
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
>> >> git tree:       upstream
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12164c97800000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c1872be62e587eae9669
>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >> userspace arch: i386
>> >>
>> >> Unfortunately, I don't have any reproducer for this crash yet.
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com
>> >>
>> >>
>> >> ======================================================
>> >> WARNING: possible circular locking dependency detected
>> >> 4.17.0-rc3+ #59 Not tainted
>> >> ------------------------------------------------------
>> >> syz-executor1/25282 is trying to acquire lock:
>> >> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at: sk_diag_dump_icons
>> >> net/unix/diag.c:82 [inline]
>> >> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at:
>> >> sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
>> >>
>> >> but task is already holding lock:
>> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock
>> >> include/linux/spinlock.h:310 [inline]
>> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons
>> >> net/unix/diag.c:64 [inline]
>> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_fill.isra.5+0x94e/0x10d0
>> >> net/unix/diag.c:144
>> >>
>> >> which lock already depends on the new lock.
>> >
>> > In the code, we have a comment which explains why it is safe to take this lock
>> >
>> > /*
>> >  * The state lock is outer for the same sk's
>> >  * queue lock. With the other's queue locked it's
>> >  * OK to lock the state.
>> >  */
>> > unix_state_lock_nested(req);
>> >
>> > It is a question how to explain this to lockdep.
>>
>> Do I understand it correctly that (&u->lock)->rlock associated with
>> AF_UNIX is locked under rlock-AF_UNIX, and then rlock-AF_UNIX is
>> locked under (&u->lock)->rlock associated with AF_NETLINK? If so, I
>> think we need to split (&u->lock)->rlock by family too, so that we
>> have u->lock-AF_UNIX and u->lock-AF_NETLINK.
>
> I think here is another problem. lockdep woried about
> sk->sk_receive_queue vs unix_sk(s)->lock.
>
> sk_diag_dump_icons() takes sk->sk_receive_queue and then
> unix_sk(s)->lock.
>
> unix_dgram_sendmsg takes unix_sk(sk)->lock and then sk->sk_receive_queue.
>
> sk_diag_dump_icons() takes locks for two different sockets, but
> unix_dgram_sendmsg() takes locks for one socket.
>
> sk_diag_dump_icons
>         if (sk->sk_state == TCP_LISTEN) {
>                 spin_lock(&sk->sk_receive_queue.lock);
>                 skb_queue_walk(&sk->sk_receive_queue, skb) {
>                         unix_state_lock_nested(req);
>                                 spin_lock_nested(&unix_sk(s)->lock,
>
>
> unix_dgram_sendmsg
>         unix_state_lock(other)
>                 spin_lock(&unix_sk(s)->lock)
>         skb_queue_tail(&other->sk_receive_queue, skb);
>                 spin_lock_irqsave(&list->lock, flags);


Do you mean the following?
There is socket 1 with state lock (S1) and queue lock (Q2), and socket
2 with state lock (S2) and queue lock (Q2). unix_dgram_sendmsg lock
S1->Q1. And sk_diag_dump_icons locks Q1->S2.
If yes, then this looks pretty much as deadlock. Consider that 2
unix_dgram_sendmsg in 2 different threads lock S1 and S2 respectively.
Now 2  sk_diag_dump_icons in 2 different threads lock Q1 and Q2
respectively. Now sk_diag_dump_icons want to lock S's, and
unix_dgram_sendmsg want to lock Q's. Nobody can proceed.
