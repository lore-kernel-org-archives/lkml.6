Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC26C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D962147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfBTGpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:45:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:51133 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBTGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:45:05 -0500
Received: by mail-it1-f200.google.com with SMTP id i63so9128067itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 22:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ecDC1cC+bJoHUcNwtURv9W4PAiZVU3CwRNChTN9AMn0=;
        b=dg+LrfdJfIrX6LhtNrpJGLRYJYypX+wk6LobQFc+S6W7ZmpnU6LmuWeph8ngxh4VF6
         LXfqcnZrV0kT0iJfLByfALSf334fcjeQUhUEvbSZz4ahcHTqsHz5kR/1bA/OKkRXP6RK
         +35Nqrkv0iiW8qG46KoP6EgLynZWcaLYcN/jXNFB9e4MQwMqQNk2jInUCF3yI16engjI
         Ldp3NzNT2d8qHI4R6MZnWUBrORQBpvgKM0TAwFMrgYNBfp6m/WG3N4Mp/kiVBgrIm0ay
         Y9xYwlnHq1qqGV9bzvktyJmP0MY2S/Q3KNMokg940HYQdXd3Koj0Lhm2Bd1awp3qCty/
         44EQ==
X-Gm-Message-State: AHQUAuaU1XUKU6ZgdGky6X1AnnKEJ5ZTsJMFyBneQ9jJK95Md4iNURk0
        PMSUIDNjAP0DlHhF9Ul1sCySenlxz0NRljzaM508AZSsbzW+
X-Google-Smtp-Source: AHgI3IajuZZ5VhrJhoGXCMYfNJy5kNXbVSXfFqXWuJH5LM6WTgzUSMMnwyRV8Bupq3I7CSkoQ0uifHsJgCRT3Wx49ms4A6lA9Piv
MIME-Version: 1.0
X-Received: by 2002:a02:9c16:: with SMTP id q22mr19383354jak.13.1550645103855;
 Tue, 19 Feb 2019 22:45:03 -0800 (PST)
Date:   Tue, 19 Feb 2019 22:45:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096952e05824db245@google.com>
Subject: KASAN: use-after-free Read in h5_reset_rx
From:   syzbot <syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7a92eb7cc1dc Add linux-next specific files for 20190215
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b2f400c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b16fd68f18a50133
dashboard link: https://syzkaller.appspot.com/bug?extid=899a33dc0fa0dbaf06a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com

Bluetooth: Invalid header checksum
==================================================================
BUG: KASAN: use-after-free in h5_reset_rx+0xe0/0x100  
drivers/bluetooth/hci_h5.c:544
Read of size 8 at addr ffff88809117be18 by task kworker/u4:4/880

CPU: 1 PID: 880 Comm: kworker/u4:4 Not tainted 5.0.0-rc6-next-20190215 #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  h5_reset_rx+0xe0/0x100 drivers/bluetooth/hci_h5.c:544
  h5_rx_3wire_hdr+0x2f5/0x3c0 drivers/bluetooth/hci_h5.c:455
  h5_recv+0x30a/0x4c0 drivers/bluetooth/hci_h5.c:578
  hci_uart_tty_receive+0x22b/0x530 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x228/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2267
  worker_thread+0x98/0xe40 kernel/workqueue.c:2413
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 6242:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3615
  kmalloc include/linux/slab.h:548 [inline]
  kzalloc include/linux/slab.h:743 [inline]
  h5_open+0x4e4/0x5f0 drivers/bluetooth/hci_h5.c:222
  hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:686 [inline]
  hci_uart_tty_ioctl+0x2d4/0xa70 drivers/bluetooth/hci_ldisc.c:748
  tty_ioctl+0xac9/0x14d0 drivers/tty/tty_io.c:2664
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6242:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3491 [inline]
  kfree+0xcf/0x230 mm/slab.c:3816
  h5_close+0x11a/0x150 drivers/bluetooth/hci_h5.c:266
  hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:696 [inline]
  hci_uart_tty_ioctl+0x839/0xa70 drivers/bluetooth/hci_ldisc.c:748
  tty_ioctl+0xac9/0x14d0 drivers/tty/tty_io.c:2664
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809117bb40
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 728 bytes inside of
  1024-byte region [ffff88809117bb40, ffff88809117bf40)
The buggy address belongs to the page:
page:ffffea0002445e80 count:1 mapcount:0 mapping:ffff88812c3f0ac0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea000226a888 ffffea000097a788 ffff88812c3f0ac0
raw: 0000000000000000 ffff88809117a040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809117bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809117bd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809117be00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff88809117be80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809117bf00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
