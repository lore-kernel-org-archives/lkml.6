Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeDDTY3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:24:29 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:33210 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeDDTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:24:26 -0400
X-Google-Smtp-Source: AIpwx48BP+GcZWKKngBzOsiXjeXomkvHLbov6gyL88oMM/XZbaVE5ZA0wZPpfLBvGZX4t69xasrg0jnD6eWGR/PvGho=
MIME-Version: 1.0
In-Reply-To: <001a1148578c10e4700568e814eb@google.com>
References: <001a1148578c10e4700568e814eb@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 4 Apr 2018 21:24:05 +0200
Message-ID: <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
Subject: Re: WARNING in up_write
To: syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 4:01 AM, syzbot
<syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 86bbbebac1933e6e95e8234c4f7d220c5ddd38bc (Mon Apr 2 18:47:07 2018 +0000)
> Merge branch 'ras-core-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=dc5ab2babdf22ca091af
>
> So far this crash happened 8 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5688491102961664
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5709211904245760
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5720789257027584
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=6801295859785128502
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

+Ted for ext4 frames

> EXT4-fs (sda1): shut down requested (0)
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
> WARNING: CPU: 1 PID: 4441 at kernel/locking/rwsem.c:133 up_write+0x1cc/0x210
> kernel/locking/rwsem.c:133
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 4441 Comm: syzkaller594909 Not tainted 4.16.0+ #11
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>  panic+0x1f8/0x42c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x1f4/0x2b0 lib/bug.c:186
>  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:up_write+0x1cc/0x210 kernel/locking/rwsem.c:133
> RSP: 0018:ffff8801b349f710 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801ccc0ce40 RCX: ffffffff815ae26e
> RDX: 0000000000000000 RSI: 1ffff10036693e92 RDI: 1ffff10036693e67
> RBP: ffff8801b349f798 R08: fffffbfff10b0659 R09: fffffbfff10b0659
> R10: ffff8801b349f708 R11: fffffbfff10b0658 R12: 1ffff10036693ee2
> R13: dffffc0000000000 R14: ffff8801b349f770 R15: ffff8801ccc0ce98
>  percpu_up_write+0xca/0x110 kernel/locking/percpu-rwsem.c:183
>  sb_freeze_unlock fs/super.c:1390 [inline]
>  thaw_super+0x1ca/0x260 fs/super.c:1524
>  thaw_bdev+0x151/0x180 fs/block_dev.c:555
>  ext4_shutdown fs/ext4/ioctl.c:489 [inline]
>  ext4_ioctl+0x1f85/0x3e60 fs/ext4/ioctl.c:1048
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x440109
> RSP: 002b:00007fffce185d28 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440109
> RDX: 0000000020000100 RSI: 000000008004587d RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 000000000000000f R09: 65732f636f72702f
> R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401990
> R13: 0000000000401a20 R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1148578c10e4700568e814eb%40google.com.
> For more options, visit https://groups.google.com/d/optout.
