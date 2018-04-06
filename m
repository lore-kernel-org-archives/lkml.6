Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755748AbeDFNeC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:34:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45655 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeDFNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:33:57 -0400
X-Google-Smtp-Source: AIpwx49d1UtPgoi/eey5l7SYVVUrAkwp+5PNuWvGgCM//rt+36sjuOIh5ucnHRqIarAC0Oz95W1U2UY3qOKXO1m0hJ0=
MIME-Version: 1.0
In-Reply-To: <001a114467482dbc4b05692df8f9@google.com>
References: <001a114467482dbc4b05692df8f9@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Apr 2018 15:33:36 +0200
Message-ID: <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
Subject: Re: WARNING in kmem_cache_free
To: syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 3:24 PM, syzbot
<syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> f2d285669aae656dfeafa0bf25e86bbbc5d22329 (Tue Apr 3 17:45:39 2018 +0000)
> Merge tag 'pm-4.17-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=75397ee3df5c70164154
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5265497960480768
> Kernel config: https://syzkaller.appspot.com/x/.config?id=686016073509112605
> compiler: gcc (GCC) 7.1.1 20170620
> user-space arch: i386
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> cache_from_obj: Wrong slab cache. names_cache but object is from kmalloc-96

/\/\/\/\

Interesting type of bug, I think we see this for the first time.

Al, do you see how this can happen?


> WARNING: CPU: 0 PID: 11100 at mm/slab.h:378 cache_from_obj mm/slab.h:376
> [inline]
> WARNING: CPU: 0 PID: 11100 at mm/slab.h:378 kmem_cache_free+0x226/0x2a0
> mm/slab.c:3736
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 11100 Comm: syz-executor3 Not tainted 4.16.0+ #288
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
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:991
> RIP: 0010:cache_from_obj mm/slab.h:376 [inline]
> RIP: 0010:kmem_cache_free+0x226/0x2a0 mm/slab.c:3736
> RSP: 0018:ffff8801933a7970 EFLAGS: 00010282
> RAX: 000000000000004b RBX: ffff8801dad7e600 RCX: 0000000000000000
> RDX: 000000000000004b RSI: ffffc90002a2d000 RDI: ffffed0032674f22
> RBP: ffff8801933a7990 R08: ffffed003b604f99 R09: ffffed003b604f99
> R10: 0000000000000000 R11: ffffed003b604f98 R12: ffff880199ec2000
> R13: ffff8801dad7e600 R14: ffff8801d08585dc R15: 00000000ffffffd8
>  putname+0xc8/0x130 fs/namei.c:255
>  filename_lookup+0x315/0x500 fs/namei.c:2324
>  user_path_at_empty+0x40/0x50 fs/namei.c:2569
>  user_path include/linux/namei.h:62 [inline]
>  do_mount+0x15f/0x2b90 fs/namespace.c:2787
>  C_SYSC_mount fs/compat.c:195 [inline]
>  compat_SyS_mount+0xd0/0x1070 fs/compat.c:160
>  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>  do_fast_syscall_32+0x3ec/0xf9f arch/x86/entry/common.c:392
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f47c99
> RSP: 002b:00000000f5f42c6c EFLAGS: 00000246 ORIG_RAX: 0000000000000015
> RAX: ffffffffffffffda RBX: 00000000080eff11 RCX: 0000000020000000
> RDX: 0000000000000000 RSI: 00000000080d6b6d RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a114467482dbc4b05692df8f9%40google.com.
> For more options, visit https://groups.google.com/d/optout.
