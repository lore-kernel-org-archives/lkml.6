Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935039AbeBURrt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:47:49 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26733 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932422AbeBURrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:45 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="709068484"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 05/10] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
Date: Wed, 21 Feb 2018 18:47:16 +0100
Message-Id: <1519235241-6500-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
memory that has a "struct page".

The life-cycle of the mapping also changes to avoid doing map and unmap on
every single exit (which becomes very expesive once we use memremap). Now
the memory is mapped and only unmapped when a new VMCS12 is loaded into the
vCPU (or when the vCPU is freed!).

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0a98d1a..4bfef58 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -462,6 +462,9 @@ struct nested_vmx {
 	struct page *apic_access_page;
 	struct page *virtual_apic_page;
 	struct page *pi_desc_page;
+
+	struct kvm_host_map msr_bitmap_map;
+
 	struct pi_desc *pi_desc;
 	bool pi_pending;
 	u16 posted_intr_nv;
@@ -7664,6 +7667,8 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 				  vmx->nested.current_vmptr >> PAGE_SHIFT,
 				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
 
+	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
+
 	vmx->nested.current_vmptr = -1ull;
 }
 
@@ -7704,6 +7709,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -10374,9 +10381,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12)
 {
 	int msr;
-	struct page *page;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
+	struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
+
 	/*
 	 * pred_cmd & spec_ctrl are trying to verify two things:
 	 *
@@ -10402,11 +10410,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	    !pred_cmd && !spec_ctrl)
 		return false;
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
-	if (is_error_page(page))
+	if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)kmap(page);
+	msr_bitmap_l1 = (unsigned long *)map->kaddr;
+
 	if (nested_cpu_has_apic_reg_virt(vmcs12)) {
 		/*
 		 * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
@@ -10454,9 +10462,6 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 					MSR_IA32_PRED_CMD,
 					MSR_TYPE_W);
 
-	kunmap(page);
-	kvm_release_page_clean(page);
-
 	return true;
 }
 
-- 
2.7.4
