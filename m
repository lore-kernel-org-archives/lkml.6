Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05B62086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05B62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeKQMN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:13:56 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:54114 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:13:55 -0500
Received: by mail-it1-f199.google.com with SMTP id i12so587560ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 17:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CKN80Le++Xdl4rcxucG8qgsVXVJYO7dxqPvIQjJYI+E=;
        b=YPmd/re+tkrNWlb7tAo6T+KZk7McatzYCsBvvxl0Swcobh8cNFNj+erEVCxrLQQI5e
         hFg81+O7BzPmgVEqnUrG3bSkZztGXvi6IigOqHV8lm7fsYoKxhbvvR4y2iMN5yXGUY5E
         QbOUUH4OgN2EUAeguSBmrnS7rsB6zq8clWR/JEfpaxIF388wBhIft//2bhocEHl9+qpC
         r2OMYVH18IeqcFrJwVEOTsJdHEz6NaVBuMlGW8o1PRQqVsHvHQjsuD4Hxh3bn7ybJ04x
         HgeFj/LoDVVlVpT8kjpjj7XZUboWifGc8V/20UMtzj6lLQSkC0XOz+lJy4Pa7BxXE2hE
         hCog==
X-Gm-Message-State: AA+aEWZJ6Eek/b5eLOPrWJhDF8aDMgoDjq9/xx7EdBW2/51la0IZf+BZ
        6vQToUYghMW4coEz14me8DG+Ib7EjWsXCZ0nU7aINcZnYu4x
X-Google-Smtp-Source: AJdET5fi0Mpih58sNZ0CyK8gV4SDBKIPFR1AVnpl0/OTlLj+fItM67Impn+dYfRpZmqcCzODPtGxyY2VYhejB9qcJ6WEuhleYoAk
MIME-Version: 1.0
X-Received: by 2002:a24:5fc6:: with SMTP id r189-v6mr508230itb.28.1542419943160;
 Fri, 16 Nov 2018 17:59:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:59:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce83ad057ad2a0f4@google.com>
Subject: KASAN: use-after-free Read in sctp_epaddr_lookup_transport
From:   syzbot <syzbot+aad231d51b1923158444@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a97b95653383 drivers/net/ethernet/qlogic/qed/qed_rdma.h: f..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1217d26d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=aad231d51b1923158444
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b5bb0b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aad231d51b1923158444@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in sctp_epaddr_lookup_transport+0xacb/0xb20  
net/sctp/input.c:971
Read of size 8 at addr ffff8881cde426b0 by task syz-executor3/18110

CPU: 1 PID: 18110 Comm: syz-executor3 Not tainted 4.20.0-rc2+ #187
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  sctp_epaddr_lookup_transport+0xacb/0xb20 net/sctp/input.c:971
  sctp_endpoint_lookup_assoc+0xe0/0x290 net/sctp/endpointola.c:338
  sctp_addr_id2transport+0x1f8/0x370 net/sctp/socket.c:279
  sctp_getsockopt_peer_addr_params+0x17c/0x1260 net/sctp/socket.c:5613
  sctp_getsockopt+0x44f9/0x7d32 net/sctp/socket.c:7462
  sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:2937
  __sys_getsockopt+0x1ad/0x390 net/socket.c:1939
  __do_sys_getsockopt net/socket.c:1950 [inline]
  __se_sys_getsockopt net/socket.c:1947 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1947
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f177b561c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 0000000000000009 RSI: 0000000000000084 RDI: 0000000000000006
RBP: 000000000072c180 R08: 000000002044fffc R09: 0000000000000000
R10: 0000000020a68000 R11: 0000000000000246 R12: 00007f177b5626d4
R13: 00000000004c8318 R14: 00000000004ce200 R15: 00000000ffffffff

Allocated by task 18068:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  sctp_association_new+0x14e/0x2290 net/sctp/associola.c:311
  sctp_sendmsg_new_asoc+0x39c/0x11f0 net/sctp/socket.c:1723
  sctp_sendmsg+0x18a5/0x1da0 net/sctp/socket.c:2086
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 18110:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  sctp_association_destroy net/sctp/associola.c:437 [inline]
  sctp_association_put+0x264/0x350 net/sctp/associola.c:889
  sctp_transport_destroy net/sctp/transport.c:180 [inline]
  sctp_transport_put+0x186/0x1f0 net/sctp/transport.c:340
  sctp_hash_cmp+0x1ef/0x260 net/sctp/input.c:825
  __rhashtable_lookup include/linux/rhashtable.h:483 [inline]
  rhltable_lookup include/linux/rhashtable.h:566 [inline]
  sctp_epaddr_lookup_transport+0x4fe/0xb20 net/sctp/input.c:967
  sctp_endpoint_lookup_assoc+0xe0/0x290 net/sctp/endpointola.c:338
  sctp_addr_id2transport+0x1f8/0x370 net/sctp/socket.c:279
  sctp_getsockopt_peer_addr_params+0x17c/0x1260 net/sctp/socket.c:5613
  sctp_getsockopt+0x44f9/0x7d32 net/sctp/socket.c:7462
  sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:2937
  __sys_getsockopt+0x1ad/0x390 net/socket.c:1939
  __do_sys_getsockopt net/socket.c:1950 [inline]
  __se_sys_getsockopt net/socket.c:1947 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1947
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cde42600
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 176 bytes inside of
  4096-byte region [ffff8881cde42600, ffff8881cde43600)
The buggy address belongs to the page:
page:ffffea0007379080 count:1 mapcount:0 mapping:ffff8881da800dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0007379008 ffffea0007377f08 ffff8881da800dc0
raw: 0000000000000000 ffff8881cde42600 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cde42580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881cde42600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881cde42680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881cde42700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cde42780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
kobject: 'loop5' (00000000f0e4ffac): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
