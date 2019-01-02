Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C60C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F990218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfABMGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:06:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:33235 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfABMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:06:05 -0500
Received: by mail-it1-f198.google.com with SMTP id w68so25062105ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 04:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JnrZgP+gt56VHpAK71cc+m8moScoY7xmgwpVvO2o2a0=;
        b=tdInMBr/ICr9LO8RnsKqk9/0oHMwzrybHu0rnS6ayssxaLVi4KtYRMz1meWb14ZGS0
         Tm99RtF71JBLcFlJR4li1SYIzJZQc9/FCvKib3XdQE1MstAeNoUNibuFv3Ur08PHxvsw
         /xVjD4L45hH/rJjf+mqSlaYm85MO8tvlmmWBjUA7vlIWYh9rNQ8jYTfXDM8vRhQQvXJd
         iAiJHRfwMSKdC85r5z6GXiYHWtL9Zv6U0tMrFDGFB3NsOnJYtZd/jvgEsDgl19I5t1w7
         IwuNG3enVoVvgQmMg1dxebJP5eNvaSz9iuv1/2zkO7KxGaLUtoE9eNf2DMYnnEfQACd0
         B1TQ==
X-Gm-Message-State: AA+aEWbvs3FbPsC8sRy7Cln+4Hfu2/wp2LzaNH2SQoGBGPG3DpEFmSem
        E0/fzyHRTFznj1O7c9GURqca5D1F6VJDbXyGMZFmYo2ZvKi5
X-Google-Smtp-Source: AFSGD/WwzzTsq07x8xKPg5lybR5/yERXVFaw2NRf4ejTAZtoI54pRMYEtjFTD8Yq2VP/NokvTUp8WSAluN15h6+uHLL84GDlHFaX
MIME-Version: 1.0
X-Received: by 2002:a02:4596:: with SMTP id o22mr34055845jad.12.1546430764515;
 Wed, 02 Jan 2019 04:06:04 -0800 (PST)
Date:   Wed, 02 Jan 2019 04:06:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000638c1b057e787822@google.com>
Subject: WARNING: lock held when returning to user space in grab_super
From:   syzbot <syzbot+87b93137e0280beaeba1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118961fd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=87b93137e0280beaeba1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87b93137e0280beaeba1@syzkaller.appspotmail.com

WARNING: lock held when returning to user space!
4.20.0+ #396 Not tainted
------------------------------------------------
syz-executor0/29677 is leaving the kernel with locks still held!
1 lock held by syz-executor0/29677:
  #0: 00000000ec5f6915 (&type->s_umount_key#43){++++}, at:  
grab_super+0xcc/0x400 fs/super.c:383
kobject: 'loop5' (00000000edd59d60): kobject_uevent_env
kobject: 'loop5' (00000000edd59d60): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
==================================================================
BUG: KASAN: use-after-free in owner_on_cpu kernel/locking/rwsem-xadd.c:367  
[inline]
BUG: KASAN: use-after-free in rwsem_can_spin_on_owner  
kernel/locking/rwsem-xadd.c:384 [inline]
BUG: KASAN: use-after-free in rwsem_optimistic_spin  
kernel/locking/rwsem-xadd.c:437 [inline]
BUG: KASAN: use-after-free in  
__rwsem_down_write_failed_common+0x14ea/0x15e0  
kernel/locking/rwsem-xadd.c:518
Read of size 4 at addr ffff88805631c738 by task syz-executor0/29718

CPU: 0 PID: 29718 Comm: syz-executor0 Not tainted 4.20.0+ #396
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'loop2' (000000006e1a6a52): kobject_uevent_env
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.5+0x9/0x1ff mm/kasan/report.c:187
kobject: 'loop2' (000000006e1a6a52): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  kasan_report.cold.6+0x1b/0x39 mm/kasan/report.c:317
kobject: 'loop1' (0000000042cf1ea5): kobject_uevent_env
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
  owner_on_cpu kernel/locking/rwsem-xadd.c:367 [inline]
  rwsem_can_spin_on_owner kernel/locking/rwsem-xadd.c:384 [inline]
  rwsem_optimistic_spin kernel/locking/rwsem-xadd.c:437 [inline]
  __rwsem_down_write_failed_common+0x14ea/0x15e0  
kernel/locking/rwsem-xadd.c:518
kobject: 'loop1' (0000000042cf1ea5): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000006e1a6a52): kobject_uevent_env
kobject: 'loop2' (000000006e1a6a52): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:606
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa5/0x130 kernel/locking/rwsem.c:72
kobject: 'loop5' (00000000edd59d60): kobject_uevent_env
  grab_super+0xcc/0x400 fs/super.c:383
kobject: 'loop5' (00000000edd59d60): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  sget_userns+0x435/0xed0 fs/super.c:511
  kernfs_mount_ns+0x1d7/0xa80 fs/kernfs/mount.c:324
  kernfs_mount include/linux/kernfs.h:554 [inline]
  cgroup_do_mount+0xc4/0x330 kernel/cgroup/cgroup.c:2038
  cgroup_mount+0xb6d/0xd30 kernel/cgroup/cgroup.c:2102
  mount_fs+0xae/0x31d fs/super.c:1261
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2469 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2801
  ksys_mount+0x12d/0x140 fs/namespace.c:3017
  __do_sys_mount fs/namespace.c:3031 [inline]
  __se_sys_mount fs/namespace.c:3028 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3028
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbd6c16dc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fbd6c16dc90 RCX: 0000000000457ec9
RDX: 0000000020000200 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbd6c16e6d4
R13: 00000000004c3a19 R14: 00000000004d64a8 R15: 0000000000000003

Allocated by task 29676:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  kasan_slab_alloc+0x12/0x20 mm/kasan/common.c:397
  kmem_cache_alloc_node+0x147/0x730 mm/slab.c:3631
  alloc_task_struct_node kernel/fork.c:158 [inline]
  dup_task_struct kernel/fork.c:849 [inline]
  copy_process+0x2027/0x8790 kernel/fork.c:1757
  _do_fork+0x1cb/0x11d0 kernel/fork.c:2222
  __do_sys_clone kernel/fork.c:2329 [inline]
  __se_sys_clone kernel/fork.c:2323 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2323
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 29709:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3747
  free_task_struct kernel/fork.c:163 [inline]
  free_task+0x16e/0x1f0 kernel/fork.c:462
  __put_task_struct+0x2e6/0x620 kernel/fork.c:735
  put_task_struct include/linux/sched/task.h:96 [inline]
  delayed_put_task_struct+0x2ff/0x4c0 kernel/exit.c:181
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2452 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2773 [inline]
  rcu_process_callbacks+0xc5b/0x1600 kernel/rcu/tree.c:2754
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292

The buggy address belongs to the object at ffff88805631c700
  which belongs to the cache task_struct(17:syz0) of size 6080
The buggy address is located 56 bytes inside of
  6080-byte region [ffff88805631c700, ffff88805631dec0)
The buggy address belongs to the page:
page:ffffea000158c700 count:1 mapcount:0 mapping:ffff88808d959e40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00023f4688 ffffea0000394788 ffff88808d959e40
raw: 0000000000000000 ffff88805631c700 0000000100000001 ffff88805aa82c00
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff88805aa82c00

Memory state around the buggy address:
  ffff88805631c600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88805631c680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88805631c700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                         ^
  ffff88805631c780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88805631c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
