Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeCaXBE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 19:01:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:43533 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeCaXBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 19:01:02 -0400
X-Google-Smtp-Source: AIpwx49G/yTRx7XoHxiOIRvkL8TuLLFIpQoAPT3g/v6w/+4s5W4409DGKuK1CmXubzy19At0E7eBpkfoG3oS8P6r6zfug4yz48UB
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 16:01:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a55f900568bd543f@google.com>
Subject: general protection fault in __list_del_entry_valid (3)
From: syzbot <syzbot+0bb443b74ce09197e970@syzkaller.appspotmail.com>
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
c0b6edef0bf0e33c12eaf80c676ff09def011518 (Thu Mar 29 19:58:10 2018 +0000)
tc-testing: Add newline when writing test case files
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=0bb443b74ce09197e970

So far this crash happened 40 times on bpf-next, net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5934690573746176
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5611083175821312
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6249721593069568
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=3327544840960562528
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0bb443b74ce09197e970@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Name sequence creation failed, no memory
Failed to create subscription for {1020,0,4294967295}
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4361 Comm: syzkaller865516 Not tainted 4.16.0-rc6+ #288
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
RSP: 0018:ffff8801ae29eec8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 00000000000001f8 RCX: 0000000000000000
RDX: 000000000000003f RSI: ffff8801c9eb6cd8 RDI: ffff8801c9eb6ce0
RBP: ffff8801ae29eee0 R08: ffffffff86b2cc9f R09: 0000000000000000
R10: ffff8801ae29eda8 R11: ffff8801d08cf710 R12: 0000000000400040
R13: ffff8801ae29f080 R14: ffff8801c9eb6cd8 R15: ffff8801d08cf6c0
FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020265000 CR3: 000000000846a004 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  tipc_nametbl_unsubscribe+0x337/0x990 net/tipc/name_table.c:808
  tipc_sub_unsubscribe+0x6d/0x2e0 net/tipc/subscr.c:164
  tipc_conn_delete_sub+0x324/0x4a0 net/tipc/topsrv.c:245
  tipc_topsrv_kern_unsubscr+0x21d/0x350 net/tipc/topsrv.c:598
  tipc_group_delete+0x2c0/0x3d0 net/tipc/group.c:231
  tipc_sk_leave+0x10b/0x200 net/tipc/socket.c:2800
  tipc_release+0x154/0xff0 net/tipc/socket.c:576
  sock_release+0x8d/0x1e0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x327/0x7e0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x199/0x270 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
  do_group_exit+0x149/0x400 kernel/exit.c:968
  SYSC_exit_group kernel/exit.c:979 [inline]
  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x43f0d8
RSP: 002b:00007ffca6e03198 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f0d8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf1c8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000020265000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
Code: 00 00 00 00 ad de 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48 89  
da 48 39 c3 74 65 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00  
75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8
RIP: __list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51 RSP:  
ffff8801ae29eec8
---[ end trace 31f0221025ea0e3e ]---


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
