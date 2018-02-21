Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936732AbeBURr4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:47:56 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11223 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935683AbeBURrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:53 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="723871775"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 06/10] KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
Date: Wed, 21 Feb 2018 18:47:17 +0100
Message-Id: <1519235241-6500-7-git-send-email-karahmed@amazon.de>
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
 arch/x86/kvm/vmx.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4bfef58..a700338 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -460,9 +460,8 @@ struct nested_vmx {
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
 	struct page *apic_access_page;
-	struct page *virtual_apic_page;
+	struct kvm_host_map virtual_apic_map;
 	struct page *pi_desc_page;
-
 	struct kvm_host_map msr_bitmap_map;
 
 	struct pi_desc *pi_desc;
@@ -5444,10 +5443,9 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 
 	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
 	if (max_irr != 256) {
-		vapic_page = kmap(vmx->nested.virtual_apic_page);
+		vapic_page = vmx->nested.virtual_apic_map.kaddr;
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
 			vapic_page, &max_irr);
-		kunmap(vmx->nested.virtual_apic_page);
 
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
@@ -7667,6 +7665,7 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 				  vmx->nested.current_vmptr >> PAGE_SHIFT,
 				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
 
+	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
 	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
 
 	vmx->nested.current_vmptr = -1ull;
@@ -7698,10 +7697,7 @@ static void free_nested(struct vcpu_vmx *vmx)
 		kvm_release_page_dirty(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
 	}
-	if (vmx->nested.virtual_apic_page) {
-		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-		vmx->nested.virtual_apic_page = NULL;
-	}
+	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
@@ -10222,6 +10218,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 					struct vmcs12 *vmcs12)
 {
+	struct kvm_host_map *map;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct page *page;
 	u64 hpa;
@@ -10260,11 +10257,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	}
 
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
-		if (vmx->nested.virtual_apic_page) { /* shouldn't happen */
-			kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-			vmx->nested.virtual_apic_page = NULL;
-		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->virtual_apic_page_addr);
+		map = &vmx->nested.virtual_apic_map;
 
 		/*
 		 * If translation failed, VM entry will fail because
@@ -10279,11 +10272,9 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 		 * control.  But such a configuration is useless, so
 		 * let's keep the code simple.
 		 */
-		if (!is_error_page(page)) {
-			vmx->nested.virtual_apic_page = page;
-			hpa = page_to_phys(vmx->nested.virtual_apic_page);
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
-		}
+
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map))
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, gfn_to_gpa(map->pfn));
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
@@ -11902,10 +11893,6 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 		kvm_release_page_dirty(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
 	}
-	if (vmx->nested.virtual_apic_page) {
-		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-		vmx->nested.virtual_apic_page = NULL;
-	}
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-- 
2.7.4
