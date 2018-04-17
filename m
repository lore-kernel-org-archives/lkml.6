Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755603AbeDQQMk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:12:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56894 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbeDQQMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:12:37 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code: section, v3
Date: Tue, 17 Apr 2018 18:11:15 +0200
Message-Id: <20180417161124.5294-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's v3 now that the merge window is done, with hopefully all review
feedback (thanks Josh et al!) incorporated.

Thx.

Borislav Petkov (9):
  x86/dumpstack: Remove code_bytes
  x86/dumpstack: Unexport oops_begin()
  x86/dumpstack: Carve out Code: dumping into a function
  x86/dumpstack: Improve opcodes dumping in the Code: section
  x86/dumpstack: Add loglevel argument to show_opcodes()
  x86/fault: Dump user opcode bytes on fatal faults
  x86/dumpstack: Add a show_ip() function
  x86/dumpstack: Save first regs set for the executive summary
  x86/dumpstack: Explain the reasoning for the prologue and buffer size

 Documentation/admin-guide/kernel-parameters.txt |   5 -
 arch/x86/include/asm/stacktrace.h               |   2 +
 arch/x86/kernel/dumpstack.c                     | 144 ++++++++++++------------
 arch/x86/kernel/process_32.c                    |   8 +-
 arch/x86/mm/fault.c                             |   7 +-
 5 files changed, 80 insertions(+), 86 deletions(-)

-- 
2.13.0

Changelog:

v2:

here's v2 with the dumpstack cleanups. This one gets rid of code_bytes=
as it was discussed last time. As a result, the code got even leaner and
simpler. I like that. :)

Thx.

Borislav Petkov (9):
  x86/dumstack: Remove code_bytes
  x86/dumpstack: Unexport oops_begin()
  x86/dumpstack: Carve out Code: dumping into a function
  x86/dumpstack: Improve opcodes dumping in the Code: section
  x86/dumpstack: Add loglevel argument to show_opcodes()
  x86/fault: Dump user opcode bytes on fatal faults
  x86/dumpstack: Add a show_ip() function
  x86/dumpstack: Save first regs set for the executive summary
  x86/dumpstack: Explain the reasoning for the prologue and buffer size

 Documentation/admin-guide/kernel-parameters.txt |   5 -
 arch/x86/include/asm/stacktrace.h               |   2 +
 arch/x86/kernel/dumpstack.c                     | 138 ++++++++++++------------
 arch/x86/kernel/process_32.c                    |   4 +-
 arch/x86/mm/fault.c                             |   7 +-
 5 files changed, 78 insertions(+), 78 deletions(-)


v1:

Hi,

here's v2 of the dumpstack cleanups.

I've split them into more fine-grained pieces to show each change. The
relevant parts are the saving of the executive registers of the first
time we oops and dumping them in the end + opcode bytes for user faults.
I've tested splats in a 80x25 screen and the registers, RIP and opcode
bytes fit all in.

I'm adding exemplary dumps from 32-bit and 64-bit at the end of this mail.

I still have on my TODO list to experiment with console log levels and
see whether we can do a best-of-both-worlds thing there.

v0:

Hi,

so I've been thinking about doing this for a while now: be able to dump
the opcode bytes around the user rIP just like we do for kernel faults.

Why?

See patch 5's commit message. That's why I've marked it RFC.

The rest is cleanups: we're copying the opcodes byte-by-byte and that's
just wasteful.

Also, we're using probe_kernel_read() underneath and it does
__copy_from_user_inatomic() which makes copying user opcode bytes
trivial.

With that, it looks like this:

[  696.837457] strsep[1733]: segfault at 40066b ip 00007fad558fccf8 sp 00007ffc5e662520 error 7 in libc-2.26.so[7fad55876000+1ad000]
[  696.837538] Code: 1b 48 89 fd 48 89 df e8 77 99 f9 ff 48 01 d8 80 38 00 75 17 48 c7 45 00 00 00 00 00 48 83 c4 08 48 89 d8 5b 5d c3 0f 1f 44 00 00 <c6> 00 00 48 83 c0 01 48 89 45 00 48 83 c4 08 48 89 d8 5b 5d c3

and the code matches, as expected:

0000000000086cc0 <__strsep_g@@GLIBC_2.2.5>:
   86cc0:       55                      push   %rbp
   86cc1:       53                      push   %rbx
   86cc2:       48 83 ec 08             sub    $0x8,%rsp
   86cc6:       48 8b 1f                mov    (%rdi),%rbx
   86cc9:       48 85 db                test   %rbx,%rbx
   86ccc:       74 1b                   je     86ce9 <__strsep_g@@GLIBC_2.2.5+0x29>
   86cce:       48 89 fd                mov    %rdi,%rbp
   86cd1:       48 89 df                mov    %rbx,%rdi
   86cd4:       e8 77 99 f9 ff          callq  20650 <*ABS*+0x854e0@plt>
   86cd9:       48 01 d8                add    %rbx,%rax
   86cdc:       80 38 00                cmpb   $0x0,(%rax)
   86cdf:       75 17                   jne    86cf8 <__strsep_g@@GLIBC_2.2.5+0x38>
   86ce1:       48 c7 45 00 00 00 00    movq   $0x0,0x0(%rbp)
   86ce8:       00 
   86ce9:       48 83 c4 08             add    $0x8,%rsp
   86ced:       48 89 d8                mov    %rbx,%rax
   86cf0:       5b                      pop    %rbx
   86cf1:       5d                      pop    %rbp
   86cf2:       c3                      retq   
   86cf3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
   86cf8:       c6 00 00                movb   $0x0,(%rax)
   86cfb:       48 83 c0 01             add    $0x1,%rax
   86cff:       48 89 45 00             mov    %rax,0x0(%rbp)
   86d03:       48 83 c4 08             add    $0x8,%rsp
   86d07:       48 89 d8                mov    %rbx,%rax
   86d0a:       5b                      pop    %rbx
   86d0b:       5d                      pop    %rbp
   86d0c:       c3                      retq

Comments and suggestions are welcome!

Thx.

Example dumps

v3:

64-bit:

[   34.688928] sysrq: SysRq : Trigger a crash
[   34.690799] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   34.692653] PGD 7aac2067 P4D 7aac2067 PUD 7aac3067 PMD 0 
[   34.692653] Oops: 0002 [#1] PREEMPT SMP
[   34.692653] CPU: 0 PID: 3695 Comm: bash Not tainted 4.16.0+ #14
[   34.692653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   34.692653] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   34.692653] Code: d1 e8 9d f1 b6 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 46 0c bd ff c7 05 74 0e 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 46 0a c2 ff fb e9 30 
[   34.692653] RSP: 0018:ffffc90001b57df0 EFLAGS: 00010246
[   34.692653] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   34.692653] RDX: 0000000000000000 RSI: ffffffff81101f2a RDI: 0000000000000063
[   34.692653] RBP: ffffffff8226fec0 R08: 0000000000000183 R09: 00000000000a8320
[   34.692653] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   34.692653] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   34.692653] FS:  00007ffff7fdb700(0000) GS:ffff88007ec00000(0000) knlGS:0000000000000000
[   34.692653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.692653] CR2: 0000000000000000 CR3: 0000000079462000 CR4: 00000000000406f0
[   34.692653] Call Trace:
[   34.692653]  __handle_sysrq+0x9e/0x160
[   34.692653]  write_sysrq_trigger+0x2b/0x30
[   34.692653]  proc_reg_write+0x38/0x70
[   34.692653]  __vfs_write+0x36/0x160
[   34.692653]  ? __fd_install+0x69/0x110
[   34.692653]  ? preempt_count_add+0x74/0xb0
[   34.692653]  ? _raw_spin_lock+0x13/0x30
[   34.692653]  ? set_close_on_exec+0x41/0x80
[   34.692653]  ? preempt_count_sub+0xa8/0x100
[   34.692653]  vfs_write+0xc0/0x190
[   34.692653]  ksys_write+0x64/0xe0
[   34.692653]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   34.692653]  do_syscall_64+0x70/0x130
[   34.692653]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   34.692653] RIP: 0033:0x7ffff74b9620
[   34.692653] Code: 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 24 
[   34.692653] RSP: 002b:00007fffffffe6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   34.692653] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   34.692653] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   34.692653] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   34.692653] R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
[   34.692653] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   34.692653] Modules linked in:
[   34.692653] CR2: 0000000000000000
[   34.728373] ---[ end trace 84a5f329ce73ad83 ]---
[   34.730511] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   34.732585] Code: d1 e8 9d f1 b6 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 46 0c bd ff c7 05 74 0e 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 46 0a c2 ff fb e9 30 
[   34.739863] RSP: 0018:ffffc90001b57df0 EFLAGS: 00010246
[   34.740612] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   34.741653] RDX: 0000000000000000 RSI: ffffffff81101f2a RDI: 0000000000000063
[   34.742585] RBP: ffffffff8226fec0 R08: 0000000000000183 R09: 00000000000a8320
[   34.743517] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   34.744500] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   34.745626] FS:  00007ffff7fdb700(0000) GS:ffff88007ec00000(0000) knlGS:0000000000000000
[   34.746691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.747422] CR2: 0000000000000000 CR3: 0000000079462000 CR4: 00000000000406f0
[   34.748382] Kernel panic - not syncing: Fatal exception
[   34.749531] Kernel Offset: disabled
[   34.750005] ---[ end Kernel panic - not syncing: Fatal exception ]---

32-bit:

[  103.959732] sysrq: SysRq : Trigger a crash
[  103.964190] BUG: unable to handle kernel NULL pointer dereference at 00000000
[  103.968108] *pde = 00000000 
[  103.968108] Oops: 0002 [#1] PREEMPT SMP
[  103.968108] CPU: 5 PID: 2117 Comm: bash Not tainted 4.16.0+ #15
[  103.968108] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  103.968108] EIP: sysrq_handle_crash+0x1d/0x30
[  103.968108] Code: ff eb d6 e8 a5 f4 b9 ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 03 f0 bf ff c7 05 34 b2 c1 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 44 
[  103.968108] EAX: 00000000 EBX: 0000000a ECX: 00000000 EDX: c1505ad0
[  103.968108] ESI: 00000063 EDI: 00000000 EBP: f374fe80 ESP: f374fe80
[  103.968108] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  103.968108] CR0: 80050033 CR2: 00000000 CR3: 33044000 CR4: 000406d0
[  103.968108] Call Trace:
[  103.968108]  __handle_sysrq+0x93/0x130
[  103.968108]  ? sysrq_filter+0x3c0/0x3c0
[  103.968108]  write_sysrq_trigger+0x27/0x40
[  103.968108]  proc_reg_write+0x4d/0x80
[  103.968108]  ? proc_reg_poll+0x70/0x70
[  103.968108]  __vfs_write+0x38/0x160
[  103.968108]  ? preempt_count_sub+0xa0/0x110
[  103.968108]  ? set_close_on_exec+0x4b/0x60
[  103.968108]  ? preempt_count_sub+0xa0/0x110
[  103.968108]  ? __fd_install+0x51/0xd0
[  103.968108]  ? __sb_start_write+0x4c/0xc0
[  103.968108]  ? preempt_count_sub+0xa0/0x110
[  103.968108]  vfs_write+0x98/0x180
[  103.968108]  ksys_write+0x51/0xb0
[  103.968108]  SyS_write+0x16/0x20
[  103.968108]  do_fast_syscall_32+0x99/0x200
[  103.968108]  entry_SYSENTER_32+0x53/0x86
[  103.968108] EIP: 0xb7f71b35
[  103.968108] Code: 89 e5 8b 55 08 8b 80 64 cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[  103.968108] EAX: ffffffda EBX: 00000001 ECX: 09b11a08 EDX: 00000002
[  103.968108] ESI: 00000002 EDI: b7f3cd80 EBP: 09b11a08 ESP: bfeeb390
[  103.968108] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  103.968108] Modules linked in:
[  103.968108] CR2: 0000000000000000
[  104.023961] ---[ end trace 705add298921f2dd ]---
[  104.025249] EIP: sysrq_handle_crash+0x1d/0x30
[  104.026323] Code: ff eb d6 e8 a5 f4 b9 ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 03 f0 bf ff c7 05 34 b2 c1 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 44 
[  104.034894] EAX: 00000000 EBX: 0000000a ECX: 00000000 EDX: c1505ad0
[  104.036643] ESI: 00000063 EDI: 00000000 EBP: f374fe80 ESP: c1c1187c
[  104.038432] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  104.040185] CR0: 80050033 CR2: 00000000 CR3: 33044000 CR4: 000406d0
[  104.041826] Kernel panic - not syncing: Fatal exception
[  104.043607] Kernel Offset: disabled
[  104.044170] ---[ end Kernel panic - not syncing: Fatal exception ]---




v2:

64-bit:

[   53.534957] sysrq: SysRq : Trigger a crash
[   53.536939] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   53.539982] PGD 79149067 P4D 79149067 PUD 793a5067 PMD 0 
[   53.540897] Oops: 0002 [#1] PREEMPT SMP
[   53.540897] CPU: 6 PID: 3700 Comm: bash Not tainted 4.16.0-rc5+ #11
[   53.540897] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   53.540897] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   53.540897] Code: d1 e8 6d 08 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 76 1f bd ff c7 05 a4 12 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 c6 1b c2 ff fb e9 80 
[   53.540897] RSP: 0018:ffffc9000053bdf0 EFLAGS: 00010246
[   53.540897] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   53.540897] RDX: 0000000000000000 RSI: ffffffff81101e0a RDI: 0000000000000063
[   53.540897] RBP: ffffffff822714c0 R08: 0000000000000185 R09: 00000000000829ad
[   53.540897] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   53.540897] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   53.540897] FS:  00007ffff7fdb700(0000) GS:ffff88007ed80000(0000) knlGS:0000000000000000
[   53.540897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.540897] CR2: 0000000000000000 CR3: 0000000079107000 CR4: 00000000000406e0
[   53.540897] Call Trace:
[   53.540897]  __handle_sysrq+0x9e/0x160
[   53.540897]  write_sysrq_trigger+0x2b/0x30
[   53.540897]  proc_reg_write+0x38/0x70
[   53.540897]  __vfs_write+0x36/0x160
[   53.540897]  ? __fd_install+0x69/0x110
[   53.540897]  ? preempt_count_add+0x74/0xb0
[   53.540897]  ? _raw_spin_lock+0x13/0x30
[   53.540897]  ? set_close_on_exec+0x41/0x80
[   53.540897]  ? preempt_count_sub+0xa8/0x100
[   53.540897]  vfs_write+0xc0/0x190
[   53.540897]  SyS_write+0x64/0xe0
[   53.540897]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   53.540897]  do_syscall_64+0x70/0x130
[   53.540897]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   53.540897] RIP: 0033:0x7ffff74b9620
[   53.540897] Code: 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 24 
[   53.540897] RSP: 002b:00007fffffffe6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   53.540897] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   53.540897] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   53.540897] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   53.540897] R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
[   53.540897] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   53.540897] Modules linked in:
[   53.540897] CR2: 0000000000000000
[   53.576029] ---[ end trace 9b6fe8eba592293d ]---
[   53.578109] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   53.580191] Code: d1 e8 6d 08 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 76 1f bd ff c7 05 a4 12 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 c6 1b c2 ff fb e9 80 
[   53.587244] RSP: 0018:ffffc9000053bdf0 EFLAGS: 00010246
[   53.587928] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   53.588929] RDX: 0000000000000000 RSI: ffffffff81101e0a RDI: 0000000000000063
[   53.589956] RBP: ffffffff822714c0 R08: 0000000000000185 R09: 00000000000829ad
[   53.590886] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   53.591812] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   53.592781] Kernel panic - not syncing: Fatal exception
[   53.594100] Kernel Offset: disabled
[   53.594571] ---[ end Kernel panic - not syncing: Fatal exception ]---

[   22.737752] strsep[3728]: segfault at 40066b ip 00007ffff7abe22b sp 00007fffffffea60 error 7 in libc-2.19.so[7ffff7a33000+19f000]
[   22.742487] Code: 48 89 fd 53 48 83 ec 08 48 8b 1f 48 85 db 74 67 0f b6 06 84 c0 74 33 80 7e 01 00 74 22 48 89 df e8 5a 8a ff ff 48 85 c0 74 20 <c6> 00 00 48 83 c0 01 48 89 45 00 48 89 d8 48 83 c4 08 5b 5d c3 0f


32-bit
------

[  151.053373] sysrq: SysRq : Trigger a crash
[  151.056586] BUG: unable to handle kernel NULL pointer dereference at 00000000
[  151.060237] *pde = 00000000 
[  151.060484] Oops: 0002 [#1] PREEMPT SMP
[  151.060484] CPU: 1 PID: 2070 Comm: bash Not tainted 4.16.0-rc5+ #12
[  151.060484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  151.060484] EIP: sysrq_handle_crash+0x1d/0x30
[  151.060484] Code: ff eb d6 e8 75 0f ba ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 03 07 c0 ff c7 05 34 72 c1 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 44 
[  151.060484] EAX: 00000000 EBX: 0000000a ECX: 00000000 EDX: c1503f70
[  151.060484] ESI: 00000063 EDI: 00000000 EBP: f36d7e8c ESP: f36d7e8c
[  151.060484]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  151.060484] CR0: 80050033 CR2: 00000000 CR3: 33d64000 CR4: 000406d0
[  151.060484] Call Trace:
[  151.060484]  __handle_sysrq+0x93/0x130
[  151.060484]  ? sysrq_filter+0x3c0/0x3c0
[  151.060484]  write_sysrq_trigger+0x27/0x40
[  151.060484]  proc_reg_write+0x4d/0x80
[  151.060484]  ? proc_reg_poll+0x70/0x70
[  151.060484]  __vfs_write+0x38/0x160
[  151.060484]  ? preempt_count_sub+0xa0/0x110
[  151.060484]  ? __fd_install+0x51/0xd0
[  151.060484]  ? __sb_start_write+0x4c/0xc0
[  151.060484]  ? preempt_count_sub+0xa0/0x110
[  151.060484]  vfs_write+0x98/0x180
[  151.060484]  SyS_write+0x4f/0xb0
[  151.060484]  do_fast_syscall_32+0x99/0x200
[  151.060484]  entry_SYSENTER_32+0x53/0x86
[  151.060484] EIP: 0xb7f25b35
[  151.060484] Code: 89 e5 8b 55 08 8b 80 64 cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[  151.060484] EAX: ffffffda EBX: 00000001 ECX: 08b14a08 EDX: 00000002
[  151.060484] ESI: 00000002 EDI: b7ef0d80 EBP: 08b14a08 ESP: bfc53830
[  151.060484]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  151.060484] Modules linked in:
[  151.060484] CR2: 0000000000000000
[  151.128925] ---[ end trace 822f779813ab57e1 ]---
[  151.136624] EIP: sysrq_handle_crash+0x1d/0x30
[  151.136625] Code: ff eb d6 e8 75 0f ba ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 03 07 c0 ff c7 05 34 72 c1 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 44 
[  151.136658] EAX: 00000000 EBX: 0000000a ECX: 00000000 EDX: c1503f70
[  151.136659] ESI: 00000063 EDI: 00000000 EBP: f36d7e8c ESP: c1c0d87c
[  151.136661]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  151.136662] Kernel panic - not syncing: Fatal exception
[  151.137001] Kernel Offset: disabled
[  151.140587] ---[ end Kernel panic - not syncing: Fatal exception ]---

[  103.241026] strsep32[2125]: segfault at 4336a7 ip b7df6758 sp bfc73fd0 error 7 in libc-2.26.so[b7d76000+1cd000]
[  103.252505] Code: 1d 83 ec 08 ff 74 24 1c 56 e8 14 d6 ff ff 01 f0 83 c4 10 80 38 00 75 12 c7 03 00 00 00 00 83 c4 04 89 f0 5b 5e c3 8d 74 26 00 <c6> 00 00 83 c0 01 89 03 83 c4 04 89 f0 5b 5e c3 66 90 66 90 66 90

-- 
2.13.0
