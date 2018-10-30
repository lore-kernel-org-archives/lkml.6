Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02B220823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02B220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJaBML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:12:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49074 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeJaBML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:12:11 -0400
Received: by mail-io1-f70.google.com with SMTP id c17-v6so11376702ioi.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/5EgYZgd1afPwZpeHSzKiYj8R4yFQR5C9ygU+fqJtdE=;
        b=iyWAJE8CYWTullqariIYcCMR+Mgs2HxgICPGLFW9xKM9W1q5kjgQNdko/HqrQmEV6y
         0fNeUmyX4l7N0JEcNwaZA9FaBZdLI9Pe2ALjDEI5qy2PIEZJY+OGX9ZPfjUuYKojhyct
         CzBeH/PMJfRb19+xmHmAKX9qfKR93m1OJSC5bDV6WojIvXDVdIpWqrrFBFuSEy0CUQYT
         OtQSzHKVYGGOeZerrFmFRrc4e8/GDDViUu4iNIpxK278ElG6yk/7uDC8dMmRtEvL+DP1
         dve4j7CYSgWR1G+zjGV2YLGG4lbfY0c4hQIzg2PkPx11XgWTe06VkeIyySSDlWKCwC/1
         R+LA==
X-Gm-Message-State: AGRZ1gJnZ/yf8W473D6BYZ7ADcgVxCKjvWr5KH6qHhZm2RIW50KHu7Xj
        U+KlowLLz8n+xawCr/6lD1kmYwpBgS/nzor4obqSYA9aLH6P
X-Google-Smtp-Source: AJdET5cqN5O7XWCvGTymhPoSHGcR3EDu2f8igFksecBIMAdUDRec1mr2B/C14s2Y5e1Ix0mFpmEAUQsPileoWPOYOMKR2kb2qLAS
MIME-Version: 1.0
X-Received: by 2002:a24:68c7:: with SMTP id v190-v6mr12385321itb.12.1540916283585;
 Tue, 30 Oct 2018 09:18:03 -0700 (PDT)
Date:   Tue, 30 Oct 2018 09:18:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b641b70579748761@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_bearer_enable
From:   syzbot <syzbot+b33d5cae0efd35dbfe77@syzkaller.appspotmail.com>
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

HEAD commit:    4bb25354f0b0 kmsan: unpoison pt_regs in do_nmi()
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=107556e5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36c582b1a617b1e6
dashboard link: https://syzkaller.appspot.com/bug?extid=b33d5cae0efd35dbfe77
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c2e95b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129a919d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b33d5cae0efd35dbfe77@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:484
CPU: 1 PID: 6371 Comm: syz-executor652 Not tainted 4.19.0-rc8+ #70
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x306/0x460 lib/dump_stack.c:113
  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
  __msan_warning+0x7c/0xe0 mm/kmsan/kmsan_instr.c:500
  strlen+0x3b/0xa0 lib/string.c:484
  nla_put_string include/net/netlink.h:1011 [inline]
  tipc_nl_compat_bearer_enable+0x238/0x7b0 net/tipc/netlink_compat.c:389
  __tipc_nl_compat_doit net/tipc/netlink_compat.c:311 [inline]
  tipc_nl_compat_doit+0x39f/0xae0 net/tipc/netlink_compat.c:344
  tipc_nl_compat_recv+0x147c/0x2760 net/tipc/netlink_compat.c:1107
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185c/0x1a20 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x394/0x640 net/netlink/af_netlink.c:2454
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x166d/0x1720 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0x1391/0x1420 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe47/0x1200 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440179
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffef7beee8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440179
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401a00
R13: 0000000000401a90 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
  kmsan_internal_poison_shadow+0xc8/0x1d0 mm/kmsan/kmsan.c:180
  kmsan_kmalloc+0xa4/0x120 mm/kmsan/kmsan_hooks.c:104
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:113
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2727 [inline]
  __kmalloc_node_track_caller+0xb43/0x1400 mm/slub.c:4360
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x422/0xe90 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
  netlink_sendmsg+0xcaf/0x1420 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe47/0x1200 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
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
