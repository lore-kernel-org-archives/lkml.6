Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1AFC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8257D215E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8257D215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeHSDTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 23:19:31 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:57965 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHSDTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 23:19:31 -0400
Received: by mail-it0-f72.google.com with SMTP id e6-v6so11007226itc.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 17:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7NmKw4ZH2MdvT+nnK0T+rWFkcik/kAMH8k4tSF5CWuc=;
        b=WsE3WvGYEO7vghO9oZNjCE0NYiFYyel8dZgVqAmFltbUcFJfqahUsvt6DXnUqUSwx9
         dO4k1e0k0js+SBee1/1F971uucToTUojNjUdKRxBGTCU5o1wntJuz3DBnWVfryQ4zD16
         c2XoT9zdco66QEkVVMdff3BZbeF4w4o0r7p0OzUumdtWh4Vzt4+bMC7SQptMhrBLKWDT
         AKf+Ja5Yx/4kSW9F1Ggsh2e42fe2rHqOaMcoBeOzT8l9T1iXERWsYOf8LanFxUMqGmgQ
         kPsCzvSQ8naE92fhP6c/AraHDbYR1Lgami9815QL79/wxjRhX1Mrtj4sL4g0LRWHwDh/
         x31Q==
X-Gm-Message-State: AOUpUlF1qq1yD/NrYhBdXGpTJO1gXzUfgUhVz78ELev3jgGHPdwTAiBa
        uIWM5d0WhqtTm6J7vAKYxUxNUSY0D6kgveYvX1AV9w3YZLar
X-Google-Smtp-Source: AA+uWPxTlKcUdrOqCKJPTIGsCp8gr5cURiGWww3SkiTT4uKdzejrLiVQoxV8uEZB86ucePqtKiROXr2y3+h5RKUSalUWIMV5ZAtJ
MIME-Version: 1.0
X-Received: by 2002:a6b:6509:: with SMTP id z9-v6mr18288580iob.20.1534637402276;
 Sat, 18 Aug 2018 17:10:02 -0700 (PDT)
Date:   Sat, 18 Aug 2018 17:10:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038cc590573be9db2@google.com>
Subject: KASAN: use-after-free Read in tipc_group_fill_sock_diag
From:   syzbot <syzbot+b9c8f3ab2994b7cd1625@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a18d783fedfe Merge tag 'driver-core-4.19-rc1' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bcc936400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7eeabb17332898c0
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c8f3ab2994b7cd1625
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1374ec4a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b9c8f3ab2994b7cd1625@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in tipc_group_fill_sock_diag+0x7b9/0x84b  
net/tipc/group.c:921
Read of size 4 at addr ffff8801ceb5565c by task syz-executor0/4838

CPU: 1 PID: 4838 Comm: syz-executor0 Not tainted 4.18.0+ #196
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  tipc_group_fill_sock_diag+0x7b9/0x84b net/tipc/group.c:921
  tipc_sk_fill_sock_diag+0x9f8/0xdb0 net/tipc/socket.c:3322
  __tipc_add_sock_diag+0x22f/0x360 net/tipc/diag.c:62
  tipc_nl_sk_walk+0x68d/0xd30 net/tipc/socket.c:3249
  tipc_diag_dump+0x24/0x30 net/tipc/diag.c:73
  netlink_dump+0x519/0xd50 net/netlink/af_netlink.c:2233
  __netlink_dump_start+0x4f1/0x6f0 net/netlink/af_netlink.c:2329
  netlink_dump_start include/linux/netlink.h:213 [inline]
  tipc_sock_diag_handler_dump+0x234/0x340 net/tipc/diag.c:89
  __sock_diag_cmd net/core/sock_diag.c:232 [inline]
  sock_diag_rcv_msg+0x31d/0x410 net/core/sock_diag.c:263
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:274
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
  __sys_sendmsg+0x11d/0x290 net/socket.c:2152
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg net/socket.c:2159 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3a5d506c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3a5d5076d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4088 R14: 00000000004c8ab0 R15: 0000000000000000

Allocated by task 4838:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  tipc_group_create+0x155/0xa70 net/tipc/group.c:171
  tipc_sk_join net/tipc/socket.c:2766 [inline]
  tipc_setsockopt+0x2d1/0xd70 net/tipc/socket.c:2881
  __sys_setsockopt+0x1c5/0x3b0 net/socket.c:1900
  __do_sys_setsockopt net/socket.c:1911 [inline]
  __se_sys_setsockopt net/socket.c:1908 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1908
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4837:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  tipc_group_delete+0x2e5/0x3f0 net/tipc/group.c:227
  tipc_sk_leave+0x113/0x220 net/tipc/socket.c:2800
  tipc_release+0x14e/0x12b0 net/tipc/socket.c:574
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1139
  __fput+0x39b/0x860 fs/file_table.c:251
  ____fput+0x15/0x20 fs/file_table.c:282
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ceb55600
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 92 bytes inside of
  192-byte region [ffff8801ceb55600, ffff8801ceb556c0)
The buggy address belongs to the page:
page:ffffea00073ad540 count:1 mapcount:0 mapping:ffff8801dac00040 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00073a5088 ffffea00073ae5c8 ffff8801dac00040
raw: 0000000000000000 ffff8801ceb55000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ceb55500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801ceb55580: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801ceb55600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff8801ceb55680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801ceb55700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
