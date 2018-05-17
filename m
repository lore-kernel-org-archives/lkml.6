Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeEQQnE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:43:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42339 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeEQQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:42:44 -0400
X-Google-Smtp-Source: AB8JxZoee8HajsAtHMX0fKEs5q5GtWIClE6UDoCB/Vu2DbF+lMAAdRXRYvhno8mbGt9OdURE/PePVPjVynUfdPP7OjU=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aJEU8UDOQiaru9PnMPyP-rv=1hMBsUyme=6jEx5iyycg@mail.gmail.com>
References: <001a113e8a28d9ae59055cd80de6@google.com> <CACT4Y+aJEU8UDOQiaru9PnMPyP-rv=1hMBsUyme=6jEx5iyycg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 17 May 2018 18:42:23 +0200
Message-ID: <CACT4Y+afbKDLRYzqapv0-5KeH3ODDDkp+RwNnZwfzzvXoJqb5g@mail.gmail.com>
Subject: Re: general protection fault in gfn_to_rmap
To: syzbot
        <bot+53e9b911da5806836ed78f23e2b8ead1c905b469@syzkaller.appspotmail.com>
Cc: KVM list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HGhBmZ022979

On Tue, Oct 31, 2017 at 2:59 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Oct 31, 2017 at 4:51 PM, syzbot
> <bot+53e9b911da5806836ed78f23e2b8ead1c905b469@syzkaller.appspotmail.com>
> wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> 0b5477d9dabd96ded4c5ef7a5f08b00188fc1dec
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>>
>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> for information about syzkaller reproducers
>
> For the provided repro crashes in native_write_cr4, which seems to be
> a separate unrelated issue (reported today separately).
>
> Here is another repro associated with this crash:
> https://gist.githubusercontent.com/dvyukov/7bdbcdb30b084516e7c5785fa82db838/raw/98fe8a27f899d6d8ea9d1dd3092e6c917570e1b6/gistfile1.txt
> I've just tried it on upstream
> 5f479447d983111c039f1d6d958553c1ad1b2ff1 (Oct 30);
> "./syz-execprog -procs=8 -repeat repro.txt" it crashes as:
>
> ------------[ cut here ]------------
> kernel BUG at arch/x86/kvm/mmu.c:1194!
> invalid opcode: 0000 [#1] SMP KASAN
> Modules linked in:
> CPU: 1 PID: 3091 Comm: syz-executor Not tainted 4.14.0-rc7+ #13
> kvm [3107]: vcpu0, guest rIP: 0x9111 Hyper-V uhandled wrmsr:
> 0x40000020 data 0xf0047
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> task: ffff880064f206c0 task.stack: ffff88005eb40000
> RIP: 0010:pte_list_remove+0x3ae/0x3c0 arch/x86/kvm/mmu.c:1193
> RSP: 0018:ffff88005eb469d8 EFLAGS: 00010282
> RAX: 0000000000000028 RBX: ffff88006af40d80 RCX: 0000000000000000
> RDX: 0000000000000028 RSI: 1ffff1000bd68cfb RDI: ffffed000bd68d2f
> RBP: ffff88005eb46a18 R08: 0000000000000001 R09: 0000000000000000
> R10: ffff88005eb46dc0 R11: 0000000000000000 R12: ffff8800687a0078
> R13: 0000000000000000 R14: ffff88006a2c7910 R15: ffff88006a2c7938
> FS:  0000000000000000(0000) GS:ffff88006ca80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000005a22003 CR4: 00000000001626e0
> Call Trace:
>  rmap_remove arch/x86/kvm/mmu.c:1270 [inline]
>  drop_spte+0x15a/0x250 arch/x86/kvm/mmu.c:1352
>  mmu_page_zap_pte+0x224/0x340 arch/x86/kvm/mmu.c:2484
>  kvm_mmu_page_unlink_children arch/x86/kvm/mmu.c:2506 [inline]
>  kvm_mmu_prepare_zap_page+0x1c5/0x1310 arch/x86/kvm/mmu.c:2550
>  kvm_zap_obsolete_pages arch/x86/kvm/mmu.c:5330 [inline]
>  kvm_mmu_invalidate_zap_all_pages+0x4a0/0x680 arch/x86/kvm/mmu.c:5371
>  kvm_arch_flush_shadow_all+0x15/0x20 arch/x86/kvm/x86.c:8444
>  kvm_mmu_notifier_release+0x59/0x90
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:467
>  __mmu_notifier_release+0x1d5/0x690 mm/mmu_notifier.c:75
>  mmu_notifier_release include/linux/mmu_notifier.h:222 [inline]
>  exit_mmap+0x42d/0x530 mm/mmap.c:2981
>  __mmput kernel/fork.c:928 [inline]
>  mmput+0x223/0x6d0 kernel/fork.c:949
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0x904/0x1ad0 kernel/exit.c:852
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73f/0x16d0 kernel/signal.c:2334
>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath+0x42f/0x510 arch/x86/entry/common.c:266
> kvm [3097]: vcpu0, guest rIP: 0x9111 Hyper-V uhandled wrmsr:
> 0x40000020 data 0xf0047
>  entry_SYSCALL_64_fastpath+0xbc/0xbe
> RIP: 0033:0x447ad7
> RSP: 002b:00007f4d993c2058 EFLAGS: 00000207 ORIG_RAX: 0000000000000010
> RAX: 0000000000000000 RBX: 00007f4d993c27b0 RCX: 0000000000447ad7
> RDX: 00007f4d993c27b0 RSI: 00000000c008ae05 RDI: 0000000000000018
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000015 R11: 0000000000000207 R12: 0000000000000018
> R13: 0000000000008340 R14: 00000000006ec3e0 R15: 00007f4d993c4700
> Code: f9 c9 5e 00 48 8b 75 d0 48 c7 c7 40 60 e2 84 e8 8e 80 49 00 0f
> 0b e8 e2 c9 5e 00 48 8b 75 d0 48 c7 c7 00 60 e2 84 e8 77 80 49 00 <0f>
> 0b 4c 89 ef e8 48 8f 93 00 e9 01 fe ff ff 0f 1f 00 55 48 89
> RIP: pte_list_remove+0x3ae/0x3c0 arch/x86/kvm/mmu.c:1193 RSP: ffff88005eb469d8
> ---[ end trace a329c3bead6aac1c ]---
>
>
>
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] SMP KASAN
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> Modules linked in:
>> CPU: 0 PID: 4407 Comm: syz-executor5 Not tainted 4.13.0-rc2+ #9
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> task: ffff8801d661c0c0 task.stack: ffff8801ca9b0000
>> RIP: 0010:__kvm_memslots include/linux/kvm_host.h:571 [inline]
>> RIP: 0010:gfn_to_rmap+0x57f/0x6b0 arch/x86/kvm/mmu.c:1235
>> RSP: 0018:ffff8801ca9b6820 EFLAGS: 00010297
>> RAX: dffffc0000000000 RBX: ffff8801cc3e1078 RCX: 1ffff1003987c204
>> RDX: 0000000000000000 RSI: ffff8801cc3ec3c8 RDI: ffff8801cc3e1080
>> RBP: ffff8801ca9b6960 R08: 0000000000000002 R09: 0000000000000004
>> R10: ffff8801ca9b6cc8 R11: ffffffff81120ef1 R12: 0000000000000002
>> R13: 000000000000000f R14: 000000000000000e R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff8801dc000000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000000 CR3: 00000001d28ce000 CR4: 00000000001426f0
>> Call Trace:
>>  rmap_remove arch/x86/kvm/mmu.c:1267 [inline]
>>  drop_spte+0x161/0x270 arch/x86/kvm/mmu.c:1350
>>  mmu_page_zap_pte+0x224/0x350 arch/x86/kvm/mmu.c:2482
>>  kvm_mmu_page_unlink_children arch/x86/kvm/mmu.c:2504 [inline]
>>  kvm_mmu_prepare_zap_page+0x1b7/0x1260 arch/x86/kvm/mmu.c:2548
>>  kvm_zap_obsolete_pages arch/x86/kvm/mmu.c:5223 [inline]
>>  kvm_mmu_invalidate_zap_all_pages+0x4a0/0x680 arch/x86/kvm/mmu.c:5264
>>  kvm_arch_flush_shadow_all+0x15/0x20 arch/x86/kvm/x86.c:8394
>>  kvm_mmu_notifier_release+0x59/0x90
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:508
>>  __mmu_notifier_release+0x1d5/0x690 mm/mmu_notifier.c:75
>>  mmu_notifier_release include/linux/mmu_notifier.h:235 [inline]
>>  exit_mmap+0x3a3/0x470 mm/mmap.c:2972
>>  __mmput kernel/fork.c:903 [inline]
>>  mmput+0x223/0x6e0 kernel/fork.c:925
>>  exit_mm kernel/exit.c:544 [inline]
>>  do_exit+0x981/0x1b10 kernel/exit.c:852
>>  do_group_exit+0x149/0x400 kernel/exit.c:969
>>  get_signal+0x7e8/0x17e0 kernel/signal.c:2330
>>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>>  exit_to_usermode_loop+0x21c/0x2d0 arch/x86/entry/common.c:157
>>  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>>  syscall_return_slowpath+0x3a7/0x450 arch/x86/entry/common.c:263
>>  entry_SYSCALL_64_fastpath+0xbc/0xbe
>> RIP: 0033:0x4512c9
>> RSP: 002b:00007f5548015c18 EFLAGS: 00000206 ORIG_RAX: 00000000000000ca
>> RAX: 0000000000000001 RBX: 00000000007180a8 RCX: 00000000004512c9
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000007180cc
>> RBP: 0000000000001fe0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000206 R12: 00000000004b7f09
>> R13: 00000000ffffffff R14: 0000000000000007 R15: 000000000000ae80
>> Code: 3c 02 00 00 48 c7 c7 20 63 62 84 c6 05 e0 42 f8 03 01 e8 25 de 44 00
>> e9 da fb ff ff e8 6b 7f 5d 00 48 b8 00 00 00 00 00 fc ff df <80> 38 00 0f 85
>> 1b 01 00 00 4c 8b 24 25 00 00 00 00 31 db e9 83
>> RIP: __kvm_memslots include/linux/kvm_host.h:571 [inline] RSP:
>> ffff8801ca9b6820
>> RIP: gfn_to_rmap+0x57f/0x6b0 arch/x86/kvm/mmu.c:1235 RSP: ffff8801ca9b6820
>> ---[ end trace 0a16957bec756c04 ]---


Fix bisection says that this is fixed by:

commit b7e31be385584afe7f073130e8e570d53c95f7fe
Author: Radim Krčmář <rkrcmar@redhat.com>
Date:   Thu Mar 1 15:24:25 2018 +0100

    KVM: x86: fix vcpu initialization with userspace lapic

#syz fix: KVM: x86: fix vcpu initialization with userspace lapic
