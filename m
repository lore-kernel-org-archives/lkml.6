Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeDHA0E (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 20:26:04 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:42965 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDHA0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 20:26:02 -0400
X-Google-Smtp-Source: AIpwx49u+1jY9X5BU1ZAPJjrgaUpc+8LNt3g9m6RkTli8rEAyzmgi9wNkDnJdxSi2x+/Km2qyLv6lO/mhRJP1U/sbkzQ8nJk8MhY
MIME-Version: 1.0
Date: Sat, 07 Apr 2018 17:26:01 -0700
In-Reply-To: <0000000000008e46680569461f8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113ff9ca86f59a05694b552f@google.com>
Subject: Re: KMSAN: uninit-value in tipc_node_get_mtu
From: syzbot <syzbot+b0975ce9355b347c1546@syzkaller.appspotmail.com>
To: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on  
https://github.com/google/kmsan.git/master commit
e2ab7e8abba47a2f2698216258e5d8727ae58717 (Fri Apr 6 16:24:31 2018 +0000)
kmsan: temporarily disable visitAsmInstruction() to help syzbot
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b0975ce9355b347c1546

So far this crash happened 16 times on  
https://github.com/google/kmsan.git/master.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5297557005664256
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4600034989441024
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5107856890134528
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0975ce9355b347c1546@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

==================================================================
BUG: KMSAN: uninit-value in tipc_node_find net/tipc/node.c:236 [inline]
BUG: KMSAN: uninit-value in tipc_node_get_mtu+0x200/0x7a0  
net/tipc/node.c:185
CPU: 1 PID: 3571 Comm: syzkaller770798 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  tipc_node_find net/tipc/node.c:236 [inline]
  tipc_node_get_mtu+0x200/0x7a0 net/tipc/node.c:185
  __tipc_sendmsg+0x1b32/0x41c0 net/tipc/socket.c:1364
  tipc_sendmsg+0xeb/0x140 net/tipc/socket.c:1265
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmsg net/socket.c:2080 [inline]
  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
  SyS_sendmsg+0x54/0x80 net/socket.c:2087
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43fd49
RSP: 002b:00007ffd0061aba8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fd49
RDX: 0000000000000000 RSI: 000000002095ffc8 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401670
R13: 0000000000401700 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----dnode@__tipc_sendmsg
Variable was created at:
  __tipc_sendmsg+0x20c/0x41c0 net/tipc/socket.c:1272
  tipc_sendmsg+0xeb/0x140 net/tipc/socket.c:1265
==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 3571 Comm: syzkaller770798 Tainted: G    B            4.16.0+  
#82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  panic+0x39d/0x940 kernel/panic.c:183
  kmsan_report+0x238/0x240 mm/kmsan/kmsan.c:1083
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  tipc_node_find net/tipc/node.c:236 [inline]
  tipc_node_get_mtu+0x200/0x7a0 net/tipc/node.c:185
  __tipc_sendmsg+0x1b32/0x41c0 net/tipc/socket.c:1364
  tipc_sendmsg+0xeb/0x140 net/tipc/socket.c:1265
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmsg net/socket.c:2080 [inline]
  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
  SyS_sendmsg+0x54/0x80 net/socket.c:2087
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43fd49
RSP: 002b:00007ffd0061aba8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fd49
RDX: 0000000000000000 RSI: 000000002095ffc8 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401670
R13: 0000000000401700 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
