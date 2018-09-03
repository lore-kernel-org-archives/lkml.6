Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE85420658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE85420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeICWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:12:19 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:47705 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeICWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:12:18 -0400
Received: by mail-io0-f198.google.com with SMTP id v20-v6so950531iom.14
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 10:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M/jpuCkP4J1Msxy57DkRML0U1XPEMn9V4fsotxXjC/w=;
        b=GtJmbZX1e4WKxbGq93QwEZrhSyQRHC/aYwy5fOU8kwax5BFZKZO/AQCNQV+FQ4oD+u
         RJsWccJMN2ebZAM1CXuF7zGVh0IlNMbnabOhNRlzpSjYUwaTMuQzukCmXWLAH6p9RB2R
         hZXIsoci5/ZkhaiaGy+B2M+iZozw0xUlB31m4xavk7GZ2Jm8QSXwJYO3cfi+FRRjCdbB
         IGugyLw86o6xyYifb2ULXExcYdGABAsMBnaX1pCltZcIEiesz9XOnbt1/dF5VhcrijjM
         nVZ2NR855oTk911LwmtEzvNFFVeZ/BKo7RWQbY14RdCJaSZgolmaONAidpScsmFPeOs1
         gl7Q==
X-Gm-Message-State: APzg51Dbs+R9zjFVxQ78znn+AQTEwJrk3Qju71P11O0AJ9qsboGKfzVA
        IHLhLasqyW51qumLBPGw1lW7PgI+KpL2x0o4FY6ruUiZw7Mi
X-Google-Smtp-Source: ANB0Vdat3TbE3F5cgE+pMDj5B5nEWAIBGWfVOCn7EQW2ipuStXGWNVIiUpBPMXYN2FfXOFAppSLJix8IfU+DJh3JNb3vO889vSDa
MIME-Version: 1.0
X-Received: by 2002:a6b:3294:: with SMTP id y142-v6mr12321405ioy.125.1535997063757;
 Mon, 03 Sep 2018 10:51:03 -0700 (PDT)
Date:   Mon, 03 Sep 2018 10:51:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c8b4d0574fb2f07@google.com>
Subject: KASAN: use-after-free Read in destroy_async_on_interface
From:   syzbot <syzbot+f84aa7209ccec829536f@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, dan.carpenter@oracle.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mark.rutland@arm.com, oneukum@suse.com, sds@tycho.nsa.gov,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d18c2437944 Add linux-next specific files for 20180830
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156078ea400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a059d319ef7d83f6
dashboard link: https://syzkaller.appspot.com/bug?extid=f84aa7209ccec829536f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142ca151400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157b48ca400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f84aa7209ccec829536f@syzkaller.appspotmail.com

RDX: 0000000020000280 RSI: 000000008108551b RDI: 0000000000000003
RBP: 00007ffcce5daab0 R08: 0000000000000001 R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3829/0x5020  
kernel/locking/lockdep.c:3291
Read of size 8 at addr ffff8801b87825b8 by task syz-executor735/4685

CPU: 0 PID: 4685 Comm: syz-executor735 Not tainted  
4.19.0-rc1-next-20180830+ #52
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x3829/0x5020 kernel/locking/lockdep.c:3291
  lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  destroy_async_on_interface+0x155/0x5c0 drivers/usb/core/devio.c:653
  driver_disconnect+0xea/0x150 drivers/usb/core/devio.c:699
  usb_unbind_interface+0x25a/0xbe0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:966 [inline]
  device_release_driver_internal+0x651/0x750 drivers/base/dd.c:999
  device_release_driver+0x19/0x20 drivers/base/dd.c:1024
  usb_driver_release_interface+0x110/0x190 drivers/usb/core/driver.c:604
  proc_disconnect_claim+0x288/0x410 drivers/usb/core/devio.c:2281
  usbdev_do_ioctl+0x17ee/0x3b30 drivers/usb/core/devio.c:2523
  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2551
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444ca9
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcce5daa98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444ca9
RDX: 0000000020000280 RSI: 000000008108551b RDI: 0000000000000003
RBP: 00007ffcce5daab0 R08: 0000000000000001 R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4683:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x730 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  usbdev_open+0xe4/0xad0 drivers/usb/core/devio.c:976
  chrdev_open+0x25a/0x770 fs/char_dev.c:417
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x130f/0x5340 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x584/0x720 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4683:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  usbdev_release+0x3f1/0x520 drivers/usb/core/devio.c:1059
  __fput+0x3c1/0xa80 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b8782580
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 56 bytes inside of
  512-byte region [ffff8801b8782580, ffff8801b8782780)
The buggy address belongs to the page:
page:ffffea0006e1e080 count:1 mapcount:0 mapping:ffff8801dac00940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007410708 ffffea0006e22b88 ffff8801dac00940
raw: 0000000000000000 ffff8801b8782080 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b8782480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b8782500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801b8782580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                         ^
  ffff8801b8782600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b8782680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
