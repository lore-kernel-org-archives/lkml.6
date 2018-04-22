Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeDVK6S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:58:18 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:39383 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeDVK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:58:16 -0400
X-Google-Smtp-Source: AIpwx48ptxoiqwIFTNrEvdZsE+7eMWt3Qj6isFi/IBY+lZM0FHPsW6IblIqTmwbiEPwIk/ij9AmPdVCaeHW6N5OKNc0=
MIME-Version: 1.0
In-Reply-To: <000000000000116485056a369609@google.com>
References: <000000000000116485056a369609@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 22 Apr 2018 12:57:54 +0200
Message-ID: <CACT4Y+Z+739yCrxUxU0PcA5A8w9t0h=R=aUic6Y-tGNJju_yEQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __udp4_lib_rcv
To: syzbot <syzbot+493bccc5b8cfe9d5035e@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 7:06 PM, syzbot
<syzbot+493bccc5b8cfe9d5035e@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on https://github.com/google/kmsan.git/master
> commit
> 35ff515e4bda2646f6c881d33951c306ea9c282a (Tue Apr 10 08:59:43 2018 +0000)
> Merge pull request #11 from parkerduckworth/readme
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=493bccc5b8cfe9d5035e
>
> So far this crash happened 11 times on
> https://github.com/google/kmsan.git/master.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4935004320694272
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5133260011077632
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5329144879513600
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=6627248707860932248
> compiler: clang version 7.0.0 (trunk 329391)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+493bccc5b8cfe9d5035e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


This does not reproduce after:
https://github.com/google/kmsan/commit/a7f95e9c8a95e9fbb388c3999b61a17667cd3bbe
so let's consider this as false positive related to checksums:

#syz invalid



> ==================================================================
> BUG: KMSAN: uninit-value in __udp4_lib_rcv+0x628/0x4740 net/ipv4/udp.c:2066
> CPU: 1 PID: 3573 Comm: syzkaller192717 Not tainted 4.16.0+ #83
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
>  __udp4_lib_rcv+0x628/0x4740 net/ipv4/udp.c:2066
>  udp_rcv+0x5c/0x70 net/ipv4/udp.c:2287
>  ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
>  NF_HOOK include/linux/netfilter.h:288 [inline]
>  ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
>  dst_input include/net/dst.h:449 [inline]
>  ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
>  NF_HOOK include/linux/netfilter.h:288 [inline]
>  ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
>  __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
>  __netif_receive_skb net/core/dev.c:4627 [inline]
>  process_backlog+0x62d/0xe20 net/core/dev.c:5307
>  napi_poll net/core/dev.c:5705 [inline]
>  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
>  __do_softirq+0x56d/0x93d kernel/softirq.c:285
>  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1040
>  </IRQ>
>  do_softirq kernel/softirq.c:329 [inline]
>  __local_bh_enable_ip+0x114/0x140 kernel/softirq.c:182
>  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
>  rcu_read_unlock_bh include/linux/rcupdate.h:726 [inline]
>  ip_finish_output2+0x124e/0x1380 net/ipv4/ip_output.c:231
>  ip_finish_output+0xcb0/0xff0 net/ipv4/ip_output.c:317
>  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
>  ip_output+0x502/0x5c0 net/ipv4/ip_output.c:405
>  dst_output include/net/dst.h:443 [inline]
>  ip_local_out net/ipv4/ip_output.c:124 [inline]
>  ip_send_skb+0x5f3/0x820 net/ipv4/ip_output.c:1414
>  ip_push_pending_frames+0x105/0x170 net/ipv4/ip_output.c:1434
>  raw_sendmsg+0x2960/0x3ed0 net/ipv4/raw.c:684
>  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg net/socket.c:640 [inline]
>  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
>  __sys_sendmsg net/socket.c:2080 [inline]
>  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
>  SyS_sendmsg+0x54/0x80 net/socket.c:2087
>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> RIP: 0033:0x43fe99
> RSP: 002b:00007ffca5bf5be8 EFLAGS: 00000217 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fe99
> RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004017c0
> R13: 0000000000401850 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
>  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
>  kmsan_memcpy_origins+0x11d/0x170 mm/kmsan/kmsan.c:526
>  __msan_memcpy+0x19f/0x1f0 mm/kmsan/kmsan_instr.c:470
>  skb_copy_bits+0x63a/0xdb0 net/core/skbuff.c:2046
>  __pskb_pull_tail+0x483/0x22e0 net/core/skbuff.c:1883
>  pskb_may_pull include/linux/skbuff.h:2112 [inline]
>  __udp4_lib_rcv+0x55f/0x4740 net/ipv4/udp.c:2058
>  udp_rcv+0x5c/0x70 net/ipv4/udp.c:2287
>  ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
>  NF_HOOK include/linux/netfilter.h:288 [inline]
>  ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
>  dst_input include/net/dst.h:449 [inline]
>  ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
>  NF_HOOK include/linux/netfilter.h:288 [inline]
>  ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
>  __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
>  __netif_receive_skb net/core/dev.c:4627 [inline]
>  process_backlog+0x62d/0xe20 net/core/dev.c:5307
>  napi_poll net/core/dev.c:5705 [inline]
>  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
>  __do_softirq+0x56d/0x93d kernel/softirq.c:285
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>  kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:814
>  kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:868
>  __alloc_pages_nodemask+0xf5b/0x5dc0 mm/page_alloc.c:4283
>  alloc_pages_current+0x6b5/0x970 mm/mempolicy.c:2055
>  alloc_pages include/linux/gfp.h:494 [inline]
>  skb_page_frag_refill+0x3ba/0x5e0 net/core/sock.c:2208
>  sk_page_frag_refill+0xa4/0x340 net/core/sock.c:2228
>  __ip_append_data+0x107e/0x3d10 net/ipv4/ip_output.c:1057
>  ip_append_data+0x2fb/0x440 net/ipv4/ip_output.c:1170
>  raw_sendmsg+0x287b/0x3ed0 net/ipv4/raw.c:678
>  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg net/socket.c:640 [inline]
>  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
>  __sys_sendmsg net/socket.c:2080 [inline]
>  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
>  SyS_sendmsg+0x54/0x80 net/socket.c:2087
>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000116485056a369609%40google.com.
> For more options, visit https://groups.google.com/d/optout.
