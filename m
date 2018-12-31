Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE485C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890072133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeLaJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:41:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:41701 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLaJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 04:41:04 -0500
Received: by mail-it1-f198.google.com with SMTP id 123so31469748itv.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 01:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=67oQS8UTKcUlR5cuhOisrUkyIqeQCXTfj+rLc+EJugE=;
        b=AexrZ3cKUDNCNsSEEBqLuI4J+Yh1pJdC9PHgY76jbiASrK3EVhQnwckb03grraJ/xQ
         SF5vAsCBX30mGsv2DAHklqf6Hd1ikyGYi5htAmRBg92Ve/BkvhPhVsJz0C9+ZFhKw/Wa
         1sVa5PGBRGxZ5c/47Ea2g/946hyWafHhPiaUeiFRjCov++vsjAsDc2vGSrxWLlGO2BEN
         i1z0ONKo7EeXpJ6U+YHDzr3KyzcOmoCYaEuzNa96AmO7pFuZkwdd68WYgop6gWOpjP/I
         +xqCYJYauO7nahW5UOryjjT3qgvPm+7lsfLNgG3udXN8V2eaYdcj3FHnycYqmzAClBoo
         P5eg==
X-Gm-Message-State: AJcUukckY0KZl9PkmJmdnJSYFPvvMd/3bg8ot9k41xW1576smROmzVMe
        aSn9NeNBYNnf/1HwuSO6Sc1Aff+2mW5/0kQF6pEL6JFqZXNK
X-Google-Smtp-Source: ALg8bN5fc7FiFkv8VXRu7B6PgRS542/dqcnzw7R8DlzLKu2v4q9L2eAA0ld323W3cx5SZ33yMoVFfLiHjpPMfs+izYV/9qoIEMtC
MIME-Version: 1.0
X-Received: by 2002:a5d:9a0b:: with SMTP id s11mr35137818iol.5.1546249263054;
 Mon, 31 Dec 2018 01:41:03 -0800 (PST)
Date:   Mon, 31 Dec 2018 01:41:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f098d057e4e3662@google.com>
Subject: KASAN: slab-out-of-bounds Read in batadv_interface_tx
From:   syzbot <syzbot+9d7405c7faa390e60b4e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f346b0becb1b Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f0bbdd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c255c77ba370fe7c
dashboard link: https://syzkaller.appspot.com/bug?extid=9d7405c7faa390e60b4e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c3eabf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164bfbfb400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d7405c7faa390e60b4e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
==================================================================
BUG: KASAN: slab-out-of-bounds in batadv_interface_tx+0x160a/0x18b0  
net/batman-adv/soft-interface.c:226
Read of size 2 at addr ffff8880a662f5cb by task syz-executor922/8142

CPU: 0 PID: 8142 Comm: syz-executor922 Not tainted 4.20.0+ #173
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.5+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.6+0x1b/0x39 mm/kasan/report.c:317
  __asan_report_load_n_noabort+0xf/0x20 mm/kasan/generic_report.c:145
  batadv_interface_tx+0x160a/0x18b0 net/batman-adv/soft-interface.c:226
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  dev_direct_xmit+0x36c/0x6a0 net/core/dev.c:3930
  packet_direct_xmit+0xfb/0x170 net/packet/af_packet.c:246
  packet_snd net/packet/af_packet.c:2932 [inline]
  packet_sendmsg+0x298a/0x6ad0 net/packet/af_packet.c:2957
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441619
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 0b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd5c9334f8 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441619
RDX: 000000000000000e RSI: 0000000020000180 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004025e0
R13: 0000000000402670 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8184:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  kasan_slab_alloc+0x12/0x20 mm/kasan/common.c:397
  kmem_cache_alloc+0x130/0x730 mm/slab.c:3541
  getname_flags+0xd0/0x590 fs/namei.c:140
  getname+0x19/0x20 fs/namei.c:211
  do_sys_open+0x383/0x780 fs/open.c:1057
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8184:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3747
  putname+0xf2/0x130 fs/namei.c:261
  do_sys_open+0x54d/0x780 fs/open.c:1072
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a662e5c0
  which belongs to the cache names_cache of size 4096
The buggy address is located 11 bytes to the right of
  4096-byte region [ffff8880a662e5c0, ffff8880a662f5c0)
The buggy address belongs to the page:
page:ffffea0002998b80 count:1 mapcount:0 mapping:ffff88821bc48200 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00029fa208 ffffea00022fd188 ffff88821bc48200
raw: 0000000000000000 ffff8880a662e5c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a662f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a662f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a662f580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                               ^
  ffff8880a662f600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a662f680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
