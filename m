Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeEMI0i (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:26:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38625 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEMI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:26:36 -0400
X-Google-Smtp-Source: AB8JxZpgpPxI1c0EYBh+VG7l2r7qZOZjFy4Mp+vODe2ZGG1shqVJlkDVWdKKVCXLRegsW6qBiCbbli4nlBmjbVn+7VU=
MIME-Version: 1.0
In-Reply-To: <00000000000011cf3a056affabfd@google.com>
References: <00000000000011cf3a056affabfd@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 13 May 2018 10:26:15 +0200
Message-ID: <CACT4Y+bJH+gy2x+jDNsAgbRTSpf_4ieP_AbSOHUsgzKWxyk+wA@mail.gmail.com>
Subject: Re: general protection fault in __radix_tree_delete
To: syzbot <syzbot+549decbd1891d501b6d5@syzkaller.appspotmail.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 7:00 PM, syzbot
<syzbot+549decbd1891d501b6d5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> cdface5209349930ae1b51338763c8e029971b97 (Sun Apr 29 03:07:21 2018 +0000)
> Merge tag 'for_linus_stable' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=549decbd1891d501b6d5
>
> So far this crash happened 8 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6647588371562496
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=4781854846615552
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=4580574157078528
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=7043958930931867332
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+549decbd1891d501b6d5@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


This crash was bisected as introduced by:

commit faeb7833eee0d6afe0ecb6bdfa6042556c2c352e
Author: Roman Kagan <rkagan@virtuozzo.com>
Date:   Thu Feb 1 16:48:32 2018 +0300

    kvm: x86: hyperv: guest->host event signaling via eventfd

https://gist.githubusercontent.com/dvyukov/df4971d7dfd1b37bedb5bfa0c95f9ebc/raw/ee8b7804788049f80625563e0322090c798c4544/gistfile1.txt



> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4525 Comm: syz-executor786 Not tainted 4.17.0-rc2+ #23
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:__radix_tree_delete+0x74/0x230 lib/radix-tree.c:1989
> RSP: 0018:ffff8801d9137108 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: dffffc0000000000 RCX: 1ffff1003b226e3e
> RDX: 0000000000000000 RSI: ffffffff8768eeed RDI: ffff8801a7dac168
> RBP: ffff8801d91371a8 R08: ffff8801d962c1c0 R09: ffffed0034fb5811
> R10: ffff8801d91372b8 R11: ffff8801a7dac08f R12: 0000000000000000
> R13: ffff8801a7dac168 R14: 0000000000000018 R15: ffff8801d9137230
> FS:  0000000001df3880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 00000001d9104000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  radix_tree_delete_item+0x148/0x2d0 lib/radix-tree.c:2050
>  idr_remove+0x46/0x60 lib/idr.c:157
>  kvm_hv_eventfd_deassign arch/x86/kvm/hyperv.c:1433 [inline]
>  kvm_vm_ioctl_hv_eventfd+0x1df/0x24b arch/x86/kvm/hyperv.c:1451
>  kvm_arch_vm_ioctl+0x155e/0x2690 arch/x86/kvm/x86.c:4563
>  kvm_vm_ioctl+0x246/0x1d90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3100
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440069
> RSP: 002b:00007ffcf0b02cd8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 6d766b2f7665642f RCX: 0000000000440069
> RDX: 0000000020000000 RSI: 000000004018aebd RDI: 00000000000000a9
> RBP: 00000000006cb018 R08: 00007ffcf0b02cf0 R09: 00007ffcf0b02cf0
> R10: 00007ffcf0b02cf0 R11: 0000000000000217 R12: 00000000004018a0
> R13: 0000000000401930 R14: 0000000000000000 R15: 0000000000000000
> Code: 3f 9a 88 48 c7 45 88 80 ee 68 87 c7 00 f1 f1 f1 f1 c7 40 04 00 f2 f2
> f2 c7 40 08 f3 f3 f3 f3 e8 a3 51 10 fa 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 0f
> 85 97 01 00 00 48 8d 55 d8 4c 8d 7a c0 49 8b 1e
> RIP: __read_once_size include/linux/compiler.h:188 [inline] RSP:
> ffff8801d9137108
> RIP: __radix_tree_delete+0x74/0x230 lib/radix-tree.c:1989 RSP:
> ffff8801d9137108
> ---[ end trace 79327005f044daef ]---
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000011cf3a056affabfd%40google.com.
> For more options, visit https://groups.google.com/d/optout.
