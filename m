Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E185ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685D208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2685D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIPQZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 12:25:37 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40798 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeIPQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 12:25:37 -0400
Received: by mail-io1-f69.google.com with SMTP id p22-v6so14648125ioh.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 04:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y22/O0w76yKTL5vOfBgmATjT+bB2RUyOBV1gMPdb3gc=;
        b=eYQiY0nZ7+XPTGorYAApFPoVKkxmNPsZtJO+fvhv7QG1swyu53fLn+FkmA+jiapElR
         WgprNLnvt/JVTaWHWieN9mW5A6tc35Hub6g/8DMXvJHx1+cGKCjy81qPlMZX5AuVDNKg
         +qNXFJc+V8V/0sKo8sBuVhyDfeGD8miH5rTmDbjRDqq8N1bCb237S0YC5h2w+gO12mSW
         7a2YIsB6DGbdIU3BT6WAyFqngOCqlDKZGe3JbfjaTNmjrssi2i6JPZ9jm/AdnN/J0u7o
         vnJTmyr6jwombwC8Wn9qoScoi3oo2hPdN1Up3oYVT3a2mZ3EDQxk6d07jNElanTln48Y
         RnpA==
X-Gm-Message-State: APzg51DwwyUYUNA7r4pNaAeETzmLl6XL7+Usb4kj6b1ry9X1so+8Mxix
        88RW9vlSMUc7eH+XbhyccD6Nph/pfihyYKV1CLGglZiBVvpI
X-Google-Smtp-Source: ANB0VdZQBZQamuUUFEVhrihdZS+kP4e5uQHPYHGl9qBQdx2fPaewWNQrGhqkGanQCRzzF9zYDN13stYlcqQxGUpjvKRVfvtrDYRM
MIME-Version: 1.0
X-Received: by 2002:a6b:f116:: with SMTP id e22-v6mr15686116iog.50.1537095783148;
 Sun, 16 Sep 2018 04:03:03 -0700 (PDT)
Date:   Sun, 16 Sep 2018 04:03:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002407700575fb00f4@google.com>
Subject: KMSAN: uninit-value in ip_rcv_core
From:   syzbot <syzbot+2e406a9ac75bb71d4b7a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    42a037ca8d9d kmsan: update README.md to reference LLVM r34..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1089adea400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3431f03869413153
dashboard link: https://syzkaller.appspot.com/bug?extid=2e406a9ac75bb71d4b7a
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d6d421400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fdeb7a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e406a9ac75bb71d4b7a@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in ip_rcv_core+0xabd/0x1160 net/ipv4/ip_input.c:464
CPU: 1 PID: 4270 Comm: syz-executor158 Not tainted 4.19.0-rc1+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  ip_rcv_core+0xabd/0x1160 net/ipv4/ip_input.c:464
  ip_rcv+0xbb/0x6d0 net/ipv4/ip_input.c:521
  __netif_receive_skb_one_core net/core/dev.c:4892 [inline]
  __netif_receive_skb net/core/dev.c:5002 [inline]
  process_backlog+0x752/0x10b0 net/core/dev.c:5808
  napi_poll net/core/dev.c:6228 [inline]
  net_rx_action+0x723/0x19d0 net/core/dev.c:6294
  __do_softirq+0x562/0x948 kernel/softirq.c:292
  do_softirq_own_stack+0x49/0x80 arch/x86/entry/entry_64.S:1055
  </IRQ>
  do_softirq kernel/softirq.c:336 [inline]
  __local_bh_enable_ip+0x119/0x150 kernel/softirq.c:189
  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
  rcu_read_unlock_bh include/linux/rcupdate.h:723 [inline]
  __dev_queue_xmit+0x35a8/0x3ab0 net/core/dev.c:3830
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3836
  packet_snd net/packet/af_packet.c:2925 [inline]
  packet_sendmsg+0x80ff/0x8c60 net/packet/af_packet.c:2950
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441149
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffebf721a18 EFLAGS: 00000286 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441149
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000100 R09: 0000000000000100
R10: 0000000000000100 R11: 0000000000000286 R12: 00000000004020b0
R13: 0000000000402140 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:271 [inline]
  kmsan_internal_chain_origin+0x128/0x210 mm/kmsan/kmsan.c:573
  __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:482
  iptunnel_xmit+0xa3c/0xd50 net/ipv4/ip_tunnel_core.c:85
  ip_tunnel_xmit+0x33e1/0x3750 net/ipv4/ip_tunnel.c:778
  __gre_xmit net/ipv4/ip_gre.c:449 [inline]
  ipgre_xmit+0xdcf/0xeb0 net/ipv4/ip_gre.c:703
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3217 [inline]
  dev_hard_start_xmit+0x5df/0xc20 net/core/dev.c:3233
  __dev_queue_xmit+0x2f35/0x3ab0 net/core/dev.c:3803
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3836
  packet_snd net/packet/af_packet.c:2925 [inline]
  packet_sendmsg+0x80ff/0x8c60 net/packet/af_packet.c:2950
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2719 [inline]
  __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4352
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  alloc_skb_with_frags+0x1d0/0xac0 net/core/skbuff.c:5276
  sock_alloc_send_pskb+0xb47/0x1170 net/core/sock.c:2082
  packet_alloc_skb net/packet/af_packet.c:2779 [inline]
  packet_snd net/packet/af_packet.c:2870 [inline]
  packet_sendmsg+0x6599/0x8c60 net/packet/af_packet.c:2950
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
