Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2264cmAxDXb7aQwbeM6ne6JVw/2OTfS3aeu4zYduooOdLDqHXgEqCsMmJss/JmzAym3wNajt
ARC-Seal: i=1; a=rsa-sha256; t=1518440006; cv=none;
        d=google.com; s=arc-20160816;
        b=L4x5/iZo+nSX2C9G8x9nxBJxQhM37dILJIuhbYDUWvyqvfP5lnJc4D5vo1MGg6MnqC
         D0QIxaG1OGnqb2zwtyMXXeTsVhZAbf3E0zGHQB5RppIotaYw5dH8GVKV0WUqRPrt9n8K
         wMENUNUg8cUGRDuiLiqlk926nOScxzTh+Y72+3Jb192GzKlMpBylZtY6C9hdIKavu8uG
         iWoa2sIg1rYGFl8zc+/CzzR3WK+23/3wVlkghvFBzBANO0KtSF6zmYxUFErxjQhTFosf
         uXyg/TA9t9Lyh02LorBHHuc6MwxtZuHPBkdzexBX/fc/B70y/442l5+A65tSepYsljxv
         jHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=0er5PgGdn9nSm4N++HRzzjN3ATy1dFK+dxzGrkM8nLw=;
        b=QV7+gl3GT6S9BC44Twk4H867AhuPcszPfydSPW4Y/STipP28XTOFWGxQq9nGVHRef7
         0VZa2CyLilz6O9i6bheJI6jj1LGupb1dZGCDj0enR8oIKAYMUlnram3Og1nLm6JIplp1
         ZBtmpYvtYl1YnZGPvmot84jdgo7CNHMWac5dYF7SDPYlF57Yj2r4kBzO66xZ4BC/GdTw
         LJ+4qqaLYihhbYV4QOprk9ptrILrHyRmzYjtM4VzFRkaWf9jgP3vLfPYdlFiecs+gFVd
         JRQvRNCANz2zr4kq1mZb8a1DFylKYAyQZNVY4FwU1VMln/ahM2KxM+x5LLBgrN6UR16N
         lXeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=ML+xW6lo;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LN3Iuijz;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=ML+xW6lo;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LN3Iuijz;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.550669905@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:49:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 6/8] x86/paravirt: Annotate indirect calls
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-retpoline-annotate-pv.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199747452922783?=
X-GMAIL-MSGID: =?utf-8?q?1592199747452922783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Paravirt emits indirect calls which get flagged by objtool retpoline
checks, annotate it away because all these indirect calls will be
patched out before we start userspace.

This patching happens through alternative_instructions() ->
apply_paravirt() -> pv_init_ops.patch() which will eventually end up
in paravirt_patch_default(). This function _will_ write direct
alternatives.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h       |   17 +++++++++++++----
 arch/x86/include/asm/paravirt_types.h |    5 ++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #include <asm/paravirt_types.h>
 
@@ -879,23 +880,27 @@ extern void default_banner(void);
 
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret);)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX				\
 	push %ecx; push %edx;				\
+	ANNOTATE_RETPOLINE_SAFE;				\
 	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
 	pop %edx; pop %ecx
 #else	/* !CONFIG_X86_32 */
@@ -917,21 +922,25 @@ extern void default_banner(void);
  */
 #define SWAPGS								\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
 		 )
 
 #define GET_CR2_INTO_RAX				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
+	ANNOTATE_RETPOLINE_SAFE;				\
+	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2);
 
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
 		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64);)
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl), clobbers, \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
+		  ANNOTATE_RETPOLINE_SAFE;				    \
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_save_fl);    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -43,6 +43,7 @@
 #include <asm/desc_defs.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
+#include <asm/nospec-branch.h>
 
 struct page;
 struct thread_struct;
@@ -392,7 +393,9 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
-#define PARAVIRT_CALL	"call *%c[paravirt_opptr];"
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
