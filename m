Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2F3223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2F3223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHKABk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:01:40 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:42182 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeHKABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:01:39 -0400
Received: by mail-io0-f197.google.com with SMTP id n11-v6so282535ioj.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FLH4iY6A3lLQAlS1Yc8wpJv4JM+/g910KL0sm4aPUDg=;
        b=XK7LPCW1Ri2+/+b6IYTeHM3wgurz3DBN03s5eTQ87dlIK/XP22dgPKYangNL4mYwsV
         UdpXKGmMvu3cEIcNxKqTJ1Ru3Lq27qTbVGQiYKRLeoS1QUeK5z+2z0DtdgbrBYOmcrup
         CnXQ7KL/VgUy6WxKozEJ61BIcJJOT/9jg2H5qlG298oxK0MVAWgyNilS8PVU9aBFULyY
         Dhgm6mjAIWP4InuKMh2KwOm0ToMM7A82XvbQ8RRjI+GRx9scnZaMc9tSQ1YUSfi91Cox
         IJC2E4Ba/HzCpQuhCNeuml6a/EveEycZi5HlXc+jB2USFWBNtQt7Esx/cx+8Dj4ziSJa
         UPlQ==
X-Gm-Message-State: AOUpUlHqK5Jkp+6AjQGOXwl/JZqs9eYDixWwJQYpI5aW/BXMu5BOXE4A
        GyX68NmNVeA0LwYikZfut/OrRW0HEpe7wesXOkYG1zCPYmtX
X-Google-Smtp-Source: AA+uWPxFtP6MuEMKWecHb1/otG+oi1mt1iUTYZJq6yOeis4rTmfIjTv0hw0mbKYNQHBKFKVIzVUIj4o8be1CZga+PmIEJrhaaXzd
MIME-Version: 1.0
X-Received: by 2002:a24:d11:: with SMTP id 17-v6mr2041607itx.3.1533936602954;
 Fri, 10 Aug 2018 14:30:02 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:30:02 -0700
In-Reply-To: <00000000000082e3a90571fadb4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053c91f05731b72b8@google.com>
Subject: Re: KMSAN: uninit-value in sit_tunnel_xmit
From:   syzbot <syzbot+782ee96f9147673d8822@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0cc51dc9a291 kmsan: instrument get_user() and put_user() p..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=14973622400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3618361797c180a3
dashboard link: https://syzkaller.appspot.com/bug?extid=782ee96f9147673d8822
compiler:       clang version 8.0.0 (trunk 339414)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10fd6e30400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a2aee2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+782ee96f9147673d8822@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in __ipv6_prefix_equal64_half  
include/net/ipv6.h:515 [inline]
BUG: KMSAN: uninit-value in ipv6_prefix_equal include/net/ipv6.h:532  
[inline]
BUG: KMSAN: uninit-value in check_6rd net/ipv6/sit.c:771 [inline]
BUG: KMSAN: uninit-value in try_6rd net/ipv6/sit.c:805 [inline]
BUG: KMSAN: uninit-value in ipip6_tunnel_xmit net/ipv6/sit.c:865 [inline]
BUG: KMSAN: uninit-value in sit_tunnel_xmit+0x18c0/0x3640  
net/ipv6/sit.c:1029
CPU: 0 PID: 4467 Comm: syz-executor896 Not tainted 4.18.0-rc8+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x17c/0x1c0 lib/dump_stack.c:113
  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:982
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  __ipv6_prefix_equal64_half include/net/ipv6.h:515 [inline]
  ipv6_prefix_equal include/net/ipv6.h:532 [inline]
  check_6rd net/ipv6/sit.c:771 [inline]
  try_6rd net/ipv6/sit.c:805 [inline]
  ipip6_tunnel_xmit net/ipv6/sit.c:865 [inline]
  sit_tunnel_xmit+0x18c0/0x3640 net/ipv6/sit.c:1029
  __netdev_start_xmit include/linux/netdevice.h:4148 [inline]
  netdev_start_xmit include/linux/netdevice.h:4157 [inline]
  xmit_one net/core/dev.c:3034 [inline]
  dev_hard_start_xmit+0x5df/0xc20 net/core/dev.c:3050
  __dev_queue_xmit+0x2eea/0x3a70 net/core/dev.c:3569
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3602
  packet_snd net/packet/af_packet.c:2921 [inline]
  packet_sendmsg+0x7fb5/0x8ae0 net/packet/af_packet.c:2946
  sock_sendmsg_nosec net/socket.c:642 [inline]
  sock_sendmsg net/socket.c:652 [inline]
  ___sys_sendmsg+0xe32/0x1250 net/socket.c:2126
  __sys_sendmsg net/socket.c:2164 [inline]
  __do_sys_sendmsg net/socket.c:2173 [inline]
  __se_sys_sendmsg net/socket.c:2171 [inline]
  __x64_sys_sendmsg+0x32d/0x460 net/socket.c:2171
  do_syscall_64+0x15b/0x220 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441149
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb58f66a8 EFLAGS: 00000286 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441149
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000100 R09: 0000000000000100
R10: 0000000000000100 R11: 0000000000000286 R12: 00000000004020b0
R13: 0000000000402140 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2720 [inline]
  __kmalloc_node_track_caller+0xb4c/0x11d0 mm/slub.c:4353
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2ce/0x9b0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:988 [inline]
  alloc_skb_with_frags+0x1d0/0xac0 net/core/skbuff.c:5272
  sock_alloc_send_pskb+0xb47/0x1120 net/core/sock.c:2095
  packet_alloc_skb net/packet/af_packet.c:2776 [inline]
  packet_snd net/packet/af_packet.c:2867 [inline]
  packet_sendmsg+0x6480/0x8ae0 net/packet/af_packet.c:2946
  sock_sendmsg_nosec net/socket.c:642 [inline]
  sock_sendmsg net/socket.c:652 [inline]
  ___sys_sendmsg+0xe32/0x1250 net/socket.c:2126
  __sys_sendmsg net/socket.c:2164 [inline]
  __do_sys_sendmsg net/socket.c:2173 [inline]
  __se_sys_sendmsg net/socket.c:2171 [inline]
  __x64_sys_sendmsg+0x32d/0x460 net/socket.c:2171
  do_syscall_64+0x15b/0x220 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================

