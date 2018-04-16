Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeDPJLK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:11:10 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32786 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754611AbeDPJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:11:08 -0400
X-Google-Smtp-Source: AIpwx4/UphC2CgCkShb0JUmQ/gxm4IkktyOO5br6RNV0UrT2AnkItdQMEHvuVNj/DjcS0MYywDG4NREk5AWnCoAsyQ8=
MIME-Version: 1.0
In-Reply-To: <001a1142766c7793080569dc017b@google.com>
References: <001a1142766c7793080569dc017b@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Apr 2018 11:10:47 +0200
Message-ID: <CACT4Y+YBWeJGVGyY7Cm-O1OGzpM7Q8fMmoTo8VNzyFQTvXBrbA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in corrupted
To: syzbot <syzbot+bb6ed94ce15c5cd0be00@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3G9BcqW019007

On Sun, Apr 15, 2018 at 7:02 AM, syzbot
<syzbot+bb6ed94ce15c5cd0be00@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> c18bb396d3d261ebbb4efbc05129c5d354c541e4 (Tue Apr 10 00:04:10 2018 +0000)
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=bb6ed94ce15c5cd0be00
>
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6361086471176192
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5146710238035968
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)


Looking at the reproducer, it seems that KVM somehow badly corrupts
memory. +kvm maintainers.


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+bb6ed94ce15c5cd0be00@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> BUG: unable to handle kernel paging request at 0000000000005b63
> PGD 1b67b2067 P4D 1b67b2067 PUD 1b67b3067 PMD 0
> Oops: 0002 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4510 Comm: syz-executor5 Not tainted 4.16.0+ #18
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> ==================================================================
> BUG: KASAN: out-of-bounds in vsnprintf+0x1a3b/0x1b40 lib/vsprintf.c:2315
> Read of size 8 at addr -02 � ���e �6 �  a by task syz-executor5/4510
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#2] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4510 Comm: syz-executor5 Not tainted 4.16.0+ #18
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: b08e6540:die_lock+0x0/0x4
> RSP: b08e6568:ffffffff81b2a8f1 EFLAGS: ffff8801b08e61e8 ORIG_RAX:
> ffffed003611cc58
> RAX: 1ffffffff10842bc RBX: ffff8801db021849 RCX: ffffffff874b04e3
> RDX: 0000000000000000 RSI: ffffffff874b02f9 RDI: 0000000000000001
> RBP: ffff8801b08e6568 R08: ffff8801c322e040 R09: ffffed003b6042bc
> R10: ffffed003b6042bc R11: ffff8801db0215e3 R12: ffffffff884215e0
> R13: ffffed003611cc58 R14: ffffffff898d54ec R15: ffff8801b08e6540
> FS:  00007ff89fb7d700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000005b63 CR3: 00000001b67b1000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 <01> 00 00 00 02
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RIP: die_lock+0x0/0x4 RSP: ffffffff81b2a8f1
> ---[ end trace 4c7524c29b994875 ]---
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1142766c7793080569dc017b%40google.com.
> For more options, visit https://groups.google.com/d/optout.
