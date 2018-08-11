Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6DC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B5321A41
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B5321A41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHKWrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:47:51 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:56928 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeHKWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:47:51 -0400
Received: by mail-it0-f71.google.com with SMTP id f184-v6so1669525itc.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 13:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wDF2fWo4h4oBK5y/SMMy2ODGNgAPnjMoAudAoIvM5fo=;
        b=se2R8IVf5GuHas9qTpiyNnN5r4sCQd5ibd9P8pLBMv1j9Prq7ct0sd2S5cJwCbQHt0
         5rS/upTrtLhc8aJp0E0TZVtKtGARzolCKNuDIL3ZoRCqYc6WYDhxiIGMZlTjb7NQKgr0
         MkptHZQ4vu0bFbtf8gOwDIc6abDphkjrWHGSi+vOOlqTa8/id9IVWMf//DbRJeRnbpxf
         reK/PIEQXiMUCc5iucpXzI+me8BOcsK1SyIB6FBM/vzoNA9sNP1CnvAywI3168pvuPDE
         sBzxjE0bDVv1XSUnw9wpdE1UiV+2jZ6DTYxdhVcQH633AVnBTWLmK+n1DuHs5sl4E1SB
         Dy4Q==
X-Gm-Message-State: AOUpUlH2vB7yL7IMEMXP4pTiByHXEk2jANZA7kqSPAT9i1Yq1cDZvff8
        LtRFynGJikrslZrwyCv96BJLYNimwpBk84IyF2qlj9Ps9Rls
X-Google-Smtp-Source: AA+uWPxlMS7L5BHbiVkjgJFZfax7CbzGlVLqu1seEc7Hsgwk84vamWJBPHmDPaIfgukQ1EOA4QZPzBArRlmG/uEJJGocaYbbNDPK
MIME-Version: 1.0
X-Received: by 2002:a5e:d70e:: with SMTP id v14-v6mr2526850iom.63.1534014542110;
 Sat, 11 Aug 2018 12:09:02 -0700 (PDT)
Date:   Sat, 11 Aug 2018 12:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcf0c905732d9766@google.com>
Subject: KASAN: use-after-free Write in preempt_notifier_register (2)
From:   syzbot <syzbot+d5d3b529a776503b24a2@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2b769bb85b48 Add linux-next specific files for 20180807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1356aef0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547d800b8773c2c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d5d3b529a776503b24a2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1618c464400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122d6672400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d5d3b529a776503b24a2@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: use-after-free in hlist_add_head include/linux/list.h:704  
[inline]
BUG: KASAN: use-after-free in preempt_notifier_register+0x1ec/0x200  
kernel/sched/core.c:2460
Write of size 8 at addr ffff8801ac490050 by task syz-executor201/4333

CPU: 0 PID: 4333 Comm: syz-executor201 Not tainted  
4.18.0-rc8-next-20180807+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
  hlist_add_head include/linux/list.h:704 [inline]
  preempt_notifier_register+0x1ec/0x200 kernel/sched/core.c:2460
  vcpu_load+0x27/0x40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:163
  vmx_free_vcpu_nested arch/x86/kvm/vmx.c:10658 [inline]
  vmx_free_vcpu+0x194/0x300 arch/x86/kvm/vmx.c:10672
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8387 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8836 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8933
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:784
  __fput+0x376/0x8a0 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b25/0x2760 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  __do_sys_exit_group kernel/exit.c:983 [inline]
  __se_sys_exit_group kernel/exit.c:981 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:981
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ece8
Code: Bad RIP value.
RSP: 002b:00007ffd3f933c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ece8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be5a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4333:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  vmx_create_vcpu+0xcf/0x28b0 arch/x86/kvm/vmx.c:10682
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8401
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476  
[inline]
  kvm_vm_ioctl+0x488/0x1d80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4333:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  vmx_free_vcpu+0x26b/0x300 arch/x86/kvm/vmx.c:10676
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8387 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8836 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8933
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:784
  __fput+0x376/0x8a0 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b25/0x2760 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  __do_sys_exit_group kernel/exit.c:983 [inline]
  __se_sys_exit_group kernel/exit.c:981 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:981
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ac490040
  which belongs to the cache kvm_vcpu of size 23808
The buggy address is located 16 bytes inside of
  23808-byte region [ffff8801ac490040, ffff8801ac495d40)
The buggy address belongs to the page:
page:ffffea0006b12400 count:1 mapcount:0 mapping:ffff8801d5297a80 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801d528f448 ffffea0006b2aa08 ffff8801d5297a80
raw: 0000000000000000 ffff8801ac490040 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ac48ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801ac48ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801ac490000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff8801ac490080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ac490100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
