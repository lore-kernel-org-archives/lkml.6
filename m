Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ODNsIPtIGVuPTAAAmS7hNA
	; Thu, 07 Jun 2018 15:03:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0A5D608BA; Thu,  7 Jun 2018 15:03:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8B8076063F;
	Thu,  7 Jun 2018 15:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B8076063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935970AbeFGPDr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:03:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41526 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935948AbeFGPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:44 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbw-0005Zk-WB; Thu, 07 Jun 2018 15:09:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002kR-6L; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jim Mattson" <jmattson@google.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.776047846@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 054/410] KVM: VMX: make MSR bitmaps per-VCPU
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 904e14fb7cb96401a7dc803ca2863fd5ba32ffe6 upstream.

Place the MSR bitmap in struct loaded_vmcs, and update it in place
every time the x2apic or APICv state can change.  This is rare and
the loop can handle 64 MSRs per iteration, in a similar fashion as
nested_vmx_prepare_msr_bitmap.

This prepares for choosing, on a per-VM basis, whether to intercept
the SPEC_CTRL and PRED_CMD MSRs.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - No support for nested MSR bitmaps
 - APICv support looked different
 - We still need to intercept the APIC_ID MSR
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 228 +++++++++++++++++++++------------------------
 1 file changed, 107 insertions(+), 121 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -101,6 +101,14 @@ module_param_named(enable_shadow_vmcs, e
 static bool __read_mostly nested = 0;
 module_param(nested, bool, S_IRUGO);
 
+#define MSR_TYPE_R	1
+#define MSR_TYPE_W	2
+#define MSR_TYPE_RW	3
+
+#define MSR_BITMAP_MODE_X2APIC		1
+#define MSR_BITMAP_MODE_X2APIC_APICV	2
+#define MSR_BITMAP_MODE_LM		4
+
 #define KVM_GUEST_CR0_MASK (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST (X86_CR0_WP | X86_CR0_NE)
 #define KVM_VM_CR0_ALWAYS_ON						\
@@ -154,6 +162,7 @@ struct loaded_vmcs {
 	struct vmcs *vmcs;
 	int cpu;
 	int launched;
+	unsigned long *msr_bitmap;
 	struct list_head loaded_vmcss_on_cpu_link;
 };
 
@@ -410,6 +419,7 @@ struct vcpu_vmx {
 	unsigned long         host_rsp;
 	u8                    fail;
 	bool                  nmi_known_unmasked;
+	u8		      msr_bitmap_mode;
 	u32                   exit_intr_info;
 	u32                   idt_vectoring_info;
 	ulong                 rflags;
@@ -745,6 +755,7 @@ static void vmx_sync_pir_to_irr_dummy(st
 static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx);
 static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx);
 static bool vmx_mpx_supported(void);
+static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -757,10 +768,6 @@ static DEFINE_PER_CPU(struct desc_ptr, h
 
 static unsigned long *vmx_io_bitmap_a;
 static unsigned long *vmx_io_bitmap_b;
-static unsigned long *vmx_msr_bitmap_legacy;
-static unsigned long *vmx_msr_bitmap_longmode;
-static unsigned long *vmx_msr_bitmap_legacy_x2apic;
-static unsigned long *vmx_msr_bitmap_longmode_x2apic;
 static unsigned long *vmx_vmread_bitmap;
 static unsigned long *vmx_vmwrite_bitmap;
 
@@ -2073,25 +2080,6 @@ static void move_msr_up(struct vcpu_vmx
 	vmx->guest_msrs[from] = tmp;
 }
 
-static void vmx_set_msr_bitmap(struct kvm_vcpu *vcpu)
-{
-	unsigned long *msr_bitmap;
-
-	if (irqchip_in_kernel(vcpu->kvm) && apic_x2apic_mode(vcpu->arch.apic)) {
-		if (is_long_mode(vcpu))
-			msr_bitmap = vmx_msr_bitmap_longmode_x2apic;
-		else
-			msr_bitmap = vmx_msr_bitmap_legacy_x2apic;
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
@@ -2132,7 +2120,7 @@ static void setup_msrs(struct vcpu_vmx *
 	vmx->save_nmsrs = save_nmsrs;
 
 	if (cpu_has_vmx_msr_bitmap())
-		vmx_set_msr_bitmap(&vmx->vcpu);
+		vmx_update_msr_bitmap(&vmx->vcpu);
 }
 
 /*
@@ -3014,6 +3002,8 @@ static void free_loaded_vmcs(struct load
 	loaded_vmcs_clear(loaded_vmcs);
 	free_vmcs(loaded_vmcs->vmcs);
 	loaded_vmcs->vmcs = NULL;
+	if (loaded_vmcs->msr_bitmap)
+		free_page((unsigned long)loaded_vmcs->msr_bitmap);
 }
 
 static struct vmcs *alloc_vmcs(void)
@@ -3028,7 +3018,18 @@ static int alloc_loaded_vmcs(struct load
 		return -ENOMEM;
 
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
@@ -4089,10 +4090,8 @@ static void free_vpid(struct vcpu_vmx *v
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
 
@@ -4126,8 +4125,8 @@ static void __vmx_disable_intercept_for_
 	}
 }
 
-static void __vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
-						u32 msr, int type)
+static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
 
@@ -4161,37 +4160,76 @@ static void __vmx_enable_intercept_for_m
 	}
 }
 
-static void vmx_disable_intercept_for_msr(u32 msr, bool longmode_only)
+static void __always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+			     			      u32 msr, int type, bool value)
 {
-	if (!longmode_only)
-		__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy,
-						msr, MSR_TYPE_R | MSR_TYPE_W);
-	__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode,
-						msr, MSR_TYPE_R | MSR_TYPE_W);
+	if (value)
+		vmx_enable_intercept_for_msr(msr_bitmap, msr, type);
+	else
+		vmx_disable_intercept_for_msr(msr_bitmap, msr, type);
 }
 
-static void vmx_enable_intercept_msr_read_x2apic(u32 msr)
+static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
 {
-	__vmx_enable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic,
-			msr, MSR_TYPE_R);
-	__vmx_enable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic,
-			msr, MSR_TYPE_R);
+	u8 mode = 0;
+
+	if (irqchip_in_kernel(vcpu->kvm) && apic_x2apic_mode(vcpu->arch.apic)) {
+		mode |= MSR_BITMAP_MODE_X2APIC;
+		if (enable_apicv)
+			mode |= MSR_BITMAP_MODE_X2APIC_APICV;
+	}
+
+	if (is_long_mode(vcpu))
+		mode |= MSR_BITMAP_MODE_LM;
+
+	return mode;
 }
 
-static void vmx_disable_intercept_msr_read_x2apic(u32 msr)
+#define X2APIC_MSR(r) (APIC_BASE_MSR + ((r) >> 4))
+
+static void vmx_update_msr_bitmap_x2apic(unsigned long *msr_bitmap,
+					 u8 mode)
 {
-	__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic,
-			msr, MSR_TYPE_R);
-	__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic,
-			msr, MSR_TYPE_R);
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
+			vmx_enable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_ID), MSR_TYPE_R);
+			vmx_enable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
+			vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
+			vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
+		}
+	}
 }
 
-static void vmx_disable_intercept_msr_write_x2apic(u32 msr)
+static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 {
-	__vmx_disable_intercept_for_msr(vmx_msr_bitmap_legacy_x2apic,
-			msr, MSR_TYPE_W);
-	__vmx_disable_intercept_for_msr(vmx_msr_bitmap_longmode_x2apic,
-			msr, MSR_TYPE_W);
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
 
 static int vmx_vm_has_apicv(struct kvm *kvm)
@@ -4412,7 +4450,7 @@ static int vmx_vcpu_setup(struct vcpu_vm
 		vmcs_write64(VMWRITE_BITMAP, __pa(vmx_vmwrite_bitmap));
 	}
 	if (cpu_has_vmx_msr_bitmap())
-		vmcs_write64(MSR_BITMAP, __pa(vmx_msr_bitmap_legacy));
+		vmcs_write64(MSR_BITMAP, __pa(vmx->vmcs01.msr_bitmap));
 
 	vmcs_write64(VMCS_LINK_POINTER, -1ull); /* 22.3.1.5 */
 
@@ -7085,7 +7123,7 @@ static void vmx_set_virtual_x2apic_mode(
 	}
 	vmcs_write32(SECONDARY_VM_EXEC_CONTROL, sec_exec_control);
 
-	vmx_set_msr_bitmap(vcpu);
+	vmx_update_msr_bitmap(vcpu);
 }
 
 static void vmx_hwapic_isr_update(struct kvm *kvm, int isr)
@@ -7605,6 +7643,7 @@ static struct kvm_vcpu *vmx_create_vcpu(
 {
 	int err;
 	struct vcpu_vmx *vmx = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
+	unsigned long *msr_bitmap;
 	int cpu;
 
 	if (!vmx)
@@ -7630,6 +7669,15 @@ static struct kvm_vcpu *vmx_create_vcpu(
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
@@ -8955,7 +9003,7 @@ static struct kvm_x86_ops vmx_x86_ops =
 
 static int __init vmx_init(void)
 {
-	int r, i, msr;
+	int r, i;
 
 	rdmsrl_safe(MSR_EFER, &host_efer);
 
@@ -8972,30 +9020,13 @@ static int __init vmx_init(void)
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
-	vmx_msr_bitmap_longmode = (unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_longmode)
-		goto out3;
-
-	vmx_msr_bitmap_longmode_x2apic =
-				(unsigned long *)__get_free_page(GFP_KERNEL);
-	if (!vmx_msr_bitmap_longmode_x2apic)
-		goto out4;
 	vmx_vmread_bitmap = (unsigned long *)__get_free_page(GFP_KERNEL);
 	if (!vmx_vmread_bitmap)
-		goto out5;
+		goto out1;
 
 	vmx_vmwrite_bitmap = (unsigned long *)__get_free_page(GFP_KERNEL);
 	if (!vmx_vmwrite_bitmap)
-		goto out6;
+		goto out2;
 
 	memset(vmx_vmread_bitmap, 0xff, PAGE_SIZE);
 	memset(vmx_vmwrite_bitmap, 0xff, PAGE_SIZE);
@@ -9004,51 +9035,18 @@ static int __init vmx_init(void)
 
 	memset(vmx_io_bitmap_b, 0xff, PAGE_SIZE);
 
-	memset(vmx_msr_bitmap_legacy, 0xff, PAGE_SIZE);
-	memset(vmx_msr_bitmap_longmode, 0xff, PAGE_SIZE);
-
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
 		     __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)
-		goto out7;
+		goto out3;
 
 #ifdef CONFIG_KEXEC
 	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
 			   crash_vmclear_local_loaded_vmcss);
 #endif
 
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
-
-	if (enable_apicv) {
-		for (msr = 0x800; msr <= 0x8ff; msr++)
-			vmx_disable_intercept_msr_read_x2apic(msr);
-
-		/* According SDM, in x2apic mode, the whole id reg is used.
-		 * But in KVM, it only use the highest eight bits. Need to
-		 * intercept it */
-		vmx_enable_intercept_msr_read_x2apic(0x802);
-		/* TMCCT */
-		vmx_enable_intercept_msr_read_x2apic(0x839);
-		/* TPR */
-		vmx_disable_intercept_msr_write_x2apic(0x808);
-		/* EOI */
-		vmx_disable_intercept_msr_write_x2apic(0x80b);
-		/* SELF-IPI */
-		vmx_disable_intercept_msr_write_x2apic(0x83f);
-	}
-
 	if (enable_ept) {
 		kvm_mmu_set_mask_ptes(0ull,
 			(enable_ept_ad_bits) ? VMX_EPT_ACCESS_BIT : 0ull,
@@ -9061,18 +9059,10 @@ static int __init vmx_init(void)
 
 	return 0;
 
-out7:
-	free_page((unsigned long)vmx_vmwrite_bitmap);
-out6:
-	free_page((unsigned long)vmx_vmread_bitmap);
-out5:
-	free_page((unsigned long)vmx_msr_bitmap_longmode_x2apic);
-out4:
-	free_page((unsigned long)vmx_msr_bitmap_longmode);
 out3:
-	free_page((unsigned long)vmx_msr_bitmap_legacy_x2apic);
+	free_page((unsigned long)vmx_vmwrite_bitmap);
 out2:
-	free_page((unsigned long)vmx_msr_bitmap_legacy);
+	free_page((unsigned long)vmx_vmread_bitmap);
 out1:
 	free_page((unsigned long)vmx_io_bitmap_b);
 out:
@@ -9082,10 +9072,6 @@ out:
 
 static void __exit vmx_exit(void)
 {
-	free_page((unsigned long)vmx_msr_bitmap_legacy_x2apic);
-	free_page((unsigned long)vmx_msr_bitmap_longmode_x2apic);
-	free_page((unsigned long)vmx_msr_bitmap_legacy);
-	free_page((unsigned long)vmx_msr_bitmap_longmode);
 	free_page((unsigned long)vmx_io_bitmap_b);
 	free_page((unsigned long)vmx_io_bitmap_a);
 	free_page((unsigned long)vmx_vmwrite_bitmap);
