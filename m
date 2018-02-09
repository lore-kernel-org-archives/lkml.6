Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184916-2-15932443438167888280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184915; b=Uk7upsm1Wk8B5Wu0hJFXh25iiHWVqVcy0jABkE8cj1RGaEu
    K/CBvcAB9z5uWge0u3Az8SgX+WXVTpiopfEx84FT0Gs108K/CYKEgHJXl8bzn3sc
    0/o7eRv7IcOkjWnKWl5qZlFDGKnogiPP6gfyUKNNivYZTACxdFH9f50stW3vfMxL
    vZfGyElUkbBzHzSw1urEuAJG7jiXoECPLUYiTk76cilOxH+G0IgfV/N4rm+2M45R
    O3FCi0GSIeZViEbirSWZw4yaZagem6Dpg3vdh2dNbSNxVHkn2v+Z1izQgeP3vraG
    X+bmZSIsmvMYT92MKHfrBPpFDWxkGcNLiRdR3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184915; bh=gLwAPUy0cSqQAbZdIocZ8YRctv
    CnijQqDYbCUFxOvoo=; b=jE9jsDSo07zbWwcEpHSUW2mpa0vn+9UFtKBoiDQlPy
    bLQg0IV1YFNAq2Z8hvccLQ7nHuDcZSwE9/uKgv+hMsBiui/n//4iksYS73tbMlmL
    b1Bk1IcT8zUEkpoJQxbF5cKFdxq4x3ugXm8xf4p8rSnMtmKa5gXKS0yR/HXoByIk
    ZPTEnagroyhVz0JYPnc+/6nxPSKKE7Rj9u8oE7BEKPPYoNEHUNcSZML8UDd/lqi4
    fQKxa4fp6e+3tu9F1abxtiWa2HrdTChU1IQV93utTxeZw901D7NgRixB7Macby5+
    eBawsaCgM3V1z6uemjdnYTmQBJyT8E9xxa3RpPXUErYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeBINoG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeBINoE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 81/92] KVM: VMX: make MSR bitmaps per-VCPU
Date: Fri,  9 Feb 2018 14:39:50 +0100
Message-Id: <20180209133937.010500093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>


(cherry picked from commit 904e14fb7cb96401a7dc803ca2863fd5ba32ffe6)

Place the MSR bitmap in struct loaded_vmcs, and update it in place
every time the x2apic or APICv state can change.  This is rare and
the loop can handle 64 MSRs per iteration, in a similar fashion as
nested_vmx_prepare_msr_bitmap.

This prepares for choosing, on a per-VM basis, whether to intercept
the SPEC_CTRL and PRED_CMD MSRs.

Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |  316 +++++++++++++++++++----------------------------------
 1 file changed, 115 insertions(+), 201 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -110,6 +110,14 @@ static u64 __read_mostly host_xss;
 static bool __read_mostly enable_pml = 1;
 module_param_named(pml, enable_pml, bool, S_IRUGO);
 
+#define MSR_TYPE_R	1
+#define MSR_TYPE_W	2
+#define MSR_TYPE_RW	3
+
+#define MSR_BITMAP_MODE_X2APIC		1
+#define MSR_BITMAP_MODE_X2APIC_APICV	2
+#define MSR_BITMAP_MODE_LM		4
+
 #define KVM_VMX_TSC_MULTIPLIER_MAX     0xffffffffffffffffULL
 
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
@@ -191,6 +199,7 @@ struct loaded_vmcs {
 	struct vmcs *shadow_vmcs;
 	int cpu;
 	int launched;
+	unsigned long *msr_bitmap;
 	struct list_head loaded_vmcss_on_cpu_link;
 };
 
@@ -429,8 +438,6 @@ struct nested_vmx {
 	bool pi_pending;
 	u16 posted_intr_nv;
 
-	unsigned long *msr_bitmap;
-
 	struct hrtimer preemption_timer;
 	bool preemption_timer_expired;
 
@@ -531,6 +538,7 @@ struct vcpu_vmx {
 	unsigned long         host_rsp;
 	u8                    fail;
 	bool                  nmi_known_unmasked;
+	u8		      msr_bitmap_mode;
 	u32                   exit_intr_info;
 	u32                   idt_vectoring_info;
 	ulong                 rflags;
@@ -902,6 +910,7 @@ static u32 vmx_segment_access_rights(str
 static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx);
 static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx);
 static int alloc_identity_pagetable(struct kvm *kvm);
+static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -921,12 +930,6 @@ static DEFINE_PER_CPU(spinlock_t, blocke
 
 static unsigned long *vmx_io_bitmap_a;
 static unsigned long *vmx_io_bitmap_b;
-static unsigned long *vmx_msr_bitmap_legacy;
-static unsigned long *vmx_msr_bitmap_longmode;
-static unsigned long *vmx_msr_bitmap_legacy_x2apic;
-static unsigned long *vmx_msr_bitmap_longmode_x2apic;
-static unsigned long *vmx_msr_bitmap_legacy_x2apic_apicv_inactive;
-static unsigned long *vmx_msr_bitmap_longmode_x2apic_apicv_inactive;
 static unsigned long *vmx_vmread_bitmap;
 static unsigned long *vmx_vmwrite_bitmap;
 
@@ -2520,36 +2523,6 @@ static void move_msr_up(struct vcpu_vmx
 	vmx->guest_msrs[from] = tmp;
 }
 
-static void vmx_set_msr_bitmap(struct kvm_vcpu *vcpu)
-{
-	unsigned long *msr_bitmap;
-
-	if (is_guest_mode(vcpu))
-		msr_bitmap = to_vmx(vcpu)->nested.msr_bitmap;
-	else if (cpu_has_secondary_exec_ctrls() &&
-		 (vmcs_read32(SECONDARY_VM_EXEC_CONTROL) &
-		  SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE)) {
-		if (enable_apicv && kvm_vcpu_apicv_active(vcpu)) {
-			if (is_long_mode(vcpu))
-				msr_bitmap = vmx_msr_bitmap_longmode_x2apic;
-			else
-				msr_bitmap = vmx_msr_bitmap_legacy_x2apic;
-		} else {
-			if (is_long_mode(vcpu))
-				msr_bitmap = vmx_msr_bitmap_longmode_x2apic_apicv_inactive;
-			else
-				msr_bitmap = vmx_msr_bitmap_legacy_x2apic_apicv_inactive;
-		}
-	} else {
-		if (is_long_mode(vcpu))
-			msr_bitmap = vmx_msr_bitmap_longmode;
-		else
-			msr_bitmap = vmx_msr_bitmap_legacy;
-	}
-
-	vmcs_write64(MSR_BITMAP, __pa(msr_bitmap));
-}
-
 /*
  * Set up the vmcs to automatically save and restore system
  * msrs.  Don't touch the 64-bit msrs if the guest is in legacy
@@ -2590,7 +2563,7 @@ static void setup_msrs(struct vcpu_vmx *
 	vmx->save_nmsrs = save_nmsrs;
 
 	if (cpu_has_vmx_msr_bitmap())
-		vmx_set_msr_bitmap(&vmx->vcpu);
+		vmx_update_msr_bitmap(&vmx->vcpu);
 }
 
 /*
@@ -3537,6 +3510,8 @@ static void free_loaded_vmcs(struct load
 	loaded_vmcs_clear(loaded_vmcs);
 	free_vmcs(loaded_vmcs->vmcs);
 	loaded_vmcs->vmcs = NULL;
+	if (loaded_vmcs->msr_bitmap)
+		free_page((unsigned long)loaded_vmcs->msr_bitmap);
 	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
 }
 
@@ -3553,7 +3528,18 @@ static int alloc_loaded_vmcs(struct load
 
 	loaded_vmcs->shadow_vmcs = NULL;
 	loaded_vmcs_init(loaded_vmcs);
+
+	if (cpu_has_vmx_msr_bitmap()) {
+		loaded_vmcs->msr_bitmap = (unsigned long *)__get_free_page(GFP_KERNEL);
+		if (!loaded_vmcs->msr_bitmap)
+			goto out_vmcs;
+		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
+	}
 	return 0;
+
+out_vmcs:
+	free_loaded_vmcs(loaded_vmcs);
+	return -ENOMEM;
 }
 
 static void free_kvm_area(void)
@@ -4562,10 +4548,8 @@ static void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-#define MSR_TYPE_R	1
-#define MSR_TYPE_W	2
-static void __vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
-						u32 msr, int type)
+static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+							  u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
 
@@ -4599,8 +4583,8 @@ static void __vmx_disable_intercept_for_
 	}
 }
 
-static void __vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
-						u32 msr, int type)
+static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
 
@@ -4634,6 +4618,15 @@ static void __vmx_enable_intercept_for_m
 	}
 }
 
+static void __always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+			     			      u32 msr, int type, bool value)
+{
+	if (value)
+		vmx_enable_intercept_for_msr(msr_bitmap, msr, type);
+	else
+		vmx_disable_intercept_for_msr(msr_bitmap, msr, type);
+}
+
 /*
  * If a msr is allowed by L0, we should check whether it is allowed by L1.
  * The corresponding bit will be cleared unless both of L0 and L1 allow it.
@@ -4680,58 +4673,68 @@ static void nested_vmx_disable_intercept
 	}
 }
 
-static void vmx_disable_intercept_for_msr(u32 msr, bool longmode_only)
+static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
 {
-	if (!longmode_only)
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy,
-						msr, MSR_TYPE_R | MSR_TYPE_W);
-	__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode,
-						msr, MSR_TYPE_R | MSR_TYPE_W);
-}
-
-static void vmx_enable_intercept_msr_read_x2apic(u32 msr, bool apicv_active)
-{
-	if (apicv_active) {
-		__vmx_enable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic,
-				msr, MSR_TYPE_R);
-		__vmx_enable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic,
-				msr, MSR_TYPE_R);
-	} else {
-		__vmx_enable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic_apicv_inactive,
-				msr, MSR_TYPE_R);
-		__vmx_enable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic_apicv_inactive,
-				msr, MSR_TYPE_R);
+	u8 mode = 0;
+
+	if (cpu_has_secondary_exec_ctrls() &&
+	    (vmcs_read32(SECONDARY_VM_EXEC_CONTROL) &
+	     SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE)) {
+		mode |= MSR_BITMAP_MODE_X2APIC;
+		if (enable_apicv && kvm_vcpu_apicv_active(vcpu))
+			mode |= MSR_BITMAP_MODE_X2APIC_APICV;
 	}
+
+	if (is_long_mode(vcpu))
+		mode |= MSR_BITMAP_MODE_LM;
+
+	return mode;
 }
 
-static void vmx_disable_intercept_msr_read_x2apic(u32 msr, bool apicv_active)
+#define X2APIC_MSR(r) (APIC_BASE_MSR + ((r) >> 4))
+
+static void vmx_update_msr_bitmap_x2apic(unsigned long *msr_bitmap,
+					 u8 mode)
 {
-	if (apicv_active) {
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic,
-				msr, MSR_TYPE_R);
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic,
-				msr, MSR_TYPE_R);
-	} else {
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic_apicv_inactive,
-				msr, MSR_TYPE_R);
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic_apicv_inactive,
-				msr, MSR_TYPE_R);
+	int msr;
+
+	for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+		unsigned word = msr / BITS_PER_LONG;
+		msr_bitmap[word] = (mode & MSR_BITMAP_MODE_X2APIC_APICV) ? 0 : ~0;
+		msr_bitmap[word + (0x800 / sizeof(long))] = ~0;
+	}
+
+	if (mode & MSR_BITMAP_MODE_X2APIC) {
+		/*
+		 * TPR reads and writes can be virtualized even if virtual interrupt
+		 * delivery is not in use.
+		 */
+		vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_RW);
+		if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
+			vmx_enable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
+			vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
+			vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
+		}
 	}
 }
 
-static void vmx_disable_intercept_msr_write_x2apic(u32 msr, bool apicv_active)
+static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 {
-	if (apicv_active) {
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic,
-				msr, MSR_TYPE_W);
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic,
-				msr, MSR_TYPE_W);
-	} else {
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic_apicv_inactive,
-				msr, MSR_TYPE_W);
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic_apicv_inactive,
-				msr, MSR_TYPE_W);
-	}
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
+	u8 mode = vmx_msr_bitmap_mode(vcpu);
+	u8 changed = mode ^ vmx->msr_bitmap_mode;
+
+	if (!changed)
+		return;
+
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_KERNEL_GS_BASE, MSR_TYPE_RW,
+				  !(mode & MSR_BITMAP_MODE_LM));
+
+	if (changed & (MSR_BITMAP_MODE_X2APIC | MSR_BITMAP_MODE_X2APIC_APICV))
+		vmx_update_msr_bitmap_x2apic(msr_bitmap, mode);
+
+	vmx->msr_bitmap_mode = mode;
 }
 
 static bool vmx_get_enable_apicv(void)
@@ -4976,7 +4979,7 @@ static void vmx_refresh_apicv_exec_ctrl(
 	}
 
 	if (cpu_has_vmx_msr_bitmap())
-		vmx_set_msr_bitmap(vcpu);
+		vmx_update_msr_bitmap(vcpu);
 }
 
 static u32 vmx_exec_control(struct vcpu_vmx *vmx)
@@ -5065,7 +5068,7 @@ static int vmx_vcpu_setup(struct vcpu_vm
 		vmcs_write64(VMWRITE_BITMAP, __pa(vmx_vmwrite_bitmap));
 	}
 	if (cpu_has_vmx_msr_bitmap())
-		vmcs_write64(MSR_BITMAP, __pa(vmx_msr_bitmap_legacy));
+		vmcs_write64(MSR_BITMAP, __pa(vmx->vmcs01.msr_bitmap));
 
 	vmcs_write64(VMCS_LINK_POINTER, -1ull); /* 22.3.1.5 */
 
@@ -6396,7 +6399,7 @@ static void wakeup_handler(void)
 
 static __init int hardware_setup(void)
 {
-	int r = -ENOMEM, i, msr;
+	int r = -ENOMEM, i;
 
 	rdmsrl_safe(MSR_EFER, &host_efer);
 
@@ -6411,41 +6414,13 @@ static __init int hardware_setup(void)
 	if (!vmx_io_bitmap_b)
 		goto out;
 
-	vmx_msr_bitmap_legacy = (unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_legacy)
-		goto out1;
-
-	vmx_msr_bitmap_legacy_x2apic =
-				(unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_legacy_x2apic)
-		goto out2;
-
-	vmx_msr_bitmap_legacy_x2apic_apicv_inactive =
-				(unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_legacy_x2apic_apicv_inactive)
-		goto out3;
-
-	vmx_msr_bitmap_longmode = (unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_longmode)
-		goto out4;
-
-	vmx_msr_bitmap_longmode_x2apic =
-				(unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_longmode_x2apic)
-		goto out5;
-
-	vmx_msr_bitmap_longmode_x2apic_apicv_inactive =
-				(unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_longmode_x2apic_apicv_inactive)
-		goto out6;
-
 	vmx_vmread_bitmap = (unsigned long *)__get_free_page(GFP_KERNEL);
 	if (!vmx_vmread_bitmap)
-		goto out7;
+		goto out1;
 
 	vmx_vmwrite_bitmap = (unsigned long *)__get_free_page(GFP_KERNEL);
 	if (!vmx_vmwrite_bitmap)
-		goto out8;
+		goto out2;
 
 	memset(vmx_vmread_bitmap, 0xff, PAGE_SIZE);
 	memset(vmx_vmwrite_bitmap, 0xff, PAGE_SIZE);
@@ -6454,12 +6429,9 @@ static __init int hardware_setup(void)
 
 	memset(vmx_io_bitmap_b, 0xff, PAGE_SIZE);
 
-	memset(vmx_msr_bitmap_legacy, 0xff, PAGE_SIZE);
-	memset(vmx_msr_bitmap_longmode, 0xff, PAGE_SIZE);
-
 	if (setup_vmcs_config(&vmcs_config) < 0) {
 		r = -EIO;
-		goto out9;
+		goto out3;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_NX))
@@ -6516,47 +6488,8 @@ static __init int hardware_setup(void)
 		kvm_tsc_scaling_ratio_frac_bits = 48;
 	}
 
-	vmx_disable_intercept_for_msr(MSR_FS_BASE, false);
-	vmx_disable_intercept_for_msr(MSR_GS_BASE, false);
-	vmx_disable_intercept_for_msr(MSR_KERNEL_GS_BASE, true);
-	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_CS, false);
-	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_ESP, false);
-	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_EIP, false);
-
-	memcpy(vmx_msr_bitmap_legacy_x2apic,
-			vmx_msr_bitmap_legacy, PAGE_SIZE);
-	memcpy(vmx_msr_bitmap_longmode_x2apic,
-			vmx_msr_bitmap_longmode, PAGE_SIZE);
-	memcpy(vmx_msr_bitmap_legacy_x2apic_apicv_inactive,
-			vmx_msr_bitmap_legacy, PAGE_SIZE);
-	memcpy(vmx_msr_bitmap_longmode_x2apic_apicv_inactive,
-			vmx_msr_bitmap_longmode, PAGE_SIZE);
-
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
-	/*
-	 * enable_apicv && kvm_vcpu_apicv_active()
-	 */
-	for (msr = 0x800; msr <= 0x8ff; msr++)
-		vmx_disable_intercept_msr_read_x2apic(msr, true);
-
-	/* TMCCT */
-	vmx_enable_intercept_msr_read_x2apic(0x839, true);
-	/* TPR */
-	vmx_disable_intercept_msr_write_x2apic(0x808, true);
-	/* EOI */
-	vmx_disable_intercept_msr_write_x2apic(0x80b, true);
-	/* SELF-IPI */
-	vmx_disable_intercept_msr_write_x2apic(0x83f, true);
-
-	/*
-	 * (enable_apicv && !kvm_vcpu_apicv_active()) ||
-	 * 	!enable_apicv
-	 */
-	/* TPR */
-	vmx_disable_intercept_msr_read_x2apic(0x808, false);
-	vmx_disable_intercept_msr_write_x2apic(0x808, false);
-
 	if (enable_ept) {
 		kvm_mmu_set_mask_ptes(VMX_EPT_READABLE_MASK,
 			(enable_ept_ad_bits) ? VMX_EPT_ACCESS_BIT : 0ull,
@@ -6602,22 +6535,10 @@ static __init int hardware_setup(void)
 
 	return alloc_kvm_area();
 
-out9:
-	free_page((unsigned long)vmx_vmwrite_bitmap);
-out8:
-	free_page((unsigned long)vmx_vmread_bitmap);
-out7:
-	free_page((unsigned long)vmx_msr_bitmap_longmode_x2apic_apicv_inactive);
-out6:
-	free_page((unsigned long)vmx_msr_bitmap_longmode_x2apic);
-out5:
-	free_page((unsigned long)vmx_msr_bitmap_longmode);
-out4:
-	free_page((unsigned long)vmx_msr_bitmap_legacy_x2apic_apicv_inactive);
 out3:
-	free_page((unsigned long)vmx_msr_bitmap_legacy_x2apic);
+	free_page((unsigned long)vmx_vmwrite_bitmap);
 out2:
-	free_page((unsigned long)vmx_msr_bitmap_legacy);
+	free_page((unsigned long)vmx_vmread_bitmap);
 out1:
 	free_page((unsigned long)vmx_io_bitmap_b);
 out:
@@ -6628,12 +6549,6 @@ out:
 
 static __exit void hardware_unsetup(void)
 {
-	free_page((unsigned long)vmx_msr_bitmap_legacy_x2apic);
-	free_page((unsigned long)vmx_msr_bitmap_legacy_x2apic_apicv_inactive);
-	free_page((unsigned long)vmx_msr_bitmap_longmode_x2apic);
-	free_page((unsigned long)vmx_msr_bitmap_longmode_x2apic_apicv_inactive);
-	free_page((unsigned long)vmx_msr_bitmap_legacy);
-	free_page((unsigned long)vmx_msr_bitmap_longmode);
 	free_page((unsigned long)vmx_io_bitmap_b);
 	free_page((unsigned long)vmx_io_bitmap_a);
 	free_page((unsigned long)vmx_vmwrite_bitmap);
@@ -6998,13 +6913,6 @@ static int handle_vmon(struct kvm_vcpu *
 	if (r < 0)
 		goto out_vmcs02;
 
-	if (cpu_has_vmx_msr_bitmap()) {
-		vmx->nested.msr_bitmap =
-				(unsigned long *)__get_free_page(GFP_KERNEL);
-		if (!vmx->nested.msr_bitmap)
-			goto out_msr_bitmap;
-	}
-
 	vmx->nested.cached_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_vmcs12)
 		goto out_cached_vmcs12;
@@ -7034,9 +6942,6 @@ out_shadow_vmcs:
 	kfree(vmx->nested.cached_vmcs12);
 
 out_cached_vmcs12:
-	free_page((unsigned long)vmx->nested.msr_bitmap);
-
-out_msr_bitmap:
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 
 out_vmcs02:
@@ -7115,10 +7020,6 @@ static void free_nested(struct vcpu_vmx
 	vmx->nested.vmxon = false;
 	free_vpid(vmx->nested.vpid02);
 	nested_release_vmcs12(vmx);
-	if (vmx->nested.msr_bitmap) {
-		free_page((unsigned long)vmx->nested.msr_bitmap);
-		vmx->nested.msr_bitmap = NULL;
-	}
 	if (enable_shadow_vmcs) {
 		vmcs_clear(vmx->vmcs01.shadow_vmcs);
 		free_vmcs(vmx->vmcs01.shadow_vmcs);
@@ -8465,7 +8366,7 @@ static void vmx_set_virtual_x2apic_mode(
 	}
 	vmcs_write32(SECONDARY_VM_EXEC_CONTROL, sec_exec_control);
 
-	vmx_set_msr_bitmap(vcpu);
+	vmx_update_msr_bitmap(vcpu);
 }
 
 static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa)
@@ -9085,6 +8986,7 @@ static struct kvm_vcpu *vmx_create_vcpu(
 {
 	int err;
 	struct vcpu_vmx *vmx = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
+	unsigned long *msr_bitmap;
 	int cpu;
 
 	if (!vmx)
@@ -9125,6 +9027,15 @@ static struct kvm_vcpu *vmx_create_vcpu(
 	if (err < 0)
 		goto free_msrs;
 
+	msr_bitmap = vmx->vmcs01.msr_bitmap;
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_FS_BASE, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_GS_BASE, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
+	vmx->msr_bitmap_mode = 0;
+
 	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
@@ -9519,7 +9430,7 @@ static inline bool nested_vmx_merge_msr_
 	int msr;
 	struct page *page;
 	unsigned long *msr_bitmap_l1;
-	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.msr_bitmap;
+	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 
 	/* This shortcut is ok because we support only x2APIC MSRs so far. */
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
@@ -10034,6 +9945,9 @@ static void prepare_vmcs02(struct kvm_vc
 	if (kvm_has_tsc_control)
 		decache_tsc_multiplier(vmx);
 
+	if (cpu_has_vmx_msr_bitmap())
+		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
+
 	if (enable_vpid) {
 		/*
 		 * There is no direct mapping between vpid02 and vpid12, the
@@ -10738,7 +10652,7 @@ static void load_vmcs12_host_state(struc
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
 	if (cpu_has_vmx_msr_bitmap())
-		vmx_set_msr_bitmap(vcpu);
+		vmx_update_msr_bitmap(vcpu);
 
 	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
 				vmcs12->vm_exit_msr_load_count))
