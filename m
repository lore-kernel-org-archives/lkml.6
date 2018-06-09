Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YZq/NVdDHFtXYgAAmS7hNA
	; Sat, 09 Jun 2018 22:47:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D76A9607E4; Sat,  9 Jun 2018 22:47:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 17013605A5;
	Sat,  9 Jun 2018 22:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17013605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeFIWrG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:47:06 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:43262 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbeFIWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:47:03 -0400
Received: by mail-it0-f69.google.com with SMTP id i9-v6so5607063itb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 15:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=S6GXpPGfK18PcweMr04T+Tue0gFBn6gw2NKEZpYpCXs=;
        b=hrrwoBGNyC7lUTnqIh/0GtPbdaIUimuxVqVR5S+LAygMRJC8zb75PvlHFC/qiOShCG
         1+ZoXvC2aA9IgRahK/aVXARZw3sSp2c3Q8wntASho3/dbwdF1TurCIMQrKRaHQLZ+5F7
         qoKbOKpBeOrW1H2iF3L3Q5XUrm+YPXj56zvmkHX9tw/lmPT9GwFdRxI0sEat/Imh/lbt
         pDyux+Rj7XqEyPho9mzNMP39hDy2j7vF/lV1phxU05RZMuRfUnmzION6h1N01TgH9c/O
         wB3GHejY9CgTA+Z+wAekeoikh5XoN+bgXZx6Bks15tDOZ1WqRI5WprLBUDrD+G06v9Gm
         L3LQ==
X-Gm-Message-State: APt69E2E6Rg0ufdj4idFXkL2Ds3CynWjmBuN96i+fbNXpDSH3CMfLzua
        9KX8Ok0vmSoqwS3m6hnrkIED+OBrc6lbybwPVNJxW4xLk/F8
X-Google-Smtp-Source: ADUXVKKU6HoEeeYe5NeKa7Hp27vWJ+M+surkN5kfD5h+EUNNEJNSduDAHinbx0bUkQrLGkbfOaDAG9t+X3LuhEVEXkW8I4v5XZqT
MIME-Version: 1.0
X-Received: by 2002:a24:b90d:: with SMTP id w13-v6mr5801502ite.18.1528584423317;
 Sat, 09 Jun 2018 15:47:03 -0700 (PDT)
Date: Sat, 09 Jun 2018 15:47:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fa9d0056e3d4bc9@google.com>
Subject: BUG: unable to handle kernel paging request in ebt_do_table
From: syzbot <syzbot+93f34882275ae7caf9db@syzkaller.appspotmail.com>
To: bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101c56bf800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
dashboard link: https://syzkaller.appspot.com/bug?extid=93f34882275ae7caf9db
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10bdbebf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a8a0cf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+93f34882275ae7caf9db@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
8021q: adding VLAN 0 to HW filter on device team0
IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
BUG: unable to handle kernel paging request at ffffc9005c3ca003
PGD 1da946067 P4D 1da946067 PUD 0
Oops: 0000 [#1] SMP KASAN
CPU: 0 PID: 4498 Comm: syz-executor667 Not tainted 4.17.0+ #92
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ebt_do_table+0x1983/0x2140 net/bridge/netfilter/ebtables.c:288
Code: 24 08 48 89 d8 48 89 9d d0 fe ff ff 48 c1 e8 03 42 0f b6 04 38 84 c0  
74 08 3c 03 0f 8e 3b 06 00 00 48 8b 85 d0 fe ff ff 31 ff <8b> 18 89 de e8  
04 e8 c0 fa 85 db 0f 85 a0 02 00 00 e8 e7 e6 c0 fa
RSP: 0018:ffff8801b2e15c68 EFLAGS: 00010246
RAX: ffffc9005c3ca003 RBX: ffffc9005c3ca003 RCX: ffffc90001e1e000
RDX: 0000000000000000 RSI: ffffffff86b9558c RDI: 0000000000000000
RBP: ffff8801b2e15e38 R08: ffff8801b2588380 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffc90001e1e000
R13: ffffc90001e1a130 R14: ffffc90001e1a090 R15: dffffc0000000000
FS:  00000000006ed880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9005c3ca003 CR3: 00000001b3ba1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ebt_in_hook+0x65/0x80 net/bridge/netfilter/ebtable_filter.c:63
  ebt_out_hook+0x25/0x30 net/bridge/netfilter/ebtable_filter.c:63
  nf_hook_entry_hookfn include/linux/netfilter.h:119 [inline]
  nf_hook_slow+0xc2/0x1c0 net/netfilter/core.c:511
  nf_hook include/linux/netfilter.h:242 [inline]
  NF_HOOK include/linux/netfilter.h:285 [inline]
  __br_forward+0x520/0xd90 net/bridge/br_forward.c:113
  deliver_clone+0x61/0xc0 net/bridge/br_forward.c:129
  maybe_deliver net/bridge/br_forward.c:170 [inline]
  br_flood+0x6f3/0x980 net/bridge/br_forward.c:212
  br_dev_xmit+0x1121/0x1810 net/bridge/br_device.c:103
  __netdev_start_xmit include/linux/netdevice.h:4128 [inline]
  netdev_start_xmit include/linux/netdevice.h:4137 [inline]
  xmit_one net/core/dev.c:3034 [inline]
  dev_hard_start_xmit+0x264/0xc10 net/core/dev.c:3050
  __dev_queue_xmit+0x29da/0x3900 net/core/dev.c:3569
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  neigh_resolve_output+0x679/0xad0 net/core/neighbour.c:1361
  neigh_output include/net/neighbour.h:483 [inline]
  ip_finish_output2+0xa5f/0x1840 net/ipv4/ip_output.c:229
  ip_do_fragment+0x218e/0x2ac0 net/ipv4/ip_output.c:675
  ip_fragment.constprop.49+0x179/0x240 net/ipv4/ip_output.c:546
  ip_finish_output+0x6cb/0xf80 net/ipv4/ip_output.c:315
  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
  ip_output+0x21b/0x850 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x40/0xe0 net/ipv4/ip_output.c:1435
  udp_send_skb.isra.39+0x6b7/0x11d0 net/ipv4/udp.c:824
  udp_push_pending_frames+0x5c/0xf0 net/ipv4/udp.c:852
  udp_sendmsg+0x17d1/0x3970 net/ipv4/udp.c:1152
  udpv6_sendmsg+0x28c8/0x35f0 net/ipv6/udp.c:1200
  inet_sendmsg+0x19f/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:633 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:643
  __sys_sendto+0x3d7/0x670 net/socket.c:1821
  __do_sys_sendto net/socket.c:1833 [inline]
  __se_sys_sendto net/socket.c:1829 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1829
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441af9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeebd76c18 EFLAGS: 00000213 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441af9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00000000006cd018 R08: 0000000020000180 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004027f0
R13: 0000000000402880 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffc9005c3ca003
---[ end trace b04e96b1e335c4f5 ]---
RIP: 0010:ebt_do_table+0x1983/0x2140 net/bridge/netfilter/ebtables.c:288
Code: 24 08 48 89 d8 48 89 9d d0 fe ff ff 48 c1 e8 03 42 0f b6 04 38 84 c0  
74 08 3c 03 0f 8e 3b 06 00 00 48 8b 85 d0 fe ff ff 31 ff <8b> 18 89 de e8  
04 e8 c0 fa 85 db 0f 85 a0 02 00 00 e8 e7 e6 c0 fa
RSP: 0018:ffff8801b2e15c68 EFLAGS: 00010246
RAX: ffffc9005c3ca003 RBX: ffffc9005c3ca003 RCX: ffffc90001e1e000
RDX: 0000000000000000 RSI: ffffffff86b9558c RDI: 0000000000000000
RBP: ffff8801b2e15e38 R08: ffff8801b2588380 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffc90001e1e000
R13: ffffc90001e1a130 R14: ffffc90001e1a090 R15: dffffc0000000000
FS:  00000000006ed880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9005c3ca003 CR3: 00000001b3ba1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
