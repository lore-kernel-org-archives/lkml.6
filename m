Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeC2VEE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:04:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:50290 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2VEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:04:02 -0400
X-Google-Smtp-Source: AIpwx49PL/L++/8et4QIad5Ma6WtU3Mp3dQlxfss/eXmNoX6B2AAfXaQ1JUQ7UUJhlADUOjY6O57EBT3KsVt+P0wSm7UIH1HsVH4
MIME-Version: 1.0
Date: Thu, 29 Mar 2018 14:04:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086b99b05689376fa@google.com>
Subject: possible deadlock in perf_event_detach_bpf_prog
From: syzbot <syzbot+dc5ca0e4c9bfafaf2bae@syzkaller.appspotmail.com>
To: ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
Linux 4.16-rc7
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=dc5ca0e4c9bfafaf2bae

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4742532743299072
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dc5ca0e4c9bfafaf2bae@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.


======================================================
WARNING: possible circular locking dependency detected
4.16.0-rc7+ #3 Not tainted
------------------------------------------------------
syz-executor7/24531 is trying to acquire lock:
  (bpf_event_mutex){+.+.}, at: [<000000008a849b07>]  
perf_event_detach_bpf_prog+0x92/0x3d0 kernel/trace/bpf_trace.c:854

but task is already holding lock:
  (&mm->mmap_sem){++++}, at: [<0000000038768f87>] vm_mmap_pgoff+0x198/0x280  
mm/util.c:353

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_sem){++++}:
        __might_fault+0x13a/0x1d0 mm/memory.c:4571
        _copy_to_user+0x2c/0xc0 lib/usercopy.c:25
        copy_to_user include/linux/uaccess.h:155 [inline]
        bpf_prog_array_copy_info+0xf2/0x1c0 kernel/bpf/core.c:1694
        perf_event_query_prog_array+0x1c7/0x2c0 kernel/trace/bpf_trace.c:891
        _perf_ioctl kernel/events/core.c:4750 [inline]
        perf_ioctl+0x3e1/0x1480 kernel/events/core.c:4770
        vfs_ioctl fs/ioctl.c:46 [inline]
        do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
        SYSC_ioctl fs/ioctl.c:701 [inline]
        SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x42/0xb7

-> #0 (bpf_event_mutex){+.+.}:
        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
        perf_event_detach_bpf_prog+0x92/0x3d0 kernel/trace/bpf_trace.c:854
        perf_event_free_bpf_prog kernel/events/core.c:8147 [inline]
        _free_event+0xbdb/0x10f0 kernel/events/core.c:4116
        put_event+0x24/0x30 kernel/events/core.c:4204
        perf_mmap_close+0x60d/0x1010 kernel/events/core.c:5172
        remove_vma+0xb4/0x1b0 mm/mmap.c:172
        remove_vma_list mm/mmap.c:2490 [inline]
        do_munmap+0x82a/0xdf0 mm/mmap.c:2731
        mmap_region+0x59e/0x15a0 mm/mmap.c:1646
        do_mmap+0x6c0/0xe00 mm/mmap.c:1483
        do_mmap_pgoff include/linux/mm.h:2223 [inline]
        vm_mmap_pgoff+0x1de/0x280 mm/util.c:355
        SYSC_mmap_pgoff mm/mmap.c:1533 [inline]
        SyS_mmap_pgoff+0x462/0x5f0 mm/mmap.c:1491
        SYSC_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x42/0xb7

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&mm->mmap_sem);
                                lock(bpf_event_mutex);
                                lock(&mm->mmap_sem);
   lock(bpf_event_mutex);

  *** DEADLOCK ***

1 lock held by syz-executor7/24531:
  #0:  (&mm->mmap_sem){++++}, at: [<0000000038768f87>]  
vm_mmap_pgoff+0x198/0x280 mm/util.c:353

stack backtrace:
CPU: 0 PID: 24531 Comm: syz-executor7 Not tainted 4.16.0-rc7+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2417 [inline]
  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
  __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
  perf_event_detach_bpf_prog+0x92/0x3d0 kernel/trace/bpf_trace.c:854
  perf_event_free_bpf_prog kernel/events/core.c:8147 [inline]
  _free_event+0xbdb/0x10f0 kernel/events/core.c:4116
  put_event+0x24/0x30 kernel/events/core.c:4204
  perf_mmap_close+0x60d/0x1010 kernel/events/core.c:5172
  remove_vma+0xb4/0x1b0 mm/mmap.c:172
  remove_vma_list mm/mmap.c:2490 [inline]
  do_munmap+0x82a/0xdf0 mm/mmap.c:2731
  mmap_region+0x59e/0x15a0 mm/mmap.c:1646
  do_mmap+0x6c0/0xe00 mm/mmap.c:1483
  do_mmap_pgoff include/linux/mm.h:2223 [inline]
  vm_mmap_pgoff+0x1de/0x280 mm/util.c:355
  SYSC_mmap_pgoff mm/mmap.c:1533 [inline]
  SyS_mmap_pgoff+0x462/0x5f0 mm/mmap.c:1491
  SYSC_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454889
RSP: 002b:00007f5f44fdac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f5f44fdb6d4 RCX: 0000000000454889
RDX: 0000000000000000 RSI: 0000000000002000 RDI: 0000000020f1f000
RBP: 000000000072c010 R08: 0000000000000014 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000003f4 R14: 00000000006f7f80 R15: 0000000000000002
bond0 (unregistering): Released all slaves
IPVS: ftp: loaded support on port[0] = 21
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
kernel msg: ebtables bug: please report to author: Wrong len argument
kernel msg: ebtables bug: please report to author: Wrong len argument
kernel msg: ebtables bug: please report to author: Wrong len argument
kernel msg: ebtables bug: please report to author: Wrong len argument
kernel msg: ebtables bug: please report to author: Wrong len argument
kernel msg: ebtables bug: please report to author: Wrong len argument
kernel msg: ebtables bug: please report to author: Wrong len argument


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
