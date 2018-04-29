Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeD2QcE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:32:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:53900 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbeD2QcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:32:02 -0400
X-Google-Smtp-Source: AB8JxZqL5E4ZEXmljNnffK0LP+T/6ceOdkBN8vUL6W7J7bUVoQ6ITbrPKlJdJjn2WCexgE2vPEoB8PyQdKGvjdOs+HGkosgatAiq
MIME-Version: 1.0
Date: Sun, 29 Apr 2018 09:32:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4758d056aff4604@google.com>
Subject: KMSAN: uninit-value in _decode_session4
From: syzbot <syzbot+e7fec512bc2eb4ae0781@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on  
https://github.com/google/kmsan.git/master commit
d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617 (Sun Apr 22 15:05:22 2018 +0000)
kmsan: add initialization for shmem pages
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=e7fec512bc2eb4ae0781

So far this crash happened 6 times on  
https://github.com/google/kmsan.git/master.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5844177157881856
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6093669123751936
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4545366699540480
Kernel config: https://syzkaller.appspot.com/x/.config?id=328654897048964367
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e7fec512bc2eb4ae0781@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in _decode_session4+0x11d3/0x1ce0  
net/ipv4/xfrm4_policy.c:126
CPU: 0 PID: 4502 Comm: syz-executor427 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  _decode_session4+0x11d3/0x1ce0 net/ipv4/xfrm4_policy.c:126
  __xfrm_decode_session+0x151/0x200 net/xfrm/xfrm_policy.c:2368
  xfrm_decode_session include/net/xfrm.h:1206 [inline]
  vti6_tnl_xmit+0x49b/0x2070 net/ipv6/ip6_vti.c:546
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
  SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
  SyS_sendto+0x8a/0xb0 net/socket.c:1715
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4418f9
RSP: 002b:00007ffcea97afc8 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004418f9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006cd018 R08: 0000000020000000 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000216 R12: 00000000004025f0
R13: 0000000000402680 R14: 0000000000000000 R15: 0000000000000000

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
  SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
  SyS_sendto+0x8a/0xb0 net/socket.c:1715
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
==================================================================


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
