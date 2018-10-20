Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A1FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C7B2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C7B2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeJUAYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:24:00 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:58293 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeJUAYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:24:00 -0400
Received: by mail-it1-f198.google.com with SMTP id d7-v6so6954901itf.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 09:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lF8qd7E16kcTFUYbgaEbIEQ+/zU/IoMZ8vRa6eSHVAg=;
        b=m9uOvteOQL00X/IQmIXcehn7S/RzPPqy/Zrb01A2Jhweco/PZHEuKhpomw2T+Ph/Ip
         rzyyCHUEwyFrj9OSIlGUZGMqJRivvtwqW/H+zFqo61oQoHYzKm/Cwc+qg3PmKIJrP6qH
         FJL1R0T9NFxLoXttx/d6ECKTYgidy7yKVOu31oMqKOGmMH1wbzjyTJ1EraYg8HWGz2Tw
         hz2LN1y+sMYiuvpGKWWIKfSOqWJ0D/kVmPzPY05Z30Nj3Z63DRSzs8bYOpmFkfDoc8UA
         mDy/CfviC3xb9l6NQwKy/A5fik1uD+jVldvyen3zsu1yEEjrDLVU1cMQcwveFy5r97dD
         xmWg==
X-Gm-Message-State: ABuFfojI5Qlx7SfphBsmwWi6c5Lp0R5QUXqugzsaBh8RpX8obSHwzZKP
        Z44R2XjwuQixauXpawl8gYEmu1ZHXA20nAByuZl3vLO13F2e
X-Google-Smtp-Source: ACcGV62PRfJxPFweu18T4CCN1SMYcz1ga7XwXISlkxylhGdsbEdhdcqMn/ynItj/jkU8i4yUWhYWaw6/lqe5R57mcNRzrJnkcO5f
MIME-Version: 1.0
X-Received: by 2002:a24:8306:: with SMTP id d6-v6mr7119690ite.24.1540051982525;
 Sat, 20 Oct 2018 09:13:02 -0700 (PDT)
Date:   Sat, 20 Oct 2018 09:13:02 -0700
In-Reply-To: <000000000000cd1e2205785951c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005aafaa0578ab4b11@google.com>
Subject: Re: possible deadlock in __generic_file_fsync
From:   syzbot <syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    270b77a0f30e Merge tag 'drm-fixes-2018-10-20-1' of git://a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146f4ad9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=5cd33f0e6abe2bb3e397
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1436fc45400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11058e2d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com

syz-executor388 (5339) used greatest stack depth: 15944 bytes left
syz-executor388 (5337) used greatest stack depth: 15800 bytes left

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc8+ #293 Not tainted
------------------------------------------------------
kworker/0:1/14 is trying to acquire lock:
000000008e61a3a9 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
000000008e61a3a9 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
__generic_file_fsync+0xb5/0x200 fs/libfs.c:981

but task is already holding lock:
00000000160c39d9 ((work_completion)(&dio->complete_work)){+.+.}, at:  
process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&dio->complete_work)){+.+.}:
        process_one_work+0xc0a/0x1b90 kernel/workqueue.c:2129
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x420 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

-> #1 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
        flush_workqueue+0x30a/0x1e10 kernel/workqueue.c:2655
        drain_workqueue+0x2a9/0x640 kernel/workqueue.c:2820
        destroy_workqueue+0xc6/0x9c0 kernel/workqueue.c:4155
        sb_init_dio_done_wq+0x74/0x90 fs/direct-io.c:634
        do_blockdev_direct_IO+0x12ea/0x9d70 fs/direct-io.c:1283
        __blockdev_direct_IO+0x9d/0xc6 fs/direct-io.c:1417
        ext4_direct_IO_write fs/ext4/inode.c:3743 [inline]
        ext4_direct_IO+0xae8/0x2230 fs/ext4/inode.c:3870
        generic_file_direct_write+0x275/0x4b0 mm/filemap.c:3042
        __generic_file_write_iter+0x2ff/0x630 mm/filemap.c:3221
        ext4_file_write_iter+0x390/0x1420 fs/ext4/file.c:266
        call_write_iter include/linux/fs.h:1808 [inline]
        aio_write+0x3b1/0x610 fs/aio.c:1561
        io_submit_one+0xaa1/0xf80 fs/aio.c:1835
        __do_sys_io_submit fs/aio.c:1916 [inline]
        __se_sys_io_submit fs/aio.c:1887 [inline]
        __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1887
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#10){+.+.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:738 [inline]
        __generic_file_fsync+0xb5/0x200 fs/libfs.c:981
        ext4_sync_file+0xa4f/0x1510 fs/ext4/fsync.c:120
        vfs_fsync_range+0x140/0x220 fs/sync.c:197
        generic_write_sync include/linux/fs.h:2732 [inline]
        dio_complete+0x75c/0x9e0 fs/direct-io.c:329
        dio_aio_complete_work+0x20/0x30 fs/direct-io.c:341
        process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x420 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

other info that might help us debug this:

Chain exists of:
   &sb->s_type->i_mutex_key#10 --> (wq_completion)"dio/%s"sb->s_id -->  
(work_completion)(&dio->complete_work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&dio->complete_work));
                                lock((wq_completion)"dio/%s"sb->s_id);
                                lock((work_completion)(&dio->complete_work));
   lock(&sb->s_type->i_mutex_key#10);

  *** DEADLOCK ***

2 locks held by kworker/0:1/14:
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000006dbdba7d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
process_one_work+0xb43/0x1b90 kernel/workqueue.c:2124
  #1: 00000000160c39d9 ((work_completion)(&dio->complete_work)){+.+.}, at:  
process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128

stack backtrace:
CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.0-rc8+ #293
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: dio/sda1 dio_aio_complete_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.33.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1861 [inline]
  check_prevs_add kernel/locking/lockdep.c:1974 [inline]
  validate_chain kernel/locking/lockdep.c:2415 [inline]
  __lock_acquire+0x33e4/0x4ec0 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  down_write+0x8a/0x130 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:738 [inline]
  __generic_file_fsync+0xb5/0x200 fs/libfs.c:981
  ext4_sync_file+0xa4f/0x1510 fs/ext4/fsync.c:120
  vfs_fsync_range+0x140/0x220 fs/sync.c:197
  generic_write_sync include/linux/fs.h:2732 [inline]
  dio_complete+0x75c/0x9e0 fs/direct-io.c:329
  dio_aio_complete_work+0x20/0x30 fs/direct-io.c:341
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.Ay7bpq/1/bus PID: 14 Comm: kworker/0:1
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.l9bGzq/7/bus PID: 2682 Comm: kworker/0:2
syz-executor388 (5488) used greatest stack depth: 15128 bytes left
syz-executor388 (5560) used greatest stack depth: 14328 bytes left
syz-executor388 (5630) used greatest stack depth: 12872 bytes left
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.l9bGzq/18/bus PID: 2682 Comm: kworker/0:2
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.Ay7bpq/19/bus PID: 2682 Comm: kworker/0:2
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.Ay7bpq/22/bus PID: 5540 Comm: kworker/0:4
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.ygzABq/30/bus PID: 14 Comm: kworker/0:1
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.aGaJtq/29/bus PID: 5 Comm: kworker/0:0
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.qLFhwq/30/bus PID: 5540 Comm: kworker/0:4
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.Ay7bpq/35/bus PID: 5540 Comm: kworker/0:4
syz-executor388 (6261) used greatest stack depth: 12504 bytes left
Page cache invalidation failure on direct I/O.  Possible data corruption  
due to collision with buffered I/O!
File: /root/syzkaller.aGaJtq/49/bus PID: 14 Comm: kworker/0:1
syz-executor388 (7306) used greatest stack depth: 12488 bytes left

