Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeBAH06 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:26:58 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:43966 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:26:55 -0500
X-Google-Smtp-Source: AH8x2241ONZeOwb3+Gg9dcOX9VoK43MCbbIE7p4W9IAjzDjs7lgO+4EII3lyyAJZ8pGPnncbVwItIw==
Date: Wed, 31 Jan 2018 23:26:52 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+b662152b723ded28b7458da9822acc374eed1e8e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel paging request in __lock_acquire
Message-ID: <20180201072652.GD657@zzz.localdomain>
References: <001a113f9020f1e4fc0560fcf4ff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f9020f1e4fc0560fcf4ff@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2017 at 11:34:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> audit: type=1400 audit(1513653496.149:7): avc:  denied  { map } for
> pid=3121 comm="syzkaller331655" path="/root/syzkaller331655803" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> BUG: unable to handle kernel paging request at 0000000100000137
> IP: __lock_acquire+0xd8/0x1430 kernel/locking/lockdep.c:3315
> PGD 0 P4D 0
> Oops: 0002 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 3131 Comm: syzkaller331655 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__lock_acquire+0xd8/0x1430 kernel/locking/lockdep.c:3315
> RSP: 0018:ffffc9000190bb90 EFLAGS: 00010006
> RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8802143518b8
> RBP: ffffc9000190bc60 R08: 0000000000000001 R09: ffffffff8121b4f4
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff880213514240 R14: 0000000000000001 R15: ffff8802143518b8
> FS:  000000000149c880(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000100000137 CR3: 000000000301e003 CR4: 00000000001606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_acquire+0xbf/0x220 kernel/locking/lockdep.c:3914
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x56/0x70 kernel/locking/spinlock.c:152
>  remove_wait_queue+0x14/0x60 kernel/sched/wait.c:50
>  ep_remove_wait_queue fs/eventpoll.c:595 [inline]
>  ep_unregister_pollwait.isra.7+0x79/0x1f0 fs/eventpoll.c:613
>  ep_remove+0x22/0x180 fs/eventpoll.c:776
>  eventpoll_release_file+0x63/0xa0 fs/eventpoll.c:1001
>  eventpoll_release include/linux/eventpoll.h:66 [inline]
>  __fput+0x232/0x270 fs/file_table.c:200
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0xa3/0xe0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x3e6/0x1050 kernel/exit.c:869
>  do_group_exit+0x60/0x100 kernel/exit.c:972
>  SYSC_exit_group kernel/exit.c:983 [inline]
>  SyS_exit_group+0x18/0x20 kernel/exit.c:981
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x4444f9
> RSP: 002b:00007ffee7715938 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004444f9
> RDX: 00000000004444f9 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000006cf018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000401e00 R14: 0000000000000000 R15: 0000000000000000
> Code: ff ff e8 6c db ff ff 48 85 c0 4c 8b 8d 60 ff ff ff 44 8b 9d 48 ff ff
> ff 44 8b 95 40 ff ff ff 8b 8d 3c ff ff ff 0f 84 6d 03 00 00 <f0> ff 80 38 01
> 00 00 8b 1d 33 4e d4 02 45 8b 85 68 08 00 00 85
> RIP: __lock_acquire+0xd8/0x1430 kernel/locking/lockdep.c:3315 RSP:
> ffffc9000190bb90
> CR2: 0000000100000137
> ---[ end trace 43b4a0602d494b9e ]---
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
> 
> syzbot will keep track of this bug report.
> Once a fix for this bug is merged into any tree, reply to this email with:
> #syz fix: exact-commit-title

This is the binder epoll bug which is fixed in -next by commit f5cb779ba16334b4
("ANDROID: binder: remove waitqueue when thread exits."), also reported here:
https://groups.google.com/d/msg/syzkaller-bugs/QyXdgUhAF50/eLGkcwk9AQAJ.  But
I'll just tell syzbot to invalidate this report since at the time it was
accidentally running with KASAN disabled:

#syz invalid

- Eric
