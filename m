Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935112AbeBURrv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:47:51 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:28428 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935027AbeBURrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:49 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="332936473"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 07/10] KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table
Date: Wed, 21 Feb 2018 18:47:18 +0100
Message-Id: <1519235241-6500-8-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
memory that has a "struct page".

The life-cycle of the mapping also changes to avoid doing map and unmap on
every single exit (which becomes very expesive once we use memremap).  Now
the memory is mapped and only unmapped when a new VMCS12 is loaded into the
vCPU (or when the vCPU is freed!).

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a700338..7b29419 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -461,7 +461,7 @@ struct nested_vmx {
 	 */
 	struct page *apic_access_page;
 	struct kvm_host_map virtual_apic_map;
-	struct page *pi_desc_page;
+	struct kvm_host_map pi_desc_map;
 	struct kvm_host_map msr_bitmap_map;
 
 	struct pi_desc *pi_desc;
@@ -7666,6 +7666,7 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
 
 	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
+	kvm_vcpu_unmap(&vmx->nested.pi_desc_map);
 	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
 
 	vmx->nested.current_vmptr = -1ull;
@@ -7698,14 +7699,9 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.apic_access_page = NULL;
 	}
 	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
-
+	kvm_vcpu_unmap(&vmx->nested.pi_desc_map);
 	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
+	vmx->nested.pi_desc = NULL;
 
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
@@ -10278,24 +10274,16 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		if (vmx->nested.pi_desc_page) { /* shouldn't happen */
-			kunmap(vmx->nested.pi_desc_page);
-			kvm_release_page_dirty(vmx->nested.pi_desc_page);
-			vmx->nested.pi_desc_page = NULL;
+		map = &vmx->nested.pi_desc_map;
+
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
+			vmx->nested.pi_desc =
+				(struct pi_desc *)(((void *)map->kaddr) +
+				offset_in_page(vmcs12->posted_intr_desc_addr));
+			vmcs_write64(POSTED_INTR_DESC_ADDR, pfn_to_hpa(map->pfn) +
+							    offset_in_page(vmcs12->posted_intr_desc_addr));
 		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->posted_intr_desc_addr);
-		if (is_error_page(page))
-			return;
-		vmx->nested.pi_desc_page = page;
-		vmx->nested.pi_desc = kmap(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc =
-			(struct pi_desc *)((void *)vmx->nested.pi_desc +
-			(unsigned long)(vmcs12->posted_intr_desc_addr &
-			(PAGE_SIZE - 1)));
-		vmcs_write64(POSTED_INTR_DESC_ADDR,
-			page_to_phys(vmx->nested.pi_desc_page) +
-			(unsigned long)(vmcs12->posted_intr_desc_addr &
-			(PAGE_SIZE - 1)));
+
 	}
 	if (nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
 		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
@@ -11893,13 +11881,6 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 		kvm_release_page_dirty(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
 	}
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
-
 	/*
 	 * We are now running in L2, mmu_notifier will force to reload the
 	 * page's hpa for L2 vmcs. Need to reload it for L1 before entering L1.
-- 
2.7.4
