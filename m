Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqL7BZRNlv1GXduGV3kcWONhUDEgT5P/r8vpw9HDrw0QQEPTtCLtm1VnTZr5aRVjKhJqZGA
ARC-Seal: i=1; a=rsa-sha256; t=1526937429; cv=none;
        d=google.com; s=arc-20160816;
        b=akhsgjkppArqkd7oG8O2SpaSzF7u8R7zb9cqMIhdIeoOD93rs60TW0qP4XNOwCgGuX
         rUsjOeYC2befdDZ+hjOQmq7LZCPHdPr5GU77ZVudhXyg8UjQAsBtYNdn/hrote9rDMAc
         X/kmXmG/PM8nHRKNLXjPwdAK2tipYc95et2/fiS1sI0mGr6DIUajTZI7zQ1KK7ur8TJf
         Vukii5pQYbUxCw43tmBHRjqK7vdEgePpfMTNQBLxcHVyXb8aqFzVNm7XlujA6Z+D+E+a
         jgKDS4zAlPedC/bKRyskwhDtYOxX/0jcG5gCxSAY2VKGKROaeMGYsO5iC9jLP+YqbdrW
         t3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fLhLtBVnjQKSX3XdqS9oiQvW424R8ahH0bhrLWLugjs=;
        b=j2H66AUPJLa0EHNs9yuTW1iTmmbFKW1mcFnGomRnbsvN76brQhCcTXAueIKpa3ZQXG
         WuH2RlzVgRbIuG7SCaCNiczir3MRWvO1qiQ/89A+NOdz/Sb0RkQExClBpa1yh0ZQQcTy
         f7cIr+ui+HxiI0Jreo2eQCmbHTxUT7HEp9wSCUHJhSzfkEocTAK0F3kJ0jIiAx8h/lUu
         gFDBTnHqcx2A+Zw5QAWDY8jOd1Jqx8AbOS6lIwdFfi/crPw4BDbY0ZYj0J+a/oi926E2
         Gs4gGJCluh7hhSKcelfJTlag8/dqHl5hjF/f7AJe6qhq4uqri1rB93v5XVKjece3myAo
         Yt6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ysX6q8Fu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ysX6q8Fu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 78/87] x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
Date: Mon, 21 May 2018 23:11:54 +0200
Message-Id: <20180521210426.762626320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109941891387503?=
X-GMAIL-MSGID: =?utf-8?q?1601109941891387503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit ccbcd2674472a978b48c91c1fbfb66c0ff959f24 upstream

AMD is proposing a VIRT_SPEC_CTRL MSR to handle the Speculative Store
Bypass Disable via MSR_AMD64_LS_CFG so that guests do not have to care
about the bit position of the SSBD bit and thus facilitate migration.
Also, the sibling coordination on Family 17H CPUs can only be done on
the host.

Extend x86_spec_ctrl_set_guest() and x86_spec_ctrl_restore_host() with an
extra argument for the VIRT_SPEC_CTRL MSR.

Hand in 0 from VMX and in SVM add a new virt_spec_ctrl member to the CPU
data structure which is going to be used in later patches for the actual
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |    9 ++++++---
 arch/x86/kernel/cpu/bugs.c       |   20 ++++++++++++++++++--
 arch/x86/kvm/svm.c               |   11 +++++++++--
 arch/x86/kvm/vmx.c               |    5 +++--
 4 files changed, 36 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -10,10 +10,13 @@
  * the guest has, while on VMEXIT we restore the host view. This
  * would be easier if SPEC_CTRL were architecturally maskable or
  * shadowable for guests but this is not (currently) the case.
- * Takes the guest view of SPEC_CTRL MSR as a parameter.
+ * Takes the guest view of SPEC_CTRL MSR as a parameter and also
+ * the guest's version of VIRT_SPEC_CTRL, if emulated.
  */
-extern void x86_spec_ctrl_set_guest(u64);
-extern void x86_spec_ctrl_restore_host(u64);
+extern void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl,
+				    u64 guest_virt_spec_ctrl);
+extern void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl,
+				       u64 guest_virt_spec_ctrl);
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -150,7 +150,15 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
-void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
+/**
+ * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
 {
 	u64 host = x86_spec_ctrl_base;
 
@@ -167,7 +175,15 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
 
-void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
+/**
+ * x86_spec_ctrl_restore_host - Restore host speculation control registers
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
 {
 	u64 host = x86_spec_ctrl_base;
 
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -185,6 +185,12 @@ struct vcpu_svm {
 	} host;
 
 	u64 spec_ctrl;
+	/*
+	 * Contains guest-controlled bits of VIRT_SPEC_CTRL, which will be
+	 * translated into the appropriate L2_CFG bits on the host to
+	 * perform speculative control.
+	 */
+	u64 virt_spec_ctrl;
 
 	u32 *msrpm;
 
@@ -1561,6 +1567,7 @@ static void svm_vcpu_reset(struct kvm_vc
 	u32 eax = 1;
 
 	svm->spec_ctrl = 0;
+	svm->virt_spec_ctrl = 0;
 
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
@@ -4917,7 +4924,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5041,7 +5048,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(svm->spec_ctrl);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	reload_tss(vcpu);
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8916,9 +8916,10 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
+
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -9054,7 +9055,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
