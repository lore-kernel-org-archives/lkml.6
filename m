Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C609C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C663E20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C663E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLJFlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:41:08 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:38298 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeLJFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:41:07 -0500
Received: by mail-it1-f199.google.com with SMTP id m128so13387063itd.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IHciyAKqNYZA9WZXjXs18kRU2ZKm1Icu6KMY+AEzbJA=;
        b=TeEPqvJmVDhXZfewFt5gjCzG9HGqDX9p8Z9XYiMr6aUKmC/i+RRM4QSUycCP3XdsZR
         WEOdASOyRFdF7XoHrmFe+5gc002MSxnX2Ip8f4zn6w3g4iDblMHwgCIesW8JYWW+WdEu
         IBBE2bMpgdvAE2VsA/OrdWBWJ+OsZ3H+pjvgGV4/uYFVZ8Zw1FpNHUMPuPgPWfRjmlac
         bt1eoIN915ILtaRLzzKP8eNNNwJaIEcX3xud1svTUHosYNdpKfVyRotwsLS67km6eTsQ
         jFMEV3kZdsyB4TPR6g40mJE4s8402iPOEXfGdw617EnwjYtDlNqp+ZAbtQdwkD7u+i1r
         MS3w==
X-Gm-Message-State: AA+aEWYBvqnYwvrudLBIPFrwil5wOD0muZ9OYEy7OCMXYKJ7Pp8JsEf6
        U7d9AV9sIgFFuL2VwjO7dS4XQBQ0Q8RHWJfidhLNlZHjFnK5
X-Google-Smtp-Source: AFSGD/Ui54j9967TYNe2oquE5R5aJ4GkO2kjNeuRGagmutnHZlkD/MvxJ7RrbFLq9ICLkS8bqENdjmUcRhC6zagA9RFrrVo+3YEq
MIME-Version: 1.0
X-Received: by 2002:a6b:f912:: with SMTP id j18mr8368642iog.36.1544420465586;
 Sun, 09 Dec 2018 21:41:05 -0800 (PST)
Date:   Sun, 09 Dec 2018 21:41:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c3d8a057ca46927@google.com>
Subject: KASAN: use-after-free Read in neigh_mark_dead
From:   syzbot <syzbot+35e87b87c00f386b041f@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a60956ed72f7 net: dsa: Make dsa_master_set_mtu() static
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14df67eb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=35e87b87c00f386b041f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1444565d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123832db400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35e87b87c00f386b041f@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100  
lib/list_debug.c:51
Read of size 8 at addr ffff8881bb7394b0 by task ip/7510

CPU: 0 PID: 7510 Comm: ip Not tainted 4.20.0-rc4+ #335
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  neigh_mark_dead+0x13b/0x410 net/core/neighbour.c:125
  neigh_flush_dev+0x3a1/0x960 net/core/neighbour.c:290
  neigh_changeaddr+0x31/0x40 net/core/neighbour.c:319
  ndisc_netdev_event+0xe6/0x5b0 net/ipv6/ndisc.c:1770
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1737
  call_netdevice_notifiers_extack net/core/dev.c:1749 [inline]
  call_netdevice_notifiers net/core/dev.c:1763 [inline]
  dev_set_mac_address+0x293/0x3b0 net/core/dev.c:7775
  do_setlink+0x7c7/0x3f30 net/core/rtnetlink.c:2447
  __rtnl_newlink+0xcde/0x19e0 net/core/rtnetlink.c:3115
  rtnl_newlink+0x6b/0xa0 net/core/rtnetlink.c:3240
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4966
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4984
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f1baeb6e320
Code: 02 48 83 c8 ff eb 8d 48 8b 05 14 7b 2a 00 f7 da 64 89 10 48 83 c8 ff  
eb c9 90 83 3d d5 d2 2a 00 00 75 10 b8 2e 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 5e ba 00 00 48 89 04 24
RSP: 002b:00007fff37bc5c58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff37bc9d50 RCX: 00007f1baeb6e320
RDX: 0000000000000000 RSI: 00007fff37bc5c90 RDI: 0000000000000003
RBP: 00007fff37bc5c90 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000000 R11: 0000000000000246 R12: 000000005c0d8897
R13: 0000000000000000 R14: 00000000006395c0 R15: 00007fff37bca530

Allocated by task 22:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc+0x15b/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  neigh_alloc net/core/neighbour.c:375 [inline]
  ___neigh_create+0x13fc/0x2600 net/core/neighbour.c:553
  __neigh_create+0x30/0x40 net/core/neighbour.c:640
  ip6_finish_output2+0xa59/0x27a0 net/ipv6/ip6_output.c:117
  ip6_finish_output+0x58c/0xc60 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x232/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ndisc_send_skb+0x1005/0x1560 net/ipv6/ndisc.c:491
  ndisc_send_ns+0x3c6/0x8e0 net/ipv6/ndisc.c:633
  addrconf_dad_work+0xbf2/0x1310 net/ipv6/addrconf.c:4081
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 9:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  __rcu_reclaim kernel/rcu/rcu.h:233 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x1140/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881bb739240
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 624 bytes inside of
  1024-byte region [ffff8881bb739240, ffff8881bb739640)
The buggy address belongs to the page:
page:ffffea0006edce00 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006eb2d88 ffffea0006eea708 ffff8881da800ac0
raw: 0000000000000000 ffff8881bb738040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881bb739380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881bb739400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881bb739480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881bb739500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881bb739580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
