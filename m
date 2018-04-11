Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755804AbeDKVCH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:02:07 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:43645 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755539AbeDKVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:02:03 -0400
X-Google-Smtp-Source: AIpwx48zNq3S7d2GErpf6SAvLuOgHMC8JNEiK11zliriaGm7kSkTN8PEArK3Fa+hIks0UBEav9e+TYOByGWHo5nAc5OKVlC8N14V
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 14:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <94eb2c0b816e53d353056998f3f8@google.com>
Subject: BUG: corrupted list in team_nl_cmd_options_set
From: syzbot <syzbot+4d4af685432dc0e56c91@syzkaller.appspotmail.com>
To: jiri@resnulli.us, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=4d4af685432dc0e56c91

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6161158629228544
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5600380654190592
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4627738266697728
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4d4af685432dc0e56c91@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

8021q: adding VLAN 0 to HW filter on device team0
netlink: 'syzkaller556835': attribute type 3 has an invalid length.
netlink: 'syzkaller556835': attribute type 3 has an invalid length.
list_add double add: new=0000000004f859c0, prev=00000000c9745291,  
next=0000000004f859c0.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4466 Comm: syzkaller556835 Not tainted 4.16.0+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid+0xaa/0xb0 lib/list_debug.c:29
RSP: 0018:ffff8801b04bf248 EFLAGS: 00010286
RAX: 0000000000000058 RBX: ffff8801c8fc7a90 RCX: 0000000000000000
RDX: 0000000000000058 RSI: ffffffff815fbf41 RDI: ffffed0036097e3f
RBP: ffff8801b04bf260 R08: ffff8801b0b2a700 R09: ffffed003b604f90
R10: ffffed003b604f90 R11: ffff8801db027c87 R12: ffff8801c8fc7a90
R13: ffff8801c8fc7a90 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000b98880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043fc30 CR3: 00000001afe8e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add include/linux/list.h:79 [inline]
  team_nl_cmd_options_set+0x9ff/0x12b0 drivers/net/team/team.c:2571
  genl_family_rcv_msg+0x889/0x1120 net/netlink/genetlink.c:599
  genl_rcv_msg+0xc6/0x170 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  SYSC_sendmsg net/socket.c:2164 [inline]
  SyS_sendmsg+0x29/0x30 net/socket.c:2162
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4458b9
RSP: 002b:00007ffd1d4a7278 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00000000004458b9
RDX: 0000000000000010 RSI: 0000000020000d00 RDI: 0000000000000004
RBP: 00000000004a74ed R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffd1d4a7348
R13: 0000000000402a60 R14: 0000000000000000 R15: 0000000000000000
Code: 75 e8 eb a9 48 89 f7 48 89 75 e8 e8 d1 85 7b fe 48 8b 75 e8 eb bb 48  
89 f2 48 89 d9 4c 89 e6 48 c7 c7 a0 84 d8 87 e8 ea 67 28 fe <0f> 0b 0f 1f  
40 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41
RIP: __list_add_valid+0xaa/0xb0 lib/list_debug.c:29 RSP: ffff8801b04bf248
---[ end trace b4f71d7dd7ca6d10 ]---


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
