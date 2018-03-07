Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELumWpBIFiHShUpLLiVaDAGEc8CntKykTk2ZAa+Hf6KWsYXv71Kamt9x3pssBA/FNPqUiP3o
ARC-Seal: i=1; a=rsa-sha256; t=1520452074; cv=none;
        d=google.com; s=arc-20160816;
        b=hl1VM5ZWShMmRsyDmvf7uuqMxU8nkolPbw42yLiHsKhxdnkOJxI3FxTHC8PKvcLl5H
         NiqKnXouE9ijjm1Ykdy4sBVj2S2EkT0kPwUVHdCfEt71kd9uOZEY9md4hTpqRb2CnAC4
         0gxNe2+5CmiuJqOPTjWYB5lVq+8P3uLlynVb9b54JI+LndRU27W/9kqXkz8ORk0zfn8I
         IZjyFIx0diQe8NXInDkEoptOXhxRv7OqdSQlMVnFmBiSkg7VwtSoQ+F15XZwfgHqcpXd
         jqbbcxRUNB23ebxGxQOqQRiCyNl60PeoE0rzZKKkLWFs1A9fxsfqpTFIl6SUcXkXHYQ2
         KaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2WBc9HSWh35iHAn79ETcjNGtYvGB5IlX0sk0O23UtUk=;
        b=QN7Q7d+nmqR+xrGx1MSnQpr3AarYH5uIGrUjbtPEPK2j7LXme9As/TSriTshQQR88a
         uCD0ZDq7yNyVFnS7Sw+g1Xo0JZSA5+6R0v8pC5KcYT+nTVO8hST7e+mnBqUDd47oT/Gg
         Gk1loDxOcQsLW8h+N8BAuVQ10PVMKHoimy5EC0S51NQ8tRFnAiVbp5IfLk7uSSQNEGKj
         pquaEMwFg9UUZEtwE2Vp9e+R2SPTt6Y0Xvkj1dBDsmL5faL5o860QyVzRN4gxHlyh+4k
         ESoU8YIog0hLDaKrUCpGhTQ7yWM9SxG7wSVsIqS9QuaFkTOyLVTlXT0+8cMe3lBdJ8LG
         8YkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 099/110] KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
Date: Wed,  7 Mar 2018 11:39:22 -0800
Message-Id: <20180307191052.551645345@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309327572733329?=
X-GMAIL-MSGID: =?utf-8?q?1594309554374711885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit ecb586bd29c99fb4de599dec388658e74388daad upstream.

Having a paravirt indirect call in the IBRS restore path is not a
good idea, since we are trying to protect from speculative execution
of bogus indirect branch targets.  It is also slower, so use
native_wrmsrl() on the vmentry path too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
Link: http://lkml.kernel.org/r/20180222154318.20361-2-pbonzini@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |    7 ++++---
 arch/x86/kvm/vmx.c |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -45,6 +45,7 @@
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
@@ -5015,7 +5016,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5125,10 +5126,10 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * save it.
 	 */
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -51,6 +51,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include "trace.h"
@@ -9431,7 +9432,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9567,10 +9568,10 @@ static void __noclone vmx_vcpu_run(struc
 	 * save it.
 	 */
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
