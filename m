Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeDBGBj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:01:39 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:46861 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeDBGBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:01:04 -0400
X-Google-Smtp-Source: AIpwx4+I9UWg+VI2DrcgXgxqUJDbn8Imk1fxGuR9s0nqcO009NaeIwpFiNXpDwAeByYb34chGr75loO8z+JTHhGqKoLlgEDAz8wG
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 23:01:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7c16a0568d750ce@google.com>
Subject: general protection fault in tipc_nametbl_unsubscribe
From: syzbot <syzbot+4859fe19555ea87c42f3@syzkaller.appspotmail.com>
To: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=4859fe19555ea87c42f3

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4775372465897472
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4868734988582912
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5073802094444544
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4859fe19555ea87c42f3@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Name sequence creation failed, no memory
Failed to create subscription for {24576,0,4294967295}
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4447 Comm: syzkaller851181 Not tainted 4.16.0-rc7+ #374
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
RSP: 0018:ffff8801ae1aef48 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801cf54c760 RDI: ffff8801cf54c768
RBP: ffff8801ae1aef60 R08: 1ffff10035c35cff R09: ffffffff89956150
R10: ffff8801ae1aee28 R11: 000000000000168a R12: ffffffff87745ea0
R13: ffff8801ae1af100 R14: ffff8801cf54c760 R15: ffff8801cf4c8cc0
FS:  0000000000000000(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dce15c3090 CR3: 000000000846a002 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  tipc_nametbl_unsubscribe+0x318/0x990 net/tipc/name_table.c:848
  tipc_subscrb_subscrp_delete+0x1e9/0x460 net/tipc/subscr.c:212
  tipc_subscrb_delete net/tipc/subscr.c:242 [inline]
  tipc_subscrb_release_cb+0x17/0x30 net/tipc/subscr.c:321
  tipc_topsrv_kern_unsubscr+0x2c3/0x430 net/tipc/server.c:535
  tipc_group_delete+0x2c0/0x3d0 net/tipc/group.c:231
  tipc_sk_leave+0x10b/0x200 net/tipc/socket.c:2795
  tipc_release+0x154/0xff0 net/tipc/socket.c:577
  sock_release+0x8d/0x1e0 net/socket.c:595
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
RIP: 0033:0x43f228
RSP: 002b:00007ffde31217e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f228
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf308 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00000000204ee000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
Code: 00 00 00 00 ad de 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48 89  
da 48 39 c3 74 65 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00  
75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8
RIP: __list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51 RSP:  
ffff8801ae1aef48
---[ end trace ba18c1598e2d5535 ]---


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
