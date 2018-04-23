Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeDWIkV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:40:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:41422 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeDWIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:40:11 -0400
X-Google-Smtp-Source: AIpwx4+42dW24n55X9FyDLiGZIDtCB0jZlFRLcKdYs0K1cQsrGBwP2AYkcNnzBu+9lll5EZ0DNcnNujVPdyAxM013Pk=
MIME-Version: 1.0
In-Reply-To: <00000000000068d87d056a7fe601@google.com>
References: <00000000000068d87d056a7fe601@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Apr 2018 10:39:49 +0200
Message-ID: <CACT4Y+Zpw=mL+nqGYs9JE0dEDm+h=sDdLL_BNdgP1WNfCXOGzg@mail.gmail.com>
Subject: Re: BUG: soft lockup in _raw_spin_unlock
To: syzbot <syzbot+9d16ae40a3249b00a524@syzkaller.appspotmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:34 AM, syzbot
<syzbot+9d16ae40a3249b00a524@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on bpf-next commit
> 878a4d328104fed86ea321c48a5245eed44fbe14 (Fri Apr 20 08:05:16 2018 +0000)
> libbpf: fixed build error for samples/bpf/
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=9d16ae40a3249b00a524
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6223576852070400
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-8733987683919582507
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9d16ae40a3249b00a524@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


This looks like:

#syz dup: INFO: rcu detected stall in d_walk

> random: crng init done
> watchdog: BUG: soft lockup - CPU#1 stuck for 134s! [syz-executor5:4541]
> Modules linked in:
> irq event stamp: 61201690
> hardirqs last  enabled at (61201689): [<ffffffff81c37e8f>]
> seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
> hardirqs last  enabled at (61201689): [<ffffffff81c37e8f>]
> read_seqcount_begin include/linux/seqlock.h:164 [inline]
> hardirqs last  enabled at (61201689): [<ffffffff81c37e8f>] read_seqbegin
> include/linux/seqlock.h:433 [inline]
> hardirqs last  enabled at (61201689): [<ffffffff81c37e8f>]
> read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
> hardirqs last  enabled at (61201689): [<ffffffff81c37e8f>]
> d_walk+0x80f/0xc80 fs/dcache.c:1248
> hardirqs last disabled at (61201690): [<ffffffff87800901>]
> interrupt_entry+0xb1/0xf0 arch/x86/entry/entry_64.S:624
> softirqs last  enabled at (22717476): [<ffffffff87a00778>]
> __do_softirq+0x778/0xaf5 kernel/softirq.c:311
> softirqs last disabled at (22717407): [<ffffffff8146fce1>] invoke_softirq
> kernel/softirq.c:365 [inline]
> softirqs last disabled at (22717407): [<ffffffff8146fce1>]
> irq_exit+0x1d1/0x200 kernel/softirq.c:405
> CPU: 1 PID: 4541 Comm: syz-executor5 Not tainted 4.16.0+ #8
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783
> [inline]
> RIP: 0010:lock_release+0x4d4/0xa10 kernel/locking/lockdep.c:3942
> RSP: 0018:ffff88019e567880 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: dffffc0000000000 RBX: 1ffff10033cacf15 RCX: 1ffff10033cab9dd
> RDX: 1ffffffff11a30ed RSI: 0000000000000004 RDI: 0000000000000282
> RBP: ffff88019e5679b0 R08: 1ffff10033cacf19 R09: ffffed003b5e46c2
> R10: 0000000000000003 R11: 0000000000000003 R12: ffff88019e55c6c0
> R13: ffff8801a8c5a7b8 R14: ffff88019e55c6c0 R15: ffff88019e5678c8
> FS:  0000000000e6f940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000e78978 CR3: 000000019ec29000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __raw_spin_unlock include/linux/spinlock_api_smp.h:150 [inline]
>  _raw_spin_unlock+0x1a/0x30 kernel/locking/spinlock.c:176
>  spin_unlock include/linux/spinlock.h:350 [inline]
>  d_walk+0x75f/0xc80 fs/dcache.c:1332
>  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
>  vfs_rmdir+0x202/0x470 fs/namei.c:3850
>  do_rmdir+0x523/0x610 fs/namei.c:3911
>  SYSC_rmdir fs/namei.c:3929 [inline]
>  SyS_rmdir+0x1a/0x20 fs/namei.c:3927
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x4550e7
> RSP: 002b:00007fff59f01b28 EFLAGS: 00000206 ORIG_RAX: 0000000000000054
> RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00000000004550e7
> RDX: 0000000000000000 RSI: 00007fff59f038d0 RDI: 00007fff59f038d0
> RBP: 00007fff59f038d0 R08: 0000000000000000 R09: 0000000000000001
> R10: 000000000000000a R11: 0000000000000206 R12: 0000000000e70940
> R13: 0000000000000000 R14: 00000000000001ca R15: 0000000000019a6a
> Code: 00 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a3 03 00 00 48 83 3d
> 13 d0 75 07 00 0f 84 b8 02 00 00 48 8b bd e8 fe ff ff 57 9d <0f> 1f 44 00 00
> 48 b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000068d87d056a7fe601%40google.com.
> For more options, visit https://groups.google.com/d/optout.
