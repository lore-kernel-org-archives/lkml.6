Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXW+ssCukrhmNFFM8QF3vPDUN2YEX81kOQe16Psl6ZuwJEYjkCEiM5M/UKBHfHShg4up3i
ARC-Seal: i=1; a=rsa-sha256; t=1520641378; cv=none;
        d=google.com; s=arc-20160816;
        b=vSy1oHViVU4Z7fljxUc6xbKtfp4Grb77m1KDPOsIB1tWwuts3t/GiRikSs8tagb9GA
         tB2mNc5fvm+UXy9xp9etWVGTFwTQOfi7yjMH2Z7gH3Wanl06FkwGeyv6ja7fWLdWetWf
         wWGAlX3PI4kazUP6j1r9sVPUXbc0oS3RvTcpadAfqavDz34thP7fVZHAyKlmvVqvhluo
         qZXil94MgHAF99Zd1QIwmu8XpUavSYxaK54ILXAn8tQIoVNYUacokrPYBfe/13heP3y0
         FYoXuk66cghyYutw1ILhAwKxSqZTeXeUhaP6gCP+MOSel9wY0c3G7f2zsdRVN9Vi/00T
         LM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qock6rUIyhZVeXDSVq0yELL4IxqG6H54MOypZxMWRo0=;
        b=zfNBar86gRsiPPi8BzkfSUqzCTdEnwX1lAa6sX4oVwkp0k1pA8aofkXMK76AqiNHOv
         eDxBzTWeFt0eYWxMiWB5ztkmRQb/7SdNwGBvFs9lrJQKSkQgocVxG5pMXRuFdCWOLI9D
         NQSgWQ/ls5LOOGe2qKXpHvAZwABtqpnmWVk63CMW/rB0P39gkHXpCGUee9TwoK4zmmOa
         hW7jh+hwn7G2wH+DhHwO6Vt80WYUx7q+yzo3uFOEWjXhXUgyu7izZJ5SDjyeD+6uUMnu
         1z0e9AEr231w7K3kahmpce6Au5ob21I1oBnNKSCHW0OOWQUxjiSj2p+atrIX/DPn8gF7
         UuXw==
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
Subject: [PATCH 4.9 22/65] KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
Date: Fri,  9 Mar 2018 16:18:22 -0800
Message-Id: <20180310001826.702902379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508053489211194?=
X-GMAIL-MSGID: =?utf-8?q?1594508053489211194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -44,6 +44,7 @@
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
@@ -4919,7 +4920,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5029,10 +5030,10 @@ static void svm_vcpu_run(struct kvm_vcpu
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
@@ -49,6 +49,7 @@
 #include <asm/kexec.h>
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include "trace.h"
@@ -8906,7 +8907,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9042,10 +9043,10 @@ static void __noclone vmx_vcpu_run(struc
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
