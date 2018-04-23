Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbeDWQ4H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:56:07 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:55178 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbeDWQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:56:02 -0400
X-Google-Smtp-Source: AIpwx48PEywr607OA4PG2OdBesBS21Mg8gXr95gHG2FsyKRrlNpqvEZQNWVn+ueX62J6ecHTaB1PI57zQKpa9gJqT2VEnBltRten
MIME-Version: 1.0
Date: Mon, 23 Apr 2018 09:56:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5b2b1056a86e98c@google.com>
Subject: KMSAN: uninit-value in _copy_to_iter (2)
From: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
To: avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com,
        linux-kernel@vger.kernel.org, matthew@mjdsystems.ca, mingo@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        willemb@google.com
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
https://syzkaller.appspot.com/bug?extid=87cfa083e727a224754b

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6616554548494336
Kernel config: https://syzkaller.appspot.com/x/.config?id=328654897048964367
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KMSAN: uninit-value in copyout lib/iov_iter.c:140 [inline]
BUG: KMSAN: uninit-value in _copy_to_iter+0x1bb3/0x28f0 lib/iov_iter.c:571
CPU: 0 PID: 7670 Comm: syz-executor7 Not tainted 4.16.0+ #86
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  kmsan_internal_check_memory+0x135/0x1e0 mm/kmsan/kmsan.c:1157
  kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
  copyout lib/iov_iter.c:140 [inline]
  _copy_to_iter+0x1bb3/0x28f0 lib/iov_iter.c:571
  copy_to_iter include/linux/uio.h:106 [inline]
  skb_copy_datagram_iter+0x443/0xf70 net/core/datagram.c:431
  skb_copy_datagram_msg include/linux/skbuff.h:3264 [inline]
  netlink_recvmsg+0x6f1/0x1900 net/netlink/af_netlink.c:1958
  sock_recvmsg_nosec net/socket.c:803 [inline]
  sock_recvmsg+0x1d0/0x230 net/socket.c:810
  ___sys_recvmsg+0x3fb/0x810 net/socket.c:2205
  __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
  SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
  SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x455389
RSP: 002b:00007f0281d3dc68 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f0281d3e6d4 RCX: 0000000000455389
RDX: 0000000000000003 RSI: 0000000020001f80 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000020002040 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000049e R14: 00000000006f9f70 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
  kmsan_memcpy_origins+0x11d/0x170 mm/kmsan/kmsan.c:526
  __msan_memcpy+0x109/0x160 mm/kmsan/kmsan_instr.c:477
  __nla_put lib/nlattr.c:569 [inline]
  nla_put+0x276/0x340 lib/nlattr.c:627
  copy_to_user_policy_type net/xfrm/xfrm_user.c:1678 [inline]
  build_acquire net/xfrm/xfrm_user.c:2850 [inline]
  xfrm_send_acquire+0x1068/0x1690 net/xfrm/xfrm_user.c:2873
  km_query net/xfrm/xfrm_state.c:1953 [inline]
  xfrm_state_find+0x3ad8/0x4f40 net/xfrm/xfrm_state.c:1021
  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:1393 [inline]
  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:1437 [inline]
  xfrm_resolve_and_create_bundle+0xc31/0x5270 net/xfrm/xfrm_policy.c:1833
  xfrm_lookup+0x606/0x39d0 net/xfrm/xfrm_policy.c:2163
  xfrm_lookup_route+0xfa/0x360 net/xfrm/xfrm_policy.c:2283
  ip6_dst_lookup_flow+0x221/0x270 net/ipv6/ip6_output.c:1099
  ip6_datagram_dst_update+0x93a/0x1470 net/ipv6/datagram.c:91
  __ip6_datagram_connect+0x14f6/0x1a20 net/ipv6/datagram.c:257
  ip6_datagram_connect net/ipv6/datagram.c:280 [inline]
  ip6_datagram_connect_v6_only+0x104/0x180 net/ipv6/datagram.c:292
  inet_dgram_connect+0x2e8/0x4d0 net/ipv4/af_inet.c:542
  SYSC_connect+0x41a/0x510 net/socket.c:1639
  SyS_connect+0x54/0x80 net/socket.c:1620
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Local variable description: ----upt.i.i@xfrm_send_acquire
Variable was created at:
  xfrm_send_acquire+0x73/0x1690 net/xfrm/xfrm_user.c:2864
  km_query net/xfrm/xfrm_state.c:1953 [inline]
  xfrm_state_find+0x3ad8/0x4f40 net/xfrm/xfrm_state.c:1021

Byte 200 of 207 is uninitialized
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
==================================================================
CPU: 1 PID: 7675 Comm: syz-executor3 Not tainted 4.16.0+ #86


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
