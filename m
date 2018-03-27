Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeC0LQE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:16:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:54814 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC0LQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:16:01 -0400
X-Google-Smtp-Source: AIpwx4+XacEsV7qwKkM3gsbhgPVDFgefUuFbQyZdo0L3Sx9EM4gbfAY8llTsTilQjrtV35ZpNL4/Q7Jzl1iMy/qMZ9k2kBFEEoD9
MIME-Version: 1.0
Date: Tue, 27 Mar 2018 04:16:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7826f0568630354@google.com>
Subject: possible deadlock in rtnl_lock (5)
From: syzbot <syzbot+a46d6abf9d56b1365a72@syzkaller.appspotmail.com>
To: christian.brauner@ubuntu.com, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, fw@strlen.de,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
Linux 4.16-rc7
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=a46d6abf9d56b1365a72

So far this crash happened 27 times on net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6524202618191872
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5383267238805504
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5136472378179584
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a46d6abf9d56b1365a72@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: sync thread started: state = BACKUP, mcast_ifn = sit0, syncid = 0, id  
= 0
IPVS: sync thread started: state = BACKUP, mcast_ifn = sit0, syncid = 0, id  
= 0

============================================
IPVS: stopping backup sync thread 4500 ...
WARNING: possible recursive locking detected
4.16.0-rc7+ #3 Not tainted
--------------------------------------------
syzkaller688027/4497 is trying to acquire lock:
  (rtnl_mutex){+.+.}, at: [<00000000bb14d7fb>] rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74

but task is already holding lock:
IPVS: stopping backup sync thread 4495 ...
  (rtnl_mutex){+.+.}, at: [<00000000bb14d7fb>] rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(rtnl_mutex);
   lock(rtnl_mutex);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

2 locks held by syzkaller688027/4497:
  #0:  (rtnl_mutex){+.+.}, at: [<00000000bb14d7fb>] rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74
  #1:  (ipvs->sync_mutex){+.+.}, at: [<00000000703f78e3>]  
do_ip_vs_set_ctl+0x10f8/0x1cc0 net/netfilter/ipvs/ip_vs_ctl.c:2388

stack backtrace:
CPU: 1 PID: 4497 Comm: syzkaller688027 Not tainted 4.16.0-rc7+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_deadlock_bug kernel/locking/lockdep.c:1761 [inline]
  check_deadlock kernel/locking/lockdep.c:1805 [inline]
  validate_chain kernel/locking/lockdep.c:2401 [inline]
  __lock_acquire+0xe8f/0x3e00 kernel/locking/lockdep.c:3431
  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
  __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
  ip_mc_drop_socket+0x88/0x230 net/ipv4/igmp.c:2643
  inet_release+0x4e/0x1c0 net/ipv4/af_inet.c:413
  sock_release+0x8d/0x1e0 net/socket.c:595
  start_sync_thread+0x2213/0x2b70 net/netfilter/ipvs/ip_vs_sync.c:1924
  do_ip_vs_set_ctl+0x1139/0x1cc0 net/netfilter/ipvs/ip_vs_ctl.c:2389
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0x97/0xa0 net/ipv4/ip_sockglue.c:1261
  udp_setsockopt+0x45/0x80 net/ipv4/udp.c:2406
  sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2975
  SYSC_setsockopt net/socket.c:1849 [inline]
  SyS_setsockopt+0x189/0x360 net/socket.c:1828
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x446a69
RSP: 002b:00007fa1c3a64da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000446a69
RDX: 000000000000048b RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006e29fc R08: 0000000000000018 R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 00000000006e29f8
R13: 00676e697279656b R14: 00007fa1c3a659c0 R15: 00000000006e2b60


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
