Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeERWl3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:41:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35713 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeERWl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:41:27 -0400
X-Google-Smtp-Source: AB8JxZqzm2YKrPbq8dlWS9xMupjQ2MRMLmQMm4o59DMmv00rvtc9MKjVZl1e8XLjuIsMVKyHI9U0TzmLsibIVfSIXNI=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 18 May 2018 23:41:06 +0100
Message-ID: <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Tariq,

2018-02-20 18:11 GMT+00:00 Thomas Gleixner <tglx@linutronix.de>:
> On Tue, 20 Feb 2018, Tariq Toukan wrote:
>
>> Hi Thomas,
>>
>> We started seeing new issues in our net-device daily regression tests.
>> They are related to patch [1] introduced in kernel 4.15-rc1.
>>
>> We frequently see a warning in dmesg [2]. Repro is not consistent, we tried to
>> narrow it down to a smaller run but couldn't.
>>
>> In addition, sometimes (less frequent) the warning is followed by a panic [3].
>
> Which might be just a consequence of the issue which triggers the warning.
>
>> I can share all needed details to help analyze this bug.
>> If you suspect specific flows, we can do an educated narrow down.
>
>> [2]
>> [ 8664.868564] WARNING: CPU: 5 PID: 0 at kernel/irq/matrix.c:370 irq_matrix_free+0x30/0xd0
>> [ 8664.910144] RIP: 0010:irq_matrix_free+0x30/0xd0
>> [ 8664.912624] RSP: 0018:ffff88023fd43f70 EFLAGS: 00010002
>> [ 8664.915149] RAX: 0000000000026318 RBX: ffff880157a77ec0 RCX: 0000000000000000
>> [ 8664.917679] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff880237038400
>> [ 8664.920244] RBP: ffff880237038400 R08: 00000000e8ba3c69 R09: 0000000000000000
>> [ 8664.922813] R10: 00000000000003ff R11: 0000000000000ad9 R12: ffff88023fc40000
>> [ 8664.925345] R13: 0000000000000000 R14: 0000000000000001 R15: 000000000000002b
>> [ 8664.927872] FS:  0000000000000000(0000) GS:ffff88023fd40000(0000) knlGS:0000000000000000
>> [ 8664.930455] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 8664.932996] CR2: 0000000000f2c030 CR3: 000000000220a000 CR4: 00000000000006e0
>> [ 8664.935557] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 8664.938051] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 8664.940541] Call Trace:
>> [ 8664.942980]  <IRQ>
>> [ 8664.945399]  free_moved_vector+0x4e/0x100
>> [ 8664.947787]  smp_irq_move_cleanup_interrupt+0x89/0x9e
>> [ 8664.950134]  irq_move_cleanup_interrupt+0x95/0xa0
>> [ 8664.952480]  </IRQ>
>
> So thats:
>
>         if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
>                 return;
>
> and the disassembly of
>
>> [ 8664.972909] Code: 41 56 41 89 f6 41 55 41 89 d5 89 f2 41 54 4c 8b 24 d5 60
>> 24 18 82 55 48 89 fd 53 48 8b 47 28 44 39 6f 04 77 06 44 3b 6f 08 72 0b <0f>
>> ff 5b 5d 41 5c 41 5d 41 5e c3 49 01 c4 41 80 7c 24 0c 00 74
>
> gives:
>
>   1f:   44 39 6f 04             cmp    %r13d,0x4(%rdi)
>   23:   77 06                   ja     0x2b
>   25:   44 3b 6f 08             cmp    0x8(%rdi),%r13d
>   29:   72 0b                   jb     0x36
>   2b:*  0f ff                   (bad)           <-- trapping instruction
>
> So the vector to release should be in r13d, which is 0. /me scratches head.
>
>> [ 8943.038767] BUG: unable to handle kernel paging request at 000000037a6b561b
>> [ 8943.040114] IP: free_moved_vector+0x61/0x100
>> [ 8943.054654] RIP: 0010:free_moved_vector+0x61/0x100
>> [ 8943.055940] RSP: 0018:ffff88023fd43fa0 EFLAGS: 00010007
>> [ 8943.057233] RAX: 000000037a6b561b RBX: ffff880157a77ec0 RCX: 0000000000000001
>> [ 8943.058506] RDX: 00000000000155a8 RSI: 00000000000155a8 RDI: ffff880237038400
>> [ 8943.059784] RBP: ffff880157a77ec0 R08: 00000000e8ba3c69 R09: 0000000000000000
>> [ 8943.061051] R10: 0000000000000000 R11: 0000000000000000 R12: 000000007f0c0001
>> [ 8943.062462] R13: 00000000000155a8 R14: 0000000000000001 R15: 0000000000cc620d
>> [ 8943.063726] FS:  0000000000000000(0000) GS:ffff88023fd40000(0000) knlGS:0000000000000000
>> [ 8943.064993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 8943.066253] CR2: 000000037a6b561b CR3: 000000010badc000 CR4: 00000000000006e0
>> [ 8943.067522] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 8943.068771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 8943.070029] Call Trace:
>> [ 8943.071273]  <IRQ>
>> [ 8943.072503]  smp_irq_move_cleanup_interrupt+0x89/0x9e
>> [ 8943.073794]  irq_move_cleanup_interrupt+0x95/0xa0
>> [ 8943.075048]  </IRQ>
> ...
>> [ 8943.092659] Code: 44 00 00 48 8b 3d c8 f7 9f 01 44 89 f1 44 89 e2 44 89 ee
>> e8 e2 05 0b 00 48 c7 c0 20 50 01 00 4a 8d 04 e0 4a 03 04 ed 60 24 18 82 <48>
>> c7 00 00 00 00 00 48 8b 45 28 48 85 c0 74 20 48 8b 55 20 48
>
>  17:*   48 c7 00 00 00 00 00    movq   $0x0,(%rax)              <-- trapping instruction
>
> I can't tell exactly which part of free_moved_vector() that is and which
> vector it tries to free, but its more or less the same crap just with a
> fatal vector number.
>
> Is there CPU hotplugging in play?
>
> I'll come back to you tomorrow with a plan how to debug that after staring
> into the code some more.

I'm not entirely sure that it's the same fault, but at least backtrace
looks resembling.
I've got it in VM on the last master: v4.17-rc5-110-g2c71d338bef2
Let me know if you need .config or CPU/qemu details or anything.
I'm not sure if it'll reproduce, but might still worth to paste it here:

[root@localhost self]# [  125.240084] WARNING: CPU: 1 PID: 2198 at
kernel/irq/matrix.c:371 irq_matrix_free+0x20/0xc0
[  125.242306] Modules linked in:
[  125.242709] CPU: 1 PID: 2198 Comm: sshd Not tainted 4.17.0-rc5+ #11
[  125.242949] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1.fc26 04/01/2014
[  125.243342] RIP: 0010:irq_matrix_free+0x20/0xc0
[  125.243517] RSP: 0000:ffff926e7fd03e30 EFLAGS: 00000002
[  125.243737] RAX: 0000000000000001 RBX: ffff926e7fd24700 RCX: 0000000000000000
[  125.243993] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff926e7d108400
[  125.244249] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  125.244503] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  125.244761] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[  125.245049] FS:  00007ffb4f9e74c0(0000) GS:ffff926e7fd00000(0000)
knlGS:0000000000000000
[  125.245331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.245540] CR2: 0000564a977e9658 CR3: 00000000717fe000 CR4: 00000000000006e0
[  125.245839] Call Trace:
[  125.246308]  <IRQ>
[  125.246571]  free_moved_vector+0x43/0x100
[  125.246765]  smp_irq_move_cleanup_interrupt+0xa4/0xb9
[  125.246959]  irq_move_cleanup_interrupt+0xc/0x20
[  125.247218] RIP: 0010:__do_softirq+0xa3/0x324
[  125.247382] RSP: 0000:ffff926e7fd03f78 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffffdf
[  125.247655] RAX: 00000000ffffffff RBX: ffff926e6ca6b300 RCX: 0000000000000020
[  125.247911] RDX: 0000000000000000 RSI: 0000000080000000 RDI: ffffffff9566211b
[  125.248156] RBP: 0000000000000000 R08: 00000000000f4200 R09: 0000001d27c0d340
[  125.248403] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[  125.248650] R13: 0000000000000000 R14: 0000000000000200 R15: 0000000000000000
[  125.248929]  ? irq_move_cleanup_interrupt+0x7/0x20
[  125.249129]  ? irq_exit+0xbb/0xc0
[  125.249285]  ? __do_softirq+0x9d/0x324
[  125.249432]  ? hrtimer_interrupt+0x118/0x240
[  125.249606]  irq_exit+0xbb/0xc0
[  125.249751]  smp_apic_timer_interrupt+0x6c/0x120
[  125.249932]  apic_timer_interrupt+0xf/0x20
[  125.250122]  </IRQ>
[  125.250318] RIP: 0033:0x7ffb4cdb2cdd
[  125.250456] RSP: 002b:00007fff031177e0 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  125.250722] RAX: 0000564a975a13ee RBX: 0000564a975a13e7 RCX: 0000000000000004
[  125.250966] RDX: 0000000000000074 RSI: 0000000000000025 RDI: 0000564a975a13ee
[  125.251211] RBP: 00007fff03117d50 R08: 0000564a975a13ee R09: 00000000fffffffc
[  125.251457] R10: 0000564a98c7a4f0 R11: 0000000000000004 R12: 00007fff03117ea0
[  125.251700] R13: 0000000000000009 R14: 00007fff03117d60 R15: 00007ffb4d12f4c0
[  125.251977] Code: 98 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
89 f0 41 56 41 55 41 54 55 53 48 8b 5f 28 48 03 1c c5 20 14 6b 96 39
57 04 76 0b <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 39 57 08 76 f0 89 d0 f0
48 0f
[  125.253132] ---[ end trace 47657dc74f8ba53a ]---

What I did - was running x86 selftests and ssh'ing at the same moment.
Will try it again if it'll fire by any chance.

Thanks,
             Dmitry
