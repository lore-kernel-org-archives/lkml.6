Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeC3TBN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 15:01:13 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:51688 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeC3TBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 15:01:02 -0400
X-Google-Smtp-Source: AIpwx4+j7U6f3qSv6rv92VKMnA/FJmMmemB/uECtgmu1Pn59O+3XlcU/JLqSAk09sUspr6ifN7NwH33fK9RR4AtqsQoFPF1nifEX
MIME-Version: 1.0
Date: Fri, 30 Mar 2018 12:01:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113fe6d081698f0568a5dcac@google.com>
Subject: KASAN: use-after-free Read in _decode_session4
From: syzbot <syzbot+a7db9083ed4017ba4423@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
0b412605ef5f5c64b31f19e2910b1d5eba9929c3 (Thu Mar 29 01:07:23 2018 +0000)
Merge tag 'drm-fixes-for-v4.16-rc8' of  
git://people.freedesktop.org/~airlied/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=a7db9083ed4017ba4423

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4908519807516672
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5839674757087232
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6305464228773888
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a7db9083ed4017ba4423@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
protocol 0800 is buggy, dev ip6_vti0
==================================================================
BUG: KASAN: use-after-free in _decode_session4+0x15f0/0x1990  
net/ipv4/xfrm4_policy.c:115
Read of size 1 at addr ffff8801b4117398 by task syzkaller030703/4418

CPU: 1 PID: 4418 Comm: syzkaller030703 Not tainted 4.16.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  _decode_session4+0x15f0/0x1990 net/ipv4/xfrm4_policy.c:115
  __xfrm_decode_session+0x68/0x110 net/xfrm/xfrm_policy.c:2368
  xfrm_decode_session include/net/xfrm.h:1206 [inline]
  vti6_tnl_xmit+0x36d/0x1820 net/ipv6/ip6_vti.c:546
  __netdev_start_xmit include/linux/netdevice.h:4066 [inline]
  netdev_start_xmit include/linux/netdevice.h:4075 [inline]
  xmit_one net/core/dev.c:3026 [inline]
  dev_hard_start_xmit+0x24e/0xac0 net/core/dev.c:3042
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
  __dev_queue_xmit+0x26bf/0x2fc0 net/core/dev.c:3557
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
protocol 0800 is buggy, dev ip6_vti0
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x3aed/0x60b0 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  SYSC_sendto+0x361/0x5c0 net/socket.c:1747
  SyS_sendto+0x40/0x50 net/socket.c:1715
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4417e9
RSP: 002b:00007ffd4f154978 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 1650e23d775d273d RCX: 00000000004417e9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00000000004a335c R08: 0000000020000000 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000216 R12: 00007ffd4f154a50
R13: 00000000004024c0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4418:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
  __do_kmalloc_node mm/slab.c:3670 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3684
  __kmalloc_reserve.isra.39+0x41/0xd0 net/core/skbuff.c:137
  __alloc_skb+0x13b/0x780 net/core/skbuff.c:205
  alloc_skb include/linux/skbuff.h:983 [inline]
  alloc_skb_with_frags+0x10d/0x750 net/core/skbuff.c:5227
  sock_alloc_send_pskb+0x787/0x9b0 net/core/sock.c:2085
  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
  packet_snd net/packet/af_packet.c:2894 [inline]
  packet_sendmsg+0x1ece/0x60b0 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  SYSC_sendto+0x361/0x5c0 net/socket.c:1747
  SyS_sendto+0x40/0x50 net/socket.c:1715
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 4418:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kfree+0xd9/0x260 mm/slab.c:3801
  skb_free_head+0x74/0xb0 net/core/skbuff.c:550
  skb_release_data+0x58c/0x790 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb+0x153/0x490 net/core/skbuff.c:701
  packet_rcv+0x15b/0x16c0 net/packet/af_packet.c:2162
  dev_queue_xmit_nit+0x866/0xc40 net/core/dev.c:1991
  xmit_one net/core/dev.c:3022 [inline]
  dev_hard_start_xmit+0x16b/0xac0 net/core/dev.c:3042
  __dev_queue_xmit+0x26bf/0x2fc0 net/core/dev.c:3557
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x3aed/0x60b0 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  SYSC_sendto+0x361/0x5c0 net/socket.c:1747
  SyS_sendto+0x40/0x50 net/socket.c:1715
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff8801b4117280
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 280 bytes inside of
  512-byte region [ffff8801b4117280, ffff8801b4117480)
The buggy address belongs to the page:
page:ffffea0006d045c0 count:1 mapcount:0 mapping:ffff8801b4117000 index:0x0
IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801b4117000 0000000000000000 0000000100000006
raw: ffffea0007243760 ffffea0007246a20 ffff8801dac00940 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
8021q: adding VLAN 0 to HW filter on device bond0
  ffff8801b4117280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b4117300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801b4117380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8801b4117400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b4117480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
