Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeCFJtj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:49:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeCFJtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:36 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code: section, v1
Date: Tue,  6 Mar 2018 10:49:11 +0100
Message-Id: <20180306094920.16917-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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

Thx.

Borislav Petkov (9):
  panic: Add closing panic marker parenthesis
  x86/fault: Do not print IP in show_fault_oops()
  x86/dumpstack: Unify show_regs()
  x86/dumpstack: Carve out Code: dumping into a function
  x86/dumpstack: Improve opcodes dumping in the Code: section
  x86/dumpstack: Add loglevel argument to show_opcodes()
  x86/fault: Dump user opcode bytes on fatal faults
  x86/dumpstack: Add a show_ip() function
  x86/dumpstack: Save first regs set for the executive summary

 arch/x86/include/asm/stacktrace.h |   4 +-
 arch/x86/kernel/dumpstack.c       | 106 ++++++++++++++++++++++++++++++--------
 arch/x86/kernel/dumpstack_32.c    |  42 ---------------
 arch/x86/kernel/dumpstack_64.c    |  42 ---------------
 arch/x86/kernel/process_32.c      |   4 +-
 arch/x86/mm/fault.c               |   8 +--
 kernel/panic.c                    |   2 +-
 7 files changed, 93 insertions(+), 115 deletions(-)



Changelog:

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

Example dumps:

64-bit:

[   34.099980] sysrq: SysRq : Trigger a crash
[   34.101275] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   34.102843] PGD 799c8067 P4D 799c8067 PUD 7a1a1067 PMD 0 
[   34.103946] Oops: 0002 [#1] PREEMPT SMP
[   34.104828] CPU: 7 PID: 3674 Comm: bash Not tainted 4.16.0-rc3+ #4
[   34.105252] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   34.105252] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   34.105252] Code: eb d1 e8 dd 15 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 d6 24 bd ff c7 05 a4 20 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 56 22 c2 ff fb e9 
[   34.105252] RSP: 0018:ffffc90001b8fdf0 EFLAGS: 00010246
[   34.105252] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   34.105252] RDX: 0000000000000000 RSI: ffffffff8110156a RDI: 0000000000000063
[   34.105252] RBP: ffffffff822714c0 R08: 0000000000000183 R09: 000000000001868c
[   34.105252] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   34.105252] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   34.105252] FS:  00007ffff7fdb700(0000) GS:ffff88007edc0000(0000) knlGS:0000000000000000
[   34.105252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.105252] CR2: 0000000000000000 CR3: 000000007a1e4000 CR4: 00000000000406e0
[   34.105252] Call Trace:
[   34.105252]  __handle_sysrq+0x9e/0x160
[   34.105252]  write_sysrq_trigger+0x2b/0x30
[   34.105252]  proc_reg_write+0x38/0x70
[   34.105252]  __vfs_write+0x36/0x160
[   34.105252]  ? __fd_install+0x69/0x110
[   34.105252]  ? preempt_count_add+0x74/0xb0
[   34.105252]  ? _raw_spin_lock+0x13/0x30
[   34.105252]  ? set_close_on_exec+0x41/0x80
[   34.105252]  ? preempt_count_sub+0xa8/0x100
[   34.105252]  vfs_write+0xc0/0x190
[   34.105252]  SyS_write+0x64/0xe0
[   34.105252]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   34.105252]  do_syscall_64+0x70/0x130
[   34.105252]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   34.105252] RIP: 0033:0x7ffff74b9620
[   34.105252] Code: ff 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 
[   34.105252] RSP: 002b:00007fffffffe638 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   34.105252] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   34.105252] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   34.105252] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   34.105252] R10: 00007fffffffe490 R11: 0000000000000246 R12: 00007ffff77842a0
[   34.105252] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   34.105252] Modules linked in:
[   34.105252] CR2: 0000000000000000
[   34.139401] ---[ end trace 6f07cfbc39b079a5 ]---
[   34.140257] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   34.141092] Code: eb d1 e8 dd 15 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 d6 24 bd ff c7 05 a4 20 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 56 22 c2 ff fb e9 
[   34.143853] RSP: 0018:ffffc90001b8fdf0 EFLAGS: 00010246
[   34.144786] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   34.145890] RDX: 0000000000000000 RSI: ffffffff8110156a RDI: 0000000000000063
[   34.146875] RBP: ffffffff822714c0 R08: 0000000000000183 R09: 000000000001868c
[   34.147841] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   34.149001] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   34.150089] Kernel panic - not syncing: Fatal exception
[   34.151214] Kernel Offset: disabled
[   34.151727] ---[ end Kernel panic - not syncing: Fatal exception ]---

32-bit:

[   14.915957] sysrq: SysRq : Trigger a crash
[   14.918576] BUG: unable to handle kernel NULL pointer dereference at 00000000
[   14.922275] *pde = 00000000 
[   14.922512] Oops: 0002 [#1] PREEMPT SMP
[   14.922512] CPU: 2 PID: 2070 Comm: bash Not tainted 4.16.0-rc3+ #5
[   14.922512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   14.922512] EIP: sysrq_handle_crash+0x1d/0x30
[   14.922512] Code: bf ff eb d6 e8 45 1c ba ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 d3 0a c0 ff c7 05 94 72 c1 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 
[   14.922512] EAX: 80000000 EBX: 0000000a ECX: 00000000 EDX: c110a13d
[   14.922512] ESI: 00000063 EDI: 00000000 EBP: f3edfe8c ESP: f3edfe8c
[   14.922512]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   14.922512] CR0: 80050033 CR2: 00000000 CR3: 33710000 CR4: 000406d0
[   14.922512] Call Trace:
[   14.922512]  __handle_sysrq+0x93/0x130
[   14.922512]  ? sysrq_filter+0x3c0/0x3c0
[   14.922512]  write_sysrq_trigger+0x27/0x40
[   14.922512]  proc_reg_write+0x4d/0x80
[   14.922512]  ? proc_reg_poll+0x70/0x70
[   14.922512]  __vfs_write+0x38/0x160
[   14.922512]  ? preempt_count_sub+0xa0/0x110
[   14.922512]  ? __fd_install+0x51/0xd0
[   14.922512]  ? __sb_start_write+0x4c/0xc0
[   14.922512]  ? preempt_count_sub+0xa0/0x110
[   14.922512]  vfs_write+0x98/0x180
[   14.922512]  SyS_write+0x4f/0xb0
[   14.922512]  do_fast_syscall_32+0x99/0x200
[   14.922512]  entry_SYSENTER_32+0x53/0x86
[   14.922512] EIP: 0xb7f33b35
[   14.922512] Code: ff 89 e5 8b 55 08 8b 80 64 cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 
[   14.922512] EAX: ffffffda EBX: 00000001 ECX: 08bbba08 EDX: 00000002
[   14.990702] ESI: 00000002 EDI: b7efed80 EBP: 08bbba08 ESP: bfd09980
[   14.990702]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   14.990702] Modules linked in:
[   14.990702] CR2: 0000000000000000
[   14.991604] ---[ end trace 2355d48bbc4bb91b ]---
[   14.991607] EIP: sysrq_handle_crash+0x1d/0x30
[   14.991608] Code: bf ff eb d6 e8 45 1c ba ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 d3 0a c0 ff c7 05 94 72 c1 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 
[   15.007713] EAX: 80000000 EBX: 0000000a ECX: 00000000 EDX: c110a13d
[   15.009676] ESI: 00000063 EDI: 00000000 EBP: f3edfe8c ESP: c1c0d87c
[   15.011644]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   15.017438] Kernel panic - not syncing: Fatal exception
[   15.021398] Kernel Offset: disabled
[   15.021398] ---[ end Kernel panic - not syncing: Fatal exception ]---

-- 
2.13.0
