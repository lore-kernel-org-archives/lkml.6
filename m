Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA38C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD558217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeLSSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:44:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:56187 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeLSSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:44:04 -0500
Received: by mail-it1-f197.google.com with SMTP id j3so7483960itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VwO0u9ka3pQr2Sqfb5qg978dMTxDJKZNcP02fAnSvcc=;
        b=j17KptCwsJcitNByPcNmqH2wGijn/ayVrnPL0+hbumnzwXk3XtMALUBX1bARpVTheN
         epNKPhtTfdf9Q+5bJtdKSfaIucdx+TSiu5CwxW1z7omLTMW3w7D+Yf28/fOVMv5Do9d9
         rUhxLid+1T1WcThOjOPhyVlev5sZ5QYO/NkAuy3GXGVY6p5NvdUG1aOclSwQFDNFFWyv
         hTT1+mSkXmv54CTmZfRYfqqSjb3MYmEeX5VSpva2AiBfycFl4dPtLfC3/teMyaupTIvA
         sxQuxC/sxUodHLt8gwcu3M1jRKADQ3ADxB6j3zcVTDgpwubxuAwYqNTwikc5ckBA4Iqw
         G0kA==
X-Gm-Message-State: AA+aEWYJyaFWGGaEjdogxTTZfLn8L3zOemmsKpNN2S89JjzYNG2AQYcb
        TGfxMhFmZPhbqoZu8kUHpLIfZuO4s5AvGC5sSHwKBT8e7lwV
X-Google-Smtp-Source: AFSGD/Xl/9+jONLgFcB1YL52lpV9tkfys4Nvm10KNs1HuPgxVclcTIR17UNuEHmXNpD8aPR2bJbDr9P8FzHCDO5UzIQSFV67liB2
MIME-Version: 1.0
X-Received: by 2002:a24:5f49:: with SMTP id r70mr6664066itb.22.1545245042612;
 Wed, 19 Dec 2018 10:44:02 -0800 (PST)
Date:   Wed, 19 Dec 2018 10:44:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db2873057d646597@google.com>
Subject: KASAN: use-after-free Read in kernfs_put
From:   syzbot <syzbot+beac00daeba8d7a7d757@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1a9430db2835 ima: cleanup the match_token policy code
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16518f6d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=beac00daeba8d7a7d757
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+beac00daeba8d7a7d757@syzkaller.appspotmail.com

RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5b7d6886d4
R13: 00000000004c5d63 R14: 00000000004da6c8 R15: 0000000000000004
Bluetooth: Can't register HCI device
==================================================================
BUG: KASAN: use-after-free in kernfs_put+0x6d2/0x760 fs/kernfs/dir.c:535
Read of size 8 at addr ffff8881c4a58c50 by task syz-executor3/11154

CPU: 0 PID: 11154 Comm: syz-executor3 Not tainted 4.20.0-rc7+ #155
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  kernfs_put+0x6d2/0x760 fs/kernfs/dir.c:535
  kernfs_create_dir_ns+0x12e/0x160 fs/kernfs/dir.c:1035
  sysfs_create_dir_ns+0x19b/0x340 fs/sysfs/dir.c:58
  create_dir lib/kobject.c:88 [inline]
  kobject_add_internal.cold.11+0x116/0x6af lib/kobject.c:247
  kobject_add_varg lib/kobject.c:382 [inline]
  kobject_add+0x13f/0x1b0 lib/kobject.c:426
  device_add+0x445/0x18e0 drivers/base/core.c:1879
  hci_register_dev+0x3b3/0x9c0 net/bluetooth/hci_core.c:3261
  __vhci_create_device+0x2c1/0x580 drivers/bluetooth/hci_vhci.c:139
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1857 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0d9d4dac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0d9d4db6d4
R13: 00000000004c5d63 R14: 00000000004da6c8 R15: 00000000ffffffff

Allocated by task 7609:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  kernfs_iattrs.isra.4+0x116/0x400 fs/kernfs/inode.c:45
  kernfs_xattr_get+0x67/0xb0 fs/kernfs/inode.c:316
  __vfs_getxattr+0xee/0x150 fs/xattr.c:310
  smk_fetch.part.24+0x7e/0x100 security/smack/smack_lsm.c:277
  smk_fetch security/smack/smack_lsm.c:3555 [inline]
  smack_d_instantiate+0x94e/0xea0 security/smack/smack_lsm.c:3509
  security_d_instantiate+0x5c/0xf0 security/security.c:1298
  d_splice_alias+0x120/0x11d0 fs/dcache.c:2911
CPU: 1 PID: 11171 Comm: syz-executor2 Not tainted 4.20.0-rc7+ #155
  kernfs_iop_lookup+0x1bf/0x230 fs/kernfs/dir.c:1103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
  __lookup_slow+0x2b5/0x540 fs/namei.c:1671
Call Trace:
  lookup_slow+0x57/0x80 fs/namei.c:1688
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  walk_component+0x92b/0x2590 fs/namei.c:1810
  link_path_walk.part.40+0xa61/0x1530 fs/namei.c:2141
  link_path_walk fs/namei.c:2269 [inline]
  path_lookupat.isra.43+0xf7/0xc00 fs/namei.c:2317
  filename_lookup+0x26a/0x520 fs/namei.c:2348
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  do_readlinkat+0x156/0x410 fs/stat.c:397
  __do_sys_readlink fs/stat.c:430 [inline]
  __se_sys_readlink fs/stat.c:427 [inline]
  __x64_sys_readlink+0x78/0xb0 fs/stat.c:427
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7609:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  __should_failslab+0x124/0x180 mm/failslab.c:32
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  should_failslab+0x9/0x14 mm/slab_common.c:1578
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3720 [inline]
  __kmalloc+0x2e0/0x760 mm/slab.c:3731
  kernfs_put+0x3b9/0x760 fs/kernfs/dir.c:540
  kernfs_evict_inode+0x50/0x60 fs/kernfs/inode.c:289
  evict+0x4b9/0x980 fs/inode.c:558
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  __alloc_workqueue_key+0x1dc/0x10a0 kernel/workqueue.c:4076
  iput_final fs/inode.c:1550 [inline]
  iput+0x679/0xa90 fs/inode.c:1576
  dentry_unlink_inode+0x461/0x5e0 fs/dcache.c:360
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:552
  dentry_kill+0xc9/0x680 fs/dcache.c:671
  dput.part.25+0x660/0x860 fs/dcache.c:832
  dput+0x15/0x20 fs/dcache.c:814
  lookup_fast+0xd68/0x12a0 fs/namei.c:1625
  walk_component+0x139/0x2590 fs/namei.c:1806
  link_path_walk.part.40+0xa61/0x1530 fs/namei.c:2141
  link_path_walk fs/namei.c:2072 [inline]
  path_openat+0x270/0x5150 fs/namei.c:3533
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  hci_register_dev+0x2ad/0x9c0 net/bluetooth/hci_core.c:3248
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

  __vhci_create_device+0x2c1/0x580 drivers/bluetooth/hci_vhci.c:139
The buggy address belongs to the object at ffff8881c4a58c00
  which belongs to the cache kmalloc-192 of size 192
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
The buggy address is located 80 bytes inside of
  192-byte region [ffff8881c4a58c00, ffff8881c4a58cc0)
  call_write_iter include/linux/fs.h:1857 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
The buggy address belongs to the page:
page:ffffea0007129600 count:1 mapcount:0 mapping:ffff8881da800040  
index:0xffff8881c4a58500
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0007340b48 ffffea000765b148 ffff8881da800040
  vfs_write+0x1fc/0x560 fs/read_write.c:549
raw: ffff8881c4a58500 ffff8881c4a58000 000000010000000b 0000000000000000
  ksys_write+0x101/0x260 fs/read_write.c:598
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  ffff8881c4a58b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  ffff8881c4a58b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881c4a58c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff8881c4a58c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881c4a58d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
kobject: 'loop1' (000000000073d129): kobject_uevent_env
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
kobject: 'loop1' (000000000073d129): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RSP: 002b:00007f5b7d687c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5b7d687c90 RCX: 0000000000457669
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5b7d6886d4
R13: 00000000004c5d63 R14: 00000000004da6c8 R15: 0000000000000004
kobject: 'rfkill147' (00000000e92224a0): kobject_add_internal:  
parent: 'hci0', set: 'devices'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
