Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeE3E6r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:58:47 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33467 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeE3E6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:58:45 -0400
X-Google-Smtp-Source: ADUXVKJeDy2jytya3E3dBWoOyWyI0VC9+LWm6rPyWMi38F9zxlDDQY2t5EGUdbciWIDpv4+SfGS1Dg==
Date: Wed, 30 May 2018 00:58:36 -0400 (EDT)
From: Gerb Stralko <gerb.stralko@gmail.com>
X-X-Sender: stralko@localhost.localdomain
To: aviadye@mellanox.com, davejwatson@fb.com, davem@davemloft.net,
        ilyal@mellanox.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: WARNING in iov_iter_revert
Message-ID: <alpine.LFD.2.20.1805300056060.561@localhost.localdomain>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm in the process of fixing this bug 
(https://syzkaller.appspot.com/bug?id=1339e0a805a4ddb11eaee6fb6b1bc905493ded77)

However, there are a couple things I'm trying to wrap my head around to understand and fix this issue properly.

I'm using the C reproducer from syzkaller[1] to trigger this issue which has been a huge help in learning the Linux kernel.

First in tls_sw.c in tls_sw_sendmsg we having the following: 

`do_tcp_sendpages
   `tls_push_sg
      `tls_push_record 

returns -EPIPE (-32) because sk->sk_shudown is set.  See do_tcp_sendpages 
in net/ipv4/tcp.c

Do we need to check for -EPIPE before continuing in tls_sw.c after 
tls_push_record, for example:

if (ret == -EAGAIN || ret == -EPIPE)
                     ^^^^^^^^^^^^^^
  goto send_end;

If -EPIPE is valid and we don't need to check for that particular 
condition 
then calling iov_iter_revert might be wrong because of the second 
argument:

ctx->sg_plaintext_size - orig_size

Because that statement will evaluate to -1 because ctx->sg_plaintext_size 
has been set to zero from earlier when calling:

`free_sg
  `tls_push_sg  

And orig_size is set to 1 from the beginning of the while loop:

orig_size = ctx->sg_plaintext_size

So calling iov_iter_revert with the second argument being -1 will trigger 
the warning in lib/iov_iter.c:iov_iter_revert:

if (WARN_ON(unroll > MAX_RW_COUNT))
     return;

Am I correct in thinking EPIPE should be checked after returning from 
tls_push_record?  Or do we need to do some sanity checks on 
sg_plaintext_size and orig_size before calling iov_iter_revert?

Any help would be greatly appreciated.

[1] https://syzkaller.appspot.com/text?tag=ReproC&x=141d5417800000

On Sunday, May 13, 2018 at 9:28:03 AM UTC-7, syzbot wrote:
>
> Hello, 
>
> syzbot found the following crash on: 
>
> HEAD commit:    427fbe89261d Merge branch 'next' of 
git://git.kernel.org/p.. 
>
> git tree:       upstream 
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b33477800000 
> kernel config:  
https://syzkaller.appspot.com/x/.config?x=fcce42b221691ff9 
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=c226690f7b3126c5ee04 
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental) 
> syzkaller 
repro:https://syzkaller.appspot.com/x/repro.syz?x=144f1997800000 
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141d5417800000 
>
> IMPORTANT: if you fix the bug, please add the following tag to the 
commit: 
> Reported-by: syzbot+c22669...@syzkaller.appspotmail.com <javascript:> 
>
> random: sshd: uninitialized urandom read (32 bytes read) 
> random: sshd: uninitialized urandom read (32 bytes read) 
> random: sshd: uninitialized urandom read (32 bytes read) 
> random: sshd: uninitialized urandom read (32 bytes read) 
> random: sshd: uninitialized urandom read (32 bytes read) 
> WARNING: CPU: 1 PID: 4542 at lib/iov_iter.c:857 
> iov_iter_revert+0x2ee/0xaa0   
> lib/iov_iter.c:857 
> Kernel panic - not syncing: panic_on_warn set ... 
>
> CPU: 1 PID: 4542 Comm: syz-executor650 Not tainted 4.17.0-rc4+ #44 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS   
> Google 01/01/2011 
> Call Trace: 
>   __dump_stack lib/dump_stack.c:77 [inline] 
>   dump_stack+0x1b9/0x294 lib/dump_stack.c:113 
>   panic+0x22f/0x4de kernel/panic.c:184 
>   __warn.cold.8+0x163/0x1b3 kernel/panic.c:536 
>   report_bug+0x252/0x2d0 lib/bug.c:186 
>   fixup_bug arch/x86/kernel/traps.c:178 [inline] 
>   do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296 
>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315 
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992 
> RIP: 0010:iov_iter_revert+0x2ee/0xaa0 lib/iov_iter.c:857 
> RSP: 0018:ffff8801ad1bf700 EFLAGS: 00010293 
> RAX: ffff8801ac55e6c0 RBX: 00000000ffffffff RCX: ffffffff835104a1 
> RDX: 0000000000000000 RSI: ffffffff8351074e RDI: 0000000000000007 
> RBP: ffff8801ad1bf760 R08: ffff8801ac55e6c0 R09: ffffed003b5e46c2 
> R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000001 
> R13: ffff8801ad1bfd60 R14: 0000000000000011 R15: ffff8801ae9ac040 
>   tls_sw_sendmsg+0xf1c/0x12d0 net/tls/tls_sw.c:448 
>   inet_sendmsg+0x19f/0x690 net/ipv4/af_inet.c:798 
>   sock_sendmsg_nosec net/socket.c:629 [inline] 
>   sock_sendmsg+0xd5/0x120 net/socket.c:639 
>   ___sys_sendmsg+0x805/0x940 net/socket.c:2117 
>   __sys_sendmsg+0x115/0x270 net/socket.c:2155 
>   __do_sys_sendmsg net/socket.c:2164 [inline] 
>   __se_sys_sendmsg net/socket.c:2162 [inline] 
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162 
>   do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287 
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe 
> RIP: 0033:0x4403a9 
> RSP: 002b:00007ffdcdfbd6c8 EFLAGS: 00000207 ORIG_RAX: 000000000000002e 
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004403a9 
> RDX: 0000000000000000 RSI: 0000000020001340 RDI: 0000000000000003 
> RBP: 00000000006ca018 R08: 000000000000001c R09: 000000000000001c 
> R10: 0000000020000180 R11: 0000000000000207 R12: 0000000000401cd0 
> R13: 0000000000401d60 R14: 0000000000000000 R15: 0000000000000000 
> Dumping ftrace buffer: 
>     (ftrace buffer empty) 
> Kernel Offset: disabled 
> Rebooting in 86400 seconds.. 
>
>
> --- 
> This bug is generated by a bot. It may contain errors. 
> See https://goo.gl/tpsmEJ for more information about syzbot. 
> syzbot engineers can be reached at syzk...@googlegroups.com 
<javascript:>. 
>
>
> syzbot will keep track of this bug report. See: 
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with   
> syzbot. 
> syzbot can test patches for this bug, for details see: 
> https://goo.gl/tpsmEJ#testing-patches 
>
