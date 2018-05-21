Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr5eD7kW+zbceAO5Zf42ZGqn++/Z5mqg4jv7p9lBqBtyi7OKxGSB6rRTWsSs8zkGKUVEBoV
ARC-Seal: i=1; a=rsa-sha256; t=1526937691; cv=none;
        d=google.com; s=arc-20160816;
        b=1HLAv6IzLbFygYd8gNjVwZil46aNXB4tMnQZxFEnucgj/m4Nv9vTJNXWuGUrj73LQk
         hnSNazHrG9WzhPcN18Z+Q76/7z9tY6BkoYca/i5HAt51Yry/OKVqagfgaT4Ul3NWDH7R
         /I0OrsHMyxAyV2WTSESH2wDoetiPpPiD8LPe3Ih0QiJHhGPxQODrvwoZyrroyIAbMXex
         nXPkluL5k8YLAcMonZ2Ui5e8N9f1tFnFafXAex3l+rjw6MRxT1hA5jVRtSwcM+pjkWea
         GS5N4T2FOtlJU9E9Z7VAO1ZXLBdAIW7rgMhWQMk9THAlDoP7Uhtet13QKIkTciHXeiV4
         FPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mFa1E81rwHuAROJESS4tm21jC/xLg65WYk482Lr3mJE=;
        b=bxS0K2rkPHj7gJnAq2qHgRIo8tfX+uFLYYzuShGNSCr5j6y1cTvPVF0LoOa+TbjJny
         DJ6KFFU8PzQk3l2tSc6lEmWIi6V9II6b79NYnP3Bbhc+0oYv5/uRFsifDJtahJARRgc3
         mmoOd5yfbwOYvDREg5IO1UIopR9Juu+0XxR9Gncir02trdHQcGh2APkgxPO/4yHjkHjk
         DwNHrrc6VqREcHbj2HKaPLWg+cF0DWk4EXr7QODVlB8BzUiuWiO8L+XA74qqnUDsnm+0
         bIiqdheFhKq6L0tcC3IleuuF2WsOhh42yQ38lplRK1ghzWVxUKr9wwShBUgyVWM4H4xR
         JqHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kAXcaU+r;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kAXcaU+r;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 86/95] x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
Date: Mon, 21 May 2018 23:12:16 +0200
Message-Id: <20180521210502.723086492@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109941891387503?=
X-GMAIL-MSGID: =?utf-8?q?1601110217381839535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -151,7 +151,15 @@ u64 x86_spec_ctrl_get_default(void)
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
 
@@ -168,7 +176,15 @@ void x86_spec_ctrl_set_guest(u64 guest_s
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
@@ -186,6 +186,12 @@ struct vcpu_svm {
 	} host;
 
 	u64 spec_ctrl;
+	/*
+	 * Contains guest-controlled bits of VIRT_SPEC_CTRL, which will be
+	 * translated into the appropriate L2_CFG bits on the host to
+	 * perform speculative control.
+	 */
+	u64 virt_spec_ctrl;
 
 	u32 *msrpm;
 
@@ -1611,6 +1617,7 @@ static void svm_vcpu_reset(struct kvm_vc
 	u32 eax = 1;
 
 	svm->spec_ctrl = 0;
+	svm->virt_spec_ctrl = 0;
 
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
@@ -5015,7 +5022,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5139,7 +5146,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(svm->spec_ctrl);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	reload_tss(vcpu);
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9449,9 +9449,10 @@ static void __noclone vmx_vcpu_run(struc
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
@@ -9587,7 +9588,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
