Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C9122433
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fEzF0Q+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C9122433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeHJStU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:49:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbeHJStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RTgcfJRJkVpB+RosrVCGQivunpt54hss6zC7aBwkVlU=; b=fEzF0Q+9kb0lE4bj/xbSrhkbI
        u08FVRJzqQGBpCKO2pDGNbU9wZFLv0Npx/H49ZVenSUrYYHgIXa0yA6H3Te7/n/LvknNlbNDqeM3y
        T89/fNxN0XmPQVwZByZZi0B1kmbV+uDhPHHidIWIfx3T+I5xHjNTXAO2vxuSYeyKXvIKc2LASL69l
        tIkhYENu7mGA7SRgiVztSbEKzWo86RoQgjuF+ys3Uddhe+3opwdtkoPNrI2qzG16gUmpGPEDaIuce
        M+Tn3Vw3XDyZNF6GtDpwYK3mrJeqsNsMjTWYM9UY55QjhLSCIjFN4VvBPrjgqgwRq1BvNN0aCcuos
        +nRTyTw8g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1foA7l-0000pD-0d; Fri, 10 Aug 2018 16:18:49 +0000
Date:   Fri, 10 Aug 2018 09:18:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Joel Fernandes <joelaf@google.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Todd Kjos <tkjos@google.com>, Arve Hjonnevag <arve@android.com>
Subject: Re: possible deadlock in shmem_fallocate (2)
Message-ID: <20180810161848.GB16533@bombadil.infradead.org>
References: <0000000000004024240573137822@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004024240573137822@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is another ashmem lockdep splat.  Forwarding to the appropriate ashmem
people.

On Fri, Aug 10, 2018 at 04:59:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    4110b42356f3 Add linux-next specific files for 20180810
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1411d6e2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d80606e3795a4f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=4b8b031b89e6b96c4b2e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=175052f8400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11873622400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.18.0-rc8-next-20180810+ #36 Not tainted
> ------------------------------------------------------
> syz-executor900/4483 is trying to acquire lock:
> 00000000d2bfc8fe (&sb->s_type->i_mutex_key#9){++++}, at: inode_lock
> include/linux/fs.h:765 [inline]
> 00000000d2bfc8fe (&sb->s_type->i_mutex_key#9){++++}, at:
> shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
> 
> but task is already holding lock:
> 0000000025208078 (ashmem_mutex){+.+.}, at: ashmem_shrink_scan+0xb4/0x630
> drivers/staging/android/ashmem.c:448
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (ashmem_mutex){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
>        ashmem_mmap+0x55/0x520 drivers/staging/android/ashmem.c:361
>        call_mmap include/linux/fs.h:1844 [inline]
>        mmap_region+0xf27/0x1c50 mm/mmap.c:1762
>        do_mmap+0xa10/0x1220 mm/mmap.c:1535
>        do_mmap_pgoff include/linux/mm.h:2298 [inline]
>        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:357
>        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
>        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
>        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
>        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #1 (&mm->mmap_sem){++++}:
>        __might_fault+0x155/0x1e0 mm/memory.c:4568
>        _copy_to_user+0x30/0x110 lib/usercopy.c:25
>        copy_to_user include/linux/uaccess.h:155 [inline]
>        filldir+0x1ea/0x3a0 fs/readdir.c:196
>        dir_emit_dot include/linux/fs.h:3464 [inline]
>        dir_emit_dots include/linux/fs.h:3475 [inline]
>        dcache_readdir+0x13a/0x620 fs/libfs.c:193
>        iterate_dir+0x48b/0x5d0 fs/readdir.c:51
>        __do_sys_getdents fs/readdir.c:231 [inline]
>        __se_sys_getdents fs/readdir.c:212 [inline]
>        __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (&sb->s_type->i_mutex_key#9){++++}:
>        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>        down_write+0x8f/0x130 kernel/locking/rwsem.c:70
>        inode_lock include/linux/fs.h:765 [inline]
>        shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
>        ashmem_shrink_scan+0x236/0x630 drivers/staging/android/ashmem.c:455
>        ashmem_ioctl+0x3ae/0x13a0 drivers/staging/android/ashmem.c:797
>        vfs_ioctl fs/ioctl.c:46 [inline]
>        file_ioctl fs/ioctl.c:501 [inline]
>        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>        __do_sys_ioctl fs/ioctl.c:709 [inline]
>        __se_sys_ioctl fs/ioctl.c:707 [inline]
>        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &sb->s_type->i_mutex_key#9 --> &mm->mmap_sem --> ashmem_mutex
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(ashmem_mutex);
>                                lock(&mm->mmap_sem);
>                                lock(ashmem_mutex);
>   lock(&sb->s_type->i_mutex_key#9);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz-executor900/4483:
>  #0: 0000000025208078 (ashmem_mutex){+.+.}, at:
> ashmem_shrink_scan+0xb4/0x630 drivers/staging/android/ashmem.c:448
> 
> stack backtrace:
> CPU: 1 PID: 4483 Comm: syz-executor900 Not tainted 4.18.0-rc8-next-20180810+
> #36
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_circular_bug.isra.37.cold.58+0x1bd/0x27d
> kernel/locking/lockdep.c:1227
>  check_prev_add kernel/locking/lockdep.c:1867 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
>  validate_chain kernel/locking/lockdep.c:2421 [inline]
>  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
>  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>  down_write+0x8f/0x130 kernel/locking/rwsem.c:70
>  inode_lock include/linux/fs.h:765 [inline]
>  shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
>  ashmem_shrink_scan+0x236/0x630 drivers/staging/android/ashmem.c:455
>  ashmem_ioctl+0x3ae/0x13a0 drivers/staging/android/ashmem.c:797
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440099
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff3613dbf8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440099
> RDX: 00000
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
