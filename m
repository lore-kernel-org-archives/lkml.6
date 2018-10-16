Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AD920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AD920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJPWPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:15:46 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34054 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:15:46 -0400
Received: by mail-io1-f71.google.com with SMTP id y3-v6so21796611iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qx8qf43Yi1QU1m+Qmj7AhXhwtA2ogn83a0Q1eLRXx10=;
        b=H9yQ8JGLgBnaVJ+/uOiM+SHqH4uHqfDxteRaqj+MC1h0AVFn6+dxXvDAbqlsX08HTM
         rTCi1YgEk2lTGh+Byl98WAdRY3WRM3lPcOhJetVdffwd1oBwdCVkQ7BVdo5x9Toj7l9D
         TCLQzWtiTQTRATAPZiQwMNEnd95IWc+td3JfgwQN46smXHuMlS2asrvF/1i2AP9pRqPC
         xZCioyAg35wjD3f/D/vv0c/2D1/HE84ed6bA4530Wvgj4stCYQpJ37CHkv6yI9TTsRTy
         AmEqNTl81ocFC50fIVnGH0cJuOLwVh0yPEZow3wWJhHRaHHxBjH7tu3vNRMnZ60/7WEv
         Y63A==
X-Gm-Message-State: ABuFfohpHxjVUFl3y5iGBt4E0dUnl9kDQGlfAXqa6SDizQtvKnFx5xds
        Rt2oQpZYQN7PJfCc1TtmVIMolDBz6uI3EMYw5z0xSIPxcU8i
X-Google-Smtp-Source: ACcGV62YX8234gMq2pPDuOYZjLrRr0fNisKNwyjQd2uPottR+uXj6wnEp61m9RIq0yX7GY/I9NV6VDXztaIEne+7QMvhG5IjFEn4
MIME-Version: 1.0
X-Received: by 2002:a24:6c51:: with SMTP id w78-v6mr17213036itb.5.1539699903368;
 Tue, 16 Oct 2018 07:25:03 -0700 (PDT)
Date:   Tue, 16 Oct 2018 07:25:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd1e2205785951c2@google.com>
Subject: possible deadlock in __generic_file_fsync
From:   syzbot <syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d5d82417dd6 Add linux-next specific files for 20181016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c8e495400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e55f86f01cf5131
dashboard link: https://syzkaller.appspot.com/bug?extid=5cd33f0e6abe2bb3e397
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc8-next-20181016+ #95 Not tainted
------------------------------------------------------
kworker/1:1/22 is trying to acquire lock:
000000009092b9a9 (&sb->s_type->i_mutex_key#10){++++}, at: inode_lock  
include/linux/fs.h:764 [inline]
000000009092b9a9 (&sb->s_type->i_mutex_key#10){++++}, at:  
__generic_file_fsync+0xb5/0x200 fs/libfs.c:999

but task is already holding lock:
000000000349cf73 ((work_completion)(&dio->complete_work)){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env

-> #2 ((work_completion)(&dio->complete_work)){+.+.}:
        process_one_work+0xc0a/0x1c40 kernel/workqueue.c:2129
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #1 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
        flush_workqueue+0x30a/0x1e10 kernel/workqueue.c:2655
        drain_workqueue+0x2a9/0x640 kernel/workqueue.c:2820
        destroy_workqueue+0xc6/0x9c0 kernel/workqueue.c:4155
        sb_init_dio_done_wq+0x74/0x90 fs/direct-io.c:634
        dio_set_defer_completion fs/direct-io.c:646 [inline]
        get_more_blocks fs/direct-io.c:723 [inline]
        do_direct_IO fs/direct-io.c:1001 [inline]
        do_blockdev_direct_IO+0x5bd9/0xefa0 fs/direct-io.c:1331
        __blockdev_direct_IO+0x9d/0xc6 fs/direct-io.c:1417
        ext4_direct_IO_write fs/ext4/inode.c:3774 [inline]
        ext4_direct_IO+0xadd/0x2210 fs/ext4/inode.c:3901
        generic_file_direct_write+0x275/0x4b0 mm/filemap.c:2951
        __generic_file_write_iter+0x2ff/0x630 mm/filemap.c:3130
        ext4_file_write_iter+0x390/0x1420 fs/ext4/file.c:266
        call_write_iter include/linux/fs.h:1844 [inline]
        aio_write+0x3b1/0x610 fs/aio.c:1562
        io_submit_one+0xaa1/0xf80 fs/aio.c:1836
        __do_sys_io_submit fs/aio.c:1917 [inline]
        __se_sys_io_submit fs/aio.c:1888 [inline]
        __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1888
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#10){++++}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3845
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:764 [inline]
        __generic_file_fsync+0xb5/0x200 fs/libfs.c:999
        ext4_sync_file+0xa45/0x1500 fs/ext4/fsync.c:120
        vfs_fsync_range+0x140/0x220 fs/sync.c:197
        generic_write_sync include/linux/fs.h:2776 [inline]
        dio_complete+0x75c/0x9e0 fs/direct-io.c:329
        dio_aio_complete_work+0x20/0x30 fs/direct-io.c:341
        process_one_work+0xc8b/0x1c40 kernel/workqueue.c:2153
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

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

2 locks held by kworker/1:1/22:
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
__write_once_size include/linux/compiler.h:206 [inline]
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000009ad4e495 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
process_one_work+0xb43/0x1c40 kernel/workqueue.c:2124
  #1: 000000000349cf73 ((work_completion)(&dio->complete_work)){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128

stack backtrace:
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 4.19.0-rc8-next-20181016+ #95
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: dio/sda1 dio_aio_complete_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1222
  check_prev_add kernel/locking/lockdep.c:1864 [inline]
  check_prevs_add kernel/locking/lockdep.c:1977 [inline]
  validate_chain kernel/locking/lockdep.c:2348 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3342
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3845
  down_write+0x8a/0x130 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:764 [inline]
  __generic_file_fsync+0xb5/0x200 fs/libfs.c:999
  ext4_sync_file+0xa45/0x1500 fs/ext4/fsync.c:120
  vfs_fsync_range+0x140/0x220 fs/sync.c:197
  generic_write_sync include/linux/fs.h:2776 [inline]
  dio_complete+0x75c/0x9e0 fs/direct-io.c:329
  dio_aio_complete_work+0x20/0x30 fs/direct-io.c:341
  process_one_work+0xc8b/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
audit: type=1804 audit(1539691048.645:329): pid=29314 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/709/bus" dev="sda1"  
ino=16793 res=1
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
audit: type=1804 audit(1539691048.895:330): pid=29314 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/709/bus" dev="sda1"  
ino=16793 res=1
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
audit: type=1804 audit(1539691048.945:331): pid=29316 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/709/bus" dev="sda1"  
ino=16793 res=1
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1804 audit(1539691049.235:332): pid=29353 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/710/bus" dev="sda1"  
ino=16792 res=1
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
audit: type=1804 audit(1539691049.585:333): pid=29353 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/710/bus" dev="sda1"  
ino=16792 res=1
audit: type=1804 audit(1539691049.635:334): pid=29356 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/710/bus" dev="sda1"  
ino=16792 res=1
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
audit: type=1804 audit(1539691049.915:335): pid=29402 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/711/bus" dev="sda1"  
ino=16774 res=1
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'kvm' (00000000cb832808): kobject_uevent_env
kobject: 'kvm' (00000000cb832808): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000cb832808): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (00000000cb832808): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000cb832808): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'kvm' (00000000cb832808): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000cb832808): kobject_uevent_env
kobject: 'kvm' (00000000cb832808): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kauditd_printk_skb: 5 callbacks suppressed
audit: type=1804 audit(1539691052.035:341): pid=29544 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/715/bus" dev="sda1"  
ino=16626 res=1
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
audit: type=1804 audit(1539691052.285:342): pid=29544 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/715/bus" dev="sda1"  
ino=16626 res=1
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
audit: type=1804 audit(1539691052.335:343): pid=29544 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/715/bus" dev="sda1"  
ino=16626 res=1
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
audit: type=1804 audit(1539691052.605:344): pid=29577 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/716/bus" dev="sda1"  
ino=16642 res=1
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
audit: type=1804 audit(1539691053.335:345): pid=29586 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/716/bus" dev="sda1"  
ino=16642 res=1
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
audit: type=1804 audit(1539691053.495:346): pid=29629 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/716/bus" dev="sda1"  
ino=16642 res=1
REISERFS warning (device loop3): super-6502 reiserfs_getopt: unknown mount  
option "hash=tea"
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1804 audit(1539691053.785:347): pid=29650 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/717/bus" dev="sda1"  
ino=16627 res=1
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
audit: type=1804 audit(1539691054.055:348): pid=29650 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/717/bus" dev="sda1"  
ino=16627 res=1
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
audit: type=1804 audit(1539691054.115:349): pid=29650 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/717/bus" dev="sda1"  
ino=16627 res=1
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
audit: type=1804 audit(1539691054.385:350): pid=29697 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/718/bus" dev="sda1"  
ino=16627 res=1
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
overlayfs: unrecognized mount option "func=BPRM_CHECK" or missing value
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
overlayfs: unrecognized mount option "func=BPRM_CHECK" or missing value
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kauditd_printk_skb: 13 callbacks suppressed
audit: type=1804 audit(1539691057.335:364): pid=29899 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/723/bus" dev="sda1"  
ino=16525 res=1
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
ceph: device name is missing path (no : separator in /dev/sg0)
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000003d7cbd7d): kobject_uevent_env
kobject: 'loop5' (000000003d7cbd7d): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000020f33ae7): kobject_uevent_env
kobject: 'loop2' (0000000020f33ae7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c7b421aa): kobject_uevent_env
kobject: 'loop4' (00000000c7b421aa): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000092021daa): kobject_uevent_env
audit: type=1804 audit(1539691057.605:365): pid=29892 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/723/bus" dev="sda1"  
ino=16525 res=1
kobject: 'loop0' (0000000092021daa): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000874f0bf8): kobject_uevent_env
kobject: 'loop1' (00000000874f0bf8): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
audit: type=1804 audit(1539691057.665:366): pid=29907 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor2"  
name="/root/syzkaller-testdir252511476/syzkaller.X0lV5F/723/bus" dev="sda1"  
ino=16525 res=1
kobject: 'loop3' (000000003d41719b): kobject_uevent_env
kobject: 'loop3' (000000003d41719b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
