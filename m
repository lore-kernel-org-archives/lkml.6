Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBECGZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 21:06:25 -0500
Received: from ozlabs.org ([103.22.144.67]:42617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbeBECGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 21:06:18 -0500
Date: Mon, 5 Feb 2018 13:06:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quan Xu <quan.xu0@gmail.com>, Mark Kanda <mark.kanda@oracle.com>,
        Ashok Raj <ashok.raj@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180205130615.40c90833@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between commit:

  f21f165ef922 ("KVM: VMX: introduce alloc_loaded_vmcs")
  904e14fb7cb9 ("KVM: VMX: make MSR bitmaps per-VCPU")
  15d45071523d ("KVM/x86: Add IBPB support")

from Linus' tree and commit:

  276c796cfef5 ("KVM: nVMX: Add a WARN for freeing a loaded VMCS02")
  8eb73e2d410f ("KVM: VMX: drop I/O permission bitmaps")
  1f6e5b25643e ("KVM: vmx: simplify MSR bitmap setup")
  d7231e75f73f ("KVM: VMX: introduce X2APIC_MSR macro")
  c992384bde84 ("KVM: vmx: speed up MSR bitmap merge")
  276c796cfef5 ("KVM: nVMX: Add a WARN for freeing a loaded VMCS02")

from the kvm tree.

I fixed it up (I have no idea if it is correct - see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

Its probably worth doing this back merge yourself into a test branch to
show Linus how you think it should be done.
-- 
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/vmx.c
index bee4c49f6dd0,bb5b4888505b..000000000000
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -903,18 -856,25 +869,22 @@@ static const unsigned short vmcs_field_
  
  static inline short vmcs_field_to_offset(unsigned long field)
  {
 +	const size_t size = ARRAY_SIZE(vmcs_field_to_offset_table);
 +	unsigned short offset;
+ 	unsigned index;
+ 
+ 	if (field >> 15)
+ 		return -ENOENT;
  
- 	BUILD_BUG_ON(size > SHRT_MAX);
- 	if (field >= size)
+ 	index = ROL16(field, 6);
 -	if (index >= ARRAY_SIZE(vmcs_field_to_offset_table))
++	if (index >= size)
  		return -ENOENT;
  
- 	field = array_index_nospec(field, size);
- 	offset = vmcs_field_to_offset_table[field];
 -	/*
 -	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
 -	 * generic mechanism.
 -	 */
 -	asm("lfence");
 -
 -	if (vmcs_field_to_offset_table[index] == 0)
++	index = array_index_nospec(index, size);
++	offset = vmcs_field_to_offset_table[index];
 +	if (offset == 0)
  		return -ENOENT;
 -
 -	return vmcs_field_to_offset_table[index];
 +	return offset;
  }
  
  static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
@@@ -957,8 -914,12 +927,6 @@@ static DEFINE_PER_CPU(struct list_head
  static DEFINE_PER_CPU(spinlock_t, blocked_vcpu_on_cpu_lock);
  
  enum {
- 	VMX_IO_BITMAP_A,
- 	VMX_IO_BITMAP_B,
 -	VMX_MSR_BITMAP_LEGACY,
 -	VMX_MSR_BITMAP_LONGMODE,
 -	VMX_MSR_BITMAP_LEGACY_X2APIC_APICV,
 -	VMX_MSR_BITMAP_LONGMODE_X2APIC_APICV,
 -	VMX_MSR_BITMAP_LEGACY_X2APIC,
 -	VMX_MSR_BITMAP_LONGMODE_X2APIC,
  	VMX_VMREAD_BITMAP,
  	VMX_VMWRITE_BITMAP,
  	VMX_BITMAP_NR
@@@ -966,8 -927,12 +934,6 @@@
  
  static unsigned long *vmx_bitmap[VMX_BITMAP_NR];
  
- #define vmx_io_bitmap_a                      (vmx_bitmap[VMX_IO_BITMAP_A])
- #define vmx_io_bitmap_b                      (vmx_bitmap[VMX_IO_BITMAP_B])
 -#define vmx_msr_bitmap_legacy                (vmx_bitmap[VMX_MSR_BITMAP_LEGACY])
 -#define vmx_msr_bitmap_longmode              (vmx_bitmap[VMX_MSR_BITMAP_LONGMODE])
 -#define vmx_msr_bitmap_legacy_x2apic_apicv   (vmx_bitmap[VMX_MSR_BITMAP_LEGACY_X2APIC_APICV])
 -#define vmx_msr_bitmap_longmode_x2apic_apicv (vmx_bitmap[VMX_MSR_BITMAP_LONGMODE_X2APIC_APICV])
 -#define vmx_msr_bitmap_legacy_x2apic         (vmx_bitmap[VMX_MSR_BITMAP_LEGACY_X2APIC])
 -#define vmx_msr_bitmap_longmode_x2apic       (vmx_bitmap[VMX_MSR_BITMAP_LONGMODE_X2APIC])
  #define vmx_vmread_bitmap                    (vmx_bitmap[VMX_VMREAD_BITMAP])
  #define vmx_vmwrite_bitmap                   (vmx_bitmap[VMX_VMWRITE_BITMAP])
  
@@@ -3945,33 -3821,19 +3914,46 @@@ static void free_loaded_vmcs(struct loa
  	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
  }
  
 +static struct vmcs *alloc_vmcs(void)
 +{
 +	return alloc_vmcs_cpu(raw_smp_processor_id());
 +}
 +
 +static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 +{
 +	loaded_vmcs->vmcs = alloc_vmcs();
 +	if (!loaded_vmcs->vmcs)
 +		return -ENOMEM;
 +
 +	loaded_vmcs->shadow_vmcs = NULL;
 +	loaded_vmcs_init(loaded_vmcs);
 +
 +	if (cpu_has_vmx_msr_bitmap()) {
 +		loaded_vmcs->msr_bitmap = (unsigned long *)__get_free_page(GFP_KERNEL);
 +		if (!loaded_vmcs->msr_bitmap)
 +			goto out_vmcs;
 +		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
 +	}
 +	return 0;
 +
 +out_vmcs:
 +	free_loaded_vmcs(loaded_vmcs);
 +	return -ENOMEM;
 +}
 +
+ static void vmx_nested_free_vmcs02(struct vcpu_vmx *vmx)
+ {
+ 	struct loaded_vmcs *loaded_vmcs = &vmx->nested.vmcs02;
+ 
+ 	/*
+ 	 * Just leak the VMCS02 if the WARN triggers. Better than
+ 	 * a use-after-free.
+ 	 */
+ 	if (WARN_ON(vmx->loaded_vmcs == loaded_vmcs))
+ 		return;
+ 	free_loaded_vmcs(loaded_vmcs);
+ }
+ 
  static void free_kvm_area(void)
  {
  	int cpu;
@@@ -6957,10 -6786,9 +6990,6 @@@ static __init int hardware_setup(void
  	memset(vmx_vmread_bitmap, 0xff, PAGE_SIZE);
  	memset(vmx_vmwrite_bitmap, 0xff, PAGE_SIZE);
  
- 	memset(vmx_io_bitmap_a, 0xff, PAGE_SIZE);
- 
- 	memset(vmx_io_bitmap_b, 0xff, PAGE_SIZE);
 -	memset(vmx_msr_bitmap_legacy, 0xff, PAGE_SIZE);
 -	memset(vmx_msr_bitmap_longmode, 0xff, PAGE_SIZE);
--
  	if (setup_vmcs_config(&vmcs_config) < 0) {
  		r = -EIO;
  		goto out;
@@@ -7345,7 -7212,10 +7374,7 @@@ out_shadow_vmcs
  	kfree(vmx->nested.cached_vmcs12);
  
  out_cached_vmcs12:
- 	free_loaded_vmcs(&vmx->nested.vmcs02);
 -	free_page((unsigned long)vmx->nested.msr_bitmap);
 -
 -out_msr_bitmap:
+ 	vmx_nested_free_vmcs02(vmx);
  
  out_vmcs02:
  	return -ENOMEM;
@@@ -10205,70 -10030,56 +10223,84 @@@ static inline bool nested_vmx_prepare_m
  	int msr;
  	struct page *page;
  	unsigned long *msr_bitmap_l1;
 -	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.msr_bitmap;
 +	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 +	/*
 +	 * pred_cmd & spec_ctrl are trying to verify two things:
 +	 *
 +	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
 +	 *    ensures that we do not accidentally generate an L02 MSR bitmap
 +	 *    from the L12 MSR bitmap that is too permissive.
 +	 * 2. That L1 or L2s have actually used the MSR. This avoids
 +	 *    unnecessarily merging of the bitmap if the MSR is unused. This
 +	 *    works properly because we only update the L01 MSR bitmap lazily.
 +	 *    So even if L0 should pass L1 these MSRs, the L01 bitmap is only
 +	 *    updated to reflect this when L1 (or its L2s) actually write to
 +	 *    the MSR.
 +	 */
 +	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
 +	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
  
+ 	/* Nothing to do if the MSR bitmap is not in use.  */
+ 	if (!cpu_has_vmx_msr_bitmap() ||
+ 	    !nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
+ 		return false;
+ 
 -	/* This shortcut is ok because we support only x2APIC MSRs so far. */
 -	if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
 +	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 +	    !pred_cmd && !spec_ctrl)
  		return false;
  
  	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
  	if (is_error_page(page))
  		return false;
+ 
  	msr_bitmap_l1 = (unsigned long *)kmap(page);
+ 	if (nested_cpu_has_apic_reg_virt(vmcs12)) {
+ 		/*
+ 		 * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
+ 		 * just lets the processor take the value from the virtual-APIC page;
+ 		 * take those 256 bits directly from the L1 bitmap.
+ 		 */
+ 		for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+ 			unsigned word = msr / BITS_PER_LONG;
+ 			msr_bitmap_l0[word] = msr_bitmap_l1[word];
+ 			msr_bitmap_l0[word + (0x800 / sizeof(long))] = ~0;
+ 		}
+ 	} else {
+ 		for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+ 			unsigned word = msr / BITS_PER_LONG;
+ 			msr_bitmap_l0[word] = ~0;
+ 			msr_bitmap_l0[word + (0x800 / sizeof(long))] = ~0;
+ 		}
+ 	}
  
- 	memset(msr_bitmap_l0, 0xff, PAGE_SIZE);
- 
- 	if (nested_cpu_has_virt_x2apic_mode(vmcs12)) {
- 		if (nested_cpu_has_apic_reg_virt(vmcs12))
- 			for (msr = 0x800; msr <= 0x8ff; msr++)
- 				nested_vmx_disable_intercept_for_msr(
- 					msr_bitmap_l1, msr_bitmap_l0,
- 					msr, MSR_TYPE_R);
+ 	nested_vmx_disable_intercept_for_msr(
+ 		msr_bitmap_l1, msr_bitmap_l0,
+ 		X2APIC_MSR(APIC_TASKPRI),
+ 		MSR_TYPE_W);
  
+ 	if (nested_cpu_has_vid(vmcs12)) {
  		nested_vmx_disable_intercept_for_msr(
- 				msr_bitmap_l1, msr_bitmap_l0,
- 				APIC_BASE_MSR + (APIC_TASKPRI >> 4),
- 				MSR_TYPE_R | MSR_TYPE_W);
- 
- 		if (nested_cpu_has_vid(vmcs12)) {
- 			nested_vmx_disable_intercept_for_msr(
- 				msr_bitmap_l1, msr_bitmap_l0,
- 				APIC_BASE_MSR + (APIC_EOI >> 4),
- 				MSR_TYPE_W);
- 			nested_vmx_disable_intercept_for_msr(
- 				msr_bitmap_l1, msr_bitmap_l0,
- 				APIC_BASE_MSR + (APIC_SELF_IPI >> 4),
- 				MSR_TYPE_W);
- 		}
+ 			msr_bitmap_l1, msr_bitmap_l0,
+ 			X2APIC_MSR(APIC_EOI),
+ 			MSR_TYPE_W);
+ 		nested_vmx_disable_intercept_for_msr(
+ 			msr_bitmap_l1, msr_bitmap_l0,
+ 			X2APIC_MSR(APIC_SELF_IPI),
+ 			MSR_TYPE_W);
  	}
 +
 +	if (spec_ctrl)
 +		nested_vmx_disable_intercept_for_msr(
 +					msr_bitmap_l1, msr_bitmap_l0,
 +					MSR_IA32_SPEC_CTRL,
 +					MSR_TYPE_R | MSR_TYPE_W);
 +
 +	if (pred_cmd)
 +		nested_vmx_disable_intercept_for_msr(
 +					msr_bitmap_l1, msr_bitmap_l0,
 +					MSR_IA32_PRED_CMD,
 +					MSR_TYPE_W);
 +
  	kunmap(page);
  	kvm_release_page_clean(page);
  
