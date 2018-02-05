Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeBEStD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:49:03 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23901 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753704AbeBESsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:00 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="330725242"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 03/12] KVM/VMX: Use the new host mapping API for virtual_apic_page
Date: Mon,  5 Feb 2018 19:47:22 +0100
Message-Id: <1517856451-2932-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nested guests the virtual_apic_page was mapped to the host kernel using
kvm_vcpu_gpa_to_page which assumes that all guest memory is backed by a
"struct page". This breaks guests that have their memory outside the kernel
control.

Switch to the new host mapping API which takes care of this use-case as
well.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b76ab06..6bd0c45 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -452,7 +452,7 @@ struct nested_vmx {
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
 	struct kvm_host_mapping apic_access_mapping;
-	struct page *virtual_apic_page;
+	struct kvm_host_mapping virtual_apic_mapping;
 	struct page *pi_desc_page;
 	struct pi_desc *pi_desc;
 	bool pi_pending;
@@ -5264,9 +5264,8 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 
 	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
 	if (max_irr != 256) {
-		vapic_page = kmap(vmx->nested.virtual_apic_page);
+		vapic_page = vmx->nested.virtual_apic_mapping.kaddr;
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir, vapic_page);
-		kunmap(vmx->nested.virtual_apic_page);
 
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
@@ -7502,10 +7501,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 	/* Unpin physical memory we referred to in the vmcs02 */
 	if (vmx->nested.apic_access_mapping.pfn)
 		kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
-	if (vmx->nested.virtual_apic_page) {
-		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-		vmx->nested.virtual_apic_page = NULL;
-	}
+	if (vmx->nested.virtual_apic_mapping.pfn)
+		kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
@@ -10045,7 +10042,6 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct page *page;
-	u64 hpa;
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
 		/*
@@ -10078,11 +10074,8 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	}
 
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
-		if (vmx->nested.virtual_apic_page) { /* shouldn't happen */
-			kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-			vmx->nested.virtual_apic_page = NULL;
-		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->virtual_apic_page_addr);
+		if (vmx->nested.virtual_apic_mapping.pfn) /* shouldn't happen */
+			kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);
 
 		/*
 		 * If translation failed, VM entry will fail because
@@ -10097,11 +10090,10 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 		 * control.  But such a configuration is useless, so
 		 * let's keep the code simple.
 		 */
-		if (!is_error_page(page)) {
-			vmx->nested.virtual_apic_page = page;
-			hpa = page_to_phys(vmx->nested.virtual_apic_page);
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
-		}
+		if (kvm_vcpu_gpa_to_host_mapping(vcpu, vmcs12->virtual_apic_page_addr,
+						 &vmx->nested.virtual_apic_mapping, true))
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR,
+				     vmx->nested.virtual_apic_mapping.pfn << PAGE_SHIFT);
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
@@ -11683,10 +11675,8 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	/* Unpin physical memory we referred to in vmcs02 */
 	if (vmx->nested.apic_access_mapping.pfn)
 		kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
-	if (vmx->nested.virtual_apic_page) {
-		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-		vmx->nested.virtual_apic_page = NULL;
-	}
+	if (vmx->nested.virtual_apic_mapping.pfn)
+		kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-- 
2.7.4
