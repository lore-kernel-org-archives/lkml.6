Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79F6206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79F6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeIQUux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:50:53 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34147 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbeIQUuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:50:52 -0400
Received: by mail-io1-f72.google.com with SMTP id z20-v6so18748695iol.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NVWDhCYY9R29s6Dc2V6xya2aOqIawKan8+DHVYeBd4Q=;
        b=io4G4Qau56zNFRHSwIMz3bf7j1WrZrFRcJr8VCA0NOrTPeSPUjF0J1D0I7VdZKyeE/
         Gt6tkUFp78khn4yD0bpXK3/VspvZsB1pwdMBK/wI8PAgHa6Psm6Yu1TqqXmXAmNKhUzW
         5kOCz6jDdKiXnD7HX5xqjYLTSwqcaMh+0hCUVFPS1H3WeiZiVcoDmn5/FxComX2I7kum
         A2znYSV/eAQhNYj8Frsk0FZg9ydnJcWrR2lrk+1DsrmeDlOVf1lcctxQLKWPmBATguIk
         CvU7BRR0dJM9ca2qIyVxqIKhF7RIXuGrZGkUdY9bZiBJWmjWfcTYd5+6j3+oLT+ajNwp
         fiEQ==
X-Gm-Message-State: APzg51By0hbqe/PanlqFczg0r+GdfPPjW0Eum42Fe/GAprJOtWCLAgbG
        ClFp2x0HMxFOev2tZf7Qkb8yXq74jHEfKNB02qN9QLQx8S8R
X-Google-Smtp-Source: ANB0VdaRtJpu4/SggHn4g2/D8Q9xIRMysiDNmL6Oe85sQPQDuFQDa6Cm6SRuPy3s0Of+aYQ+FZSXe+j1VzAJCQNIeE8edWWwkGIw
MIME-Version: 1.0
X-Received: by 2002:a5e:dc4a:: with SMTP id s10-v6mr19705731iop.8.1537197783637;
 Mon, 17 Sep 2018 08:23:03 -0700 (PDT)
Date:   Mon, 17 Sep 2018 08:23:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7e6a1057612bf76@google.com>
Subject: KMSAN: uninit-value in ip6_tnl_start_xmit
From:   syzbot <syzbot+3fde91d4d394747d6db4@syzkaller.appspotmail.com>
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

HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=14094a57800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=3fde91d4d394747d6db4
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17919a47800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13598fbb800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3fde91d4d394747d6db4@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in ip6ip6_tnl_xmit net/ipv6/ip6_tunnel.c:1307  
[inline]
BUG: KMSAN: uninit-value in ip6_tnl_start_xmit+0x7d2/0x1ef0  
net/ipv6/ip6_tunnel.c:1390
CPU: 0 PID: 4504 Comm: syz-executor558 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  ip6ip6_tnl_xmit net/ipv6/ip6_tunnel.c:1307 [inline]
  ip6_tnl_start_xmit+0x7d2/0x1ef0 net/ipv6/ip6_tunnel.c:1390
  __netdev_start_xmit include/linux/netdevice.h:4066 [inline]
  netdev_start_xmit include/linux/netdevice.h:4075 [inline]
  xmit_one net/core/dev.c:3026 [inline]
  dev_hard_start_xmit+0x5f1/0xc70 net/core/dev.c:3042
  __dev_queue_xmit+0x27ee/0x3520 net/core/dev.c:3557
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x7c70/0x8a30 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmmsg+0x42d/0x800 net/socket.c:2136
  SYSC_sendmmsg+0xc4/0x110 net/socket.c:2167
  SyS_sendmmsg+0x63/0x90 net/socket.c:2162
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x441819
RSP: 002b:00007ffe58ee8268 EFLAGS: 00000213 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441819
RDX: 0000000000000002 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006cd018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000402510
R13: 00000000004025a0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
  packet_snd net/packet/af_packet.c:2894 [inline]
  packet_sendmsg+0x6454/0x8a30 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmmsg+0x42d/0x800 net/socket.c:2136
  SYSC_sendmmsg+0xc4/0x110 net/socket.c:2167
  SyS_sendmmsg+0x63/0x90 net/socket.c:2162
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
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
