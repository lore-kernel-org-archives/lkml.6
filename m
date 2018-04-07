Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDGSND (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 14:13:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:52282 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeDGSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 14:13:02 -0400
X-Google-Smtp-Source: AIpwx48O/zjw3ba+co5YnlKPyKRGOu36wyxjg2Zo2LWl6LXi5ebAxbag4VxDE4KiStV0InUeqCIgVotU9cvtNGO4soIFuxYn0yk+
MIME-Version: 1.0
Date: Sat, 07 Apr 2018 11:13:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e46680569461f8d@google.com>
Subject: KMSAN: uninit-value in tipc_node_get_mtu
From: syzbot <syzbot+b0975ce9355b347c1546@syzkaller.appspotmail.com>
To: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
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
https://syzkaller.appspot.com/bug?extid=b0975ce9355b347c1546

So far this crash happened 14 times on  
https://github.com/google/kmsan.git/master.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6058260943601664
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329060) (llvm/trunk 329054)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0975ce9355b347c1546@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KMSAN: uninit-value in tipc_node_find net/tipc/node.c:236 [inline]
BUG: KMSAN: uninit-value in tipc_node_get_mtu+0x200/0x7a0  
net/tipc/node.c:185
CPU: 1 PID: 5393 Comm: syz-executor0 Not tainted 4.16.0+ #81
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
RIP: 0033:0x455259
RSP: 002b:00007feeb8eb4c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007feeb8eb56d4 RCX: 0000000000455259
RDX: 0000000000000000 RSI: 0000000020001840 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004cc R14: 00000000006fa3c0 R15: 0000000000000000

Local variable description: ----dnode@__tipc_sendmsg
Variable was created at:
  __tipc_sendmsg+0x20c/0x41c0 net/tipc/socket.c:1272
  tipc_sendmsg+0xeb/0x140 net/tipc/socket.c:1265
==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 5393 Comm: syz-executor0 Tainted: G    B            4.16.0+ #81
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
RIP: 0033:0x455259
RSP: 002b:00007feeb8eb4c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007feeb8eb56d4 RCX: 0000000000455259
RDX: 0000000000000000 RSI: 0000000020001840 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004cc R14: 00000000006fa3c0 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
