Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDDFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761A021CCE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761A021CCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeHJO2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:28:40 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:54251 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeHJO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:28:40 -0400
Received: by mail-it0-f69.google.com with SMTP id 22-v6so1685181ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 04:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fv0gvpCkqj39CaHbCRD+sj2HwWEr3NRFFSUCQSpvxSg=;
        b=AASr0VBL5jEfYsFlFBaBlOP9i36/y7mqd7SLesaC+OuT0YHU6sqn4MULNeUVZJg/GY
         QEkWCuu1evwKvtHkz25ypw91DoV8DV1XtkcPDCny7n83kX3QSiQHWeqy3T3j9nPuc+Um
         N1W8Bd18PdT2fvEGaqMQ735HRkxIP13xRYwDOwKF7PC6OzCYH2PDWmer123fQmecdwvQ
         sgd1XfmMpP71A50uxrsxgCG/gxMqaKSD0EXE5jFy9Es5Tf+PSLoz4sHrtYBTHWJZxLnj
         SrzPz254OH57OEiyCwwda7i/jpmCPtgJK7KobuohEUhe/IpfdzWWSg+mj/P6CrjS6mUE
         TNfQ==
X-Gm-Message-State: AOUpUlFyp+xjgLMzFhC1cmAaDjerC4dJCBSGkpm0zL6QoALTzQAEUHuO
        +OxARX0VZBTzWb4o0+WEQQiy49wD/JmCSpaYGoxnKKnBj7Eq
X-Google-Smtp-Source: AA+uWPy9vFvUSHzEpYN0hvjEfpxV2URJuOYhHpYMGBwDYhgVP8XC2FHjg0TWkBHkWbVEvVGiQk/OKQ5ObEAU6Ro4c2tnzWSVGtxg
MIME-Version: 1.0
X-Received: by 2002:a24:d51:: with SMTP id 78-v6mr997931itx.7.1533902342591;
 Fri, 10 Aug 2018 04:59:02 -0700 (PDT)
Date:   Fri, 10 Aug 2018 04:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004024240573137822@google.com>
Subject: possible deadlock in shmem_fallocate (2)
From:   syzbot <syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com>
To:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4110b42356f3 Add linux-next specific files for 20180810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1411d6e2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d80606e3795a4f5
dashboard link: https://syzkaller.appspot.com/bug?extid=4b8b031b89e6b96c4b2e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=175052f8400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11873622400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc8-next-20180810+ #36 Not tainted
------------------------------------------------------
syz-executor900/4483 is trying to acquire lock:
00000000d2bfc8fe (&sb->s_type->i_mutex_key#9){++++}, at: inode_lock  
include/linux/fs.h:765 [inline]
00000000d2bfc8fe (&sb->s_type->i_mutex_key#9){++++}, at:  
shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602

but task is already holding lock:
0000000025208078 (ashmem_mutex){+.+.}, at: ashmem_shrink_scan+0xb4/0x630  
drivers/staging/android/ashmem.c:448

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (ashmem_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
        ashmem_mmap+0x55/0x520 drivers/staging/android/ashmem.c:361
        call_mmap include/linux/fs.h:1844 [inline]
        mmap_region+0xf27/0x1c50 mm/mmap.c:1762
        do_mmap+0xa10/0x1220 mm/mmap.c:1535
        do_mmap_pgoff include/linux/mm.h:2298 [inline]
        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:357
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&mm->mmap_sem){++++}:
        __might_fault+0x155/0x1e0 mm/memory.c:4568
        _copy_to_user+0x30/0x110 lib/usercopy.c:25
        copy_to_user include/linux/uaccess.h:155 [inline]
        filldir+0x1ea/0x3a0 fs/readdir.c:196
        dir_emit_dot include/linux/fs.h:3464 [inline]
        dir_emit_dots include/linux/fs.h:3475 [inline]
        dcache_readdir+0x13a/0x620 fs/libfs.c:193
        iterate_dir+0x48b/0x5d0 fs/readdir.c:51
        __do_sys_getdents fs/readdir.c:231 [inline]
        __se_sys_getdents fs/readdir.c:212 [inline]
        __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#9){++++}:
        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
        down_write+0x8f/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:765 [inline]
        shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
        ashmem_shrink_scan+0x236/0x630 drivers/staging/android/ashmem.c:455
        ashmem_ioctl+0x3ae/0x13a0 drivers/staging/android/ashmem.c:797
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:501 [inline]
        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
        __do_sys_ioctl fs/ioctl.c:709 [inline]
        __se_sys_ioctl fs/ioctl.c:707 [inline]
        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &sb->s_type->i_mutex_key#9 --> &mm->mmap_sem --> ashmem_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(ashmem_mutex);
                                lock(&mm->mmap_sem);
                                lock(ashmem_mutex);
   lock(&sb->s_type->i_mutex_key#9);

  *** DEADLOCK ***

1 lock held by syz-executor900/4483:
  #0: 0000000025208078 (ashmem_mutex){+.+.}, at:  
ashmem_shrink_scan+0xb4/0x630 drivers/staging/android/ashmem.c:448

stack backtrace:
CPU: 1 PID: 4483 Comm: syz-executor900 Not tainted  
4.18.0-rc8-next-20180810+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.37.cold.58+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  down_write+0x8f/0x130 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:765 [inline]
  shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
  ashmem_shrink_scan+0x236/0x630 drivers/staging/android/ashmem.c:455
  ashmem_ioctl+0x3ae/0x13a0 drivers/staging/android/ashmem.c:797
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440099
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff3613dbf8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440099
RDX: 00000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
