Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DDC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F322173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F322173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeHNRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:20:28 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:57628 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:20:28 -0400
Received: by mail-it0-f70.google.com with SMTP id e6-v6so12790926itc.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 07:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xujd+8qasjSCqx/i7H6mKIDT7aTQGnURQvvW/d55yVU=;
        b=VO5s+J0wTiln+OcYeIs+VXU+HX8V1EIbycn3kJXk0CbNE5rdcQUDoeo8Tnp0r/bnGN
         LkWLAkv/qaQyCs+cHRxQE6gWRK3kkwO9f6y9yTTj74YPZ6PVo5dpyjnR87L7VQy7r2zy
         XpsmhQWafEkoZp0ywvv/sUxmgqSOQkA6EA4qgU5AO5TVooZ1BiUmbxxc6/LfZKUMjt59
         6AEjlko4fEheL/7xrB5eM1xnV6YoQv2D1RdZ+HWBsvNO86AjZW6YzHR2ERZHchAGwjCc
         b1DILXQbW1ylcp+BV1ejQmq15i7zQH0jWyq5+XHRpQwBym2yLE1tHqjzauQKAuDO6t8+
         fqWA==
X-Gm-Message-State: AOUpUlGO+6um+suNqERdsfcHGc2xuf3D6hecEtQqxDukiL/Bn4bRmzDx
        MVxPmmuGbe678ZZg/zcavF4Re3nAA5mSZokIxzrrQaa57i0S
X-Google-Smtp-Source: AA+uWPylHqXY8FbfQlP2WHLtNdjlD7LMN+LCBfF4Atmnuu3x01LkeR8wu3RGG+Q2nOZg59dfPnwoiwGNyWD1o1JjDUIEk6QZC2Xx
MIME-Version: 1.0
X-Received: by 2002:a6b:b3d4:: with SMTP id c203-v6mr10093759iof.53.1534257182376;
 Tue, 14 Aug 2018 07:33:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 07:33:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000598cfe0573661657@google.com>
Subject: KASAN: use-after-free Read in vmx_vcpu_load
From:   syzbot <syzbot+1ff78ee6b7dd52919ab9@syzkaller.appspotmail.com>
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

HEAD commit:    1c2f2531cf8b Add linux-next specific files for 20180809
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10129c74400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44657afb75515c8b
dashboard link: https://syzkaller.appspot.com/bug?extid=1ff78ee6b7dd52919ab9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1ff78ee6b7dd52919ab9@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007fff7398e49f R14: 00007f51b2d9f9c0 R15: 0000000000000000
==================================================================
BUG: KASAN: use-after-free in vmx_vcpu_load+0xf78/0xfe0  
arch/x86/kvm/vmx.c:2929
Read of size 8 at addr ffff88019a46e5e0 by task syz-executor7/17308

CPU: 1 PID: 17308 Comm: syz-executor7 Not tainted 4.18.0-rc8-next-20180809+  
#35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  vmx_vcpu_load+0xf78/0xfe0 arch/x86/kvm/vmx.c:2929
  kvm_arch_vcpu_load+0x22b/0x940 arch/x86/kvm/x86.c:3081
  kvm_sched_in+0x82/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3975
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x50d/0x870 kernel/sched/core.c:2679
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1ec0 kernel/sched/core.c:3471
  schedule+0xfb/0x450 kernel/sched/core.c:3515
  freezable_schedule include/linux/freezer.h:172 [inline]
  futex_wait_queue_me+0x3f9/0x840 kernel/futex.c:2530
  futex_wait+0x45b/0xa20 kernel/futex.c:2645
  do_futex+0x336/0x27d0 kernel/futex.c:3527
  __do_sys_futex kernel/futex.c:3587 [inline]
  __se_sys_futex kernel/futex.c:3555 [inline]
  __x64_sys_futex+0x472/0x6a0 kernel/futex.c:3555
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f51b2d9ecf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000009300a8 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007fff7398e49f R14: 00007f51b2d9f9c0 R15: 0000000000000000

Allocated by task 17308:
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

Freed by task 17301:
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
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2407
  __fput+0x376/0x8a0 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88019a468e00
  which belongs to the cache kvm_vcpu of size 23808
The buggy address is located 22496 bytes inside of
  23808-byte region [ffff88019a468e00, ffff88019a46eb00)
The buggy address belongs to the page:
page:ffffea0006691a00 count:1 mapcount:0 mapping:ffff8801d9fed3c0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006bd0c08 ffffea0006432c08 ffff8801d9fed3c0
raw: 0000000000000000 ffff88019a468e00 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88019a46e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88019a46e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88019a46e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff88019a46e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88019a46e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
