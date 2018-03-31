Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeCaQTc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 12:19:32 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:45243 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeCaQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 12:19:29 -0400
X-Google-Smtp-Source: AIpwx49P0ErvHs66XaSUrA1BPK7sr7PnkXiVb1RtMZ7VYspaMVVS84hVutg7YDJ+4eq7pF18LNJoT6t/bbCcWUu1zOA=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zto0DQLwFtSxZbbkexqDeCwvJ4ks-QHAMn9=o6zxShnw@mail.gmail.com>
References: <f403043a9be41c978c0560c0d164@google.com> <CANRm+Cy9-R=hBNwwUptVk_f8keX40-9yHkpqstWMP3pLSKpLGw@mail.gmail.com>
 <CACT4Y+ZxPD_6JEntRVGdngn2QBzABwubYohpKVcWJy0Hv-jXBg@mail.gmail.com> <CACT4Y+Zto0DQLwFtSxZbbkexqDeCwvJ4ks-QHAMn9=o6zxShnw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 31 Mar 2018 18:19:08 +0200
Message-ID: <CACT4Y+ZvP=TqBhEG1iagYMFbwhAr6jXwXgUvkukrrRg+qaJLQw@mail.gmail.com>
Subject: Re: general protection fault in native_write_cr4
To: Wanpeng Li <kernellwp@gmail.com>
Cc: syzbot
        <bot+ab09454bf4b7a7f8ce7e5e8d97e644d3314a0799@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2017 at 7:31 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Dec 26, 2017 at 9:52 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Dec 20, 2017 at 8:54 AM, Wanpeng Li <kernellwp@gmail.com> wrote:
>>> 2017-12-20 15:49 GMT+08:00 syzbot
>>> <bot+ab09454bf4b7a7f8ce7e5e8d97e644d3314a0799@syzkaller.appspotmail.com>:
>>>> Hello,
>>>>
>>>> syzkaller hit the following crash on
>>>> f6f3732162b5ae3c771b9285a5a32d72b8586920
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>>>> compiler: gcc (GCC) 7.1.1 20170620
>>>> .config is attached
>>>> Raw console output is attached.
>>>> C reproducer is attached
>>>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>>>> for information about syzkaller reproducers
>>>>
>>>>
>>>
>>> I will have a look again, you continue to run it in kvm guest, right?
>>
>>
>> Our test machines are GCE VMs, so yes, the kernel that catches GPF is
>> run as kvm guest.
>
> up
>
> one of top crashers with 50K crashes


This sets a new record of 130000 crashed machines on syzbot infrastructure:

https://syzkaller.appspot.com/bug?id=2bf7b7983c2398ec6f0c4c6c87cb50223e8873f8


>>>> kvm: KVM_SET_TSS_ADDR need to be called before entering vcpu
>>>> kasan: CONFIG_KASAN_INLINE enabled
>>>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>>>> general protection fault: 0000 [#1] SMP KASAN
>>>> Dumping ftrace buffer:
>>>>    (ftrace buffer empty)
>>>> Modules linked in:
>>>> CPU: 1 PID: 3142 Comm: syzkaller429302 Not tainted 4.15.0-rc3+ #224
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>>> Google 01/01/2011
>>>> RIP: 0010:native_write_cr4+0x4/0x10 arch/x86/include/asm/special_insns.h:76
>>>> RSP: 0018:ffff8801ca6f75a0 EFLAGS: 00010093
>>>> RAX: ffff8801ca1c8700 RBX: 00000000001606e0 RCX: ffffffff811a2a92
>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000001606e0
>>>> RBP: ffff8801ca6f75a0 R08: 1ffff100394dee0f R09: 0000000000000004
>>>> R10: ffff8801ca6f7510 R11: 0000000000000004 R12: 0000000000000093
>>>> R13: ffff8801ca1c8700 R14: ffff8801db514850 R15: ffff8801db514850
>>>> FS:  0000000001031880(0000) GS:ffff8801db500000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 0000000000000000 CR3: 0000000005e22006 CR4: 00000000001626e0
>>>> Call Trace:
>>>>  __write_cr4 arch/x86/include/asm/paravirt.h:76 [inline]
>>>>  __cr4_set arch/x86/include/asm/tlbflush.h:180 [inline]
>>>>  cr4_clear_bits arch/x86/include/asm/tlbflush.h:203 [inline]
>>>>  kvm_cpu_vmxoff arch/x86/kvm/vmx.c:3582 [inline]
>>>>  hardware_disable+0x34a/0x4b0 arch/x86/kvm/vmx.c:3588
>>>>  kvm_arch_hardware_disable+0x35/0xd0 arch/x86/kvm/x86.c:7982
>>>>  hardware_disable_nolock+0x30/0x40
>>>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:3310
>>>>  on_each_cpu+0xca/0x1b0 kernel/smp.c:604
>>>>  hardware_disable_all_nolock+0x3e/0x50
>>>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:3328
>>>>  hardware_disable_all arch/x86/kvm/../../../virt/kvm/kvm_main.c:3334
>>>> [inline]
>>>>  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:742 [inline]
>>>>  kvm_put_kvm+0x956/0xdf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:755
>>>>  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:766
>>>>  __fput+0x327/0x7e0 fs/file_table.c:210
>>>>  ____fput+0x15/0x20 fs/file_table.c:244
>>>>  task_work_run+0x199/0x270 kernel/task_work.c:113
>>>>  exit_task_work include/linux/task_work.h:22 [inline]
>>>>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>>>>  do_group_exit+0x149/0x400 kernel/exit.c:968
>>>>  SYSC_exit_group kernel/exit.c:979 [inline]
>>>>  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
>>>>  entry_SYSCALL_64_fastpath+0x1f/0x96
>>>> RIP: 0033:0x441c78
>>>> RSP: 002b:00007ffe68e20f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>>>> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441c78
>>>> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
>>>> RBP: 00000000006cd018 R08: 00000000000000e7 R09: ffffffffffffffd0
>>>> R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000404080
>>>> R13: 0000000000404110 R14: 0000000000000000 R15: 0000000000000000
>>>> Code: 0f 1f 80 00 00 00 00 55 48 89 e5 0f 20 d8 5d c3 0f 1f 80 00 00 00 00
>>>> 55 48 89 e5 0f 22 df 5d c3 0f 1f 80 00 00 00 00 55 48 89 e5 <0f> 22 e7 5d c3
>>>> 0f 1f 80 00 00 00 00 55 48 89 e5 44 0f 20 c0 5d
>>>> RIP: native_write_cr4+0x4/0x10 arch/x86/include/asm/special_insns.h:76 RSP:
>>>> ffff8801ca6f75a0
>>>> ---[ end trace ca14f0c15b26c251 ]---
>>>>
>>>>
>>>> ---
>>>> This bug is generated by a dumb bot. It may contain errors.
>>>> See https://goo.gl/tpsmEJ for details.
>>>> Direct all questions to syzkaller@googlegroups.com.
>>>> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>>>>
>>>> syzbot will keep track of this bug report.
>>>> Once a fix for this bug is merged into any tree, reply to this email with:
>>>> #syz fix: exact-commit-title
>>>> If you want to test a patch for this bug, please reply with:
>>>> #syz test: git://repo/address.git branch
>>>> and provide the patch inline or as an attachment.
>>>> To mark this as a duplicate of another syzbot report, please reply with:
>>>> #syz dup: exact-subject-of-another-report
>>>> If it's a one-off invalid bug report, please reply with:
>>>> #syz invalid
>>>> Note: if the crash happens again, it will cause creation of a new bug
>>>> report.
>>>> Note: all commands must start from beginning of the line in the email body.
