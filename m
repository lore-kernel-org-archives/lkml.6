Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeDYNCB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754124AbeDYNBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:01:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A745A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH 2/5] f2fs: avoid bug_on on corrupted inode
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180425054613.2700-1-jaegeuk@kernel.org>
 <20180425054613.2700-2-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <1ba2d8fa-e5d0-b916-faf0-e57653426ad3@kernel.org>
Date: Wed, 25 Apr 2018 21:01:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425054613.2700-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/25 13:46, Jaegeuk Kim wrote:
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> kernel BUG at fs/f2fs/inode.c:LINE!
> 
> F2FS-fs (loop1): invalid crc value
> F2FS-fs (loop5): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> F2FS-fs (loop5): Can't find valid F2FS filesystem in 1th superblock
> F2FS-fs (loop5): invalid crc value
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inode.c:238!
> invalid opcode: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 4886 Comm: syz-executor1 Not tainted 4.17.0-rc1+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:do_read_inode fs/f2fs/inode.c:238 [inline]
> RIP: 0010:f2fs_iget+0x3307/0x3ca0 fs/f2fs/inode.c:313
> RSP: 0018:ffff8801c44a70e8 EFLAGS: 00010293
> RAX: ffff8801ce208040 RBX: ffff8801b3621080 RCX: ffffffff82eace18
> F2FS-fs (loop2): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> RDX: 0000000000000000 RSI: ffffffff82eaf047 RDI: 0000000000000007
> RBP: ffff8801c44a7410 R08: ffff8801ce208040 R09: ffffed0039ee4176
> R10: ffffed0039ee4176 R11: ffff8801cf720bb7 R12: ffff8801c0efa000
> R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f753aa9d700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> ------------[ cut here ]------------
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel BUG at fs/f2fs/inode.c:238!
> CR2: 0000000001b03018 CR3: 00000001c8b74000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  f2fs_fill_super+0x4377/0x7bf0 fs/f2fs/super.c:2842
>  mount_bdev+0x30c/0x3e0 fs/super.c:1165
>  f2fs_mount+0x34/0x40 fs/f2fs/super.c:3020
>  mount_fs+0xae/0x328 fs/super.c:1268
>  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2517 [inline]
>  do_mount+0x564/0x3070 fs/namespace.c:2847
>  ksys_mount+0x12d/0x140 fs/namespace.c:3063
>  __do_sys_mount fs/namespace.c:3077 [inline]
>  __se_sys_mount fs/namespace.c:3074 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457daa
> RSP: 002b:00007f753aa9cba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 0000000000457daa
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f753aa9cbf0
> RBP: 0000000000000064 R08: 0000000020016a00 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000064 R14: 00000000006fcb80 R15: 0000000000000000
> RIP: do_read_inode fs/f2fs/inode.c:238 [inline] RSP: ffff8801c44a70e8
> RIP: f2fs_iget+0x3307/0x3ca0 fs/f2fs/inode.c:313 RSP: ffff8801c44a70e8
> invalid opcode: 0000 [#2] SMP KASAN
> ---[ end trace 1cbcbec2156680bc ]---
> 
> Reported-and-tested-by: syzbot+41a1b341571f0952badb@syzkaller.appspotmail.com
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
