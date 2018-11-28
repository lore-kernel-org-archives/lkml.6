Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FE420864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FE420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeK2Eml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:42:41 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35877 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbeK2Emb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:42:31 -0500
Received: by mail-io1-f71.google.com with SMTP id w5so26520593iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sRDER5mRKElQQhyCWKj3kIZDGoRKua1WEskNP0yUoic=;
        b=fVpPCg+jS8LD3kO7qHsfdDmt7FVocIlNPpqt19bZpVXaUrseUzENDU07N2v9c8TLNT
         BwZznjPbK38G4+RATSpCnMuW8yaz3uY8+Nvjeqyd5IudUzF8rtyDs0RAgm0jLCwL8KET
         DBU6+i/Yyj6wDIZxPnpG+RDuvMtCjS1t+7E15d6FuTJPnGRNaxldnx0CMRsSgAx9NHUe
         jVv4g6Ax/caNCbHikvG4mMWR6fyD/E3O09bPsLR/g2EnAIM8x+BwyOEsvaJdhT3JTBzI
         e6TNCaByLvo6bFIVP3Ne4QssuqC18p1WgrX8ygpRUf4UZzZsMkibPtsMHNEnwOjrVFYO
         wiHA==
X-Gm-Message-State: AA+aEWbxFrOy2Qtq5znAhwnR7kxlEj/MXf39arTUOua0xBeXo2qQ9ymp
        QX4e3L+AidxaSzNTrOSZvCTsphnRuOGDFa04lB+eRERp2IR7
X-Google-Smtp-Source: AFSGD/WJN+TDBU+SnpGO++yTheRrNxByD+hRCcZFz+zf3fd9qFsvvF+9S28kgFhGsiIQirCxlDkK3KylKx8QVJA+hG/udPTHmE8P
MIME-Version: 1.0
X-Received: by 2002:a24:6504:: with SMTP id u4mr3061110itb.25.1543426804756;
 Wed, 28 Nov 2018 09:40:04 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:40:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f4cf2057bbd0eeb@google.com>
Subject: possible deadlock in start_creating
From:   syzbot <syzbot+a2b1e02e7d41064cfe83@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ef78e5ec9214 ia64: export node_distance function
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d3354d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=a2b1e02e7d41064cfe83
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a2b1e02e7d41064cfe83@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc4+ #352 Not tainted
------------------------------------------------------
syz-executor4/8129 is trying to acquire lock:
000000003a2e44fb (&sb->s_type->i_mutex_key#4){++++}, at: inode_lock  
include/linux/fs.h:757 [inline]
000000003a2e44fb (&sb->s_type->i_mutex_key#4){++++}, at:  
start_creating+0xb1/0x200 fs/debugfs/inode.c:307

but task is already holding lock:
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
00000000ce7abeb2 (relay_channels_mutex){+.+.}, at: relay_open+0x478/0xac0  
kernel/relay.c:595

which lock already depends on the new lock.

kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'

the existing dependency chain (in reverse order) is:

-> #3 (relay_channels_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
        relay_prepare_cpu+0x2a/0x28b kernel/relay.c:525
        cpuhp_invoke_callback+0x35d/0x2100 kernel/cpu.c:167
        cpuhp_up_callbacks kernel/cpu.c:584 [inline]
        _cpu_up+0x290/0x560 kernel/cpu.c:1139
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
        do_cpu_up+0x1ca/0x210 kernel/cpu.c:1173
        cpu_up+0x18/0x20 kernel/cpu.c:1181
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
        smp_init+0x1a3/0x1be kernel/smp.c:578
        kernel_init_freeable+0x431/0x6b9 init/main.c:1146
        kernel_init+0x11/0x1ae init/main.c:1071
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #2 (cpu_hotplug_lock.rw_sem){++++}:
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        cpus_read_lock+0x3e/0xd0 kernel/cpu.c:287
        __static_key_slow_dec kernel/jump_label.c:239 [inline]
        static_key_slow_dec+0x57/0xa0 kernel/jump_label.c:254
        sw_perf_event_destroy+0x8b/0x140 kernel/events/core.c:8172
        _free_event+0x414/0x1660 kernel/events/core.c:4446
        put_event+0x48/0x60 kernel/events/core.c:4532
        perf_mmap_close+0x62f/0x1220 kernel/events/core.c:5515
        remove_vma+0xb1/0x180 mm/mmap.c:181
        remove_vma_list mm/mmap.c:2574 [inline]
        __do_munmap+0x751/0xf80 mm/mmap.c:2817
        do_munmap mm/mmap.c:2825 [inline]
        mmap_region+0x6a7/0x1cd0 mm/mmap.c:1729
        do_mmap+0xa22/0x1230 mm/mmap.c:1559
        do_mmap_pgoff include/linux/mm.h:2328 [inline]
        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:350
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1609
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&mm->mmap_sem){++++}:
        __might_fault+0x15e/0x1e0 mm/memory.c:4360
        _copy_to_user+0x30/0x110 lib/usercopy.c:25
        copy_to_user include/linux/uaccess.h:155 [inline]
        filldir64+0x23f/0x3e0 fs/readdir.c:281
        dir_emit_dot include/linux/fs.h:3465 [inline]
        dir_emit_dots include/linux/fs.h:3476 [inline]
        dcache_readdir+0x13a/0x620 fs/libfs.c:192
        iterate_dir+0x48c/0x5d0 fs/readdir.c:51
        ksys_getdents64+0x228/0x450 fs/readdir.c:314
        __do_sys_getdents64 fs/readdir.c:333 [inline]
        __se_sys_getdents64 fs/readdir.c:330 [inline]
        __x64_sys_getdents64+0x73/0xb0 fs/readdir.c:330
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#4){++++}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:757 [inline]
        start_creating+0xb1/0x200 fs/debugfs/inode.c:307
        __debugfs_create_file+0x63/0x400 fs/debugfs/inode.c:347
        debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
        blk_create_buf_file_callback+0x33/0x40 kernel/trace/blktrace.c:444
        relay_create_buf_file+0xf6/0x150 kernel/relay.c:428
        relay_open_buf.part.10+0x753/0xb20 kernel/relay.c:455
        relay_open_buf kernel/relay.c:447 [inline]
        relay_open+0x5e5/0xac0 kernel/relay.c:597
        do_blk_trace_setup+0x4fe/0xdb0 kernel/trace/blktrace.c:532
        __blk_trace_setup+0xd5/0x180 kernel/trace/blktrace.c:577
        blk_trace_ioctl+0x17a/0x2f0 kernel/trace/blktrace.c:716
        blkdev_ioctl+0x9e9/0x21b0 block/ioctl.c:591
        block_ioctl+0xee/0x130 fs/block_dev.c:1883
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:509 [inline]
        do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
        __do_sys_ioctl fs/ioctl.c:720 [inline]
        __se_sys_ioctl fs/ioctl.c:718 [inline]
        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &sb->s_type->i_mutex_key#4 --> cpu_hotplug_lock.rw_sem -->  
relay_channels_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(relay_channels_mutex);
                                lock(cpu_hotplug_lock.rw_sem);
                                lock(relay_channels_mutex);
   lock(&sb->s_type->i_mutex_key#4);

  *** DEADLOCK ***

2 locks held by syz-executor4/8129:
  #0: 00000000fc7e8d92 (&q->blk_trace_mutex){+.+.}, at:  
blk_trace_ioctl+0xeb/0x2f0 kernel/trace/blktrace.c:711
  #1: 00000000ce7abeb2 (relay_channels_mutex){+.+.}, at:  
relay_open+0x478/0xac0 kernel/relay.c:595

stack backtrace:
CPU: 1 PID: 8129 Comm: syz-executor4 Not tainted 4.20.0-rc4+ #352
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
  down_write+0x8a/0x130 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:757 [inline]
  start_creating+0xb1/0x200 fs/debugfs/inode.c:307
  __debugfs_create_file+0x63/0x400 fs/debugfs/inode.c:347
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  blk_create_buf_file_callback+0x33/0x40 kernel/trace/blktrace.c:444
  relay_create_buf_file+0xf6/0x150 kernel/relay.c:428
  relay_open_buf.part.10+0x753/0xb20 kernel/relay.c:455
  relay_open_buf kernel/relay.c:447 [inline]
  relay_open+0x5e5/0xac0 kernel/relay.c:597
  do_blk_trace_setup+0x4fe/0xdb0 kernel/trace/blktrace.c:532
  __blk_trace_setup+0xd5/0x180 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x17a/0x2f0 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x9e9/0x21b0 block/ioctl.c:591
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f243482fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 00000000200000c0 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f24348306d4
R13: 00000000004bea8f R14: 00000000004cf0c8 R15: 00000000ffffffff
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg0] tag#7103 FAILED Result: hostbyte=DID_ABORT  
driverbyte=DRIVER_OK
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
sd 0:0:1:0: [sg0] tag#7103 CDB: Read Generation
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg0] tag#7103 CDB[00]: 29 0e 1a 2a 09 65 02 9b 0c df 02 77 8d  
05 b6 86
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
sd 0:0:1:0: [sg0] tag#7103 CDB[10]: 3a 00 00 00 00 00 00 00 00 00 00 00 00  
00 00 00
sd 0:0:1:0: [sg0] tag#7103 CDB[20]: 00 00 00 00 00
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000e218925e): kobject_uevent_env
kobject: 'loop1' (00000000e218925e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000f89c58f8): kobject_uevent_env
kobject: 'loop0' (00000000f89c58f8): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (0000000097a4bd56): kobject_uevent_env
kobject: 'loop2' (0000000097a4bd56): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000c4ca0f77): kobject_uevent_env
kobject: 'loop4' (00000000c4ca0f77): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (000000006a23952d): kobject_uevent_env
kobject: 'kvm' (000000006a23952d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (000000007859c2f3): kobject_uevent_env
kobject: 'loop3' (000000007859c2f3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
sd 0:0:1:0: [sg_rq_end_io] Sense Key : Illegal Request [current]
sd 0:0:1:0: [sg_rq_end_io] Add. Sense: Invalid command operation code


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
