Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeBWI1B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:27:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeBWI07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:26:59 -0500
Date: Fri, 23 Feb 2018 00:26:32 -0800
From: tip-bot for Paolo Bonzini <tipbot@zytor.com>
Message-ID: <tip-ecb586bd29c99fb4de599dec388658e74388daad@git.kernel.org>
Cc: rkrcmar@redhat.com, jmattson@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, karahmed@amazon.de,
        torvalds@linux-foundation.org, mingo@kernel.org, dwmw@amazon.co.uk,
        peterz@infradead.org, pbonzini@redhat.com, hpa@zytor.com
Reply-To: hpa@zytor.com, pbonzini@redhat.com, peterz@infradead.org,
        dwmw@amazon.co.uk, mingo@kernel.org, torvalds@linux-foundation.org,
        karahmed@amazon.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rkrcmar@redhat.com, jmattson@google.com
In-Reply-To: <20180222154318.20361-2-pbonzini@redhat.com>
References: <20180222154318.20361-2-pbonzini@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
Git-Commit-ID: ecb586bd29c99fb4de599dec388658e74388daad
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ecb586bd29c99fb4de599dec388658e74388daad
Gitweb:     https://git.kernel.org/tip/ecb586bd29c99fb4de599dec388658e74388daad
Author:     Paolo Bonzini <pbonzini@redhat.com>
AuthorDate: Thu, 22 Feb 2018 16:43:17 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:24:35 +0100

KVM/x86: Remove indirect MSR op calls from SPEC_CTRL

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
---
 arch/x86/kvm/svm.c | 7 ++++---
 arch/x86/kvm/vmx.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a74828..1598beeda11c 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -49,6 +49,7 @@
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
@@ -5355,7 +5356,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5465,10 +5466,10 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
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
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 3dec126aa302..0927be315965 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -51,6 +51,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include "trace.h"
@@ -9452,7 +9453,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9588,10 +9589,10 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
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
