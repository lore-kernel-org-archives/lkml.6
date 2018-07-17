Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AAAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8792075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8792075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeGQMld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:41:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731117AbeGQMlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:41:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 047B874C420F1;
        Tue, 17 Jul 2018 20:09:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 20:09:03 +0800
Subject: Re: [V9fs-developer] BUG: corrupted list in p9_fd_cancelled
To:     syzbot <syzbot+f78c15f5aa00e5c16d59@syzkaller.appspotmail.com>,
        <davem@davemloft.net>, <ericvh@gmail.com>,
        <linux-kernel@vger.kernel.org>, <lucho@ionkov.net>,
        <netdev@vger.kernel.org>, <rminnich@sandia.gov>,
        <syzkaller-bugs@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>
References: <000000000000ca008a05711fc427@google.com>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4DDC5E.4010802@huawei.com>
Date:   Tue, 17 Jul 2018 20:09:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <000000000000ca008a05711fc427@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/16 23:49, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1d4eb636f0ab Add linux-next specific files for 20180716
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10abe770400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5926dddb0db97a
> dashboard link: https://syzkaller.appspot.com/bug?extid=f78c15f5aa00e5c16d59
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f78c15f5aa00e5c16d59@syzkaller.appspotmail.com
> 
> list_del corruption, ffff880193723368->next is LIST_POISON1 (dead000000000100)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:47!
> invalid opcode: 0000 [#1] SMP KASAN
> CPU: 1 PID: 9124 Comm: syz-executor7 Not tainted 4.18.0-rc5-next-20180716+ #8
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
> Code: ff fd 0f 0b 4c 89 e2 48 89 de 48 c7 c7 40 88 1a 88 e8 0a 35 ff fd 0f 0b 4c 89 ea 48 89 de 48 c7 c7 e0 87 1a 88 e8 f6 34 ff fd <0f> 0b 48 89 de 48 c7 c7 00 89 1a 88 e8 e5 34 ff fd 0f 0b 48 89 de
> RSP: 0018:ffff88019b65f1d0 EFLAGS: 00010282
> RAX: 000000000000004e RBX: ffff880193723368 RCX: ffffc90008c3b000
> RDX: 0000000000000000 RSI: ffffffff81633fc1 RDI: 0000000000000001
> RBP: ffff88019b65f1e8 R08: ffff88019918e100 R09: ffffed003b5e4fc0
> R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: dead000000000200
> R13: dead000000000100 R14: ffff8801ab908600 R15: dffffc0000000000
> FS:  00007f238387e700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000625208 CR3: 00000001b4588000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del include/linux/list.h:125 [inline]
>  p9_fd_cancelled+0x80/0x2f0 net/9p/trans_fd.c:707
>  p9_client_flush+0x252/0x2a0 net/9p/client.c:693
>  p9_client_rpc+0x122c/0x1400 net/9p/client.c:802
>  p9_client_version net/9p/client.c:977 [inline]
>  p9_client_create+0xdbc/0x177c net/9p/client.c:1070
>  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
>  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
>  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
>  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
>  do_new_mount fs/namespace.c:2567 [inline]
>  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
>  ksys_mount+0x12d/0x140 fs/namespace.c:3105
>  __do_sys_mount fs/namespace.c:3119 [inline]
>  __se_sys_mount fs/namespace.c:3116 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455ab9
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f238387dc68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f238387e6d4 RCX: 0000000000455ab9
> RDX: 00000000200002c0 RSI: 00000000200001c0 RDI: 0000000000000000
> RBP: 000000000072bea0 R08: 00000000200003c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c0201 R14: 00000000004cfe50 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 7de5f20f6f7cde43 ]---
> RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
> Code: ff fd 0f 0b 4c 89 e2 48 89 de 48 c7 c7 40 88 1a 88 e8 0a 35 ff fd 0f 0b 4c 89 ea 48 89 de 48 c7 c7 e0 87 1a 88 e8 f6 34 ff fd <0f> 0b 48 89 de 48 c7 c7 00 89 1a 88 e8 e5 34 ff fd 0f 0b 48 89 de
> serio: Serial port pts1
> RSP: 0018:ffff88019b65f1d0 EFLAGS: 00010282
> RAX: 000000000000004e RBX: ffff880193723368 RCX: ffffc90008c3b000
> RDX: 0000000000000000 RSI: ffffffff81633fc1 RDI: 0000000000000001
> RBP: ffff88019b65f1e8 R08: ffff88019918e100 R09: ffffed003b5e4fc0
> R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: dead000000000200
> R13: dead000000000100 R14: ffff8801ab908600 R15: dffffc0000000000
> FS:  00007f238387e700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000625208 CR3: 00000001b4588000 CR4: 00000000001406e0
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
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
> 
> .
> 

I think the reason of corrupted is list_del(&req->req_list) can be
called by multi-threads, like the race between p9_conn_cancel and
p9_fd_cancelled. There are two problems, first list_del the req_list
don't use spin lock in p9_conn_cancel; second, we should use list_del_init,
it will not report the warning when it is protected in the spinlock.

Thanks,
Yiwen.

