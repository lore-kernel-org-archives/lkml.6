Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEER7F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 13:59:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:55004 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeEER7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 13:59:03 -0400
X-Google-Smtp-Source: AB8JxZrnmrfLpzQ5qSlBBtSHyb3z5XR5bKHkKRziUxFMt0/zKlbT0AZYyo/KkjObIuwYbaBCUPR3Hnr50KF8RDpBRDEs0djLfyLp
MIME-Version: 1.0
Date: Sat, 05 May 2018 10:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000169606056b793179@google.com>
Subject: possible deadlock in sk_diag_fill
From: syzbot <syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com>
To: avagin@openvz.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12164c97800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=c1872be62e587eae9669
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc3+ #59 Not tainted
------------------------------------------------------
syz-executor1/25282 is trying to acquire lock:
000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at: sk_diag_dump_icons  
net/unix/diag.c:82 [inline]
000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at:  
sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144

but task is already holding lock:
00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons  
net/unix/diag.c:64 [inline]
00000000b6895645 (rlock-AF_UNIX){+.+.}, at:  
sk_diag_fill.isra.5+0x94e/0x10d0 net/unix/diag.c:144

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rlock-AF_UNIX){+.+.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        skb_queue_tail+0x26/0x150 net/core/skbuff.c:2900
        unix_dgram_sendmsg+0xf77/0x1730 net/unix/af_unix.c:1797
        sock_sendmsg_nosec net/socket.c:629 [inline]
        sock_sendmsg+0xd5/0x120 net/socket.c:639
        ___sys_sendmsg+0x525/0x940 net/socket.c:2117
        __sys_sendmmsg+0x3bb/0x6f0 net/socket.c:2205
        __compat_sys_sendmmsg net/compat.c:770 [inline]
        __do_compat_sys_sendmmsg net/compat.c:777 [inline]
        __se_compat_sys_sendmmsg net/compat.c:774 [inline]
        __ia32_compat_sys_sendmmsg+0x9f/0x100 net/compat.c:774
        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

-> #0 (&(&u->lock)->rlock/1){+.+.}:
        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
        _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
        sk_diag_dump_icons net/unix/diag.c:82 [inline]
        sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
        sk_diag_dump net/unix/diag.c:178 [inline]
        unix_diag_dump+0x35f/0x550 net/unix/diag.c:206
        netlink_dump+0x507/0xd20 net/netlink/af_netlink.c:2226
        __netlink_dump_start+0x51a/0x780 net/netlink/af_netlink.c:2323
        netlink_dump_start include/linux/netlink.h:214 [inline]
        unix_diag_handler_dump+0x3f4/0x7b0 net/unix/diag.c:307
        __sock_diag_cmd net/core/sock_diag.c:230 [inline]
        sock_diag_rcv_msg+0x2e0/0x3d0 net/core/sock_diag.c:261
        netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
        netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
        netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
        sock_sendmsg_nosec net/socket.c:629 [inline]
        sock_sendmsg+0xd5/0x120 net/socket.c:639
        sock_write_iter+0x35a/0x5a0 net/socket.c:908
        call_write_iter include/linux/fs.h:1784 [inline]
        new_sync_write fs/read_write.c:474 [inline]
        __vfs_write+0x64d/0x960 fs/read_write.c:487
        vfs_write+0x1f8/0x560 fs/read_write.c:549
        ksys_write+0xf9/0x250 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(rlock-AF_UNIX);
                                lock(&(&u->lock)->rlock/1);
                                lock(rlock-AF_UNIX);
   lock(&(&u->lock)->rlock/1);

  *** DEADLOCK ***

5 locks held by syz-executor1/25282:
  #0: 000000003919e1bd (sock_diag_mutex){+.+.}, at: sock_diag_rcv+0x1b/0x40  
net/core/sock_diag.c:271
  #1: 000000004f328d3e (sock_diag_table_mutex){+.+.}, at: __sock_diag_cmd  
net/core/sock_diag.c:225 [inline]
  #1: 000000004f328d3e (sock_diag_table_mutex){+.+.}, at:  
sock_diag_rcv_msg+0x169/0x3d0 net/core/sock_diag.c:261
  #2: 000000004cc04dbb (nlk_cb_mutex-SOCK_DIAG){+.+.}, at:  
netlink_dump+0x98/0xd20 net/netlink/af_netlink.c:2182
  #3: 00000000accdef41 (unix_table_lock){+.+.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
  #3: 00000000accdef41 (unix_table_lock){+.+.}, at:  
unix_diag_dump+0x10a/0x550 net/unix/diag.c:192
  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons  
net/unix/diag.c:64 [inline]
  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at:  
sk_diag_fill.isra.5+0x94e/0x10d0 net/unix/diag.c:144

stack backtrace:
CPU: 1 PID: 25282 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1223
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2417 [inline]
  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
  sk_diag_dump_icons net/unix/diag.c:82 [inline]
  sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
  sk_diag_dump net/unix/diag.c:178 [inline]
  unix_diag_dump+0x35f/0x550 net/unix/diag.c:206
  netlink_dump+0x507/0xd20 net/netlink/af_netlink.c:2226
  __netlink_dump_start+0x51a/0x780 net/netlink/af_netlink.c:2323
  netlink_dump_start include/linux/netlink.h:214 [inline]
  unix_diag_handler_dump+0x3f4/0x7b0 net/unix/diag.c:307
  __sock_diag_cmd net/core/sock_diag.c:230 [inline]
  sock_diag_rcv_msg+0x2e0/0x3d0 net/core/sock_diag.c:261
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  sock_write_iter+0x35a/0x5a0 net/socket.c:908
  call_write_iter include/linux/fs.h:1784 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x64d/0x960 fs/read_write.c:487
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f8ccb9
RSP: 002b:00000000f5f880ac EFLAGS: 00000282 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 000000002058bfe4
RDX: 0000000000000029 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

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
