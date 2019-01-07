Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B82C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFF8206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfAGNbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:31:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35591 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAGNbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:31:04 -0500
Received: by mail-io1-f69.google.com with SMTP id x12so277527ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 05:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vm6ItJyYSta4/ymiPfVMaGeSQpw+CMG54sFJCA/cdoQ=;
        b=m/I8kPGGc52cS83g00u/Ty5n2nGsdQXOaWjZYRcT6EeF2D+iObh6Ueh80FX5asdXhW
         nnATnsmyY2Kx6nnUl1ZdEF6r+FBG28r1UaQoLoavky/Fi1EkN3oH5jrWn9K0T7JrdcOD
         03nJMp96LrWChPjFbUoJhTfMU59qongXmZ62+QzIlL46rvHscnHXuDrnoOEvb49aB5iE
         kgGSxTi8RIUjnv3xre98GRnodgJV0kjDI0hu74AZN0/tmmOuQYIr31nVkFTVzY6yqq1B
         pQYpoNfuP+t5TWFIB+oEWpChxleZtU2HaQWzViY88Kv/nft4ZhXuOcUyd1FFDD/z2sSI
         cc2Q==
X-Gm-Message-State: AA+aEWYcr0WhB9stfvQ1Vea6Sj6s+64joUTuTcBBHr9z8d9ldNvb7lSt
        MI403FVe3vxoxpessssTCXJJwhZqu7ErVhTuF04lAO3r+ihH
X-Google-Smtp-Source: AFSGD/VPn3AAcFnwwWXbqm6aWR6GnmgjkASB+lH4ek0+JIfMy1agZe7gKVIxNLgWmVWb8whbbLCoYG2h6jvDNGCxCKvWzVII7vAQ
MIME-Version: 1.0
X-Received: by 2002:a02:c55:: with SMTP id g82mr47932757jad.17.1546867863851;
 Mon, 07 Jan 2019 05:31:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 05:31:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a1bce057ede3d13@google.com>
Subject: KASAN: slab-out-of-bounds Read in bacpy
From:   syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    574823bfab82 Change mincore() to count "mapped" pages rath..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15145dab400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=660883c56e2fa65d4497
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1756666f400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1397354b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:352 [inline]
BUG: KASAN: slab-out-of-bounds in bacpy+0x23/0x30  
include/net/bluetooth/bluetooth.h:236
Read of size 6 at addr ffff888094f0bc3b by task kworker/u5:0/1171

CPU: 0 PID: 1171 Comm: kworker/u5:0 Not tainted 4.20.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  memcpy+0x24/0x50 mm/kasan/common.c:130
  memcpy include/linux/string.h:352 [inline]
  bacpy+0x23/0x30 include/net/bluetooth/bluetooth.h:236
  hci_inquiry_result_with_rssi_evt net/bluetooth/hci_event.c:3986 [inline]
  hci_event_packet+0x3afc/0xc22e net/bluetooth/hci_event.c:5863
  hci_rx_work+0x578/0xcd0 net/bluetooth/hci_core.c:4412
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 7831:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  __do_kmalloc_node mm/slab.c:3671 [inline]
  __kmalloc_node_track_caller+0x4e/0x70 mm/slab.c:3685
  __kmalloc_reserve.isra.0+0x40/0xe0 net/core/skbuff.c:140
  __alloc_skb+0x12d/0x730 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1011 [inline]
  bt_skb_alloc include/net/bluetooth/bluetooth.h:339 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:180 [inline]
  vhci_write+0xc4/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1862 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x764/0xb40 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5970:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  load_elf_binary+0x25dd/0x5580 fs/binfmt_elf.c:1118
  search_binary_handler fs/exec.c:1656 [inline]
  search_binary_handler+0x17f/0x570 fs/exec.c:1634
  exec_binprm fs/exec.c:1698 [inline]
  __do_execve_file.isra.0+0x14f3/0x2700 fs/exec.c:1818
  do_execveat_common fs/exec.c:1865 [inline]
  do_execve fs/exec.c:1882 [inline]
  __do_sys_execve fs/exec.c:1963 [inline]
  __se_sys_execve fs/exec.c:1958 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1958
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888094f0ba40
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 507 bytes inside of
  512-byte region [ffff888094f0ba40, ffff888094f0bc40)
The buggy address belongs to the page:
page:ffffea000253c2c0 count:1 mapcount:0 mapping:ffff88812c3f0940 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00025dbf08 ffffea000253ca88 ffff88812c3f0940
raw: 0000000000000000 ffff888094f0b040 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888094f0bb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888094f0bb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888094f0bc00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                            ^
  ffff888094f0bc80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff888094f0bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
