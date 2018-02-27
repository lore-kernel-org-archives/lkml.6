Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeB0MUG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:20:06 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:37588 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbeB0MUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:20:04 -0500
X-Google-Smtp-Source: AH8x226Fg50DMsEhuhPe79F5WujpmD3coIFcJ4N8FnOPJn8AtcpU2Ao9Kr3y3KH+hBYatcUWqlLFzm3fZckYhv/cBjg=
MIME-Version: 1.0
In-Reply-To: <001a1147c53824d6970566309e4e@google.com>
References: <001a1147c53824d6970566309e4e@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 27 Feb 2018 13:19:42 +0100
Message-ID: <CACT4Y+bm5uPQej+DU7cHrbBKkdfZ3x18DZo=X3cdebi8R4Tu1Q@mail.gmail.com>
Subject: Re: general protection fault in hrtimer_active (2)
To: syzbot <syzbot+fb7a33a4b6c35007a72b@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 1:18 PM, syzbot
<syzbot+fb7a33a4b6c35007a72b@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 6f70eb2b00eb416146247c65003d31f4df983ce0 (Mon Feb 26 21:22:45 2018 +0000)
> Merge branch 'idr-2018-02-06' of
> git://git.infradead.org/users/willy/linux-dax
>
> So far this crash happened 867 times on upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.


Paulo,

This started happening on syzbot with threatening frequency, and it
looks like it may be related to your recent "KVM: x86: move LAPIC
initialization after VMCS creation".


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fb7a33a4b6c35007a72b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
> 8021q: adding VLAN 0 to HW filter on device bond0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> CPU: 1 PID: 5486 Comm: syz-executor1 Not tainted 4.16.0-rc3+ #331
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:hrtimer_active+0x1da/0x3c0 kernel/time/hrtimer.c:1277
> RSP: 0018:ffff8801b4ebf3c0 EFLAGS: 00010202
> RAX: 0000000000000008 RBX: 1ffff100369d7ea5 RCX: ffffffff81610225
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> RDX: 0000000000010000 RSI: ffffc90001e1b000 RDI: 0000000000000010
> RBP: ffff8801b4ebf500 R08: 0000000000002c02 R09: 0000000000000000
> R10: 0000000000000011 R11: ffffed00365cb078 R12: 0000000000000010
> R13: 0000000000000000 R14: ffffed00369d7e83 R15: dffffc0000000000
> FS:  00007f8f8c80b700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8f8c7ea000 CR3: 00000001b4577003 CR4: 00000000001626e0
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>  hrtimer_try_to_cancel+0x91/0x5b0 kernel/time/hrtimer.c:1128
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>  hrtimer_cancel+0x22/0x40 kernel/time/hrtimer.c:1154
>  kvm_lapic_reset+0x93/0xf40 arch/x86/kvm/lapic.c:2015
>  kvm_arch_vcpu_setup+0x31/0x50 arch/x86/kvm/x86.c:7978
>  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2459
> [inline]
>  kvm_vm_ioctl+0x52d/0x1cf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2949
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> RIP: 0033:0x453d69
> RSP: 002b:00007f8f8c80ac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f8f8c80b6d4 RCX: 0000000000453d69
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000020e R14: 00000000006f31f0 R15: 0000000000000000
> Code:
> kasan: CONFIG_KASAN_INLINE enabled
> ff ff 48 8d 85 18 ff ff ff 48 c1
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> e8 03 4e 8d 34 38 e8 1b f2 0f 00 48 8b 85 f0 fe ff ff c6 00 00 48 8b 85 d8
> fe ff ff 48 c1 e8 03 <42> 80 3c 38 00 0f 85 c2 01 00 00 48 8b 85 e8 fe ff ff
> 48 8b 58
> RIP: __read_once_size include/linux/compiler.h:188 [inline] RSP:
> ffff8801b4ebf3c0
> RIP: hrtimer_active+0x1da/0x3c0 kernel/time/hrtimer.c:1277 RSP:
> ffff8801b4ebf3c0
> general protection fault: 0000 [#2] SMP KASAN
> ---[ end trace a73097188f35aad4 ]---
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1147c53824d6970566309e4e%40google.com.
> For more options, visit https://groups.google.com/d/optout.
