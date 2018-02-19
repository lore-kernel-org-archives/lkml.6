Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeBSUaD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:30:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37720 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932214AbeBSU2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:28:51 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code: section
Date: Mon, 19 Feb 2018 21:28:21 +0100
Message-Id: <20180219202826.19797-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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

Borislav Petkov (5):
  x86/dumpstack: Unify show_regs()
  x86/dumpstack: Carve out Code: dumping into a function
  x86/dumpstack: Improve opcodes dumping in the Code: section
  x86/dumpstack: Add loglevel argument to show_opcodes()
  x86/fault: Dump user opcode bytes on fatal faults

 arch/x86/include/asm/stacktrace.h |  3 +-
 arch/x86/kernel/dumpstack.c       | 64 +++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/dumpstack_32.c    | 42 -------------------------
 arch/x86/kernel/dumpstack_64.c    | 42 -------------------------
 arch/x86/mm/fault.c               |  7 +++--
 5 files changed, 68 insertions(+), 90 deletions(-)

-- 
2.13.0
