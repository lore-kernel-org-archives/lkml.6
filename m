Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031457AbeEZJWI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:22:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37146 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031247AbeEZJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:22:05 -0400
X-Google-Smtp-Source: AB8JxZpCnG7s0Yc3eKR1sZbkO2N3EW5zRTkG9SK85K1764r2/yq3jxCXOEZASVH5Ezzoqvrlu3Z8DKMR3iZM9FyBHUU=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bz2XMT9zW4CKF8hAFtgVT1P+KQ=07RnPzzneh1Gm3d=Q@mail.gmail.com>
References: <94eb2c0bfe1ee3b038055cf18dce@google.com> <CACT4Y+bz2XMT9zW4CKF8hAFtgVT1P+KQ=07RnPzzneh1Gm3d=Q@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 26 May 2018 11:21:44 +0200
Message-ID: <CACT4Y+b6k7UA552=oYvBePP-WRK-QX4_tT8G6mP97VK6SZU8Zg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in irq_bypass_register_consumer
To: syzbot
        <bot+9a592b2d4f3c5d4c93adef9de16ded0105530914@syzkaller.appspotmail.com>
Cc: Bhakti Priya Shridhar <bhaktipriya96@gmail.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        KVM list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: KASAN: use-after-free Write in irq_bypass_register_consumer

On Wed, Nov 1, 2017 at 9:18 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Nov 1, 2017 at 11:17 PM, syzbot
> <bot+9a592b2d4f3c5d4c93adef9de16ded0105530914@syzkaller.appspotmail.com>
> wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> aae4e7a8bc44722fe70d58920a36916b1043195e
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>> C reproducer is attached
>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> for information about syzkaller reproducers
>>
>>
>> BUG: KASAN: use-after-free in irq_bypass_register_consumer+0x4f0/0x500
>> virt/lib/irqbypass.c:198
>> Read of size 8 at addr ffff8801cf1d9178 by task syzkaller948360/3420
>>
>> CPU: 1 PID: 3420 Comm: syzkaller948360 Not tainted 4.13.0-rc4+ #23
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:16 [inline]
>>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>>  print_address_description+0x7f/0x260 mm/kasan/report.c:252
>>  kasan_report_error mm/kasan/report.c:351 [inline]
>>  kasan_report+0x24e/0x340 mm/kasan/report.c:409
>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>>  irq_bypass_register_consumer+0x4f0/0x500 virt/lib/irqbypass.c:198
>>  kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:417 [inline]
>>  kvm_irqfd+0x137a/0x1d50 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
>>  kvm_vm_ioctl+0x1079/0x1c40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3029
>>  vfs_ioctl fs/ioctl.c:45 [inline]
>>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
>>  SYSC_ioctl fs/ioctl.c:700 [inline]
>>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
>>  entry_SYSCALL_64_fastpath+0x1f/0xbe
>> RIP: 0033:0x4460d9
>> RSP: 002b:00007f24ae19adc8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004460d9
>> RDX: 000000002000d000 RSI: 000000004020ae76 RDI: 000000000000002b
>> RBP: 0000000000000086 R08: 00007f24ae19b700 R09: 00007f24ae19b700
>> R10: 00007f24ae19b700 R11: 0000000000000202 R12: 0000000000000000
>> R13: 00007ffe1847ef3f R14: 00007f24ae19b9c0 R15: 0000000000000000
>>
>> Allocated by task 3420:
>>  save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>  set_track mm/kasan/kasan.c:459 [inline]
>>  kasan_kmalloc+0xaa/0xd0 mm/kasan/kasan.c:551
>>  kmem_cache_alloc_trace+0x101/0x6f0 mm/slab.c:3627
>>  kmalloc include/linux/slab.h:493 [inline]
>>  kzalloc include/linux/slab.h:666 [inline]
>>  kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:296 [inline]
>>  kvm_irqfd+0x16c/0x1d50 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
>>  kvm_vm_ioctl+0x1079/0x1c40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3029
>>  vfs_ioctl fs/ioctl.c:45 [inline]
>>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
>>  SYSC_ioctl fs/ioctl.c:700 [inline]
>>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
>>  entry_SYSCALL_64_fastpath+0x1f/0xbe
>>
>> Freed by task 24:
>>  save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>  set_track mm/kasan/kasan.c:459 [inline]
>>  kasan_slab_free+0x6e/0xc0 mm/kasan/kasan.c:524
>>  __cache_free mm/slab.c:3503 [inline]
>>  kfree+0xd3/0x260 mm/slab.c:3820
>>  irqfd_shutdown+0x13c/0x1a0 arch/x86/kvm/../../../virt/kvm/eventfd.c:148
>>  process_one_work+0xbf3/0x1bc0 kernel/workqueue.c:2097
>>  worker_thread+0x223/0x1860 kernel/workqueue.c:2231
>>  kthread+0x35e/0x430 kernel/kthread.c:231
>>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:425
>>
>> The buggy address belongs to the object at ffff8801cf1d9000
>>  which belongs to the cache kmalloc-512 of size 512
>> The buggy address is located 376 bytes inside of
>>  512-byte region [ffff8801cf1d9000, ffff8801cf1d9200)
>> The buggy address belongs to the page:
>> page:ffffea000654e778 count:1 mapcount:0 mapping:ffff8801cf1d9000 index:0x0
>> flags: 0x200000000000100(slab)
>> raw: 0200000000000100 ffff8801cf1d9000 0000000000000000 0000000100000006
>> raw: ffffea000654e648 ffffea0006560c48 ffff8801dbc00600
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff8801cf1d9000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801cf1d9080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>
>>> ffff8801cf1d9100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>
>>                                                                 ^
>>  ffff8801cf1d9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801cf1d9200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>
>
> Still happens on newer commits, e.g. on linux-next
> 36ef71cae353f88fd6e095e2aaa3e5953af1685d (Oct 19)
>
> ==================================================================
> BUG: KASAN: use-after-free in list_add include/linux/list.h:63 [inline]
> BUG: KASAN: use-after-free in irq_bypass_register_consumer+0x4e4/0x530
> virt/lib/irqbypass.c:217
> Write of size 8 at addr ffff880067e363e8 by task a.out/12001
>
> CPU: 1 PID: 12001 Comm: a.out Not tainted 4.14.0-rc5-next-20171018 #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x1a8/0x272 lib/dump_stack.c:52
>  print_address_description+0x6c/0x204 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x16e/0x270 mm/kasan/report.c:409
>  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:435
>  list_add include/linux/list.h:63 [inline]
>  irq_bypass_register_consumer+0x4e4/0x530 virt/lib/irqbypass.c:217
>  kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:417 [inline]
>  kvm_irqfd+0x14e7/0x1e60 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
>  kvm_vm_ioctl+0xa15/0x1dc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2988
>  vfs_ioctl fs/ioctl.c:45 [inline]
>  file_ioctl fs/ioctl.c:499 [inline]
>  do_vfs_ioctl+0x1cf/0x16b0 fs/ioctl.c:683
>  SYSC_ioctl fs/ioctl.c:700 [inline]
>  SyS_ioctl+0xb6/0xe0 fs/ioctl.c:691
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x44c969
> RSP: 002b:00007fc56c43edb8 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000044c969
> RDX: 0000000020025fe0 RSI: 000000004020ae76 RDI: 0000000000000005
> RBP: 0000000000000086 R08: 00007fc56c43f700 R09: 0000000000000000
> R10: 00007fc56c43f700 R11: 0000000000000297 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fc56c43f9c0 R15: 00007fc56c43f700
>
> Allocated by task 12001:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:551
>  kmem_cache_alloc_trace+0x140/0x740 mm/slab.c:3614
>  kmalloc include/linux/slab.h:502 [inline]
>  kzalloc include/linux/slab.h:691 [inline]
>  kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:296 [inline]
>  kvm_irqfd+0x187/0x1e60 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
>  kvm_vm_ioctl+0xa15/0x1dc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2988
>  vfs_ioctl fs/ioctl.c:45 [inline]
>  file_ioctl fs/ioctl.c:499 [inline]
>  do_vfs_ioctl+0x1cf/0x16b0 fs/ioctl.c:683
>  SYSC_ioctl fs/ioctl.c:700 [inline]
>  SyS_ioctl+0xb6/0xe0 fs/ioctl.c:691
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
>
> Freed by task 1338:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3492 [inline]
>  kfree+0xca/0x250 mm/slab.c:3807
>  irqfd_shutdown+0x13a/0x1a0 arch/x86/kvm/../../../virt/kvm/eventfd.c:148
>  process_one_work+0xb70/0x1ac0 kernel/workqueue.c:2112
>  worker_thread+0x223/0x1ac0 kernel/workqueue.c:2246
>  kthread+0x38f/0x470 kernel/kthread.c:242
>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
>
> The buggy address belongs to the object at ffff880067e36280
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 360 bytes inside of
>  512-byte region [ffff880067e36280, ffff880067e36480)
> The buggy address belongs to the page:
> page:ffffea00019f8d80 count:1 mapcount:0 mapping:ffff880067e36000 index:0x0
> flags: 0x100000000000100(slab)
> raw: 0100000000000100 ffff880067e36000 0000000000000000 0000000100000006
> raw: ffffea0001a945e0 ffffea0001a153a0 ffff88006c400940 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff880067e36280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff880067e36300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>ffff880067e36380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                           ^
>  ffff880067e36400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff880067e36480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
>
>
>
>> ---
>> This bug is generated by a dumb bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for details.
>> Direct all questions to syzkaller@googlegroups.com.
>> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>>
>> syzbot will keep track of this bug report.
>> Once a fix for this bug is committed, please reply to this email with:
>> #syz fix: exact-commit-title
>> To mark this as a duplicate of another syzbot report, please reply with:
>> #syz dup: exact-subject-of-another-report
>> If it's a one-off invalid bug report, please reply with:
>> #syz invalid
>> Note: if the crash happens again, it will cause creation of a new bug
>> report.
>> Note: all commands must start from beginning of the line.
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c0bfe1ee3b038055cf18dce%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
