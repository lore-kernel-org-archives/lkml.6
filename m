Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeDTCTm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 22:19:42 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:40528 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbeDTCTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 22:19:40 -0400
X-Google-Smtp-Source: AIpwx4+FqKd1DCzeWybIylwQTEMp1D9agJKL4zVd2tACP515UZLdBHTQ8Qx1DWl2yP6rLund1crtzA==
Date: Thu, 19 Apr 2018 19:20:48 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+f3bd89a5ab3266b10540@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: BUG: corrupted list in __dentry_kill
Message-ID: <20180420022048.GA686@sol.localdomain>
References: <001a11447acaa9eec40568bd5438@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11447acaa9eec40568bd5438@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 04:01:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 7828f20e3779e4e85e55371e0e43f5006a15fb41 (Sat Mar 31 00:17:57 2018 +0000)
> Merge branch 'bpf-cgroup-bind-connect'
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=f3bd89a5ab3266b10540
> 
> So far this crash happened 22 times on bpf-next, upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6290970458980352
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6577156880596992
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5107570603720704
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=5909223872832634926
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f3bd89a5ab3266b10540@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> RBP: 00007ffd1bbb3ae0 R08: 0000000020000200 R09: 0000000300000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000003 R14: 0000000000001380 R15: 00007ffd1bbb3378
> list_del corruption. prev->next should be 00000000a8104008, but was
> 00000000081c6144
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:53!
> invalid opcode: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4448 Comm: syzkaller853443 Not tainted 4.16.0-rc6+ #43
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__list_del_entry_valid+0xef/0x150 lib/list_debug.c:51
> RSP: 0018:ffff8801b8f977a0 EFLAGS: 00010282
> RAX: 0000000000000054 RBX: ffff8801b0c1cf60 RCX: 0000000000000000
> RDX: 0000000000000054 RSI: 1ffff100371f2ea9 RDI: ffffed00371f2ee8
> RBP: ffff8801b8f977b8 R08: 1ffff100371f2e40 R09: 0000000000000000
> R10: ffff8801b8f97778 R11: 0000000000000000 R12: ffff8801b0c1cde0
> R13: 1ffff100371f2efd R14: ffff8801b0c1cc70 R15: dffffc0000000000
> FS:  00000000023a5880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004b6fbc CR3: 00000001c85a6004 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __list_del_entry include/linux/list.h:117 [inline]
>  dentry_unlist fs/dcache.c:518 [inline]
>  __dentry_kill+0x260/0x700 fs/dcache.c:571
>  dentry_kill fs/dcache.c:616 [inline]
>  dput.part.20+0x5a0/0x830 fs/dcache.c:831
>  dput+0x1f/0x30 fs/dcache.c:795
>  rpc_gssd_dummy_depopulate net/sunrpc/rpc_pipe.c:1381 [inline]
>  rpc_fill_super+0x628/0xae0 net/sunrpc/rpc_pipe.c:1426
>  mount_ns+0xc4/0x190 fs/super.c:1036
>  rpc_mount+0x9e/0xd0 net/sunrpc/rpc_pipe.c:1451
>  mount_fs+0x66/0x2d0 fs/super.c:1222
>  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:2509 [inline]
>  do_new_mount fs/namespace.c:2512 [inline]
>  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
>  SYSC_mount fs/namespace.c:3058 [inline]
>  SyS_mount+0xab/0x120 fs/namespace.c:3035
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x442759
> RSP: 002b:00007ffd1bbb3238 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442759
> RDX: 00000000200002c0 RSI: 0000000020000140 RDI: 0000000020000300
> RBP: 00007ffd1bbb3ae0 R08: 0000000020000200 R09: 0000000300000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000003 R14: 0000000000001380 R15: 00007ffd1bbb3378
> Code: 4c 89 e2 48 c7 c7 c0 bf 75 87 e8 35 c1 46 fe 0f 0b 48 c7 c7 20 c0 75
> 87 e8 27 c1 46 fe 0f 0b 48 c7 c7 80 c0 75 87 e8 19 c1 46 fe <0f> 0b 48 c7 c7
> e0 c0 75 87 e8 0b c1 46 fe 0f 0b 48 89 df 48 89
> RIP: __list_del_entry_valid+0xef/0x150 lib/list_debug.c:51 RSP:
> ffff8801b8f977a0
> ---[ end trace e1b9954cded9aca7 ]---
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

#syz fix: rpc_pipefs: fix double-dput()

Al, it would be helpful if for syzbot-reported bugs you used the Reported-by
line suggested in the bug report.  That allows the bug to be automatically
closed, and it's also useful for people who are looking for syzbot bug fixes.

Thanks!

Eric
