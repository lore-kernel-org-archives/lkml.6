Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA96AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0602084C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0602084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeKQSj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 13:39:58 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:33902 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeKQSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 13:39:58 -0500
Received: by mail-io1-f69.google.com with SMTP id c7-v6so536250iod.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 00:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+qOsSw38J8aunTaqatL1fHIIX0JtcEN43W5c4jzM+ok=;
        b=GXGMgmHaZCDeNimfH/T59tiyxIIDuShUk11ET/soeoKlqbDyoMgezz34dg9AlKfE1r
         Z8AgzONrwSpEf0xg7zdOKDNDcow5ZOoyo+YDFoy8d4KfkqzdPnKRF3xoLEGpx9zvKygq
         a3DO/MWD81q0AZ/3u8aDennVB9gKYMflBCcJBwmhneV0RTKyWfQosn5DkaAn+h7g34NJ
         TpLlCavej5z3SC8FVx5MjYO/+TTxdjTJJ/ixnPDpRwLgkUzRkYNTtxwTSnRuANGXBXOf
         5mv4Xv/YAoXd/LbswB9368By7Ke1uHr6g3bLkueBbsAbWeMXOxZf1bYoCBsWzgFIbCN6
         KYhg==
X-Gm-Message-State: AA+aEWY3aRfW0C4CpqpYl6nOpi4ssNoXemq0ZFsVaXZD4DReae3UgY+s
        AlNvGI+DMWWNbZR+8cBa43lPvkv+eHaC/sz1TzXo4n/VFhEd
X-Google-Smtp-Source: AFSGD/UbrCLZE3jI8K9PNuxiw3PullMviXg7aJ4xmpWS79ckMoAZVE2NhBVasyNJiwJXQHRT4Og0VD6e0VOCkrflsGEycbocMjql
MIME-Version: 1.0
X-Received: by 2002:a5e:8d14:: with SMTP id m20-v6mr5804473ioj.20.1542443042943;
 Sat, 17 Nov 2018 00:24:02 -0800 (PST)
Date:   Sat, 17 Nov 2018 00:24:02 -0800
In-Reply-To: <0000000000005943f3057acf6a1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a93b1d057ad80185@google.com>
Subject: Re: possible deadlock in v4l2_release
From:   syzbot <syzbot+ea05c832a73d0615bf33@syzkaller.appspotmail.com>
To:     ezequiel@collabora.com, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, sque@chromium.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1ce80e0fe98e Merge tag 'fsnotify_for_v4.20-rc3' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132ee77b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=ea05c832a73d0615bf33
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b8e6a3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e73e2b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ea05c832a73d0615bf33@syzkaller.appspotmail.com

sshd (5890) used greatest stack depth: 15744 bytes left

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc2+ #338 Not tainted
------------------------------------------------------
kworker/0:2/3421 is trying to acquire lock:
00000000c364a3bd (&mdev->req_queue_mutex){+.+.}, at:  
v4l2_release+0x1d7/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:455

but task is already holding lock:
000000009258f90c ((delayed_fput_work).work){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 ((delayed_fput_work).work){+.+.}:
        process_one_work+0xc0a/0x1c40 kernel/workqueue.c:2129
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #2 ((wq_completion)"events"){+.+.}:
        flush_workqueue+0x30a/0x1e10 kernel/workqueue.c:2655
        flush_scheduled_work include/linux/workqueue.h:599 [inline]
        vim2m_stop_streaming+0x7c/0x2c0 drivers/media/platform/vim2m.c:811
        __vb2_queue_cancel+0x171/0xd20  
drivers/media/common/videobuf2/videobuf2-core.c:1823
        vb2_core_queue_release+0x26/0x80  
drivers/media/common/videobuf2/videobuf2-core.c:2229
        vb2_queue_release+0x15/0x20  
drivers/media/common/videobuf2/videobuf2-v4l2.c:837
        v4l2_m2m_ctx_release+0x1e/0x35  
drivers/media/v4l2-core/v4l2-mem2mem.c:930
        vim2m_release+0xe6/0x150 drivers/media/platform/vim2m.c:977
        v4l2_release+0x224/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:456
        __fput+0x385/0xa30 fs/file_table.c:278
        ____fput+0x15/0x20 fs/file_table.c:309
        task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
        tracehook_notify_resume include/linux/tracehook.h:188 [inline]
        exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&dev->dev_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        vim2m_release+0xbc/0x150 drivers/media/platform/vim2m.c:976
        v4l2_release+0x224/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:456
        __fput+0x385/0xa30 fs/file_table.c:278
        ____fput+0x15/0x20 fs/file_table.c:309
        task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
        tracehook_notify_resume include/linux/tracehook.h:188 [inline]
        exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&mdev->req_queue_mutex){+.+.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        v4l2_release+0x1d7/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:455
        __fput+0x385/0xa30 fs/file_table.c:278
        delayed_fput+0x55/0x80 fs/file_table.c:304
        process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

other info that might help us debug this:

Chain exists of:
   &mdev->req_queue_mutex --> (wq_completion)"events" -->  
(delayed_fput_work).work

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((delayed_fput_work).work);
                                lock((wq_completion)"events");
                                lock((delayed_fput_work).work);
   lock(&mdev->req_queue_mutex);

  *** DEADLOCK ***

2 locks held by kworker/0:2/3421:
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at:  
__write_once_size include/linux/compiler.h:209 [inline]
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:59 [inline]
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 00000000312444b2 ((wq_completion)"events"){+.+.}, at:  
process_one_work+0xb43/0x1c40 kernel/workqueue.c:2124
  #1: 000000009258f90c ((delayed_fput_work).work){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128
kobject: 'regulatory.0' (0000000078fe9404): kobject_uevent_env

stack backtrace:
CPU: 0 PID: 3421 Comm: kworker/0:2 Not tainted 4.20.0-rc2+ #338
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'regulatory.0' (0000000078fe9404): fill_kobj_path: path  
= '/devices/platform/regulatory.0'
Workqueue: events delayed_fput
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  v4l2_release+0x1d7/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:455
  __fput+0x385/0xa30 fs/file_table.c:278
  delayed_fput+0x55/0x80 fs/file_table.c:304
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kobject: 'regulatory.0' (0000000078fe9404): kobject_uevent_env
kobject: 'regulatory.0' (0000000078fe9404): fill_kobj_path: path  
= '/devices/platform/regulatory.0'

