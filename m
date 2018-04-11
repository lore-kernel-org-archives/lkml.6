Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDKXsE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:48:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:39842 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeDKXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:48:01 -0400
X-Google-Smtp-Source: AIpwx48KcAWxMu6X6PcjW5FTpEKQLMj12ry2pEzFZJ+qYLpf3f1iSdL7xvCzN6mOegHThFzhRqwSiAqHE0ksvGf/q7gSB22N8Dyy
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 16:48:01 -0700
In-Reply-To: <f4f5e80803d0583578056998f3e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11425bc4f3485205699b447d@google.com>
Subject: Re: BUG: sleeping function called from invalid context at
 arch/x86/mm/fault.c:LINE (2)
From: syzbot <syzbot+4af447792df4648be93b@syzkaller.appspotmail.com>
To: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=4af447792df4648be93b

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5277733517000704
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6134240995442688
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6087714151596032
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4af447792df4648be93b@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

BUG: sleeping function called from invalid context at  
arch/x86/mm/fault.c:1342
in_atomic(): 0, irqs_disabled(): 1, pid: 4492, name: syzkaller559833
1 lock held by syzkaller559833/4492:
  #0: 00000000d3c337f7 (&mm->mmap_sem){++++}, at:  
__do_page_fault+0x381/0xe40 arch/x86/mm/fault.c:1328
irq event stamp: 3862
hardirqs last  enabled at (3861): [<ffffffff81b2720f>] slab_alloc  
mm/slab.c:3385 [inline]
hardirqs last  enabled at (3861): [<ffffffff81b2720f>]  
kmem_cache_alloc+0x26f/0x760 mm/slab.c:3552
hardirqs last disabled at (3862): [<ffffffff87601402>]  
error_entry+0x72/0xd0 arch/x86/entry/entry_64.S:1261
softirqs last  enabled at (3800): [<ffffffff87800778>]  
__do_softirq+0x778/0xaf5 kernel/softirq.c:311
softirqs last disabled at (3779): [<ffffffff81470db1>] invoke_softirq  
kernel/softirq.c:365 [inline]
softirqs last disabled at (3779): [<ffffffff81470db1>] irq_exit+0x1d1/0x200  
kernel/softirq.c:405
CPU: 0 PID: 4492 Comm: syzkaller559833 Not tainted 4.16.0+ #19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  ___might_sleep.cold.88+0x11f/0x13a kernel/sched/core.c:6188
  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
  __do_page_fault+0x3ae/0xe40 arch/x86/mm/fault.c:1342
  do_page_fault+0xee/0x8a7 arch/x86/mm/fault.c:1474
  page_fault+0x25/0x50 arch/x86/entry/entry_64.S:1159
RIP: 0010:vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746
RSP: 0018:ffff8801d95b7368 EFLAGS: 00010002
RAX: 000000000000118c RBX: ffff8801d90076c0 RCX: 0000000000000282
RDX: 0000000000000000 RSI: 00000000000000fc RDI: 00000000014000c0
RBP: ffff8801d95b7c18 R08: 0000000000036f48 R09: ffffed003b200ed8
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d90076c0
R13: ffff8801dad80000 R14: 0000000000000000 R15: ffff8801d90076bf
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  slab_post_alloc_hook mm/slab.h:444 [inline]
  slab_alloc mm/slab.c:3392 [inline]
  kmem_cache_alloc+0x11b/0x760 mm/slab.c:3552
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  getname+0x19/0x20 fs/namei.c:211
  do_sys_open+0x38e/0x770 fs/open.c:1087
  SYSC_openat fs/open.c:1120 [inline]
  SyS_openat+0x30/0x40 fs/open.c:1114
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4487c9
RSP: 002b:00007f4fe57efda8 EFLAGS: 00000297 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dec44 RCX: 00000000004487c9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dec40
R13: 0030656c69662f2e R14: 6d766b2f7665642f R15: 000000000000000c
BUG: unable to handle kernel paging request at 000000000000590a
PGD 1d9ba4067 P4D 1d9ba4067 PUD 1d9b9a067 PMD 0
Oops: 0002 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4492 Comm: syzkaller559833 Tainted: G        W        4.16.0+  
#19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746
RSP: 0018:ffff8801d95b7368 EFLAGS: 00010002
RAX: 000000000000118c RBX: ffff8801d90076c0 RCX: 0000000000000282
RDX: 0000000000000000 RSI: 00000000000000fc RDI: 00000000014000c0
RBP: ffff8801d95b7c18 R08: 0000000000036f48 R09: ffffed003b200ed8
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d90076c0
R13: ffff8801dad80000 R14: 0000000000000000 R15: ffff8801d90076bf
FS:  00007f4fe57f0700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000590a CR3: 00000001ad282000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  slab_post_alloc_hook mm/slab.h:444 [inline]
  slab_alloc mm/slab.c:3392 [inline]
  kmem_cache_alloc+0x11b/0x760 mm/slab.c:3552
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  getname+0x19/0x20 fs/namei.c:211
  do_sys_open+0x38e/0x770 fs/open.c:1087
  SYSC_openat fs/open.c:1120 [inline]
  SyS_openat+0x30/0x40 fs/open.c:1114
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4487c9
RSP: 002b:00007f4fe57efda8 EFLAGS: 00000297 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dec44 RCX: 00000000004487c9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dec40
R13: 0030656c69662f2e R14: 6d766b2f7665642f R15: 000000000000000c
Code: 8b a9 68 03 00 00 4c 8b b1 70 03 00 00 4c 8b b9 78 03 00 00 48 8b 89  
08 03 00 00 75 05 0f 01 c2 eb 03 0f 01 c3 48 89 4c 24 08 59 <0f> 96 81 88  
56 00 00 48 89 81 00 03 00 00 48 89 99 18 03 00 00
RIP: vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746 RSP: ffff8801d95b7368
CR2: 000000000000590a
---[ end trace 752da7ce25dee858 ]---
