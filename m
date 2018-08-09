Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A40CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465CD21990
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465CD21990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeHIOPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:15:34 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:46382 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:15:34 -0400
Received: by mail-io0-f197.google.com with SMTP id c5-v6so4142629ioi.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HGaqJsctcNDxDS0i/Mu9FsV34Nk6bG6LhRjR3dYoe/c=;
        b=Q2oXalDMUoQQHJcpPgGDx6MljP2jKUIEK9QCVpMCJCku+AdE9n9QZrVMmJR7nJwzu1
         hipF9RCg2y1tQiJtKETcioYycResqWB/hdpBT/AznhI95mZEBKIMprsmQpNom/vPhEnh
         QZVYgl3drIdoMTyyH/0evb+YtO27pwvr2EehAYiWz1ctmbv+DAzrrCpNNJFF0YRBpsMS
         4VjphyaEyDWwi0mEhlV2nz2J5buuNPZLTLWW8Dj/RiHVZWuy6qjkMkKiwgsaWlnKnkhT
         CJNkQpwlJEExzB54dzMB9nuYsagtIxJ8Rh5KUWJfmSfxqa6SGaL6TsqGK7BA6+0y5LWC
         Vr/A==
X-Gm-Message-State: AOUpUlHJya56efv1TDP0NuGZw+WkFrlGdMilAIAgnS7I79Dno1dhYCLe
        ryDzjk1w89bccsZUKOKPPQ7MrY7ryQNqlr6ZyNCCEXtR33NT
X-Google-Smtp-Source: AA+uWPwTuYbTQhF/yfBFeIAh8w7wpRjEmZp3dtAXTMM/dabu/RLxhh63PRzwZiV6nzj4SNIIJE+FMjZoR0Ny5/GLyKMZuZM6esZa
MIME-Version: 1.0
X-Received: by 2002:a24:1011:: with SMTP id 17-v6mr987760ity.2.1533815461981;
 Thu, 09 Aug 2018 04:51:01 -0700 (PDT)
Date:   Thu, 09 Aug 2018 04:51:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c343ad0572ff3d66@google.com>
Subject: possible deadlock in perf_trace_destroy (3)
From:   syzbot <syzbot+8a284974371a58b241d1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    60f5a2173632 Merge tag 'usercopy-fix-v4.18-rc8' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d200e2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=8a284974371a58b241d1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a284974371a58b241d1@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc7+ #177 Not tainted
------------------------------------------------------
syz-executor0/7368 is trying to acquire lock:
0000000055a8b790 (event_mutex){+.+.}, at: perf_trace_destroy+0x28/0x100  
kernel/trace/trace_event_perf.c:235

but task is already holding lock:
00000000866fdc62 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0x1b5/0x2c0  
mm/util.c:355

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_sem){++++}:
        down_write_killable+0x92/0x150 kernel/locking/rwsem.c:84
        dup_mmap kernel/fork.c:430 [inline]
        dup_mm kernel/fork.c:1266 [inline]
        copy_mm kernel/fork.c:1320 [inline]
        copy_process.part.39+0x2430/0x70b0 kernel/fork.c:1826
        copy_process kernel/fork.c:1639 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2122
        __do_sys_clone kernel/fork.c:2229 [inline]
        __se_sys_clone kernel/fork.c:2223 [inline]
        __x64_sys_clone+0xbf/0x150 kernel/fork.c:2223
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&dup_mmap_sem){++++}:
        down_write+0x8f/0x130 kernel/locking/rwsem.c:70
        percpu_down_write+0xaf/0x520 kernel/locking/percpu-rwsem.c:145
        register_for_each_vma+0x8c/0xdf0 kernel/events/uprobes.c:796
        __uprobe_register kernel/events/uprobes.c:846 [inline]
        uprobe_register+0x47c/0x7c0 kernel/events/uprobes.c:907
        probe_event_enable+0x5f5/0xe90 kernel/trace/trace_uprobe.c:920
        trace_uprobe_register+0x4c9/0xcf0 kernel/trace/trace_uprobe.c:1205
        perf_trace_event_reg kernel/trace/trace_event_perf.c:123 [inline]
        perf_trace_event_init+0x4fe/0x990 kernel/trace/trace_event_perf.c:198
        perf_uprobe_init+0x1e5/0x280 kernel/trace/trace_event_perf.c:327
        perf_uprobe_event_init+0xff/0x190 kernel/events/core.c:8467
        perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9739
        perf_init_event kernel/events/core.c:9770 [inline]
        perf_event_alloc.part.93+0x1955/0x30b0 kernel/events/core.c:10043
        perf_event_alloc kernel/events/core.c:10399 [inline]
        __do_sys_perf_event_open+0xab2/0x30f0 kernel/events/core.c:10500
        __se_sys_perf_event_open kernel/events/core.c:10389 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10389
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&uprobe->register_rwsem){+.+.}:
        down_write+0x8f/0x130 kernel/locking/rwsem.c:70
        uprobe_register+0x3dd/0x7c0 kernel/events/uprobes.c:904
        probe_event_enable+0x5f5/0xe90 kernel/trace/trace_uprobe.c:920
        trace_uprobe_register+0x4c9/0xcf0 kernel/trace/trace_uprobe.c:1205
        perf_trace_event_reg kernel/trace/trace_event_perf.c:123 [inline]
        perf_trace_event_init+0x4fe/0x990 kernel/trace/trace_event_perf.c:198
        perf_uprobe_init+0x1e5/0x280 kernel/trace/trace_event_perf.c:327
        perf_uprobe_event_init+0xff/0x190 kernel/events/core.c:8467
        perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9739
        perf_init_event kernel/events/core.c:9770 [inline]
        perf_event_alloc.part.93+0x1955/0x30b0 kernel/events/core.c:10043
        perf_event_alloc kernel/events/core.c:10399 [inline]
        __do_sys_perf_event_open+0xab2/0x30f0 kernel/events/core.c:10500
        __se_sys_perf_event_open kernel/events/core.c:10389 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10389
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (event_mutex){+.+.}:
        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
        __mutex_lock_common kernel/locking/mutex.c:757 [inline]
        __mutex_lock+0x176/0x1820 kernel/locking/mutex.c:894
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
        perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:235
        tp_perf_event_destroy+0x15/0x20 kernel/events/core.c:8329
        _free_event+0x407/0x1440 kernel/events/core.c:4445
        put_event+0x48/0x60 kernel/events/core.c:4531
        perf_mmap_close+0x615/0x1190 kernel/events/core.c:5514
        remove_vma+0xb6/0x180 mm/mmap.c:181
        remove_vma_list mm/mmap.c:2549 [inline]
        do_munmap+0x743/0xf90 mm/mmap.c:2785
        mmap_region+0x61f/0x16b0 mm/mmap.c:1705
        do_mmap+0xa06/0x1320 mm/mmap.c:1535
        do_mmap_pgoff include/linux/mm.h:2306 [inline]
        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:357
        ksys_mmap_pgoff+0xf1/0x660 mm/mmap.c:1585
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   event_mutex --> &dup_mmap_sem --> &mm->mmap_sem

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&mm->mmap_sem);
                                lock(&dup_mmap_sem);
                                lock(&mm->mmap_sem);
   lock(event_mutex);

  *** DEADLOCK ***

1 lock held by syz-executor0/7368:
  #0: 00000000866fdc62 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0x1b5/0x2c0  
mm/util.c:355

stack backtrace:
CPU: 0 PID: 7368 Comm: syz-executor0 Not tainted 4.18.0-rc7+ #177
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.57+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __mutex_lock_common kernel/locking/mutex.c:757 [inline]
  __mutex_lock+0x176/0x1820 kernel/locking/mutex.c:894
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
  perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:235
  tp_perf_event_destroy+0x15/0x20 kernel/events/core.c:8329
  _free_event+0x407/0x1440 kernel/events/core.c:4445
  put_event+0x48/0x60 kernel/events/core.c:4531
  perf_mmap_close+0x615/0x1190 kernel/events/core.c:5514
  remove_vma+0xb6/0x180 mm/mmap.c:181
  remove_vma_list mm/mmap.c:2549 [inline]
  do_munmap+0x743/0xf90 mm/mmap.c:2785
  mmap_region+0x61f/0x16b0 mm/mmap.c:1705
  do_mmap+0xa06/0x1320 mm/mmap.c:1535
  do_mmap_pgoff include/linux/mm.h:2306 [inline]
  vm_mmap_pgoff+0x213/0x2c0 mm/util.c:357
  ksys_mmap_pgoff+0xf1/0x660 mm/mmap.c:1585
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456b29
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe9fd1ecc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fe9fd1ed6d4 RCX: 0000000000456b29
RDX: 0000000000000000 RSI: 0000000000200000 RDI: 00000000205a1000
RBP: 00000000009300a0 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d1b50 R14: 00000000004c72d5 R15: 0000000000000000
capability: warning: `syz-executor6' uses deprecated v2 capabilities in a  
way that may be insecure
ntfs: (device loop3): parse_options(): The umask option requires an  
argument.
ntfs: (device loop3): parse_options(): The umask option requires an  
argument.
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
bridge0: port 1(bridge_slave_0) entered disabled state
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
bridge0: port 1(bridge_slave_0) entered disabled state
mmap: syz-executor4 (7501): VmData 18391040 exceed data ulimit 0. Update  
limits or use boot option ignore_rlimit_data.
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
