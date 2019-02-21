Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB023C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D4C2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfBUTg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:36:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:36:27 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E44E33B90;
        Thu, 21 Feb 2019 19:36:25 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:36:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, darrick.wong@oracle.com, david@fromorbit.com,
        hannes@cmpxchg.org, hughd@google.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        Jan Kara <jack@suse.cz>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 __generic_file_write_iter
Message-Id: <20190221113624.284fe267e73752639186a563@linux-foundation.org>
In-Reply-To: <0000000000001aab8b0582689e11@google.com>
References: <0000000000001aab8b0582689e11@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 06:52:04 -0800 syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    4aa9fc2a435a Revert "mm, memory_hotplug: initialize struct..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1101382f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca95b2b7aef9e7cbd6ab
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

Not understanding.  That seems to be saying that we got a NULL pointer
deref in __generic_file_write_iter() at

                written = generic_perform_write(file, from, iocb->ki_pos);

which isn't possible.

I'm not seeing recent changes in there which could have caused this.  Help.


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> #PF error: [INSTR]
> PGD a7ea0067 P4D a7ea0067 PUD 81535067 PMD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 15924 Comm: syz-executor0 Not tainted 5.0.0-rc4+ #50
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:          (null)
> Code: Bad RIP value.
> RSP: 0018:ffff88804c3d7858 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffff885aeb60 RCX: 000000000000005b
> RDX: 0000000000000000 RSI: ffff88807ec22930 RDI: ffff8880a59bdcc0
> RBP: ffff88804c3d79b8 R08: 0000000000000000 R09: ffff88804c3d7910
> R10: ffff8880835ca200 R11: 0000000000000000 R12: 000000000000005b
> R13: ffff88804c3d7c98 R14: dffffc0000000000 R15: 0000000000000000
> FS:  00007f3456db4700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000000814ac000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __generic_file_write_iter+0x25e/0x630 mm/filemap.c:3333
>   ext4_file_write_iter+0x37a/0x1410 fs/ext4/file.c:266
>   call_write_iter include/linux/fs.h:1862 [inline]
>   new_sync_write fs/read_write.c:474 [inline]
>   __vfs_write+0x764/0xb40 fs/read_write.c:487
>   vfs_write+0x20c/0x580 fs/read_write.c:549
>   ksys_write+0x105/0x260 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458089
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f3456db3c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458089
> RDX: 000000000000005b RSI: 0000000020000240 RDI: 0000000000000003
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3456db46d4
> R13: 00000000004c7450 R14: 00000000004dce68 R15: 00000000ffffffff
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 5cac9d2c75a59916 ]---
> kobject: 'loop5' (000000004426a409): kobject_uevent_env
> RIP: 0010:          (null)
> Code: Bad RIP value.
> RSP: 0018:ffff88804c3d7858 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffff885aeb60 RCX: 000000000000005b
> kobject: 'loop5' (000000004426a409): fill_kobj_path: path  
> = '/devices/virtual/block/loop5'
> RDX: 0000000000000000 RSI: ffff88807ec22930 RDI: ffff8880a59bdcc0
> kobject: 'loop2' (00000000b82e0c58): kobject_uevent_env
> kobject: 'loop2' (00000000b82e0c58): fill_kobj_path: path  
> = '/devices/virtual/block/loop2'
> RBP: ffff88804c3d79b8 R08: 0000000000000000 R09: ffff88804c3d7910
> R10: ffff8880835ca200 R11: 0000000000000000 R12: 000000000000005b
> R13: ffff88804c3d7c98 R14: dffffc0000000000 R15: 0000000000000000
> kobject: 'loop5' (000000004426a409): kobject_uevent_env
> FS:  00007f3456db4700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> kobject: 'loop5' (000000004426a409): fill_kobj_path: path  
> = '/devices/virtual/block/loop5'
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000022029a0 CR3: 00000000814ac000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
