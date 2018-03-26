Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCZACL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 20:02:11 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:40517 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCZABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 20:01:03 -0400
X-Google-Smtp-Source: AG47ELtar3ujEp5/Fzzh6VsgKrYcdzy5LqIOYmEtw7UKbSygqcah9hZ6JflhKy8W/vzUEktZvnzxl6tnYgm6ffRXHpenwqy35puf
MIME-Version: 1.0
Date: Sun, 25 Mar 2018 17:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <089e08281e6c3b28c4056845781f@google.com>
Subject: general protection fault in tipc_sk_fill_sock_diag
From: syzbot <syzbot+326e587eff1074657718@syzkaller.appspotmail.com>
To: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on net-next commit
94cb5492409219ee3f9468616dd58af314029f76 (Fri Mar 23 18:31:30 2018 +0000)
net/sched: act_vlan: declare push_vid with host byte order
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=326e587eff1074657718

So far this crash happened 8 times on net-next.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5316828523921408
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5398288350052352
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5097949340106752
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=2445237949826843652
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+326e587eff1074657718@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

audit: type=1400 audit(1522009585.022:6): avc:  denied  { map } for   
pid=4261 comm="bash" path="/bin/bash" dev="sda1" ino=1457  
scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
audit: type=1400 audit(1522009597.461:7): avc:  denied  { map } for   
pid=4277 comm="syzkaller549428" path="/root/syzkaller549428900" dev="sda1"  
ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4277 Comm: syzkaller549428 Not tainted 4.16.0-rc6+ #280
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:sk_user_ns include/net/sock.h:748 [inline]
RIP: 0010:tipc_sk_fill_sock_diag+0x42d/0xc00 net/tipc/socket.c:3282
RSP: 0018:ffff8801b017eff0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 1ffff1003602fe04 RCX: 000000000000002b
RDX: dffffc0000000000 RSI: 1ffff10035d4b577 RDI: 0000000000000158
RBP: ffff8801b017f2a8 R08: 1ffff1003602fdbf R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d1637740
R13: ffff8801b0d50d40 R14: ffff8801b017f280 R15: 0000000000000000
FS:  00000000014a6880(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005000 CR3: 00000001b01b3005 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __tipc_add_sock_diag+0x20e/0x330 net/tipc/diag.c:62
  tipc_nl_sk_walk+0x565/0xb60 net/tipc/socket.c:3240
  tipc_diag_dump+0x24/0x30 net/tipc/diag.c:73
  netlink_dump+0x492/0xcf0 net/netlink/af_netlink.c:2222
  __netlink_dump_start+0x4ec/0x710 net/netlink/af_netlink.c:2319
  netlink_dump_start include/linux/netlink.h:214 [inline]
  tipc_sock_diag_handler_dump+0x206/0x2c0 net/tipc/diag.c:89
  __sock_diag_cmd net/core/sock_diag.c:230 [inline]
  sock_diag_rcv_msg+0x204/0x360 net/core/sock_diag.c:261
  netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2444
  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
  netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1334
  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1897
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:639
  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2047
  __sys_sendmsg+0xe5/0x210 net/socket.c:2081
  SYSC_sendmsg net/socket.c:2092 [inline]
  SyS_sendmsg+0x2d/0x50 net/socket.c:2088
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x43fde9
RSP: 002b:00007ffc6f197198 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fde9
RDX: 0000000000000000 RSI: 0000000020005000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401710
R13: 00000000004017a0 R14: 0000000000000000 R15: 0000000000000000
Code: f9 48 c1 e9 03 80 3c 11 00 0f 85 b5 07 00 00 4d 8b 7f 18 48 ba 00 00  
00 00 00 fc ff df 49 8d bf 58 01 00 00 48 89 f9 48 c1 e9 03 <80> 3c 11 00  
0f 85 2b 07 00 00 4d 8b bf 58 01 00 00 48 ba 00 00
RIP: sk_user_ns include/net/sock.h:748 [inline] RSP: ffff8801b017eff0
RIP: tipc_sk_fill_sock_diag+0x42d/0xc00 net/tipc/socket.c:3282 RSP:  
ffff8801b017eff0
---[ end trace ae417c2a60a8b333 ]---


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
