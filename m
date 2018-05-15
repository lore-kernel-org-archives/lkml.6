Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeEOW6w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:58:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37414 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeEOW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:58:49 -0400
X-Google-Smtp-Source: AB8JxZqbC1PxfTanmKDMmxpLclO3E5zAEczFItym8Od5PRfaKVx058eQJcN9GYEL5ovY2gKVM9dAUw==
Date: Wed, 16 May 2018 01:58:45 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: mingo@kernel.org, tglx@linutronix.de
Cc: Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH v2] x86/asm: Pad assembly functions with INT3 instructions
Message-ID: <20180515225845.GB21902@avx2>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <CA+55aFy6_fJkmuWDZC=d_WE+_oYHtXXCbb=R31jyC1qDKZ8HJw@mail.gmail.com>
 <20180515225028.GA21902@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515225028.GA21902@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INT3 instead of NOP. All that padding between functions is
an illegal area, no legitimate code should jump into it.

I've checked x86_64 allyesconfig disassembly, all changes looks sane:
INT3 is only used after RET or unconditional JMP.

On i386:
* promote ret_from_exception into ENTRY as it has corresponding END,
* demote "resume_userspace" -- unused,
* delete ALIGN directive in page_fault. It is leftover from x86 assembly
  cleanups.

    commit d211af055d0c12dc3416c2886e6fbdc6eb74a381
    i386: get rid of the use of KPROBE_ENTRY / KPROBE_END

  has ALIGN directive before branch target which makes sense.
  All the code after ALIGN disappeared later.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/entry/entry_32.S      |    6 +-----
 arch/x86/include/asm/linkage.h |    2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -320,8 +320,7 @@ END(ret_from_fork)
  */
 
 	# userspace resumption stub bypassing syscall exit tracing
-	ALIGN
-ret_from_exception:
+ENTRY(ret_from_exception)
 	preempt_stop(CLBR_ANY)
 ret_from_intr:
 #ifdef CONFIG_VM86
@@ -337,8 +336,6 @@ ret_from_intr:
 #endif
 	cmpl	$USER_RPL, %eax
 	jb	resume_kernel			# not returning to v8086 or userspace
-
-ENTRY(resume_userspace)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
@@ -910,7 +907,6 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 ENTRY(page_fault)
 	ASM_CLAC
 	pushl	$do_page_fault
-	ALIGN
 	jmp common_exception
 END(page_fault)
 
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -18,7 +18,7 @@
 	name:
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
+#define __ALIGN		.p2align 4, 0xCC
 #define __ALIGN_STR	__stringify(__ALIGN)
 #endif
 
