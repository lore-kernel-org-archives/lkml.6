Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeBTSLR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:11:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeBTSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:11:16 -0500
Date: Tue, 20 Feb 2018 19:11:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tariq Toukan <tariqt@mellanox.com>
cc: linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
Message-ID: <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Tariq Toukan wrote:

> Hi Thomas,
> 
> We started seeing new issues in our net-device daily regression tests.
> They are related to patch [1] introduced in kernel 4.15-rc1.
> 
> We frequently see a warning in dmesg [2]. Repro is not consistent, we tried to
> narrow it down to a smaller run but couldn't.
> 
> In addition, sometimes (less frequent) the warning is followed by a panic [3].

Which might be just a consequence of the issue which triggers the warning.

> I can share all needed details to help analyze this bug.
> If you suspect specific flows, we can do an educated narrow down.

> [2]
> [ 8664.868564] WARNING: CPU: 5 PID: 0 at kernel/irq/matrix.c:370 irq_matrix_free+0x30/0xd0
> [ 8664.910144] RIP: 0010:irq_matrix_free+0x30/0xd0
> [ 8664.912624] RSP: 0018:ffff88023fd43f70 EFLAGS: 00010002
> [ 8664.915149] RAX: 0000000000026318 RBX: ffff880157a77ec0 RCX: 0000000000000000
> [ 8664.917679] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff880237038400
> [ 8664.920244] RBP: ffff880237038400 R08: 00000000e8ba3c69 R09: 0000000000000000
> [ 8664.922813] R10: 00000000000003ff R11: 0000000000000ad9 R12: ffff88023fc40000
> [ 8664.925345] R13: 0000000000000000 R14: 0000000000000001 R15: 000000000000002b
> [ 8664.927872] FS:  0000000000000000(0000) GS:ffff88023fd40000(0000) knlGS:0000000000000000
> [ 8664.930455] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8664.932996] CR2: 0000000000f2c030 CR3: 000000000220a000 CR4: 00000000000006e0
> [ 8664.935557] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 8664.938051] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 8664.940541] Call Trace:
> [ 8664.942980]  <IRQ>
> [ 8664.945399]  free_moved_vector+0x4e/0x100
> [ 8664.947787]  smp_irq_move_cleanup_interrupt+0x89/0x9e
> [ 8664.950134]  irq_move_cleanup_interrupt+0x95/0xa0
> [ 8664.952480]  </IRQ>

So thats:

        if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
                return;

and the disassembly of

> [ 8664.972909] Code: 41 56 41 89 f6 41 55 41 89 d5 89 f2 41 54 4c 8b 24 d5 60
> 24 18 82 55 48 89 fd 53 48 8b 47 28 44 39 6f 04 77 06 44 3b 6f 08 72 0b <0f>
> ff 5b 5d 41 5c 41 5d 41 5e c3 49 01 c4 41 80 7c 24 0c 00 74

gives:

  1f:	44 39 6f 04          	cmp    %r13d,0x4(%rdi)
  23:	77 06                	ja     0x2b
  25:	44 3b 6f 08          	cmp    0x8(%rdi),%r13d
  29:	72 0b                	jb     0x36
  2b:*	0f ff                	(bad)  		<-- trapping instruction

So the vector to release should be in r13d, which is 0. /me scratches head.

> [ 8943.038767] BUG: unable to handle kernel paging request at 000000037a6b561b
> [ 8943.040114] IP: free_moved_vector+0x61/0x100
> [ 8943.054654] RIP: 0010:free_moved_vector+0x61/0x100
> [ 8943.055940] RSP: 0018:ffff88023fd43fa0 EFLAGS: 00010007
> [ 8943.057233] RAX: 000000037a6b561b RBX: ffff880157a77ec0 RCX: 0000000000000001
> [ 8943.058506] RDX: 00000000000155a8 RSI: 00000000000155a8 RDI: ffff880237038400
> [ 8943.059784] RBP: ffff880157a77ec0 R08: 00000000e8ba3c69 R09: 0000000000000000
> [ 8943.061051] R10: 0000000000000000 R11: 0000000000000000 R12: 000000007f0c0001
> [ 8943.062462] R13: 00000000000155a8 R14: 0000000000000001 R15: 0000000000cc620d
> [ 8943.063726] FS:  0000000000000000(0000) GS:ffff88023fd40000(0000) knlGS:0000000000000000
> [ 8943.064993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8943.066253] CR2: 000000037a6b561b CR3: 000000010badc000 CR4: 00000000000006e0
> [ 8943.067522] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 8943.068771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 8943.070029] Call Trace:
> [ 8943.071273]  <IRQ>
> [ 8943.072503]  smp_irq_move_cleanup_interrupt+0x89/0x9e
> [ 8943.073794]  irq_move_cleanup_interrupt+0x95/0xa0
> [ 8943.075048]  </IRQ>
...
> [ 8943.092659] Code: 44 00 00 48 8b 3d c8 f7 9f 01 44 89 f1 44 89 e2 44 89 ee
> e8 e2 05 0b 00 48 c7 c0 20 50 01 00 4a 8d 04 e0 4a 03 04 ed 60 24 18 82 <48>
> c7 00 00 00 00 00 48 8b 45 28 48 85 c0 74 20 48 8b 55 20 48

 17:*	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)		<-- trapping instruction

I can't tell exactly which part of free_moved_vector() that is and which
vector it tries to free, but its more or less the same crap just with a
fatal vector number.

Is there CPU hotplugging in play?

I'll come back to you tomorrow with a plan how to debug that after staring
into the code some more.

Thanks,

	tglx
