Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDSGpT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:45:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46813 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeDSGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:45:17 -0400
X-Google-Smtp-Source: AB8JxZqT+htvjteNev1cDROltgpeRPZpBjVAxVWU8oVaGvn3Tiu8rxt8l2RkGfJnRMeH0BzDFmtuqoZOgKVSlVN/I+s=
MIME-Version: 1.0
In-Reply-To: <CACsK=jcYaF8ZP6DKTnvTh6SFLh+=eh+SJtn5xjpuxRxpiM9_BA@mail.gmail.com>
References: <CACsK=jcYaF8ZP6DKTnvTh6SFLh+=eh+SJtn5xjpuxRxpiM9_BA@mail.gmail.com>
From: DaeRyong Jeong <threeearcat@gmail.com>
Date: Thu, 19 Apr 2018 15:45:15 +0900
Message-ID: <CACsK=jc7fGFD3CFJLys_K0kZZHXtCZ0YgLy1=dZB2wtfSmQFCg@mail.gmail.com>
Subject: Re: kernel BUG at /home/blee/project/race-fuzzer/kernels/kernel_v4.16-rc3/net/packet/af_packet.c:LINE!
To: LKML <linux-kernel@vger.kernel.org>
Cc: Byoungyoung Lee <byoungyoung@purdue.edu>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
We have analyzed the cause of the crash, kernel BUG at
net/packet/af_packet.c:LINE!,
which is found by RaceFuzzer (a modified version of Syzkaller) in v4.16-rc7.

Since struct packet_sock's member variables, running, has_vnet_hdr, origdev
and auxdata are declared as bitfields, accessing these variables can race if
there is no synchronization mechanism.

We think racing between following lines in af_packet.c causes the crash.
In function __unregister_prot_hook,
    po->running = 0;
In function packet_setsockopt,
    po->has_vnet_hdr = !!val;

Analysis:
CPU0
pakcet_setsockopt
    po->has_vnet_hdr = !!val;

CPU1
packet_do_bind
    __unregister_prot_hook
        po->running = 0;

In the CPU1, the value of po->running should become 0, but because of racing,
it is possible that po->running can keep the value 1.
Consequently, after returning from __unregister_prot_hook, BUG_ON at
net/packet/af_packet.c:3107 can be triggered.


Possible interleaving between racy C source lines is as follows (built with
gcc-7.1.0).
CPU0 (po->has_vnet_hdr = !!val)            CPU1 (po->running = 0)
movzbl 0x6e0(%r15),%eax
                                                           andb
$0xfe,0x6e0(%r13)
shl    $0x3,%r12d
and    $0xfffffff7,%eax
or     %r12d,%eax
mov    %al,0x6e0(%r15)


Please, check out the following reproducer.
C repro code : https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-repro.c
kernel config v4.16-rc3 :
https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-v4.16-rc3.config
kernel config v4.16-rc7 :
https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-v4.16-rc7.config
kernel config v4.15.14 :
https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-v4.15.14.config


= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.

On Sat, Mar 31, 2018 at 1:33 AM, DaeRyong Jeong <threeearcat@gmail.com> wrote:
> We report the crash: kernel BUG at
> /home/blee/project/race-fuzzer/kernels/kernel_v4.16-rc3/net/packet/af_packet.c:LINE!
>
> This crash has been found in v4.16-rc3 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report. Our analysis shows that the race occurs when invoking two
> syscalls concurrently, (setsockopt$packet_int) and (bind$packet).
> We have confirmed that the kernel v4.16-rc3, v4.16-rc7, and v4.15.14
> built with gcc 7.1.0 are crashing by running the provided C repro
> program within a few minutes (5 minutes).
> Note that this crash can be triggered from the user space.
>
> C repro code : https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-repro.c
> kernel config v4.16-rc3 :
> https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-v4.16-rc3.config
> kernel config v4.16-rc7 :
> https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-v4.16-rc7.config
> kernel config v4.15.14 :
> https://kiwi.cs.purdue.edu/static/race-fuzzer/afpacket-setsockopt-bind-v4.15.14.config
>
> [  881.047513] ------------[ cut here ]------------
> [  881.048416] kernel BUG at
> /home/blee/project/race-fuzzer/kernels/kernel_v4.16-rc3/net/packet/af_packet.c:3107!
> [  881.050014] invalid opcode: 0000 [#1] SMP KASAN
> [  881.050698] Dumping ftrace buffer:
> [  881.051244]    (ftrace buffer empty)
> [  881.051768] Modules linked in:
> [  881.052236] CPU: 1 PID: 18247 Comm: syz-executor0 Not tainted 4.16.0-rc3 #1
> [  881.053247] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> [  881.054880] RIP: 0010:packet_do_bind+0x88d/0x950
> [  881.055553] RSP: 0018:ffff8802231d7b08 EFLAGS: 00010212
> [  881.056310] RAX: 0000000000010000 RBX: ffff8800af831740 RCX: ffffc900025ce000
> [  881.057318] RDX: 00000000000000a5 RSI: ffffffff838b257d RDI: 0000000000000001
> [  881.058301] RBP: ffff8802231d7c10 R08: ffff8802342f2480 R09: 0000000000000000
> [  881.059298] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8802309f8f00
> [  881.060314] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000001000
> [  881.061320] FS:  00007f7fab50d700(0000) GS:ffff88023fc00000(0000)
> knlGS:0000000000000000
> [  881.062467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  881.063285] CR2: 0000000020038000 CR3: 00000000b11c9000 CR4: 00000000000006e0
> [  881.064317] Call Trace:
> [  881.064686]  ? compat_packet_setsockopt+0x100/0x100
> [  881.065430]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
> [  881.066188]  packet_bind+0xa2/0xe0
> [  881.066690]  SYSC_bind+0x279/0x2f0
> [  881.067180]  ? move_addr_to_kernel.part.19+0xc0/0xc0
> [  881.067896]  ? do_futex+0x1e90/0x1e90
> [  881.068435]  ? SyS_sched_getaffinity+0xe3/0x100
> [  881.069112]  ? mark_held_locks+0x25/0xb0
> [  881.069677]  ? SyS_socketpair+0x4a0/0x4a0
> [  881.070265]  SyS_bind+0x24/0x30
> [  881.070732]  do_syscall_64+0x209/0x5d0
> [  881.071270]  ? syscall_return_slowpath+0x3e0/0x3e0
> [  881.071929]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
> [  881.072675]  ? syscall_return_slowpath+0x260/0x3e0
> [  881.073365]  ? mark_held_locks+0x25/0xb0
> [  881.073950]  ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
> [  881.074693]  ? trace_hardirqs_off_caller+0xb5/0x120
> [  881.075390]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  881.076079]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [  881.076797] RIP: 0033:0x453909
> [  881.077238] RSP: 002b:00007f7fab50caf8 EFLAGS: 00000212 ORIG_RAX:
> 0000000000000031
> [  881.078268] RAX: ffffffffffffffda RBX: 00000000007080d8 RCX: 0000000000453909
> [  881.079239] RDX: 0000000000000014 RSI: 000000002001f000 RDI: 0000000000000015
> [  881.080268] RBP: 0000000000000250 R08: 0000000000000000 R09: 0000000000000000
> [  881.081256] R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004a82d3
> [  881.082272] R13: 00000000ffffffff R14: 0000000000000015 R15: 000000002001f000
> [  881.083251] Code: c0 fd 48 c7 c2 00 c8 d9 84 be ab 02 00 00 48 c7
> c7 60 c8 d9 84 c6 05 e7 a2 48 02 01 e8 3f 17 af fd e9 60 fb ff ff e8
> 43 b3 c0 fd <0f> 0b e8 3c b3 c0 fd 48 8b bd 20 ff ff ff e8 60 1e e7 fd
> 4c 89
> [  881.085828] RIP: packet_do_bind+0x88d/0x950 RSP: ffff8802231d7b08
> [  881.086619] ---[ end trace 9c461502752b4f3e ]---
> [  881.087181] Kernel panic - not syncing: Fatal exception
> [  881.088352] Dumping ftrace buffer:
> [  881.088877]    (ftrace buffer empty)
> [  881.089414] Kernel Offset: disabled
> [  881.089950] Rebooting in 86400 seconds..
>
> = About RaceFuzzer
>
> RaceFuzzer is a customized version of Syzkaller, specifically tailored
> to find race condition bugs in the Linux kernel. While we leverage
> many different technique, the notable feature of RaceFuzzer is in
> leveraging a custom hypervisor (QEMU/KVM) to interleave the
> scheduling. In particular, we modified the hypervisor to intentionally
> stall a per-core execution, which is similar to supporting per-core
> breakpoint functionality. This allows RaceFuzzer to force the kernel
> to deterministically trigger racy condition (which may rarely happen
> in practice due to randomness in scheduling).
>
> RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
> repro's scheduling synchronization should be performed at the user
> space, its reproducibility is limited (reproduction may take from 1
> second to 10 minutes (or even more), depending on a bug). This is
> because, while RaceFuzzer precisely interleaves the scheduling at the
> kernel's instruction level when finding this bug, C repro cannot fully
> utilize such a feature. Please disregard all code related to
> "should_hypercall" in the C repro, as this is only for our debugging
> purposes using our own hypervisor.
