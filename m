Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDEBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE40217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeL1WvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:51:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35619 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeL1WvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:51:05 -0500
Received: by mail-io1-f70.google.com with SMTP id x12so4907911ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=htf7sbJDGCTMagtVG0n+kO2kX2c4l98LD4lR2u2XQIw=;
        b=CapABYKETXuFhalhftrDlkmlCCqdGlL4KgtuodDdUOh/J0hVQw0gtSZXvEFaypZ7nh
         TRm2hVlw/M42ii2LIgGx8P4GqG1R4r7vN+KYqs9GyyOUWkewXYDpBaoJGcWkJfjVANsW
         pPDiDlR+YNAWep+/nHZzprGdkDEz9zHl7LO7shXZ3qv8ZnWgLBCaJA8mrQRazGLPc7Am
         XtZDm+5VUyEd6CY+5cFb7A3HBwcZnGCJsZqN7xIoquuMjbkzHVphHo937ddiBsYPUsTL
         9/x5lSFeKIl2ymx6jXf09eP57WL/um/y2sKTd1vZgcINurG12DY4c2gnGtMR7Y23WH2J
         s8bw==
X-Gm-Message-State: AJcUukcAfg0JhveaP+pSj1TOm5lkOB/SU0S/qH2tqJqrJJ/WZP1YGmIV
        74oS6uu6LbVSiBnDUJpdY7Bw0K28iPZM8RYnm6LXmpMDxE1V
X-Google-Smtp-Source: AFSGD/VSHtHGd8qKkYWB8jdDCvJDACHdeNL7hEqXnhYcQx7b6cAsmQby/i7EYCmu4e1coDE6vqpxp9yY/jM8VpAbgUowRvI0LziW
MIME-Version: 1.0
X-Received: by 2002:a24:244:: with SMTP id 65mr22562169itu.3.1546037464040;
 Fri, 28 Dec 2018 14:51:04 -0800 (PST)
Date:   Fri, 28 Dec 2018 14:51:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da8f65057e1ce530@google.com>
Subject: KASAN: use-after-free Read in ax25_fillin_cb
From:   syzbot <syzbot+ae6bb869cbed29b29040@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jreuter@yaina.de, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11502b15400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=ae6bb869cbed29b29040
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1114eac3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae6bb869cbed29b29040@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in ax25_fillin_cb_from_dev  
net/ax25/af_ax25.c:450 [inline]
BUG: KASAN: use-after-free in ax25_fillin_cb+0x6d5/0x810  
net/ax25/af_ax25.c:477
Read of size 4 at addr ffff8881ccecc438 by task syz-executor5/11370

CPU: 1 PID: 11370 Comm: syz-executor5 Not tainted 4.20.0 #387
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  ax25_fillin_cb_from_dev net/ax25/af_ax25.c:450 [inline]
  ax25_fillin_cb+0x6d5/0x810 net/ax25/af_ax25.c:477
  ax25_setsockopt+0x92a/0xa20 net/ax25/af_ax25.c:663
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f540c347c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457759
RDX: 0000000000000019 RSI: 0000000000000101 RDI: 0000000000000005
RBP: 000000000073bfa0 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000020000140 R11: 0000000000000246 R12: 00007f540c3486d4
R13: 00000000004cb2d8 R14: 00000000004d8910 R15: 00000000ffffffff

Allocated by task 11344:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  ax25_dev_device_up+0x47/0x4d0 net/ax25/ax25_dev.c:57
  ax25_device_event+0x208/0x2e0 net/ax25/af_ax25.c:126
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  __dev_notify_flags+0x17a/0x480 net/core/dev.c:7545
  dev_change_flags+0xfd/0x150 net/core/dev.c:7581
  dev_ifsioc+0x7d6/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11339:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  ax25_dev_device_down+0x164/0x2f0 net/ax25/ax25_dev.c:129
  ax25_device_event+0x1f6/0x2e0 net/ax25/af_ax25.c:131
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  __dev_notify_flags+0x29b/0x480 net/core/dev.c:7547
  dev_change_flags+0xfd/0x150 net/core/dev.c:7581
  dev_ifsioc+0x7d6/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881ccecc400
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 56 bytes inside of
  192-byte region [ffff8881ccecc400, ffff8881ccecc4c0)
The buggy address belongs to the page:
page:ffffea000733b300 count:1 mapcount:0 mapping:ffff8881da800040 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea000733b1c8 ffffea000734aac8 ffff8881da800040
raw: 0000000000000000 ffff8881ccecc000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ccecc300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881ccecc380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881ccecc400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                         ^
  ffff8881ccecc480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881ccecc500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
