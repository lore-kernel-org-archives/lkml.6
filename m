Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeBHDUb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:20:31 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41478 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeBHDUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:20:30 -0500
X-Google-Smtp-Source: AH8x224Qp0rcX/yexczJUaTsdQsYQGbAUx/Z3CyA7j7K8Km5yEkQ/MUb7IJnBOKxGOXxaMfK5EkVZHzfisNZq4lXgN8=
MIME-Version: 1.0
In-Reply-To: <001a113b9df4e2ec6405648e8a8c@google.com>
References: <001a113b9df4e2ec6405648e8a8c@google.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Feb 2018 14:20:28 +1100
X-Google-Sender-Auth: WXnB0nkkHQmPbpz9WDEHYeqAAIE
Message-ID: <CAGXu5jJhqG5LrS3Kw99YLGitRR3CNKbQz8SuRBandwVhDGc6Zw@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in put_cmsg_compat
To: syzbot <syzbot+7330488a9c5c5cb5452e@syzkaller.appspotmail.com>
Cc: James Morse <james.morse@arm.com>, keun-o.park@darkmatter.ae,
        Laura Abbott <labbott@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 4:31 AM, syzbot
<syzbot+7330488a9c5c5cb5452e@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> e237f98a9c134c3d600353f21e07db915516875b (Mon Feb 5 21:35:56 2018 +0000)
> Merge tag 'xfs-4.16-merge-5' of
> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> user-space arch: i386
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7330488a9c5c5cb5452e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory exposure attempt detected
> from SLAB object 'skbuff_head_cache' (offset 64, size 16)!
> WARNING: CPU: 0 PID: 3994 at mm/usercopy.c:81 usercopy_warn+0xdb/0x100
> mm/usercopy.c:76
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 3994 Comm: syzkaller552561 Not tainted 4.15.0+ #210
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:984
> RIP: 0010:usercopy_warn+0xdb/0x100 mm/usercopy.c:76
> RSP: 0018:ffff8801cf3873f0 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffffffff86801907 RCX: ffffffff815a585e
> RDX: 0000000000000000 RSI: 1ffff10039e70e2e RDI: 1ffff10039e70e03
> RBP: ffff8801cf387448 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000866 R11: 0000000000000000 R12: ffffffff86403180
> R13: ffffffff85f2d4c0 R14: 0000000000000040 R15: 0000000000000010
>  __check_heap_object+0x89/0xc0 mm/slab.c:4426
>  check_heap_object mm/usercopy.c:236 [inline]
>  __check_object_size+0x272/0x530 mm/usercopy.c:259
>  check_object_size include/linux/thread_info.h:112 [inline]
>  check_copy_size include/linux/thread_info.h:143 [inline]
>  copy_to_user include/linux/uaccess.h:154 [inline]
>  put_cmsg_compat+0x724/0xa50 net/compat.c:254
>  put_cmsg+0x33a/0x3f0 net/core/scm.c:225
>  sock_recv_errqueue+0x200/0x3e0 net/core/sock.c:2910
>  packet_recvmsg+0xb2e/0x17a0 net/packet/af_packet.c:3296
>  sock_recvmsg_nosec net/socket.c:803 [inline]
>  sock_recvmsg+0xc9/0x110 net/socket.c:810
>  ___sys_recvmsg+0x2a4/0x640 net/socket.c:2205
>  __sys_recvmsg+0xe2/0x210 net/socket.c:2250
>  C_SYSC_recvmsg net/compat.c:751 [inline]
>  compat_SyS_recvmsg+0x2a/0x40 net/compat.c:749
>  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>  do_fast_syscall_32+0x3ee/0xfa1 arch/x86/entry/common.c:392
>  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129
> RIP: 0023:0xf7f45c79
> RSP: 002b:00000000fffebddc EFLAGS: 00000217 ORIG_RAX: 0000000000000174
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020006fc8
> RDX: 0000000000002000 RSI: 0000000000000004 RDI: 0000000000000004
> RBP: 0000000020000fe6 R08: 0000000000000000 R09: 0000000000000000
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

#syz dup: WARNING in usercopy_warn

Same root cause and will have the same fix.

-Kees

-- 
Kees Cook
Pixel Security
