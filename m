Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF58C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27914217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27914217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHUSoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:44:44 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:55484 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeHUSoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:44:39 -0400
Received: by mail-io0-f199.google.com with SMTP id m15-v6so3526681ioj.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xDyFo747txhxyPwAV7w1MbW9TxQuUjOYeQ95xs6an3Y=;
        b=nZyGEZo8bINM96Yv2EpLl9llGroAc6i/wGS0p0HKPL5/D8/OV3lo7t3UxmLddOT1qd
         XM0BYAXLLR0lZW9vWnefasKU3DnEK8TXcd6qx5hKpSUcFpOvkkecnpS42JHLztbAJteb
         7tAl6U6/lDq0tpo5WeDbRkgHtMgBM7gDIrleRb3E0n0YiZQS1F5A6TP/W6XBkuEFyqfK
         5HDQFekXAh4HdLHVryvF7foubpPZvW2mzrmu7hJD4S3nu3SFBIBrqpU+Vm4cLrEa8/PS
         jNYcoXiRaNWJhZB18ZqTk4uT3QzR1XPhcCMcwRrPmNvRJf+oR5l21+RgVq/KGclFQOS8
         YsLQ==
X-Gm-Message-State: AOUpUlFyB4Kq8lH0MIMCnp7Bvu7O1TASmBCsbxI0pKen29+8WZf1aF+p
        cokwrmFXnpNLZyLUd5drfvUig+OCDk+++/2PGppox0w/Jqnt
X-Google-Smtp-Source: AA+uWPxDR2wlZicfFuosqfS/3aexRA1OfkkJSMweUKF80xxXWaMGJ/ArMMhMQMPCmioOTQTIbKxjVVjvZZu0Gv6sWK4tqEhDML6K
MIME-Version: 1.0
X-Received: by 2002:a24:3cc3:: with SMTP id m186-v6mr8150785ita.30.1534865043236;
 Tue, 21 Aug 2018 08:24:03 -0700 (PDT)
Date:   Tue, 21 Aug 2018 08:24:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae329e0573f39d2c@google.com>
Subject: KASAN: use-after-free Read in __loaded_vmcs_clear
From:   syzbot <syzbot+c26aa916bc6caa4853dd@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cc26ebbebde8 ia64: Fix kernel BUG at lib/ioremap.c:72!
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144c89de400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79e695838ce7a210
dashboard link: https://syzkaller.appspot.com/bug?extid=c26aa916bc6caa4853dd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c26aa916bc6caa4853dd@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ce9b8 R14: 00000000004c50d7 R15: 0000000000000000
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0xf3  
lib/list_debug.c:51
Read of size 8 at addr ffff880191f766e0 by task syz-executor3/1383

CPU: 1 PID: 1383 Comm: syz-executor3 Not tainted 4.18.0+ #199
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0xf3 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  __loaded_vmcs_clear+0x14f/0x630 arch/x86/kvm/vmx.c:2187
  flush_smp_call_function_queue+0x1a8/0x5e0 kernel/smp.c:243
  generic_smp_call_function_single_interrupt+0x13/0x2b kernel/smp.c:192
  smp_call_function_single_interrupt+0x11a/0x670 arch/x86/kernel/smp.c:296
  call_function_single_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:886
  </IRQ>
RIP: 0010:arch_local_irq_restore+0x4a/0x52  
arch/x86/include/asm/paravirt.h:783
Code: 48 c1 ea 03 80 3c 02 00 74 05 e8 b9 ef 0b fb 48 83 3d a9 53 41 01 00  
75 07 e8 9a f8 cc fa 0f 0b e8 93 f8 cc fa 48 89 df 57 9d <0f> 1f 44 00 00  
5b 5d c3 4c 89 45 d0 e8 6d ef 0b fb 4c 8b 45 d0 e9
RSP: 0018:ffff8801cc1fef90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
RAX: 0000000000040000 RBX: 0000000000000246 RCX: ffffc9000341f000
RDX: 0000000000040000 RSI: ffffffff86b0690d RDI: 0000000000000246
RBP: ffff8801cc1fef98 R08: ffff88018a440df8 R09: 0000000000000006
R10: ffff88018a4405c0 R11: 0000000000000000 R12: 0000000000000200
R13: 1ffff1003983fdfc R14: ffffffff87f1bca0 R15: 00000000ffffffff
  dump_stack+0x273/0x2b4 lib/dump_stack.c:118
  vmwrite_error+0x4c/0x60 arch/x86/kvm/vmx.c:2352
  __vmcs_writel arch/x86/kvm/vmx.c:2362 [inline]
  vmcs_writel arch/x86/kvm/vmx.c:2402 [inline]
  vmx_vcpu_load+0xcad/0xfe0 arch/x86/kvm/vmx.c:3085
  kvm_arch_vcpu_load+0x22b/0x940 arch/x86/kvm/x86.c:3106
  kvm_sched_in+0x82/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3970
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x50d/0x870 kernel/sched/core.c:2679
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1ec0 kernel/sched/core.c:3471
  preempt_schedule_common+0x22/0x60 kernel/sched/core.c:3595
  _cond_resched+0x1d/0x30 kernel/sched/core.c:4961
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc+0x2a5/0x760 mm/slab.c:3552
  alloc_inode+0xb2/0x190 fs/inode.c:212
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:903
  new_inode+0x1c/0x40 fs/inode.c:932
  debugfs_get_inode+0x19/0x120 fs/debugfs/inode.c:37
  __debugfs_create_file+0xb5/0x400 fs/debugfs/inode.c:352
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  kvm_create_vm_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:615  
[inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3209  
[inline]
  kvm_dev_ioctl+0xbf5/0x1b10 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3236
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdd4b708c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdd4b7096d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ce9b8 R14: 00000000004c50d7 R15: 0000000000000000

Allocated by task 1383:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  vmx_create_vcpu+0xcf/0x27c0 arch/x86/kvm/vmx.c:10926
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8433
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2471  
[inline]
  kvm_vm_ioctl+0x488/0x1d80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2972
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 1374:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  vmx_free_vcpu+0x26b/0x300 arch/x86/kvm/vmx.c:10920
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8419 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8869 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8966
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:747 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:768
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2402
  __fput+0x39b/0x860 fs/file_table.c:251
  ____fput+0x15/0x20 fs/file_table.c:282
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880191f70f40
  which belongs to the cache kvm_vcpu(17:syz3) of size 23872
The buggy address is located 22432 bytes inside of
  23872-byte region [ffff880191f70f40, ffff880191f76c80)
The buggy address belongs to the page:
page:ffffea000647dc00 count:1 mapcount:0 mapping:ffff8801b4ea0c80 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00064da208 ffffea00066ad408 ffff8801b4ea0c80
raw: 0000000000000000 ffff880191f70f40 0000000100000001 ffff8801d055a1c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801d055a1c0

Memory state around the buggy address:
  ffff880191f76580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880191f76600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff880191f76680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff880191f76700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880191f76780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
