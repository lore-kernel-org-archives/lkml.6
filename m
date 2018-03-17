Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeCQTNB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:13:01 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:55718 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeCQTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:12:57 -0400
Subject: Re: NULL pointer dereferences with 4.14.27
To: Carlos Carvalho <carlos@fisica.ufpr.br>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180317184110.GA9702@fisica.ufpr.br>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f5882c4c-049e-3485-9ad4-f552a38e8b0c@applied-asynchrony.com>
Date: Sat, 17 Mar 2018 20:12:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317184110.GA9702@fisica.ufpr.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/18 19:41, Carlos Carvalho wrote:
> I've put 4.14.27 this morning in this machine and in about 2h it started
> showing null dereferences identical to the following one. There were several of
> them, with about 1/2h of interval. Strangely it continued to work and I saw no
> other anomalies. I've just reverted to 4.14.26.
> 
> It only happened in this machine, which has a net traffic of several Gb/s and
> thousands of simultaneous connections.
> 
> Mar 17 13:29:21 sagres kernel: : BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
> Mar 17 13:29:21 sagres kernel: : IP: tcp_push+0x4e/0xe7
> Mar 17 13:29:21 sagres kernel: : PGD 0 P4D 0 
> Mar 17 13:29:21 sagres kernel: : Oops: 0002 [#1] SMP PTI
> Mar 17 13:29:21 sagres kernel: : CPU: 55 PID: 2658 Comm: apache2 Not tainted 4.14.27 #4
> Mar 17 13:29:21 sagres kernel: : task: ffff89791cf7e600 task.stack: ffffabdd91db8000
> Mar 17 13:29:21 sagres kernel: : RIP: 0010:tcp_push+0x4e/0xe7
> Mar 17 13:29:21 sagres kernel: : RSP: 0018:ffffabdd91dbbc10 EFLAGS: 00010246
> Mar 17 13:29:21 sagres kernel: : RAX: 0000000000000000 RBX: 00000000000004c4 RCX: 0000000000000001
> Mar 17 13:29:21 sagres kernel: : RDX: 0000000000000001 RSI: 0000000000000040 RDI: ffff89968330a100
> Mar 17 13:29:21 sagres kernel: : RBP: ffff89968330a250 R08: 0000000000007be8 R09: ffffe77cbfc4ab00
> Mar 17 13:29:21 sagres kernel: : R10: ffff89968330a250 R11: 0000000000000000 R12: ffff8987aab3bb80
> Mar 17 13:29:21 sagres kernel: : R13: ffff89968330a100 R14: ffff89791cf7e930 R15: 00000000ffffffe0
> Mar 17 13:29:21 sagres kernel: : FS:  00007f0bd67d4700(0000) GS:ffff89993f4c0000(0000) knlGS:0000000000000000
> Mar 17 13:29:21 sagres kernel: : CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 17 13:29:21 sagres kernel: : CR2: 0000000000000038 CR3: 0000003ff4842006 CR4: 00000000003606e0
> Mar 17 13:29:21 sagres kernel: : DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Mar 17 13:29:21 sagres kernel: : DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Mar 17 13:29:21 sagres kernel: : Call Trace:
> Mar 17 13:29:21 sagres kernel: : tcp_sendmsg_locked+0xac6/0xc1e
> Mar 17 13:29:21 sagres kernel: : tcp_sendmsg+0x23/0x35
> Mar 17 13:29:21 sagres kernel: : sock_sendmsg+0x11/0x1b
> Mar 17 13:29:21 sagres kernel: : sock_write_iter+0x71/0x87
> Mar 17 13:29:21 sagres kernel: : do_iter_readv_writev+0xf0/0x111
> Mar 17 13:29:21 sagres kernel: : do_iter_write+0x84/0xf0
> Mar 17 13:29:21 sagres kernel: : vfs_writev+0xad/0xfb
> Mar 17 13:29:21 sagres kernel: : ? do_writev+0x56/0x92
> Mar 17 13:29:21 sagres kernel: : do_writev+0x56/0x92
> Mar 17 13:29:21 sagres kernel: : do_syscall_64+0x181/0x210
> Mar 17 13:29:21 sagres kernel: : entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> Mar 17 13:29:21 sagres kernel: : RIP: 0033:0x7f13f1264017
> Mar 17 13:29:21 sagres kernel: : RSP: 002b:00007f0bd67d2810 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
> Mar 17 13:29:21 sagres kernel: : RAX: ffffffffffffffda RBX: 0000000000000079 RCX: 00007f13f1264017
> Mar 17 13:29:21 sagres kernel: : RDX: 000000000000000a RSI: 00007f0bd67d2970 RDI: 0000000000000079
> Mar 17 13:29:21 sagres kernel: : RBP: 00007f0bd67d2970 R08: 0000000000000000 R09: 00007f13680762c8
> Mar 17 13:29:21 sagres kernel: : R10: 0000556029c85dd4 R11: 0000000000000293 R12: 000000000000000a
> Mar 17 13:29:21 sagres kernel: : R13: 00007f0bd67d2970 R14: 00007f0bd67d28d0 R15: 0000556029ea1440
> Mar 17 13:29:21 sagres kernel: : Code: d0 75 02 31 c0 41 89 f3 41 81 e3 00 80 00 00 74 1a 44 8b 8f 58 05 00 00 41 d1 e9 44 2b 8f 5c 06 00 00 44 03 8f 64 06 00 00 79 10 <80> 48 38 08 8b 8f 5c 06 00 00 89 8f 64 06 00 00 40 80 e6 01 74 
> Mar 17 13:29:21 sagres kernel: : RIP: tcp_push+0x4e/0xe7 RSP: ffffabdd91dbbc10
> Mar 17 13:29:21 sagres kernel: : CR2: 0000000000000038
> Mar 17 13:29:21 sagres kernel: : ---[ end trace f9a8f71d250d2782 ]---
> 

Fixed by: https://www.spinics.net/lists/netdev/msg489445.html

-h
