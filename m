Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C39C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F121534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562F121534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeIUCje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:39:34 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48734 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388456AbeIUCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:39:27 -0400
Received: by mail-io1-f72.google.com with SMTP id n26-v6so14715062iog.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y5B7idGfCL5Gvg/CLqpjuDPHwkJUl4W+oGREOmCXCLU=;
        b=oqCLV4ZR8FPQbQX0DjeB5aUAVXcfXR2E9e4DtG/ZDNntFsOrQN0pyrERLjcY3XLe5b
         DFL4vaX4uR/lHThdvoU6NyxV2l3oOzICyumL4yeYyAgxK6DgGk9wA/WT5UxL+HyHCQso
         1ROmJhWxHHeKlDO89cW7rm0vmgReqmob59lIHrsrYNFYhRKzdQl1AsAQ5DcOBvSKbNUm
         m7RnZW9RG1PEeAkfxf69YbxGV1DqP01TZMa0n3VbXsggJmrkffqMcjxEH0Rwec/kElXv
         FYYKlRDkmMakiy4K4CyGM9VOwr2psuI3CvKKolNj4JwmFRHAEX/zyW8duJzVQhILFcze
         sYgQ==
X-Gm-Message-State: APzg51BnBnAbhVV6dFwTzBxyzDQQoLAdG4ezxYqqn45mHAwvHqWTa/Cg
        UKQsD056aepsTTZ0L4w+vTswO6p3NtOOPrx9lbdBzTnVgHa3
X-Google-Smtp-Source: ANB0VdbhF3I/5ATLi8GsnaMJTTdDTyFIqgVhX/YDnxdGGSKRCIWK32ZW7E7EdZSDDGoptXNhMMZ5GCHo3/OorRC/qZe0T5Qs9bLS
MIME-Version: 1.0
X-Received: by 2002:a6b:ce10:: with SMTP id p16-v6mr30530570iob.74.1537476845274;
 Thu, 20 Sep 2018 13:54:05 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:54:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000368ca9057653b99a@google.com>
Subject: KMSAN: uninit-value in dev_uc_add_excl
From:   syzbot <syzbot+3a288d5f5530b901310e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sunlw.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    99e79f6a8963 kmsan: disable assembly implementations of cr..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=14ccc911400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc53c800f40430e5
dashboard link: https://syzkaller.appspot.com/bug?extid=3a288d5f5530b901310e
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178141fa400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113d1efa400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3a288d5f5530b901310e@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
CPU: 1 PID: 4318 Comm: syz-executor998 Not tainted 4.19.0-rc3+ #49
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  memcmp+0x11d/0x180 lib/string.c:863
  dev_uc_add_excl+0x165/0x7b0 net/core/dev_addr_lists.c:464
  ndo_dflt_fdb_add net/core/rtnetlink.c:3463 [inline]
  rtnl_fdb_add+0x1081/0x1270 net/core/rtnetlink.c:3558
  rtnetlink_rcv_msg+0xa0b/0x1530 net/core/rtnetlink.c:4715
  netlink_rcv_skb+0x36e/0x5f0 net/netlink/af_netlink.c:2454
  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4733
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x1638/0x1720 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0x1205/0x1290 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440ee9
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff6a93b518 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ee9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 000000000000b4b0
R13: 0000000000401ec0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2718 [inline]
  __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4351
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
  netlink_sendmsg+0xb49/0x1290 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
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
