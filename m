Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBHJN0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:13:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeBHJNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:13:23 -0500
Date: Thu, 8 Feb 2018 10:13:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180208091302.GD25201@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 11:43:37AM -0800, Linus Torvalds wrote:
> On Wed, Feb 7, 2018 at 11:28 AM, Borislav Petkov <bp@alien8.de> wrote:
> > On Wed, Feb 07, 2018 at 08:14:51PM +0100, Peter Zijlstra wrote:
> >> Then someone went and wrecked it.
> >
> > Yeah, note says UD0 didn't eat a ModRM byte on old CPUs. But then that
> > changed too. Fun stuff changing insn encoding underway.
> >
> > So if we opt for adding a ModRM byte, could a 0x90 NOP work so that it
> > doesn't shit itself on those old CPUs?
> 
> We could just also decide that the only thing that the modrm bytes of
> UD0 actually *affect* is how the CPU might act for a page-crossing
> instruction.
> 
> Because I think that's the only semantic difference: if it's a
> page-crosser, the instruction could take a page fault before raising
> the #UD.
> 
> Is there any other decode issue we might want to look out for?

_The_ problem is that new binutils cannot sanely decode any function
that has a WARN in (this very much includes perf annotate):

old:

00000000000016a0 <copy_overflow>:
    16a0:       48 89 f2                mov    %rsi,%rdx
    16a3:       89 fe                   mov    %edi,%esi
    16a5:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        16a8: R_X86_64_32S      .rodata.str1.8+0x288
    16ac:       e8 00 00 00 00          callq  16b1 <copy_overflow+0x11>
                        16ad: R_X86_64_PC32     __warn_printk-0x4
    16b1:       0f ff                   (bad)  
    16b3:       c3                      retq   
    16b4:       66 90                   xchg   %ax,%ax
    16b6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
    16bd:       00 00 00 

new:

00000000000016a0 <copy_overflow>:
    16a0:       48 89 f2                mov    %rsi,%rdx
    16a3:       89 fe                   mov    %edi,%esi
    16a5:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        16a8: R_X86_64_32S      .rodata.str1.8+0x288
    16ac:       e8 00 00 00 00          callq  16b1 <copy_overflow+0x11>
                        16ad: R_X86_64_PC32     __warn_printk-0x4
    16b1:       0f ff c3                ud0    %ebx,%eax
    16b4:       66 90                   xchg   %ax,%ax
    16b6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
    16bd:       00 00 00 


I went through the register opcodes and matched it against the ModR/M
encoding, and the best option I've found so far is using 0xd6 as the
next byte.

That yields:

old:

0000000000001690 <copy_overflow>:
    1690:       48 89 f2                mov    %rsi,%rdx
    1693:       89 fe                   mov    %edi,%esi
    1695:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        1698: R_X86_64_32S      .rodata.str1.8+0x270
    169c:       e8 00 00 00 00          callq  16a1 <copy_overflow+0x11>
                        169d: R_X86_64_PC32     __warn_printk-0x4
    16a1:       0f ff                   (bad)  
    16a3:       d6                      (bad)  
    16a4:       c3                      retq   
    16a5:       90                      nop
    16a6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)

new:

0000000000001690 <copy_overflow>:
    1690:       48 89 f2                mov    %rsi,%rdx
    1693:       89 fe                   mov    %edi,%esi
    1695:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        1698: R_X86_64_32S      .rodata.str1.8+0x270
    169c:       e8 00 00 00 00          callq  16a1 <copy_overflow+0x11>
                        169d: R_X86_64_PC32     __warn_printk-0x4
    16a1:       0f ff d6                ud0    %esi,%edx
    16a4:       c3                      retq
    16a5:       90                      nop
    16a6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
    16ad:       00 00 00


And only grows a defconfig image by 91 bytes, purely for the purpose of
being able to disassemble it :/


   text    data     bss     dec     hex filename
17307211        4890808 1052880 23250899        162c7d3 defconfig-build/vmlinux
17307302        4890808 1052880 23250990        162c82e defconfig-build/vmlinux


---
 arch/x86/include/asm/bug.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 34d99af43994..f0d5b4a1512d 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -12,16 +12,21 @@
  * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
  *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
  *  with various things like the Intel SDM instruction encoding rules)
+ *
+ * And now someone went and taught binutils about UD0 as taking a ModR/M too
+ * and it generates crap when disassembling the kernel. Stick a pointless 0xD6
+ * ModR/M on, which the old binutils decodes as (bad) and the new binutils sees
+ * as a valid single byte ModR/M.
  */
 
-#define ASM_UD0		".byte 0x0f, 0xff"
+#define ASM_UD0		".byte 0x0f, 0xff, 0xd6"
 #define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
 #define ASM_UD2		".byte 0x0f, 0x0b"
 
 #define INSN_UD0	0xff0f
 #define INSN_UD2	0x0b0f
 
-#define LEN_UD0		2
+#define LEN_UD0		3
 
 #ifdef CONFIG_GENERIC_BUG
 
