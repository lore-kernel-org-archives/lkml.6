Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FEAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C47218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551228949;
	bh=9OcIBA0HGW50ByuJQMY0V4gE6bGP0/plCT2uniXG9RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HbhSQ3DQbtS/ShpV6gp5YZMhxcqJ//gw7KZey68k/X9op9tJcMA/3uhg0VN2h0KD7
	 zCHYTnzKbfUCKFXouxxzVahVPAVU1NAXzuF2ULxiZzF5kDrqCgO4uR9Zq3U4PwVzFA
	 uwI28hLKfPdoIbgDGtwx2ooexipd80y5/TsDqpMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfB0Azr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfB0Azr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:55:47 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D44218D0;
        Wed, 27 Feb 2019 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551228946;
        bh=9OcIBA0HGW50ByuJQMY0V4gE6bGP0/plCT2uniXG9RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqAUFdrK8bek7Tw0HvJoEnV3ylMeDznG4OvfmMa+UwNZ05dLFt4NT3l5XZrkKj7Je
         cgeJ7tx6a1Y3w+S6Ok9+NiCv3ZCQVHwwUJxq3ToRlrAo+QPxPx7ZaFPCUMln7sPD3o
         Cbn9BG/hhchPwWexxboFRhloUZbvX0h+lpeXailo=
Date:   Tue, 26 Feb 2019 16:55:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+3aac4a52d8e8ca0414d5@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: general protection fault in finish_wait
Message-ID: <20190227005543.GJ218103@gmail.com>
References: <0000000000009276d205708f9910@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009276d205708f9910@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:49:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6508b6781be0 tcp: cleanup copied_seq and urg_data in tcp_d..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1256e6dc400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=3aac4a52d8e8ca0414d5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1310fafc400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10af4f48400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3aac4a52d8e8ca0414d5@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 19 Comm: kworker/1:0 Not tainted 4.18.0-rc3+ #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events smc_tcp_listen_work
> RIP: 0010:__lock_acquire+0x245/0x5020 kernel/locking/lockdep.c:3314
> Code: 28 00 00 00 0f 85 03 34 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85
> c6 35 00 00 49 81 7d 00 60 76 e7 89 0f 84 42 ff
> RSP: 0000:ffff8801d9b36d20 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff88f1b060
> RBP: ffff8801d9b370a8 R08: 0000000000000001 R09: 0000000000000001
> R10: ffff8801d9b2a500 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000018 R14: ffff8801d9b2a500 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002cc0 CR3: 00000001ae03f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  finish_wait+0x119/0x430 kernel/sched/wait.c:364
>  inet_csk_wait_for_connect net/ipv4/inet_connection_sock.c:418 [inline]
>  inet_csk_accept+0x6d0/0xe70 net/ipv4/inet_connection_sock.c:451
>  inet_accept+0x138/0x9f0 net/ipv4/af_inet.c:734
>  kernel_accept+0x136/0x310 net/socket.c:3251
>  smc_clcsock_accept net/smc/af_smc.c:701 [inline]
>  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1114
>  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
>  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 472b359041f047a6 ]---
> RIP: 0010:__lock_acquire+0x245/0x5020 kernel/locking/lockdep.c:3314
> Code: 28 00 00 00 0f 85 03 34 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85
> c6 35 00 00 49 81 7d 00 60 76 e7 89 0f 84 42 ff
> RSP: 0000:ffff8801d9b36d20 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff88f1b060
> RBP: ffff8801d9b370a8 R08: 0000000000000001 R09: 0000000000000001
> R10: ffff8801d9b2a500 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000018 R14: ffff8801d9b2a500 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002cc0 CR3: 00000001ae03f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009276d205708f9910%40google.com.
> For more options, visit https://groups.google.com/d/optout.

This was fixed by:

    commit 78abe3d0dfad196959b1246003366e2610775ea6 (refs/bisect/new)
    Author: Myungho Jung <mhjungk@gmail.com>
    Date:   Tue Dec 18 09:02:25 2018 -0800

        net/smc: fix TCP fallback socket release

#syz fix: net/smc: fix TCP fallback socket release

There are newer crashes with this same signature, e.g.
https://syzkaller.appspot.com/text?tag=CrashReport&x=16cb391f400000
but they are something different...

- Eric
