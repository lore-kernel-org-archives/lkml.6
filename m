Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B88C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597CB2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfAGSbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:31:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:38637 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfAGSbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:31:04 -0500
Received: by mail-it1-f200.google.com with SMTP id m128so1352818itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0jYZIyCrrX6/GR8efrwhudP/H6iO9n0VT1CfmVttA0M=;
        b=RQ1zerpE7GmbAoktXPMNtXbRmg2o9xBZssdZcjIgR9JtLnPLVJx92Q4f0g1HUrpARV
         /3BHJIriO4zbXS0YDR538yoEZ1iVq3wM3xS2Q/pLsvICcsaVxmLkDFH5tBtfevPrfqdm
         wNufqRrXE36e84W6V3z03b3SBXMlK4spudow6w2e+FQeU5NCTuW2EceBjcgd0WnWaujQ
         sovU3gHo30SSotSJzKBBR8U/Yh/Q8qYlylv46WkJ+y1iPYuwGVaidKUE95Shm0wbfLBt
         4/TKnBUyusiEr6DfTN79tZOhg57QNOcpU0rOK5exjjkwDTQD8Tje1Koeqtsq63n78KzC
         xGAQ==
X-Gm-Message-State: AA+aEWbHCXGXnaWnyPKsehMwR2BuFh+ETHXV6AfY92V2pax2Namyx7jg
        WBND+rC67/dzTaoXRQ6xhowqN43XUudbqpUtQ1UglRplp8nU
X-Google-Smtp-Source: AFSGD/UJZr/pFTUWFCQvtlUr7LqYjvNnBvAtApnKipTOFkXc0ZcUI7KmTocgPlVIIJsxpbqBIInkfkilMkWxsw7/pUchkOPIsOB/
MIME-Version: 1.0
X-Received: by 2002:a02:5c8:: with SMTP id 69mr48679298jal.20.1546885863660;
 Mon, 07 Jan 2019 10:31:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 10:31:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000696949057ee26e44@google.com>
Subject: KASAN: slab-out-of-bounds Read in hci_event_packet
From:   syzbot <syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=145e8207400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=cec7a50c412a2c03f8f5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1643bfbf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6c8f7400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com

kauditd_printk_skb: 5 callbacks suppressed
audit: type=1400 audit(1546856008.711:36): avc:  denied  { map } for   
pid=8365 comm="syz-executor431" path="/root/syz-executor431611296"  
dev="sda1" ino=16484 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
==================================================================
BUG: KASAN: slab-out-of-bounds in hci_inquiry_result_with_rssi_evt  
net/bluetooth/hci_event.c:3988 [inline]
BUG: KASAN: slab-out-of-bounds in hci_event_packet+0xb33e/0xc22e  
net/bluetooth/hci_event.c:5863
Read of size 1 at addr ffff88809fcab1c0 by task kworker/u5:0/1171

CPU: 1 PID: 1171 Comm: kworker/u5:0 Not tainted 4.20.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  hci_inquiry_result_with_rssi_evt net/bluetooth/hci_event.c:3988 [inline]
  hci_event_packet+0xb33e/0xc22e net/bluetooth/hci_event.c:5863
  hci_rx_work+0x578/0xcd0 net/bluetooth/hci_core.c:4412
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 8369:
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

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff88809fcaadc0
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes to the right of
  1024-byte region [ffff88809fcaadc0, ffff88809fcab1c0)
The buggy address belongs to the page:
page:ffffea00027f2a80 count:1 mapcount:0 mapping:ffff88812c3f0ac0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0001d08488 ffffea0002812908 ffff88812c3f0ac0
raw: 0000000000000000 ffff88809fcaa040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809fcab080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88809fcab100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88809fcab180: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                            ^
  ffff88809fcab200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809fcab280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
