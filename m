Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvxbRZ8vIWmOw0CvgdtvTt1XHbXOnxxakMfoO7VPx4g2gP536lqV86VbCpDZQxGMfNtmCSH
ARC-Seal: i=1; a=rsa-sha256; t=1520451858; cv=none;
        d=google.com; s=arc-20160816;
        b=oJjKlaOMav1W6xjrDyle+9Hua1tx0cvvt1/ASm71hqtXmNcT9Z5ODH9bpN/KkXtpfR
         grH441j2RkheiYAkfHpwdv01gtS2OxMOUfbLPc/o6rXQzTyeqUHvSpklv48G1x2FHzKb
         gQNywIEo1X+e4Lrg61QltueAco7x7SsDhE4fFtsPlg0p9tfRWIDNmqGmR/GqZeDB8OUB
         971w+7z+kwPt/lbzWdZBJG8R2AsebhWCoBJzIdjInAR12GgCqSLREkIyjVEc2m4lItGa
         hzEvAMfysD6c15jc6Y+h/ILRR5vZO62rv9FeDjWNOsy/LGOdSwvyHZ4VS4tztew8ZKp1
         J0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8hTWWEdo0YXFiuk4GW/3hqmquccaN2CYzArana47oRo=;
        b=tXVkXKvvF2iW/w3AvtOborOrGebmp4KCAbtt96hXyWTWBtjsZSZ1PdPFYJaUW9bZL5
         Q74jXCpO5xWK3OgTtmNk//kgErieZ7xWpOW1szvmqswrH4qQ9Yo0PHas1wX4G7HkY+Mf
         JoLUTlIcqjLhHRtsSFYCqX8djAOjDx4lyULwQkj9XydNIadcN/W6Vxtc7r2ftE1Qi9si
         Om1ngfYX5cVLiUNbTiC0sPT13fcvtqpqQqWWBfWrVPtkV+NNkmw173b4DBdIpjzQLGg8
         TmqBloH/EZf8MOaMHqntcQtbZZ7dQZq4KCZ2b0VIt+7OTRCMXDCR+nTvODZQZeQQdSpS
         /k4g==
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
Subject: [PATCH 4.15 113/122] KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
Date: Wed,  7 Mar 2018 11:38:45 -0800
Message-Id: <20180307191746.018327420@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309327572733329?=
X-GMAIL-MSGID: =?utf-8?q?1594309327572733329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5029,7 +5030,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5139,10 +5140,10 @@ static void svm_vcpu_run(struct kvm_vcpu
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
@@ -9443,7 +9444,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9579,10 +9580,10 @@ static void __noclone vmx_vcpu_run(struc
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
