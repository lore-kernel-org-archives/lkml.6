Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790A020675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbeLQGLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:11:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:36687 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeLQGLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:11:05 -0500
Received: by mail-it1-f198.google.com with SMTP id w15so13671829ita.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 22:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=01U/LF311mWZssaBbn/CHWgwSI+6MeZvbvE2JoBQxho=;
        b=oQbi5LI68SHMshe1AzE/tuv2+05EvIwhm/iCEktT6c6xg6KOSaKUp0QiKmzrkVMl8b
         2s+Qp+EvT+iv/b1N0y/4CA7iDFtUBeYFCxNqavm13XyF9T/q8H1NZPTIpXFlkS2PqEzr
         EBXNN2l680tMwgSpjS40+fWht79ZK3tx5CFUZvZTeV7Ia5b47T0Q7mmBSwqZqQuFULYp
         GRclhKJB87N0G9uK5ynIwynwrobkRiP4bKU7MeHxj6PCdy1XYJysnaEFaeZvuTVeZVpA
         /YjpOODFtYFesNjDvAJWQqfRlfBMPeod/3EZIQr9bHutQoqPkxufT0Is2+8iQS6qm4Ku
         /9tw==
X-Gm-Message-State: AA+aEWYCwF0b3TM/KdoLGEXOMoPaDNMwr9CYsT2+e/7Khjru+qFwUeur
        wArsHu8GuuI2OjYGuYzenG2qZ1rqmQU7ZduldZ/YLd3zZQKI
X-Google-Smtp-Source: AFSGD/VV7/FQBh107esSJvMWJ7ASKP3lY9gM4T6Frh4kPt+PspQqQhRqVBEnQIG+jrTVWfk66wB2dxY0qOmkQ3tnRtlbIjtePg69
MIME-Version: 1.0
X-Received: by 2002:a02:3b6e:: with SMTP id i46mr10373599jaf.16.1545027064457;
 Sun, 16 Dec 2018 22:11:04 -0800 (PST)
Date:   Sun, 16 Dec 2018 22:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005870ab057d31a591@google.com>
Subject: KASAN: use-after-free Read in tipc_mcast_xmit
From:   syzbot <syzbot+99f20222fc5018d2b97a@syzkaller.appspotmail.com>
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

HEAD commit:    8203e2d844d3 net: clear skb->tstamp in forwarding paths
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17d37c1b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=99f20222fc5018d2b97a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d7c943400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+99f20222fc5018d2b97a@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in tipc_mcast_xmit+0xb77/0xdb0  
net/tipc/bcast.c:305
Read of size 1 at addr ffff8881d219454e by task syz-executor0/6307

CPU: 0 PID: 6307 Comm: syz-executor0 Not tainted 4.20.0-rc6+ #234
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  tipc_mcast_xmit+0xb77/0xdb0 net/tipc/bcast.c:305
  tipc_send_group_bcast+0xa5f/0xdf0 net/tipc/socket.c:1054
  __tipc_sendmsg+0xeec/0x1d40 net/tipc/socket.c:1310
  tipc_sendmsg+0x50/0x70 net/tipc/socket.c:1275
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbfc19b2c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbfc19b36d4
R13: 00000000004c44bd R14: 00000000004d74a8 R15: 00000000ffffffff

Allocated by task 6307:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  tipc_group_create+0x152/0xa70 net/tipc/group.c:171
  tipc_sk_join net/tipc/socket.c:2836 [inline]
  tipc_setsockopt+0x2d1/0xd70 net/tipc/socket.c:2951
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6308:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  tipc_group_delete+0x2e4/0x3f0 net/tipc/group.c:227
  tipc_sk_leave+0x113/0x220 net/tipc/socket.c:2870
  tipc_setsockopt+0x97d/0xd70 net/tipc/socket.c:2954
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d2194500
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 78 bytes inside of
  192-byte region [ffff8881d2194500, ffff8881d21945c0)
The buggy address belongs to the page:
page:ffffea0007486500 count:1 mapcount:0 mapping:ffff8881da800040 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea00074e6dc8 ffffea000748fa88 ffff8881da800040
raw: 0000000000000000 ffff8881d2194000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d2194400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d2194480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881d2194500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff8881d2194580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881d2194600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
