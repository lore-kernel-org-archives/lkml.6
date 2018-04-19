Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeDSRGF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:06:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:37409 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeDSRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:06:02 -0400
X-Google-Smtp-Source: AB8JxZpgKtGFcVx50cNt/Oj0jtRjckG/g04Nj7/FMvDqHyXwUZf5PWaWMV+4mPvb91A5zgvLMkZoa2FfmaVO4e5sNbVE5lw/jeWS
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 10:06:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e2bf3056a36962d@google.com>
Subject: KMSAN: uninit-value in dccp_invalid_packet
From: syzbot <syzbot+00763607efc31f91b276@syzkaller.appspotmail.com>
To: davem@davemloft.net, dccp@vger.kernel.org, gerrit@erg.abdn.ac.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on  
https://github.com/google/kmsan.git/master commit
e2ab7e8abba47a2f2698216258e5d8727ae58717 (Fri Apr 6 16:24:31 2018 +0000)
kmsan: temporarily disable visitAsmInstruction() to help syzbot
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=00763607efc31f91b276

So far this crash happened 19 times on  
https://github.com/google/kmsan.git/master.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5163725019414528
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4836676144726016
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4771447134224384
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+00763607efc31f91b276@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
==================================================================
BUG: KMSAN: uninit-value in dccp_invalid_packet+0x3b8/0xf50  
net/dccp/ipv4.c:716
CPU: 1 PID: 3572 Comm: syzkaller338124 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  dccp_invalid_packet+0x3b8/0xf50 net/dccp/ipv4.c:716
  dccp_v4_rcv+0xf7/0x2630 net/dccp/ipv4.c:778
  ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
  dst_input include/net/dst.h:449 [inline]
  ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
  __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
  __netif_receive_skb net/core/dev.c:4627 [inline]
  process_backlog+0x62d/0xe20 net/core/dev.c:5307
  napi_poll net/core/dev.c:5705 [inline]
  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
  __do_softirq+0x56d/0x93d kernel/softirq.c:285
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1040
  </IRQ>
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x114/0x140 kernel/softirq.c:182
  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
  rcu_read_unlock_bh include/linux/rcupdate.h:726 [inline]
  ip_finish_output2+0x124e/0x1380 net/ipv4/ip_output.c:231
  ip_finish_output+0xcb0/0xff0 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
  ip_output+0x502/0x5c0 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:443 [inline]
  ip_local_out net/ipv4/ip_output.c:124 [inline]
  ip_send_skb+0x5f3/0x820 net/ipv4/ip_output.c:1414
  ip_push_pending_frames+0x105/0x170 net/ipv4/ip_output.c:1434
  raw_sendmsg+0x2960/0x3ed0 net/ipv4/raw.c:684
  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
  SyS_sendto+0x8a/0xb0 net/socket.c:1715
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x441709
RSP: 002b:00007ffffde4d688 EFLAGS: 00000217 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000000000000001b RCX: 0000000000441709
RDX: 0000000000000030 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00000000004a3318 R08: 0000000020000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000217 R12: 00007ffffde4d768
R13: 0000000000402490 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
  kmsan_memcpy_origins+0x11d/0x170 mm/kmsan/kmsan.c:526
  __msan_memcpy+0x19f/0x1f0 mm/kmsan/kmsan_instr.c:470
  skb_copy_bits+0x63a/0xdb0 net/core/skbuff.c:2046
  __pskb_pull_tail+0x483/0x22e0 net/core/skbuff.c:1883
  pskb_may_pull include/linux/skbuff.h:2112 [inline]
  dccp_invalid_packet+0x352/0xf50 net/dccp/ipv4.c:708
  dccp_v4_rcv+0xf7/0x2630 net/dccp/ipv4.c:778
  ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
  dst_input include/net/dst.h:449 [inline]
  ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
  __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
  __netif_receive_skb net/core/dev.c:4627 [inline]
  process_backlog+0x62d/0xe20 net/core/dev.c:5307
  napi_poll net/core/dev.c:5705 [inline]
  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
  __do_softirq+0x56d/0x93d kernel/softirq.c:285
Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:814
  kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:868
  __alloc_pages_nodemask+0xf5b/0x5dc0 mm/page_alloc.c:4283
  alloc_pages_current+0x6b5/0x970 mm/mempolicy.c:2055
  alloc_pages include/linux/gfp.h:494 [inline]
  skb_page_frag_refill+0x3ba/0x5e0 net/core/sock.c:2208
  sk_page_frag_refill+0xa4/0x340 net/core/sock.c:2228
  __ip_append_data+0x107e/0x3d10 net/ipv4/ip_output.c:1057
  ip_append_data+0x2fb/0x440 net/ipv4/ip_output.c:1170
  raw_sendmsg+0x287b/0x3ed0 net/ipv4/raw.c:678
  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
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
