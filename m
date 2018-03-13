Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtSblWS52sPb9Vdc5yA/4XYtUPbs81b74Yp1Ez8ARyyBpZa8IizPH7FT2Gm0wB4fouc4o5c
ARC-Seal: i=1; a=rsa-sha256; t=1520955117; cv=none;
        d=google.com; s=arc-20160816;
        b=uHCwTGin+flTpVJP1E+WVa+2PPThmnDCmcFNKaoSk0aGxie3wirncZwsgkOnPscSEm
         ZUfI/dYs7Cs+rPKKk6+iSbD0MfK8lUpqURVBW0numJYfX9EAriag9xV+oo/TexUEIhsF
         iWJqWHTLTQ7ksGOuq3qWjMRZS4ssFvdLcaIGxGPepVkZ4yiwXW8AlvKl/fpyvbo1KB83
         GYUptVyiidTJ70PF4T8JxrUpidM/mf9MI2k8nUGnOb4Xa8AsZUjabCSmb7Z52yVUhMdg
         NB/aDArhGV15u6281r0yz7m/82Ahm3CKQ4biiu2ZaYm4QhhO/wu2mNuDUmMi24oAq8cR
         dPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PhqKEppZLA03t6bMVQ8JVO1LQu+udFVO5ce8KEDbjnY=;
        b=e73ioCjX0Kt5m/qvKciT+zEt4madUDfo8zXnN4vpfXkXyPDH/4oeCl7BxJoe7caF6c
         0E0i5gSp4EW1qXA16NFmVZRIVpWyIQEkoY1TzMHFAgi7qH0Mmlp9t3g0pAMc7PuXUG1u
         WcCeXxGsPLUD9sCwLgSps9zJmMP9UZO8MfHRABqH9C7SJmX0FTqUy5NLJFnX3N/v69tE
         Koae6tgjB7aBiogCGtoPNXhvEeVY036CSc995ZTWz/wPA7yWW0jSwBra+D9w2ERC5WHD
         6JRACHmhSus4fouT+HeubUSS1Isip6D6yuWMt7Gr0UnXmtJ1ChwCl3P/lK9rHCg+jB4J
         0NpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 094/146] x86/paravirt, objtool: Annotate indirect calls
Date: Tue, 13 Mar 2018 16:24:21 +0100
Message-Id: <20180313152327.906719352@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837033233057464?=
X-GMAIL-MSGID: =?utf-8?q?1594837033233057464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 3010a0663fd949d122eca0561b06b0a9453f7866 upstream.

Paravirt emits indirect calls which get flagged by objtool retpoline
checks, annotate it away because all these indirect calls will be
patched out before we start userspace.

This patching happens through alternative_instructions() ->
apply_paravirt() -> pv_init_ops.patch() which will eventually end up
in paravirt_patch_default(). This function _will_ write direct
alternatives.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
