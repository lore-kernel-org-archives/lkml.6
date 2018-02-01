Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2265H8z44x4zErqzUc0f5D8bw50NN42q7lhSFn/gLxkkk/PFeY1S5LQRCkFP8s8jN/jDAZ94
ARC-Seal: i=1; a=rsa-sha256; t=1517496546; cv=none;
        d=google.com; s=arc-20160816;
        b=TOZCKo/+iryXkJs866RbcBSBc/L123Mfd8EP9j+ARxF1T1dfSC4eK0RwtRKUczq8At
         HZlqpzNjcGyAxXKKtYt6vaqWzru2/L+8fRqHJ+CkcVPK0sTfhTHVmLRXsK7wgLmK9QKa
         +SvJyuVkn30UwNUOu/nXoSOUVsAolT028xQy6x/mrX3F87a+2/fdPbfKTwsdcbS/Rjso
         76kwKAakbBmAHQApaZw074Go+FzW2hBx58NmFVoBk0iebr5YGmQkNUmCbI9Sqq+xzFox
         u3sIvGMbILsh29M2lCknNH2lCMaVerbD2rAlRFf+Tc4IUwisvap/pbpwjsZL8s6yyBXd
         oNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=7LObvnbr82X3IHIpdVDKOmhxT15pH3yjv2/g+vs/nos=;
        b=rlZeGOA6jaRCsUA6ZFpD4K28UiPp3+jqAMBItH41N+g8G/U2kbtjB9McJngg9crJwi
         8nVKgyxRG1+paDpbkifpZKU+WhibhoI3fEcl7F132mDiwk49JQJEIlOlWnnY8o7A2E+Y
         9nfN/9oj8fudPho3X3kXhvAeReyhRubZTGOMynuVR/D0UvPc9tPFqJnxhfSXpkgWBds/
         1ZdXRgkJnIDp/N8dlGRrO0KLylmhD9Hdu4JSDstYty10dp1Q2SmI3am1kJ7dxi+r5uBu
         a/EONgK29ap9JpVUpNwjGEZVSVPRnv+wmAcMfoZSzr4oz1BehHdJeOz/REVFTG10Ik9T
         Pq+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=T9C+fCEf;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=T9C+fCEf;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143822.011838802@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:26 +0100
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
Subject: [PATCH 5/7] x86/paravirt: Annotate indirect calls
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-retpoline-annotate-pv.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210458147251665?=
X-GMAIL-MSGID: =?utf-8?q?1591210458147251665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Paravirt emits indirect calls which get flagged by objtool retpoline
checks, annotate it away because all these indirect calls will be
patched out before we start userspace.

This patching happens through alternative_instructions() ->
apply_paravirt() -> pv_init_ops.patch() which will eventually end up
in paravirt_patch_default(). This function _will_ write direct
alternatives.

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
