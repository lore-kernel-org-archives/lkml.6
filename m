Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeDOV6E (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:58:04 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21598 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbeDOVy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:57 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="735371358"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 07/12] KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
Date: Sun, 15 Apr 2018 23:53:13 +0200
Message-Id: <1523829198-13236-8-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map when mapping the virtual APIC page since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

One additional semantic change is that the virtual host mapping lifecycle
has changed a bit. It now has the same lifetime of the pinning of the
virtual APIC page on the host side.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Do not change the lifecycle of the mapping (pbonzini)
- Use pfn_to_hpa instead of gfn_to_gpa
---
 arch/x86/kvm/vmx.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6d335fc..b55053a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -492,9 +492,8 @@ struct nested_vmx {
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
 	struct page *apic_access_page;
-	struct page *virtual_apic_page;
+	struct kvm_host_map virtual_apic_map;
 	struct page *pi_desc_page;
-
 	struct kvm_host_map msr_bitmap_map;
 
 	struct pi_desc *pi_desc;
@@ -5572,11 +5571,12 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 
 	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
 	if (max_irr != 256) {
-		vapic_page = kmap(vmx->nested.virtual_apic_page);
+		vapic_page = vmx->nested.virtual_apic_map.hva;
+		if (!vapic_page)
+			return;
+
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
 			vapic_page, &max_irr);
-		kunmap(vmx->nested.virtual_apic_page);
-
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
 			status &= ~0xff;
@@ -7806,10 +7806,7 @@ static void free_nested(struct vcpu_vmx *vmx)
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
@@ -10358,6 +10355,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_host_map *map;
 	struct page *page;
 	u64 hpa;
 
@@ -10395,11 +10393,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -10414,11 +10408,8 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		 * control.  But such a configuration is useless, so
 		 * let's keep the code simple.
 		 */
-		if (!is_error_page(page)) {
-			vmx->nested.virtual_apic_page = page;
-			hpa = page_to_phys(vmx->nested.virtual_apic_page);
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
-		}
+		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map))
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
@@ -12076,10 +12067,7 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
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
-- 
2.7.4
