Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0CCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE072133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfxA5yzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE072133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeLETuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:50:16 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38543 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeLETuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:15 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so17705245ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDeMNFmKTzyf6mIUDFVADs3eALcbjx8BlYTD7wb/BQE=;
        b=tfxA5yzEEspVx5ECQSPAeP5slbYpry0qVGHAOZXUt7qDmKHM4A2bUdBtHalFzjHyxh
         1TIwo9IXRcF/TbdQSEvvfBjtPunipVNGCEM1x0afHGS1nBCbXUGUNhnwvGoErpxasL3Y
         r6M1r4zBDN9CtL4Edoasq4Hi69PMI3p228BTF3mA5fYZ5X4HE06jN0BW9YWf0vY/IJWZ
         MECJqKP4dPKG1ns5aZJnSQT5JCa+huQwYOOqzJrsU/HfaeRX6bD/616vO3PMXkbdPoCP
         LsCWKh/WPg+9O3dSFhtEh7geuHJ7LBogkmbeORDUpcCEAKuuIsuYdRtlU0swny6Op4LR
         OuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDeMNFmKTzyf6mIUDFVADs3eALcbjx8BlYTD7wb/BQE=;
        b=re5Z87EGIwAJ3Ft33WnemBdB+zXuQN00oz3ldaw2pzGjwsJ/AQfcDDwXTWsmJQNkBk
         lPtja0Vu4+0fh/UMgx9ZFHpU36Gce9YdrPldBBsFIOKnaNdjMeLeA5Zt/fduQxydwU5e
         D6dXVqr/8os5oB3yGTs90BUW7S+y5gr9CvUXa5B9e6aJvXc37gI875tgPHEIqfUonUDT
         aW/jyua4S2CJ+Kp7K9k2ZrBaiKv8VsmvkH2orxCH1wR30prit+tcu7dQvBK4bCOhpKrn
         EHVoN4U+obxYGen58broXru28xsSd73vlPsKcY2QCSdk09kmJ8jgFBE5KhpuZUVMOXx9
         Vm0w==
X-Gm-Message-State: AA+aEWYNgKvfojA+QxR7xUswn9BViNroeP5Oc0PzYz76EAVWZHBoN/Gg
        hXk0+KxF1AzcZBv20ZXiSQCFGEEe2LCpzZPApcJf2A==
X-Google-Smtp-Source: AFSGD/VisybbIbAD9XrqWSPIyXfmj4n0iTrk2K0VICtPR1Z1CHHxGueW57IUKnJuShbxg/d6dTDQisG6F4CyeH0s0TA=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr19867753iom.11.1544039414068;
 Wed, 05 Dec 2018 11:50:14 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e59aab056e8873ae@google.com>
In-Reply-To: <000000000000e59aab056e8873ae@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Dec 2018 20:50:03 +0100
Message-ID: <CACT4Y+bsj7oEHOUAkETFESORNf2EYyRTB2MmWAWYMMnz77kkOg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in blkdev_get
To:     syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:27 PM syzbot
<syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f5b7769eb040 Revert "debugfs: inode: debugfs_create_dir us..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=171dc837800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=709f8187af941e84
> dashboard link: https://syzkaller.appspot.com/bug?extid=eaeb616d85c9a0afec7d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=177f898f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147eb85f800000

Was this fixed by something? This happened 108 times in Jun-Aug, then
last time on Sep 2, and then stopped happened since then.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com
>
> reiserfs: using flush barriers
> REISERFS warning (device loop4): sh-2022 reiserfs_fill_super: unable to
> initialize journal space
> REISERFS (device loop3): using ordered data mode
> reiserfs: using flush barriers
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3888/0x5140
> kernel/locking/lockdep.c:3314
> Read of size 8 at addr ffff8801a78932f8 by task syz-executor927/4536
>
> CPU: 1 PID: 4536 Comm: syz-executor927 Not tainted 4.17.0+ #100
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>   print_address_description+0x6c/0x20b mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>   __lock_acquire+0x3888/0x5140 kernel/locking/lockdep.c:3314
>   lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
>   __mutex_lock_common kernel/locking/mutex.c:757 [inline]
>   __mutex_lock+0x16d/0x17f0 kernel/locking/mutex.c:894
>   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
>   blkdev_get+0x5d8/0xb30 fs/block_dev.c:1620
>   blkdev_get_by_dev+0x3f/0x80 fs/block_dev.c:1736
>   journal_init_dev fs/reiserfs/journal.c:2628 [inline]
>   journal_init+0xcad/0x6a20 fs/reiserfs/journal.c:2775
>   reiserfs_fill_super+0xd59/0x3900 fs/reiserfs/super.c:2034
>   mount_bdev+0x30c/0x3e0 fs/super.c:1174
>   get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
>   mount_fs+0xae/0x328 fs/super.c:1277
>   vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
>   vfs_kern_mount fs/namespace.c:1027 [inline]
>   do_new_mount fs/namespace.c:2518 [inline]
>   do_mount+0x564/0x30b0 fs/namespace.c:2848
>   ksys_mount+0x12d/0x140 fs/namespace.c:3064
>   __do_sys_mount fs/namespace.c:3078 [inline]
>   __se_sys_mount fs/namespace.c:3075 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
>   do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x446fda
> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 1d aa fb ff c3 66 2e 0f
> 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fa a9 fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007fffcf4ce188 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fffcf4ce1a0 RCX: 0000000000446fda
> RDX: 00007fffcf4ce1a0 RSI: 0000000020000100 RDI: 00007fffcf4ce1c0
> RBP: 0000000000000001 R08: 00007fffcf4ce200 R09: 000000000000000a
> R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000003
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000001
>
> Allocated by task 4536:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>   kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>   kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>   bdev_alloc_inode+0x1b/0x40 fs/block_dev.c:727
>   alloc_inode+0x63/0x190 fs/inode.c:210
>   new_inode_pseudo+0x69/0x1a0 fs/inode.c:895
>   new_inode+0x1c/0x40 fs/inode.c:924
>   iget5_locked+0x126/0x190 fs/inode.c:1097
>   bdget+0xb1/0x5c0 fs/block_dev.c:868
>   blkdev_get_by_dev+0x24/0x80 fs/block_dev.c:1732
>   journal_init_dev fs/reiserfs/journal.c:2628 [inline]
>   journal_init+0xcad/0x6a20 fs/reiserfs/journal.c:2775
>   reiserfs_fill_super+0xd59/0x3900 fs/reiserfs/super.c:2034
>   mount_bdev+0x30c/0x3e0 fs/super.c:1174
>   get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
>   mount_fs+0xae/0x328 fs/super.c:1277
>   vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
>   vfs_kern_mount fs/namespace.c:1027 [inline]
>   do_new_mount fs/namespace.c:2518 [inline]
>   do_mount+0x564/0x30b0 fs/namespace.c:2848
>   ksys_mount+0x12d/0x140 fs/namespace.c:3064
>   __do_sys_mount fs/namespace.c:3078 [inline]
>   __se_sys_mount fs/namespace.c:3075 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
>   do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 2414:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>   __cache_free mm/slab.c:3498 [inline]
>   kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
>   bdev_i_callback+0x20/0x30 fs/block_dev.c:738
>   __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
>   rcu_do_batch kernel/rcu/tree.c:2558 [inline]
>   invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
>   __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
>   rcu_process_callbacks+0xe9d/0x1760 kernel/rcu/tree.c:2802
>   __do_softirq+0x2e0/0xaf5 kernel/softirq.c:284
>
> The buggy address belongs to the object at ffff8801a7893280
>   which belongs to the cache bdev_cache of size 1352
> The buggy address is located 120 bytes inside of
>   1352-byte region [ffff8801a7893280, ffff8801a78937c8)
> The buggy address belongs to the page:
> page:ffffea00069e24c0 count:1 mapcount:0 mapping:ffff8801da9874c0
> index:0xffff8801a7893ffe
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0006dfab08 ffffea00069e2508 ffff8801da9874c0
> raw: ffff8801a7893ffe ffff8801a7893280 0000000100000002 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8801a7893180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8801a7893200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801a7893280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                                  ^
>   ffff8801a7893300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8801a7893380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
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
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e59aab056e8873ae%40google.com.
> For more options, visit https://groups.google.com/d/optout.
