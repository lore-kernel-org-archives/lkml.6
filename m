Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B044C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92932151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92932151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeIZV5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:57:36 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:58635 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeIZV5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:57:36 -0400
Received: by mail-it1-f200.google.com with SMTP id d194-v6so3789571itb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TQJLVzgnyMsensxVEyerg63hILZyTk6dmDoI5UGc2Z0=;
        b=DAtYubfur88s8BAgHDmoiNJyey4stwNYKyYR9f7rmj8tiSQHY60mWcRXvjTEDeYHdZ
         u9MokzDW7fu3Kxe64mL6wBWn7yy0K3g3JPrKa1vf1fIPx4PPQzKx8GXAvGx5MCL9dR4c
         E1pMqCcjBUBNqWGGdFqSYPLtZ61qxBGot6K+QVIEcH9rc8jusUw9RLihxFyZ/xPiml0M
         MuTbdUMTtfZrwa3/kwskMs10DDBuRa+Tu7k1h58pNxbYZFmFv+/QwGiEUocUaFyhJYWF
         /l37FEa2OV2rMcYnxh/LnlykifReSazVbgR6fZTUo8K6p2C2kef6seeDxc8BBlGlMpOo
         3P5Q==
X-Gm-Message-State: ABuFfog5ZoGb0pWGeoN0BzWJ/Gs8/jbVzGaMXZjmjzcMD5sYLr7dA7cY
        Af6LuQOdra5Z8diDElfGh+gZzXdOn8+xP6zn7XLFtPgunqqo
X-Google-Smtp-Source: ACcGV62KC9ig5arQTYpmFQt6GJ9jhs+CuFQSxJu9BV9a9M5DDbs3Prg99b0wtZ9iNTmcxjlH6jQyyhNYDpCsdhUeYykTjGAZtGQt
MIME-Version: 1.0
X-Received: by 2002:a6b:8d94:: with SMTP id p142-v6mr4467964iod.25.1537976643671;
 Wed, 26 Sep 2018 08:44:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 08:44:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084e2450576c817cc@google.com>
Subject: KASAN: use-after-free Read in tcf_block_find
From:   syzbot <syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f763fa400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
dashboard link: https://syzkaller.appspot.com/bug?extid=37b8770e6d5a8220a039
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5614e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a532a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in tcf_block_find+0x9d1/0xb90  
net/sched/cls_api.c:646
Read of size 4 at addr ffff8801cc126978 by task syz-executor002/5646

CPU: 1 PID: 5646 Comm: syz-executor002 Not tainted 4.19.0-rc5+ #232
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  tcf_block_find+0x9d1/0xb90 net/sched/cls_api.c:646
  tc_new_tfilter+0x497/0x1d20 net/sched/cls_api.c:1331
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4730
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2447
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4748
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441979
Code: e8 0c ac 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 04 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd8b1e9178 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441979
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000009641 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000001bb6880 R11: 0000000000000213 R12: 0000000000000000
R13: 0000000000402390 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5522:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:555 [inline]
  kzalloc_node include/linux/slab.h:718 [inline]
  qdisc_alloc+0x10f/0xb50 net/sched/sch_generic.c:820
  qdisc_create_dflt+0x7a/0x1e0 net/sched/sch_generic.c:894
  attach_one_default_qdisc net/sched/sch_generic.c:1041 [inline]
  netdev_for_each_tx_queue include/linux/netdevice.h:2114 [inline]
  attach_default_qdiscs net/sched/sch_generic.c:1060 [inline]
  dev_activate+0x82f/0xcb0 net/sched/sch_generic.c:1103
  __dev_open+0x2cb/0x410 net/core/dev.c:1400
  __dev_change_flags+0x730/0x9b0 net/core/dev.c:7448
  dev_change_flags+0x89/0x150 net/core/dev.c:7517
  do_setlink+0xb5f/0x3f20 net/core/rtnetlink.c:2441
  rtnl_newlink+0x136f/0x1d40 net/core/rtnetlink.c:3054
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4730
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2447
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4748
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  qdisc_free+0x89/0x100 net/sched/sch_generic.c:941
  qdisc_free_cb+0x19/0x20 net/sched/sch_generic.c:948
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801cc126940
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 56 bytes inside of
  1024-byte region [ffff8801cc126940, ffff8801cc126d40)
The buggy address belongs to the page:
page:ffffea0007304980 count:1 mapcount:0 mapping:ffff8801da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007304808 ffffea0007302788 ffff8801da800ac0
raw: 0000000000000000 ffff8801cc126040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801cc126800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801cc126880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801cc126900: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8801cc126980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801cc126a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
