Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E41C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0059C20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QwACmbGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0059C20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeKSU6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeKSU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DwnqvFUhKAKDLKiAAPNJE98oowVRK3GDljqSen+mO3Q=; b=QwACmbGcM3F6MIAK902W0O08G
        hukm5K5lR9OyuPS9cFAtl/Oyi0pcAjSRxq5VXGRkwjRezLhyQ3D67BfoHOOPhuYnZAZzotdfU7Qng
        LrFEWtWtcX2t0mw0eFsjA5gl7VGJojGl3GG+wGu0e+yUdo8JbedeXp7324mkAYCOcp7HGjyca3j/+
        WlGBRgWz3ycamT8GoqLwgvW28aDFUawqMbq18+bZiaqRbGqzkaN48J837tmzl6+08xk5BZEwv611Q
        BV6bc5Bmx/Hqx86q096InKIiroGsq/hUqrGp5LxwABANLoLTA1yCis59Pm/yMukRT8dHMoIjSE8j5
        tIKqgs1hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOgt3-0003wC-Fc; Mon, 19 Nov 2018 10:34:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05B8120298C0C; Mon, 19 Nov 2018 11:34:36 +0100 (CET)
Date:   Mon, 19 Nov 2018 11:34:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: WARNING in enqueue_task_dl
Message-ID: <20181119103435.GA9761@hirez.programming.kicks-ass.net>
References: <000000000000b5e346057af4da06@google.com>
 <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:23:03AM +0100, Thomas Gleixner wrote:
> Adding scheduler folks

Nothing new there, printk is crap.

> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 4.20.0-rc2+ #338 Not tainted
> > ------------------------------------------------------
> > syz-executor0/6351 is trying to acquire lock:
> > 00000000b2b97155 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70
> > kernel/locking/semaphore.c:136
> > 
> > but task is already holding lock:
> > 000000004cd5557e (&rq->lock){-.-.}, at: task_rq_lock+0xc5/0x2a0
> > kernel/sched/core.c:99
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #2 (&rq->lock){-.-.}:
> >       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >       _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
> >       rq_lock kernel/sched/sched.h:1126 [inline]
> >       task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:9768
> >       sched_fork+0x443/0xba0 kernel/sched/core.c:2359
> >       copy_process+0x25b8/0x87a0 kernel/fork.c:1887
> >       _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
> >       kernel_thread+0x34/0x40 kernel/fork.c:2275
> >       rest_init+0x28/0x372 init/main.c:409
> >       arch_call_rest_init+0xe/0x1b
> >       start_kernel+0x9f0/0xa2b init/main.c:745
> >       x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
> >       x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
> >       secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
> > 
> > -> #1 (&p->pi_lock){-.-.}:
> >       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >       _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
> >       try_to_wake_up+0xdc/0x1490 kernel/sched/core.c:1965
> >       wake_up_process+0x10/0x20 kernel/sched/core.c:2129
> >       __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
> >       up+0x13c/0x1c0 kernel/locking/semaphore.c:187
> >       __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:236
> >       console_unlock+0x811/0x1190 kernel/printk/printk.c:2432
> >       do_con_write+0x1356/0x23b0 drivers/tty/vt/vt.c:2767
> >       con_write+0x25/0xc0 drivers/tty/vt/vt.c:3116
> >       process_output_block drivers/tty/n_tty.c:593 [inline]
> >       n_tty_write+0x6c1/0x11a0 drivers/tty/n_tty.c:2331
> >       do_tty_write drivers/tty/tty_io.c:959 [inline]
> >       tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1043
> >       __vfs_write+0x119/0x9f0 fs/read_write.c:485
> >       vfs_write+0x1fc/0x560 fs/read_write.c:549
> >       ksys_write+0x101/0x260 fs/read_write.c:598
> >       __do_sys_write fs/read_write.c:610 [inline]
> >       __se_sys_write fs/read_write.c:607 [inline]
> >       __x64_sys_write+0x73/0xb0 fs/read_write.c:607
> >       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >       entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > -> #0 ((console_sem).lock){-.-.}:
> >       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> >       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >       _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
> >       down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
> >       __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
> >       console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
> >       console_trylock_spinning kernel/printk/printk.c:1653 [inline]
> >       vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
> >       vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
> >       vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
> >       printk+0xa7/0xcf kernel/printk/printk.c:1997
> >       __warn+0x9e/0x1d0 kernel/panic.c:522
> >       report_bug+0x254/0x2d0 lib/bug.c:186
> >       fixup_bug arch/x86/kernel/traps.c:178 [inline]
> >       do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
> >       do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
> >       invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
> >       enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
> >       enqueue_task+0x184/0x390 kernel/sched/core.c:730
> >       __sched_setscheduler+0xe99/0x2190 kernel/sched/core.c:4336
> >       sched_setattr kernel/sched/core.c:4394 [inline]
> >       __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
> >       __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
> >       __x64_sys_sched_setattr+0x1b2/0x2f0 kernel/sched/core.c:4549
> >       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >       entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > other info that might help us debug this:
> > 
> > Chain exists of:
> >  (console_sem).lock --> &p->pi_lock --> &rq->lock
> > 
> > Possible unsafe locking scenario:
> > 
> >       CPU0                    CPU1
> >       ----                    ----
> >  lock(&rq->lock);
> >                               lock(&p->pi_lock);
> >                               lock(&rq->lock);
> >  lock((console_sem).lock);
> > 
> > *** DEADLOCK ***
> > 
> > 3 locks held by syz-executor0/6351:
> > #0: 000000001a0356c1 (rcu_read_lock){....}, at: __do_sys_sched_setattr
> > kernel/sched/core.c:4563 [inline]
> > #0: 000000001a0356c1 (rcu_read_lock){....}, at: __se_sys_sched_setattr
> > kernel/sched/core.c:4549 [inline]
> > #0: 000000001a0356c1 (rcu_read_lock){....}, at:
> > __x64_sys_sched_setattr+0x146/0x2f0 kernel/sched/core.c:4549
> > #1: 000000000b71b478 (&p->pi_lock){-.-.}, at: task_rq_lock+0x62/0x2a0
> > kernel/sched/core.c:97
> > #2: 000000004cd5557e (&rq->lock){-.-.}, at: task_rq_lock+0xc5/0x2a0
> > kernel/sched/core.c:99
> > 
> > stack backtrace:
> > CPU: 1 PID: 6351 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #338
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> > 01/01/2011
> > Call Trace:
> > __dump_stack lib/dump_stack.c:77 [inline]
> > dump_stack+0x244/0x39d lib/dump_stack.c:113
> > print_circular_bug.isra.35.cold.54+0x1bd/0x27d kernel/locking/lockdep.c:1221
> > check_prev_add kernel/locking/lockdep.c:1863 [inline]
> > check_prevs_add kernel/locking/lockdep.c:1976 [inline]
> > validate_chain kernel/locking/lockdep.c:2347 [inline]
> > __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
> > lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> > __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> > _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
> > down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
> > __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
> > console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
> > console_trylock_spinning kernel/printk/printk.c:1653 [inline]
> > vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
> > vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
> > vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
> > printk+0xa7/0xcf kernel/printk/printk.c:1997
> > __warn+0x9e/0x1d0 kernel/panic.c:522
> > report_bug+0x254/0x2d0 lib/bug.c:186
> > fixup_bug arch/x86/kernel/traps.c:178 [inline]
> > do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
> > do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
> > invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
> > RIP: 0010:enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
> > Code: ff 48 8b 8d c8 fe ff ff 48 c1 e6 2a 4c 8b 9d d0 fe ff ff 8b 95 d8 fe ff
> > ff 48 8b 85 e0 fe ff ff e9 16 e4 ff ff e8 16 d0 ea ff <0f> 0b e9 17 f1 ff ff
> > 48 8b bd e8 fe ff ff 4c 89 95 c8 fe ff ff 48
> > RSP: 0018:ffff8881ba39fa18 EFLAGS: 00010002
> > RAX: 0000000000000000 RBX: ffff8881b9d6c000 RCX: ffff8881b9d6c278
> > RDX: ffff8881b9d6c03c RSI: 0000000000000002 RDI: ffff8881daf2d710
> > RBP: ffff8881ba39fb78 R08: 0000000000000001 R09: ffff8881daf00000
> > R10: 0000001a4d4f1987 R11: ffff8881daf2db3b R12: 1ffff11037473f4e
> > R13: ffff8881b9d6c2cc R14: ffff8881daf2ccc0 R15: ffff8881daf2ccc0
> > enqueue_task+0x184/0x390 kernel/sched/core.c:730
> > __sched_setscheduler+0xe99/0x2190 kernel/sched/core.c:4336
> > sched_setattr kernel/sched/core.c:4394 [inline]
> > __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
> > __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
> > __x64_sys_sched_setattr+0x1b2/0x2f0 kernel/sched/core.c:4549
> > do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x457569
> > Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48
> > 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f
> > 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f05ce0a2c78 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
> > RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
> > RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f05ce0a36d4
> > R13: 00000000004c369f R14: 00000000004d5730 R15: 00000000ffffffff
> > Shutting down cpus with NMI
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> > 
> > 
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
