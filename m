Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933607AbeD0PSc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:18:32 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:44316 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeD0PS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:18:28 -0400
X-Google-Smtp-Source: AB8JxZqyDU5Y5/e2r2kzR6QpPrkf01nHu1RbuOPg2bGMUc6WgEMg5+0S8JzhkcsumMfCa2UmvaGwWbRKKFbiLmJySKw=
MIME-Version: 1.0
In-Reply-To: <000000000000c1d8f1056acdcbfa@google.com>
References: <000000000000c1d8f1056acdcbfa@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Apr 2018 17:18:06 +0200
Message-ID: <CACT4Y+aTiKDAEfGhT5HYiOwzsZNj-oNZ6HNmX2Ye5dLrXRoxRA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in process_preds
To: syzbot <syzbot+b76562b749bb67fca79f@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 7:30 AM, syzbot
<syzbot+b76562b749bb67fca79f@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on bpf-next commit
> 0c90f2243ec67eeacf9624ae52ab43c734fe0e93 (Wed Apr 18 02:46:34 2018 +0000)
> tools: bpftool: make it easier to feed hex bytes to bpftool
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=b76562b749bb67fca79f
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5319914659250176
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b76562b749bb67fca79f@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

#syz dup: KASAN: use-after-free Read in process_preds

> BUG: unable to handle kernel paging request at ffff87f9dbf70994
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 7133 Comm: syz-executor4 Not tainted 4.16.0+ #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:predicate_parse kernel/trace/trace_events_filter.c:563 [inline]
> RIP: 0010:process_preds+0x146c/0x19b0
> kernel/trace/trace_events_filter.c:1505
> RSP: 0018:ffff880197cc7438 EFLAGS: 00010246
> RAX: 0000000000000007 RBX: ffff87f9dbf70990 RCX: 0000000000000000
> RDX: 00000000ffffffff RSI: ffffffff817f1ee9 RDI: ffff87f9dbf70994
> RBP: ffff880197cc7540 R08: ffff8801b2146540 R09: ffffed003b6246c2
> R10: ffffed003b6246c2 R11: ffff8801db123613 R12: dffffc0000000000
> R13: ffff8801c1f04fe0 R14: 00000000fffffffe R15: dffffc0000000000
> FS:  00007fedc5480700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff87f9dbf70994 CR3: 00000001a0041000 CR4: 00000000001406e0
> DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  create_filter+0x1a8/0x370 kernel/trace/trace_events_filter.c:1714
>  ftrace_profile_set_filter+0x109/0x2b0
> kernel/trace/trace_events_filter.c:2042
>  perf_event_set_filter+0x248/0x1230 kernel/events/core.c:9064
>  _perf_ioctl+0x84c/0x15e0 kernel/events/core.c:5056
>  perf_ioctl+0x59/0x80 kernel/events/core.c:5107
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  SYSC_ioctl fs/ioctl.c:708 [inline]
>  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x455329
> RSP: 002b:00007fedc547fc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fedc54806d4 RCX: 0000000000455329
> RDX: 0000000020000100 RSI: 0000000040082406 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000000291 R14: 00000000006f6e38 R15: 0000000000000000
> Code: ff ff 41 8b 55 04 48 8d 7b 04 48 89 f8 48 c1 e8 03 42 0f b6 0c 20 48
> 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 08 05 00 00 <44> 8b 7b 04 89
> d7 89 95 68 ff ff ff 44 89 fe e8 80 0a f8 ff 8b
> RIP: predicate_parse kernel/trace/trace_events_filter.c:563 [inline] RSP:
> ffff880197cc7438
> RIP: process_preds+0x146c/0x19b0 kernel/trace/trace_events_filter.c:1505
> RSP: ffff880197cc7438
> CR2: ffff87f9dbf70994
> ---[ end trace 9971f5aefc423124 ]---
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c1d8f1056acdcbfa%40google.com.
> For more options, visit https://groups.google.com/d/optout.
