Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeDSWpO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:45:14 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36712 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeDSWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:45:12 -0400
X-Google-Smtp-Source: AIpwx49UpV3LQ/6+M5NGxBtV4NDD4ZbP7yFBkWvG4JIn5oy7YO7m23B4AL5yt2bp1KL2HCQ5ZofhMQ==
Date: Thu, 19 Apr 2018 15:45:09 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+6eaf536fd743f5e119c5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: WARNING in refcount_inc (3)
Message-ID: <20180419224509.GB13221@gmail.com>
References: <001a113ec036acc2460568bd5427@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113ec036acc2460568bd5427@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 04:01:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 1379ef828a18d8f81c526b25e4d5685caa2cfd65 (Thu Mar 29 22:09:44 2018 +0000)
> Merge branch 'bpf-sockmap-ingress'
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=6eaf536fd743f5e119c5
> 
> So far this crash happened 6 times on bpf-next.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6614614900998144
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5035340528091136
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5063394046509056
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-1280663959502969741
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6eaf536fd743f5e119c5@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> R13: 0000000000000005 R14: 0000000000001380 R15: 00007ffd314c8768
> ------------[ cut here ]------------
> ------------[ cut here ]------------
> refcount_t: increment on 0; use-after-free.
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 4434 at lib/refcount.c:153 refcount_inc+0x47/0x50
> lib/refcount.c:153
> WARNING: CPU: 0 PID: 4437 at lib/refcount.c:187
> refcount_sub_and_test+0x167/0x1b0 lib/refcount.c:187
> Kernel panic - not syncing: panic_on_warn set ...
> 
> Modules linked in:
> CPU: 1 PID: 4434 Comm: syzkaller349430 Not tainted 4.16.0-rc6+ #41
> CPU: 0 PID: 4437 Comm: syzkaller349430 Not tainted 4.16.0-rc6+ #41
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:refcount_sub_and_test+0x167/0x1b0 lib/refcount.c:187
> Call Trace:
> RSP: 0018:ffff8801b061f728 EFLAGS: 00010286
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
> RAX: dffffc0000000008 RBX: 0000000000000000 RCX: ffffffff815ba4be
> RDX: 0000000000000000 RSI: 1ffff100360c3e95 RDI: 1ffff100360c3e6a
> RBP: ffff8801b061f7b8 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff8801b061f850 R11: 0000000000000000 R12: 1ffff100360c3ee6
>  panic+0x1e4/0x41c kernel/panic.c:183
> R13: 00000000ffffffff R14: 0000000000000001 R15: ffff8801b1be4184
> FS:  0000000001817880(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd314c9000 CR3: 00000001b04a1006 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x1f4/0x2b0 lib/bug.c:186
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  refcount_dec_and_test+0x1a/0x20 lib/refcount.c:212
>  put_net include/net/net_namespace.h:222 [inline]
>  __sk_destruct+0x560/0x920 net/core/sock.c:1592
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:refcount_inc+0x47/0x50 lib/refcount.c:153
> RSP: 0018:ffff8801b058f860 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801ab55a1c4 RCX: ffffffff815ba4be
> RDX: 0000000000000000 RSI: 1ffff100360b1ebc RDI: 1ffff100360b1e91
> RBP: ffff8801b058f868 R08: 0000000000000000 R09: 0000000000000000
>  sk_destruct+0x47/0x80 net/core/sock.c:1601
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801b058faf8
>  __sk_free+0xf1/0x2b0 net/core/sock.c:1612
> R13: ffff8801af87b513 R14: ffff8801ab55a1c0 R15: ffff8801af87b501
>  sk_free+0x2a/0x40 net/core/sock.c:1623
>  sock_put include/net/sock.h:1661 [inline]
>  tcp_close+0x967/0x1190 net/ipv4/tcp.c:2329
>  get_net include/net/net_namespace.h:204 [inline]
>  sk_alloc+0x3f9/0x1440 net/core/sock.c:1540
>  inet_release+0xed/0x1c0 net/ipv4/af_inet.c:427
>  sock_release+0x8d/0x1e0 net/socket.c:594
>  sock_close+0x16/0x20 net/socket.c:1149
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  inet_create+0x47c/0xf50 net/ipv4/af_inet.c:320
>  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
>  exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
>  __sock_create+0x4d4/0x850 net/socket.c:1285
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
>  sock_create net/socket.c:1325 [inline]
>  SYSC_socket net/socket.c:1355 [inline]
>  SyS_socket+0xeb/0x1d0 net/socket.c:1335
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x402950
> RSP: 002b:00007ffd314c8628 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000402950
> RDX: 00000000000000e0 RSI: 00007ffd314c8f00 RDI: 0000000000000003
> RBP: 00007ffd314c8740 R08: 00007ffd314c864c R09: 0000000000000001
> R10: 00007ffd314c8740 R11: 0000000000000246 R12: 00000000006cf4c0
> R13: 00000000006cee40 R14: 0000000000001380 R15: 00007ffd314c8768
> Code:
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 5e
> RIP: 0033:0x4456a7
> 41
> RSP: 002b:00007ffd314c8628 EFLAGS: 00000202 ORIG_RAX: 0000000000000029
> 5f
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004456a7
> 5d
> RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 00007ffd314c8740 R08: 0000000000000000 R09: 0000000000000001
> c3
> R10: 0000000000000006 R11: 0000000000000202 R12: 0000000000000003
> e8
> R13: 0000000000000003 R14: 0000000000006cc2 R15: 00007ffd314c8768
> 0a 0b be fe 80 3d 20 c9 84 05 00 75 1a e8 fc 0a be fe 48 c7 c7 e0 78 e5 86
> c6 05 0b c9 84 05 01 e8 a9 16 8e fe <0f> 0b 31 db eb a3 e8 de 0a be fe 83 fb
> ff 0f 85 63 ff ff ff 31
> ---[ end trace dd327356f543ce46 ]---
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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

Broken error handling when mounting rpc_pipefs is messing things up.
Fixed by patch in vfs/for-linus:

#syz fix: rpc_pipefs: deal with early sget() failures

- Eric
