Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BADB2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BADB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLDPVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:21:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:58254 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:21:05 -0500
Received: by mail-it1-f197.google.com with SMTP id n124so12926193itb.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hlkXGEJF2m/jMDCfsOvDd/bOoVjAHYqTwyAfWUipLAU=;
        b=ni9cojtGGjjd5rc7pVms6Xrqv2nom3nX78B3LOY+thOAjmV1p3Ba5Ahfqu56uDuTKF
         N3w4VCSdmv9+gnxtwFsoNs17VlNR5/X/QZYcIJ6fDAam5RdRHzD9zXBFGuav1IEYClcT
         M5fvlEfZxpqJ3qI6QNSX+V7fhjeUfymxmfYb2ortg0WAqtda9gJawFbNrOUOILOUhhy9
         sNLdgJ1E/kBPQNpZ5dPChnBnGdYOzgfuc3ZGIsKEAFXp7K1SMV0LZJBlDLEZtu2/2XxR
         74NxiDC75HTkFBwmHb/ptRZGiq1p1+AeYZkuGp2LHxrWJo2AoS06EduDUW9kk411Qkx+
         xnUQ==
X-Gm-Message-State: AA+aEWa2MpWwObjApJoERTQarrSPaQEHyaydCF8LSwztDBJ9q29I39Rq
        kVbmVskO1v//IGXk46edTPgwbVKvxLptZg6NZWfLLLRAAhiK
X-Google-Smtp-Source: AFSGD/XTRyJkZEM3sgfp7Q8FeZRt971AuhM9K0M57lRopFmltlrOHKHTOS53ZQ4RzQonYJdU7rVWqBy9cGCeCkKfmFEWUXXWlvC4
MIME-Version: 1.0
X-Received: by 2002:a24:2c4d:: with SMTP id i74mr10782944iti.12.1543936863520;
 Tue, 04 Dec 2018 07:21:03 -0800 (PST)
Date:   Tue, 04 Dec 2018 07:21:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e5428057c33d061@google.com>
Subject: possible deadlock in ep_free
From:   syzbot <syzbot+296ea3811c64964727aa@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0072a0c14d5b Merge tag 'media/v4.20-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d2796d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=296ea3811c64964727aa
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+296ea3811c64964727aa@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc5+ #265 Not tainted
------------------------------------------------------
kworker/0:3/6216 is trying to acquire lock:
000000006d826351 (epmutex){+.+.}, at: ep_free+0xf6/0x300 fs/eventpoll.c:829

but task is already holding lock:
000000005098accc ((delayed_fput_work).work){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 ((delayed_fput_work).work){+.+.}:
        process_one_work+0xc0a/0x1c40 kernel/workqueue.c:2129
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #3 ((wq_completion)"events"){+.+.}:
        flush_workqueue+0x30a/0x1e10 kernel/workqueue.c:2655
        flush_scheduled_work include/linux/workqueue.h:599 [inline]
        vim2m_stop_streaming+0x7c/0x2c0 drivers/media/platform/vim2m.c:811
        __vb2_queue_cancel+0x171/0xd20  
drivers/media/common/videobuf2/videobuf2-core.c:1823
        vb2_core_queue_release+0x26/0x80  
drivers/media/common/videobuf2/videobuf2-core.c:2229
        vb2_queue_release+0x15/0x20  
drivers/media/common/videobuf2/videobuf2-v4l2.c:837
        v4l2_m2m_ctx_release+0x2a/0x35  
drivers/media/v4l2-core/v4l2-mem2mem.c:931
        vim2m_release+0xe6/0x150 drivers/media/platform/vim2m.c:977
        v4l2_release+0x224/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:456
        __fput+0x385/0xa30 fs/file_table.c:278
        ____fput+0x15/0x20 fs/file_table.c:309
        task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
        tracehook_notify_resume include/linux/tracehook.h:188 [inline]
        exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
        do_fast_syscall_32+0xcd5/0xfb2 arch/x86/entry/common.c:397
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

-> #2 (&dev->dev_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        v4l2_m2m_fop_poll+0x98/0x120  
drivers/media/v4l2-core/v4l2-mem2mem.c:1105
        v4l2_poll+0x153/0x200 drivers/media/v4l2-core/v4l2-dev.c:350
        vfs_poll include/linux/poll.h:86 [inline]
        ep_item_poll.isra.15+0x15c/0x400 fs/eventpoll.c:892
        ep_insert+0x781/0x1dd0 fs/eventpoll.c:1464
        __do_sys_epoll_ctl fs/eventpoll.c:2121 [inline]
        __se_sys_epoll_ctl fs/eventpoll.c:2007 [inline]
        __ia32_sys_epoll_ctl+0xeda/0x1080 fs/eventpoll.c:2007
        do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
        do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

-> #1 (&ep->mtx){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        ep_free+0x160/0x300 fs/eventpoll.c:849
        ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:869
        __fput+0x385/0xa30 fs/file_table.c:278
        ____fput+0x15/0x20 fs/file_table.c:309
        task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
        tracehook_notify_resume include/linux/tracehook.h:188 [inline]
        exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (epmutex){+.+.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        ep_free+0xf6/0x300 fs/eventpoll.c:829
        ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:869
        __fput+0x385/0xa30 fs/file_table.c:278
        delayed_fput+0x55/0x80 fs/file_table.c:304
        process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

other info that might help us debug this:

Chain exists of:
   epmutex --> (wq_completion)"events" --> (delayed_fput_work).work

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((delayed_fput_work).work);
                                lock((wq_completion)"events");
                                lock((delayed_fput_work).work);
   lock(epmutex);

  *** DEADLOCK ***

2 locks held by kworker/0:3/6216:
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at:  
__write_once_size include/linux/compiler.h:209 [inline]
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:59 [inline]
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000000aab2aee ((wq_completion)"events"){+.+.}, at:  
process_one_work+0xb43/0x1c40 kernel/workqueue.c:2124
  #1: 000000005098accc ((delayed_fput_work).work){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128

stack backtrace:
CPU: 0 PID: 6216 Comm: kworker/0:3 Not tainted 4.20.0-rc5+ #265
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
  ep_free+0xf6/0x300 fs/eventpoll.c:829
  ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:869
  __fput+0x385/0xa30 fs/file_table.c:278
  delayed_fput+0x55/0x80 fs/file_table.c:304
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
audit: type=1326 audit(1543921229.079:66): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=265 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
audit: type=1326 audit(1543921229.079:67): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
audit: type=1326 audit(1543921229.079:68): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
audit: type=1326 audit(1543921229.079:69): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921229.079:70): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
audit: type=1326 audit(1543921229.079:71): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
audit: type=1326 audit(1543921229.079:72): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
audit: type=1326 audit(1543921229.079:73): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
audit: type=1326 audit(1543921229.079:74): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop2' (00000000a9a0cc13): kobject_uevent_env
audit: type=1326 audit(1543921229.079:75): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop2' (00000000a9a0cc13): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1326 audit(1543921229.079:76): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23841 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000a9a0cc13): kobject_uevent_env
kobject: 'loop2' (00000000a9a0cc13): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000b69c11d9): kobject_uevent_env
kobject: 'loop4' (00000000b69c11d9): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000a9a0cc13): kobject_uevent_env
kobject: 'loop2' (00000000a9a0cc13): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kauditd_printk_skb: 30514 callbacks suppressed
audit: type=1326 audit(1543921234.119:30591): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30592): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30593): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30594): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30595): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30596): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30597): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30598): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30599): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
audit: type=1326 audit(1543921234.149:30600): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=23893 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=40000003 syscall=240 compat=1  
ip=0xf7f68a29 code=0x50000
kobject: 'loop4' (00000000b69c11d9): kobject_uevent_env
kobject: 'loop4' (00000000b69c11d9): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000a9a0cc13): kobject_uevent_env
kobject: 'loop2' (00000000a9a0cc13): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (00000000b69c11d9): kobject_uevent_env
kobject: 'loop4' (00000000b69c11d9): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000b08eabe4): kobject_uevent_env
kobject: 'loop1' (00000000b08eabe4): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000a9a0cc13): kobject_uevent_env
kobject: 'loop2' (00000000a9a0cc13): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000287e60d6): kobject_uevent_env
kobject: 'loop3' (00000000287e60d6): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000a9a0cc13): kobject_uevent_env
kobject: 'loop2' (00000000a9a0cc13): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000095b64449): kobject_uevent_env
kobject: 'loop5' (0000000095b64449): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000c90ec763): kobject_uevent_env
kobject: 'loop0' (00000000c90ec763): fill_kobj_path: path  
= '/devices/virtual/block/loop0'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
