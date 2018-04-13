Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbeDMFVQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:21:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34807 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeDMFVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:21:15 -0400
X-Google-Smtp-Source: AIpwx4+EfELiQ1Qrsz9oeQIiYf1WQckh112S/HSlPUkrgEkJ/06EaQv+NOkmDhKOHlmEfQysZ6X/mAyFMMUMtzjP2xs=
MIME-Version: 1.0
References: <20180412215501.GA16406@roeck-us.net>
In-Reply-To: <20180412215501.GA16406@roeck-us.net>
From: Vitaly Wool <vitalywool@gmail.com>
Date: Fri, 13 Apr 2018 05:21:02 +0000
Message-ID: <CAMJBoFMq8DoWdcrajB_xyMrGXsUsbMjos_U60mOvf01MpK_9Kw@mail.gmail.com>
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
To: linux@roeck-us.net
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,


Den fre 13 apr. 2018 kl 00:01 skrev Guenter Roeck <linux@roeck-us.net>:

> Hi all,

> we are observing crashes with z3pool under memory pressure. The kernel
version
> used to reproduce the problem is v4.16-11827-g5d1365940a68, but the
problem was
> also seen with v4.14 based kernels.


just before I dig into this, could you please try reproducing the errors
you see with https://patchwork.kernel.org/patch/10210459/ applied?

Thanks,
    Vitaly

> For simplicity, here is a set of shortened logs. A more complete log is
> available at [1].

> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK - 10)
> WARNING: CPU: 2 PID: 594 at kernel/sched/core.c:3212
preempt_count_add+0x90/0xa0
> Modules linked in:
> CPU: 2 PID: 594 Comm: memory-eater Not tainted 4.16.0-yocto-standard+ #8
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1
04/01/2014
> RIP: 0010:preempt_count_add+0x90/0xa0
> RSP: 0000:ffffb12740db7750 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000000f6
> RDX: 00000000000000f6 RSI: 0000000000000082 RDI: 00000000ffffffff
> RBP: fffff00480f357a0 R08: 000000000000004a R09: 00000000000001ad
> R10: ffffb12740db77e0 R11: 0000000000000000 R12: ffff9cbc7e265d10
> R13: ffff9cbc7cd5e000 R14: ffff9cbc7a7000d8 R15: fffff00480f35780
> FS:  00007f5140791700(0000) GS:ffff9cbc7fd00000(0000)
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f513260f000 CR3: 0000000032086000 CR4: 00000000000006e0
> Call Trace:
>   _raw_spin_trylock+0x13/0x30
>   z3fold_zpool_shrink+0xab/0x3a0
>   zswap_frontswap_store+0x10b/0x610
> ...
> WARNING: CPU: 1 PID: 92 at mm/z3fold.c:278
release_z3fold_page_locked+0x25/0x40
> Modules linked in:
> ...
> INFO: rcu_preempt self-detected stall on CPU
>          2-...!: (20958 ticks this GP) idle=5da/1/4611686018427387906
>          softirq=4104/4113 fqs=11
> ...
> RIP: 0010:queued_spin_lock_slowpath+0x132/0x190
> RSP: 0000:ffffb12740db7750 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000100101 RBX: ffff9cbc7a7000c8 RCX: 0000000000000001
> RDX: 0000000000000101 RSI: 0000000000000001 RDI: 0000000000000101
> RBP: 0000000000000000 R08: ffff9cbc7fc21240 R09: ffffffffaf19c900
> R10: ffffb12740db75a0 R11: 0000000000000010 R12: fffff00480522d20
> R13: ffff9cbc548b4000 R14: ffff9cbc7a7000d8 R15: fffff00480522d00
>   ? __zswap_pool_current+0x80/0x90
>   z3fold_zpool_shrink+0x1d3/0x3a0
>   zswap_frontswap_store+0x10b/0x610
> ...

> With lock debugging enabled, the log is a bit different, but similar.

> BUG: MAX_LOCK_DEPTH too low!
> turning off the locking correctness validator.
> depth: 48  max: 48!
> 48 locks held by memory-eater/619:
>   #0: 000000002da807ce (&mm->mmap_sem){++++}, at:
__do_page_fault+0x122/0x5a0
>   #1: 0000000012fa6629 (&(&pool->lock)->rlock#3){+.+.}, at:
z3fold_zpool_shrink+0x47/0x3e0
>   #2: 00000000c85f45dd (&(&zhdr->page_lock)->rlock){+.+.}, at:
z3fold_zpool_shrink+0xb7/0x3e0
>   #3: 00000000876f5fdc (&(&zhdr->page_lock)->rlock){+.+.}, at:
z3fold_zpool_shrink+0xb7/0x3e0
> ...
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [memory-eater:613]
> Modules linked in:
> irq event stamp: 1435394
> hardirqs last  enabled at (1435393): [<ffffffff9b90ed81>]
> _raw_spin_unlock_irqrestore+0x51/0x60
> hardirqs last disabled at (1435394): [<ffffffff9b907baa>]
__schedule+0xba/0xbb0
> softirqs last  enabled at (1434508): [<ffffffff9bc0027c>]
__do_softirq+0x27c/0x516
> softirqs last disabled at (1434323): [<ffffffff9b069a29>]
irq_exit+0xa9/0xc0
> CPU: 0 PID: 613 Comm: memory-eater Tainted: G        W
> 4.16.0-yocto-standard+ #9
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1
04/01/2014
> RIP: 0010:queued_spin_lock_slowpath+0x177/0x1a0
> RSP: 0000:ffffa61f80e074e0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000000 RBX: ffff9704379cba08 RCX: ffff97043fc22080
> RDX: 0000000000000001 RSI: ffffffff9c05f6a0 RDI: 0000000000040000
> RBP: 0000000000000000 R08: ffffffff9b1f2215 R09: 0000000000000000
> R10: ffffa61f80e07490 R11: ffff9704379cba20 R12: ffff97043fc22080
> R13: ffffde77404e0920 R14: ffff970413824000 R15: ffff9704379cba00
> FS:  00007f8c6317f700(0000) GS:ffff97043fc00000(0000)
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8c43f3d010 CR3: 000000003aba0000 CR4: 00000000000006f0
> Call Trace:
>   do_raw_spin_lock+0xad/0xb0
>   z3fold_zpool_malloc+0x595/0x790
> ...

> The problem is easy to reproduce. Please see [2] and the other files
> at [3] for details. Various additional crash logs, observed with
> chromeos-4.14, are available at [4].

> Please let me know if there is anything else I can do to help solving
> or debugging the problem. I had a look into the code, but I must admit
> that its locking is a mystery to me.

> Thanks,
> Guenter

> ---
> [1] http://server.roeck-us.net/qemu/z3pool/crashdump
> [2] http://server.roeck-us.net/qemu/z3pool/README
> [3] http://server.roeck-us.net/qemu/z3pool/
> [4] https://bugs.chromium.org/p/chromium/issues/detail?id=822360
