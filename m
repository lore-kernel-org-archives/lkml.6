Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8563ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA192087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA192087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJTAAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:00:47 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37542 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeJTAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:00:45 -0400
Received: by mail-io1-f70.google.com with SMTP id t4-v6so20519723iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Aw5yor+tO++5iW3STHmMbjgUBdQQ6ySJ7Q6JvaYKt4M=;
        b=Dl/V14tN1w6RQUeprIoQDJcc7CS5MBMZwi9TZEbug67o0pKbKRDWKo6siH/QvOBK8U
         TmcnagmYXVG3GXZjExs6NhowrMetMvqOYd/UfRrcrZ+I2+kqf/7DDOgRRz9AilK2AuzN
         ONppUPCWm5PIFG0PPHJkFMlhTmxM9N33xiE2tDFS6u2Sq/FsRXsGsoAT2Az/6BSja8pL
         1AzjU3v/I82bUCTyTfFul8+KcE2cg0SJUIy+JH25JVkxrpNsncvtM/RduwcgLjneAeKv
         LMKFIroG9niOvkqvur90N/NfEOY+5H79RXXeQwcvycisfHuQy7PVu/LZCaKkF3Ttu3Qq
         nyNg==
X-Gm-Message-State: ABuFfohRc1+nErozWWlQ5vS9r4l/rHx2QaiP015NiBEFd2QKBGvDi5H1
        4zyyLpyKBo7jEVMC7FxcnX7r1wIUkZdvmJ9fejd2kE5Dudi8
X-Google-Smtp-Source: ACcGV62NRUxIj8HcGn9RFKa044owVDDAXW8ZrOKiviot47fmDZmQRhpxmKgyvGur5maDtlYbFmyOPA694ietc7x6WmDQYz6HXub2
MIME-Version: 1.0
X-Received: by 2002:a05:660c:310:: with SMTP id u16mr4007493itj.1.1539964444178;
 Fri, 19 Oct 2018 08:54:04 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:54:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a980e3057896e9df@google.com>
Subject: KASAN: use-after-free Read in kobject_put
From:   syzbot <syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fa520c47eaa1 fscache: Fix out of bound read in long cookie..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f664f6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=fdc00003f4efff43bc5b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kobject_put+0xcb/0xe0 lib/kobject.c:704
Read of size 1 at addr ffff88018515a3cc by task syz-executor4/11682

CPU: 1 PID: 11682 Comm: syz-executor4 Not tainted 4.19.0-rc8+ #290
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  kobject_put+0xcb/0xe0 lib/kobject.c:704
  put_device+0x20/0x30 drivers/base/core.c:2024
  hci_free_dev+0x19/0x20 net/bluetooth/hci_core.c:3143
  vhci_release+0x7e/0xf0 drivers/bluetooth/hci_vhci.c:355
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffc03715460 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000730348 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000730338 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 000000000000003c R15: 0000000000000004

Allocated by task 11686:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  hci_alloc_dev+0x228/0x2120 net/bluetooth/hci_core.c:3053
  __vhci_create_device+0x102/0x580 drivers/bluetooth/hci_vhci.c:114
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1808 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11682:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  bt_host_release+0x19/0x30 net/bluetooth/hci_sysfs.c:86
  device_release+0x7e/0x210 drivers/base/core.c:891
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  put_device+0x20/0x30 drivers/base/core.c:2024
  hci_dev_put include/net/bluetooth/hci_core.h:1004 [inline]
  hci_unregister_dev+0x71d/0x990 net/bluetooth/hci_core.c:3314
  vhci_release+0x76/0xf0 drivers/bluetooth/hci_vhci.c:354
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880185159300
  which belongs to the cache kmalloc-8192 of size 8192
The buggy address is located 4300 bytes inside of
  8192-byte region [ffff880185159300, ffff88018515b300)
The buggy address belongs to the page:
page:ffffea0006145600 count:1 mapcount:0 mapping:ffff8801da802080 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006211e08 ffffea0006156408 ffff8801da802080
raw: 0000000000000000 ffff880185159300 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88018515a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018515a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88018515a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88018515a400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018515a480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
