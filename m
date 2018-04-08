Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeDHHPD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:15:03 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:45983 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeDHHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 03:15:01 -0400
X-Google-Smtp-Source: AIpwx497GYc2bGVWIHSC9kVZxM32NKckOxXnoISnZQ6pNJl8wLw4V/hTqGpTWEzDVZwwmtX2GJY0uprxrnXeiFD3U31fE72BBR/s
MIME-Version: 1.0
Date: Sun, 08 Apr 2018 00:15:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000311cdd0569510cc7@google.com>
Subject: KMSAN: uninit-value in _decode_session6
From: syzbot <syzbot+2974b85346f85b586f4d@syzkaller.appspotmail.com>
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
e2ab7e8abba47a2f2698216258e5d8727ae58717 (Fri Apr 6 16:24:31 2018 +0000)
kmsan: temporarily disable visitAsmInstruction() to help syzbot
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=2974b85346f85b586f4d

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4871594698604544
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329060) (llvm/trunk 329054)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2974b85346f85b586f4d@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KMSAN: uninit-value in _decode_session6+0x6d1/0x1290  
net/ipv6/xfrm6_policy.c:151
CPU: 1 PID: 5714 Comm: blkid Not tainted 4.16.0+ #81
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  _decode_session6+0x6d1/0x1290 net/ipv6/xfrm6_policy.c:151
  __xfrm_decode_session+0x140/0x1c0 net/xfrm/xfrm_policy.c:2368
  xfrm_decode_session_reverse include/net/xfrm.h:1213 [inline]
  icmpv6_route_lookup net/ipv6/icmp.c:372 [inline]
  icmp6_send+0x305f/0x3460 net/ipv6/icmp.c:551
  icmpv6_send+0xe0/0x110 net/ipv6/ip6_icmp.c:43
  ip6_link_failure+0x8f/0x580 net/ipv6/route.c:2034
  dst_link_failure include/net/dst.h:426 [inline]
  ndisc_error_report+0x101/0x1a0 net/ipv6/ndisc.c:695
  neigh_invalidate+0x385/0x930 net/core/neighbour.c:883
  neigh_timer_handler+0xd85/0x12d0 net/core/neighbour.c:969
  call_timer_fn+0x26a/0x5a0 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0xda7/0x11c0 kernel/time/timer.c:1666
  run_timer_softirq+0x43/0x70 kernel/time/timer.c:1692
  __do_softirq+0x56d/0x93d kernel/softirq.c:285
  invoke_softirq kernel/softirq.c:365 [inline]
  irq_exit+0x202/0x240 kernel/softirq.c:405
  exiting_irq+0xe/0x10 arch/x86/include/asm/apic.h:541
  smp_apic_timer_interrupt+0x64/0x90 arch/x86/kernel/apic/apic.c:1055
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:857
  </IRQ>
RIP: 0010:kmsan_get_origin_address_noruntime+0x8f/0x260  
include/linux/mmzone.h:1206
RSP: 0000:ffff880165b0fb40 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff12
RAX: ffff8801e5b0fcc8 RBX: 0000000000000000 RCX: ffff88021fff1580
RDX: 0000000000000580 RSI: 0000000000000000 RDI: ffff880165b0fcc8
RBP: ffff880165b0fb78 R08: 0000000001080020 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000068
R13: 00000000d3a0004b R14: ffff880165b0fcc8 R15: 0000000000000000
  kmsan_set_origin_inline+0x6b/0x120 mm/kmsan/kmsan_instr.c:585
  __msan_poison_alloca+0x15c/0x1d0 mm/kmsan/kmsan_instr.c:647
  handle_mm_fault+0x1c8/0x7ba0 mm/memory.c:4114
  __do_page_fault+0xec4/0x1a10 arch/x86/mm/fault.c:1423
  do_page_fault+0xd3/0x260 arch/x86/mm/fault.c:1500
  page_fault+0x45/0x50 arch/x86/entry/entry_64.S:1151
RIP: 0033:0x7f93ad8e4789
RSP: 002b:00007ffd11b3cf20 EFLAGS: 00010216
RAX: 00007f93ad4742a0 RBX: 00007f93adaf79a8 RCX: 00000000000004a8
RDX: 00007f93ad6a9028 RSI: aaaaaaaaaaaaaaab RDI: 0000000000000000
RBP: 00007ffd11b3d000 R08: 0000000000000001 R09: 0000000000000010
R10: 00007f93ad343a30 R11: 0000000000000206 R12: 00007f93ad325000
R13: 00007f93ad343220 R14: 00007f93ad33d748 R15: 00007f93adaef740

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
  kmsan_memcpy_origins+0x11d/0x170 mm/kmsan/kmsan.c:526
  __msan_memcpy+0x19f/0x1f0 mm/kmsan/kmsan_instr.c:470
  skb_copy_bits+0x63a/0xdb0 net/core/skbuff.c:2046
  __pskb_pull_tail+0x483/0x22e0 net/core/skbuff.c:1883
  pskb_may_pull include/linux/skbuff.h:2112 [inline]
  _decode_session6+0x79f/0x1290 net/ipv6/xfrm6_policy.c:152
  __xfrm_decode_session+0x140/0x1c0 net/xfrm/xfrm_policy.c:2368
  xfrm_decode_session_reverse include/net/xfrm.h:1213 [inline]
  icmpv6_route_lookup net/ipv6/icmp.c:372 [inline]
  icmp6_send+0x305f/0x3460 net/ipv6/icmp.c:551
  icmpv6_send+0xe0/0x110 net/ipv6/ip6_icmp.c:43
  ip6_link_failure+0x8f/0x580 net/ipv6/route.c:2034
  dst_link_failure include/net/dst.h:426 [inline]
  ndisc_error_report+0x101/0x1a0 net/ipv6/ndisc.c:695
  neigh_invalidate+0x385/0x930 net/core/neighbour.c:883
  neigh_timer_handler+0xd85/0x12d0 net/core/neighbour.c:969
  call_timer_fn+0x26a/0x5a0 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0xda7/0x11c0 kernel/time/timer.c:1666
  run_timer_softirq+0x43/0x70 kernel/time/timer.c:1692
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
  __ip6_append_data+0x1a20/0x4bb0 net/ipv6/ip6_output.c:1503
  ip6_append_data+0x40e/0x6b0 net/ipv6/ip6_output.c:1576
  rawv6_sendmsg+0x2787/0x4cc0 net/ipv6/raw.c:928
  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
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
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
