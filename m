Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F8BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED9920841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED9920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJKKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:24:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbeJKKYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:24:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65D21259DA6CB;
        Thu, 11 Oct 2018 10:59:08 +0800 (CST)
Received: from [10.130.223.208] (10.130.223.208) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 11 Oct
 2018 10:59:02 +0800
From:   Du Changbin <duchangbin3@huawei.com>
Subject: Re: kernel BUG at arch/x86/kvm/x86.c:LINE! (2)
To:     syzbot <syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com>
CC:     <bp@alien8.de>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <x86@kernel.org>, <changbin.du@huawei.com>
References: <0000000000004ab2c40577db2115@google.com>
Message-ID: <c4d02cc1-0298-533d-bc07-bb4195c2eea9@huawei.com>
Date:   Thu, 11 Oct 2018 10:57:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000004ab2c40577db2115@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.130.223.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the issue is that using vmx instructions after vmx off. The 
scenario is:
1. kernel is rebooting and vmx is turned off by notification handler 
kvm_reboot(),
    and 'kvm_rebooting' is set.
2. But there is a pending KVM_CREATE_VCPU ioctl which will invoke 
vmcs_clear()->
    ____kvm_handle_fault_on_reboot()->kvm_spurious_fault()->BUG().

Need to improve the handler for such case so won't hang kernel.

On Wed, Oct 10, 2018 at 12:52:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    64c5e530ac2c Merge tag 'arc-4.19-rc8' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=167a4e85400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9b42efadea9f5453100
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com
> 
> Use struct sctp_sack_info instead
> sctp: [Deprecated]: syz-executor0 (pid 11077) Use of struct sctp_assoc_value
> in delayed_ack socket option.
> Use struct sctp_sack_info instead
> audit: type=1326 audit(1539141761.977:32): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj==unconfined pid=11031 comm="syz-executor2"
> exe="/root/syz-executor2" sig=9 arch=40000003 syscall=265 compat=1
> ip=0xf7fecca9 code=0x0
> ------------[ cut here ]------------
> kernel BUG at arch/x86/kvm/x86.c:353!
> ------------[ cut here ]------------
> kernel BUG at arch/x86/kvm/x86.c:353!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 11079 Comm: syz-executor2 Not tainted 4.19.0-rc7+ #178
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
> Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44 00
> 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
> RSP: 0018:ffff8801dae07bd8 EFLAGS: 00010006
> RAX: ffff8801cc2f2180 RBX: 1ffff1003b5c0f7f RCX: ffffffff81385bcc
> RDX: 0000000000010000 RSI: ffffffff810bd1f9 RDI: ffff8801dae07c18
> RBP: ffff8801dae07bd8 R08: ffff8801cc2f2180 R09: ffffed003b5c5ba0
> R10: ffffed003b5c5ba0 R11: ffff8801dae2dd07 R12: ffff8801dae07c58
> R13: dffffc0000000000 R14: ffff8801beccc000 R15: ffff8801dae07c18
> FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f5fa6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: ffff8801dae07c18 CR3: 00000001cc8d1000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  kvm_fastop_exception+0x50b/0x5455
>  loaded_vmcs_init arch/x86/kvm/vmx.c:2129 [inline]
>  __loaded_vmcs_clear+0x2d6/0x690 arch/x86/kvm/vmx.c:2212
>  flush_smp_call_function_queue+0x1d2/0x640 kernel/smp.c:243
>  generic_smp_call_function_single_interrupt+0x13/0x2b kernel/smp.c:192
>  smp_call_function_single_interrupt+0x12f/0x650 arch/x86/kernel/smp.c:296
>  call_function_single_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:886
>  </IRQ>
> RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
> RIP: 0010:preempt_schedule_irq+0x7d/0x110 kernel/sched/core.c:3699
> Code: 00 e8 87 6a a6 f9 e8 c2 d8 d5 f9 4c 89 f0 48 c1 e8 03 42 80 3c 20 00
> 75 7b 48 83 3d 14 ea 82 01 00 74 61 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00 e8
> f9 d1 ff ff 41 80 7d 00 00 75 6a 48 83 3d ea e9
> RSP: 0018:ffff88018b397160 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
> RAX: 1ffffffff1263e53 RBX: 0000000000000000 RCX: ffffc9000628e000
> RDX: 0000000000000004 RSI: ffffffff8184e1e4 RDI: ffffffff896fe100
> RBP: ffff88018b397188 R08: ffff8801cc2f2180 R09: ffffed003b5c5979
> R10: ffffed003b5c5979 R11: ffff8801dae2cbcb R12: dffffc0000000000
> R13: fffffbfff1263e52 R14: ffffffff8931f298 R15: ffffffff8931f290
>  retint_kernel+0x1b/0x2d
> RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
> RIP: 0010:cond_local_irq_enable arch/x86/kernel/traps.c:80 [inline]
> RIP: 0010:do_error_trap+0x270/0x4d0 arch/x86/kernel/traps.c:301
> Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 4f 02 00 00 48 83
> 3d 55 6a 07 08 00 0f 84 46 01 00 00 fb 66 0f 1f 44 00 00 <e9> b8 fe ff ff 31
> c0 41 b8 01 00 00 00 48 ba 00 00 00 00 00 fc ff
> RSP: 0018:ffff88018b397248 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
> RAX: dffffc0000000000 RBX: ffff88018b397398 RCX: ffffc9000628e000
> RDX: 1ffffffff1263e53 RSI: ffffffff8184e1e4 RDI: ffffffff8931f298
> RBP: ffff88018b397378 R08: ffff8801cc2f2180 R09: 0000000000000001
> R10: fffffbfff12720fc R11: 0000000000000000 R12: 0000000000000006
> R13: ffff88018b397350 R14: 0000000000000004 R15: 1ffff10031672e4e
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
> Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44 00
> 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
> RSP: 0018:ffff88018b397448 EFLAGS: 00010212
> RAX: 0000000000040000 RBX: 1ffff10031672e8d RCX: ffffc9000628e000
> RDX: 0000000000000417 RSI: ffffffff810bd1f9 RDI: ffff88018b397488
> RBP: ffff88018b397448 R08: ffff8801cc2f2180 R09: ffff8801c308d000
> R10: ffffed0038611bff R11: ffff8801c308dfff R12: ffff88018b3974c8
> R13: dffffc0000000000 R14: ffff8801c308d000 R15: ffff88018b397488
>  kvm_fastop_exception+0x50b/0x5455
>  loaded_vmcs_init arch/x86/kvm/vmx.c:2129 [inline]
>  alloc_loaded_vmcs+0x7f/0x280 arch/x86/kvm/vmx.c:4766
>  vmx_create_vcpu+0x20e/0x25e0 arch/x86/kvm/vmx.c:11025
>  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8471
>  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476
> [inline]
>  kvm_vm_ioctl+0x470/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
>  kvm_vm_compat_ioctl+0x143/0x430
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:3170
>  __do_compat_sys_ioctl fs/compat_ioctl.c:1419 [inline]
>  __se_compat_sys_ioctl fs/compat_ioctl.c:1365 [inline]
>  __ia32_compat_sys_ioctl+0x20e/0x630 fs/compat_ioctl.c:1365
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fecca9
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90
> 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f5fa60cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 000000000000ae41
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 1c8fec48833612c0 ]---
> RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
> Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44 00
> 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
> RSP: 0018:ffff8801dae07bd8 EFLAGS: 00010006
> RAX: ffff8801cc2f2180 RBX: 1ffff1003b5c0f7f RCX: ffffffff81385bcc
> RDX: 0000000000010000 RSI: ffffffff810bd1f9 RDI: ffff8801dae07c18
> RBP: ffff8801dae07bd8 R08: ffff8801cc2f2180 R09: ffffed003b5c5ba0
> R10: ffffed003b5c5ba0 R11: ffff8801dae2dd07 R12: ffff8801dae07c58
> R13: dffffc0000000000 R14: ffff8801beccc000 R15: ffff8801dae07c18
> FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f5fa6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: ffff8801dae07c18 CR3: 00000001cc8d1000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.

-- 
Thanks,
Du Changbin
